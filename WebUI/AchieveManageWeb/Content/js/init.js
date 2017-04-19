$(function () {
    BindRightAccordion();
    //BindTreeData();  旧版 菜单树 保留不使用
    CheckIsChangePwd();
})

//绑定新菜单
function BindRightAccordion() {
    $("#RightAccordion").accordion({ //初始化accordion
        fillSpace: true,
        fit: true,
        border: false,
        animate: false
    });
    //获取第一层初始目录
    $.post("/Home/GetTreeByEasyui", { "id": "0" },
       function (data) {
           if (data == "0") {
               window.location.href = '/Login/Index';
           }
           $.each(data, function (i, e) {
               var id = e.id;
               $('#RightAccordion').accordion('add', {
                   title: e.text,
                   content: "<ul id='tree" + id + "' ></ul>",
                   selected: true,
                   iconCls: e.iconCls
               });
               $.parser.parse();
               //获取二级以下目录 含2级
               $.post("/Home/GetTreeByEasyui?id=" + id, function (data) {
                   $("#tree" + id).tree({
                       data: data,
                       onBeforeExpand: function (node, param) {
                           $("#tree" + id).tree('options').url = "/Home/GetTreeByEasyui?id=" + node.id;
                       },
                       onClick: function (node) {
                           if (node.state == 'closed') {
                               $(this).tree('expand', node.target);
                           } else if (node.state == 'open') {
                               $(this).tree('collapse', node.target);
                               var tabTitle = node.text;
                               var url = node.attributes;
                               var icon = node.iconCls;
                               addTab(tabTitle, url, icon);
                           }
                       }
                   });
               }, 'json');
           });
       }, "json");
}

//判断是否初始密码
function CheckIsChangePwd() {
    $.ajax({
        url: "/Home/CheckIsChangePwd?r=" + Math.random(),
        type: "post",
        data: { action: "getuser" },
        dataType: "json",
        success: function (result) {
            if (result.success) {
                if (!result.msg.IfChangePwd) {
                    changePwd("first");
                }
            }
            else {
                window.location.href = "/Login/Index";
            }
        }
    });
}

//绑定前台菜单栏 
function BindTreeData() {
    $('#LeftMenuTree').tree({    //初始化左侧功能树（不同用户显示的树是不同的）
        method: 'GET',
        url: '/Home/LoadMenuData',
        lines: true,
        onClick: function (node) {    //点击左侧的tree节点  打开右侧tabs显示内容
            if (node.attributes) {
                addTab(node.text, node.attributes.url, node.iconCls);
            }
        }
    });
}

//选项卡
function addTab(subtitle, url, icon) {
    var strHtml = '<iframe id="frmWorkArea" width="99.5%" height="99%" style="padding:1px;" frameborder="0" scrolling="yes" src="' + url + '"></iframe>';
    if (!$('#tabs').tabs('exists', subtitle)) {
        $('#tabs').tabs('add', {
            title: subtitle,
            content: strHtml,
            iconCls: icon,
            closable: true,
            loadingMessage: '正在加载中......'
        });
    } else {
        $('#tabs').tabs('select', subtitle);
    }
}
//刷新选项卡
function refreshTab() {
    var index = $('#tabs').tabs('getTabIndex', $('#tabs').tabs('getSelected'));
    if (index != -1) {
        var tab = $('#tabs').tabs('getTab', index);
        $('#tabs').tabs('update', {
            tab: tab,
            options: {
                selected: true
            }
        });
    }
}

//关闭选项卡
function closeTab() {
    $('.tabs-inner span').each(function (i, n) {
        var t = $(n).text();
        if (t != '') {
            if (t != "我的主页") {
                $('#tabs').tabs('close', t);
            }
        }
    });
}

//修改密码
function changePwd(changetype) {
    var titles = "修改密码";
    var outText = "取 消";
    if (changetype == "first") {
        titles = "首次登陆必须重置密码";
        outText = "退 出";
    }

    $("<div/>").dialog({
        id: "ui_user_userchangepwd_dialog",
        href: "/User/ChangePwd",
        title: titles,
        height: 220,
        width: 320,
        modal: true,
        closable: false,
        buttons: [{
            id: "ui_user_userchangepwd_edit",
            text: '修 改',
            handler: function () {
                var postData = {
                    UserPwd: $("#txtoriginalpwd").val(),
                    NewPwd: $("#txtnewpwd").val(),
                    ConfirmPwd: $("#txtconfirmpwd").val()
                };
                if (postData.UserPwd == postData.NewPwd) {
                    $.show_alert("提示", "新密码不能与原密码相同");
                    return;
                }

                //更新密码
                $.post("/User/UpdatePwd", postData, function (data) {
                    var dataBack = $.parseJSON(data);
                    if (dataBack.success) {
                        alert(dataBack.msg);
                        UserLoginOut();
                    }
                    else {
                        $.show_alert("提示", dataBack.msg);
                    }
                });
            }
        }, {
            text: outText,
            handler: function () {
                if (changetype == "first") {
                    UserLoginOut();
                }
                else {
                    $("#ui_user_userchangepwd_dialog").dialog('destroy');
                }
            }
        }],
        onLoad: function () {
            $("#txtoriginalpwd").focus();
            if (changetype == "first") {
                $.show_alert("提示", "首次登陆必须重置密码");
            }
        }
    });
}

//退出系统
function loginOut() {
    $.messager.confirm('提示！', '确定退出系统？', function (r) {
        if (r) {
            var para = { "action": "logout" };
            $.ajax({
                url: "/Login/UserLoginOut",
                type: "post",
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.success) {
                        window.location.href = "/Login/Index";
                    }
                    else {
                        $.show_alert("提示", result.msg);
                    }
                }
            })
        }
    })
};

//退出系统
function UserLoginOut() {
    var para = { "action": "logout" };
    $.ajax({
        url: "/Login/UserLoginOut",
        type: "post",
        data: para,
        dataType: "json",
        success: function (result) {
            if (result.success) {
                window.location.href = "/Login/Index";
            }
            else {
                $.show_alert("提示", result.msg);
            }
        }
    })
}