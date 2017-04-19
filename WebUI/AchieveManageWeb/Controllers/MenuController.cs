using AchieveBLL;
using AchieveCommon;
using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AchieveManageWeb.Controllers
{
    [AchieveManageWeb.App_Start.JudgmentLogin]
    public class MenuController : Controller
    {
        //
        // GET: /Menu/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllMenuInfo()
        {
            string strWhere = "1=1";
            string sort = Request["sort"] == null ? "Id" : Request["sort"];
            string order = Request["order"] == null ? "asc" : Request["order"];
            if (!string.IsNullOrEmpty(Request["MenuName"]) && !SqlInjection.GetString(Request["MenuName"]))
            {
                strWhere += " and Name like '%" + Request["MenuName"] + "%'";
            }
            //首先获取前台传递过来的参数
            int pageindex = Request["page"] == null ? 1 : Convert.ToInt32(Request["page"]);
            int pagesize = Request["rows"] == null ? 10 : Convert.ToInt32(Request["rows"]);
            int totalCount;   //输出参数
            string strJson = "";    //输出结果
            if (order.IndexOf(',') != -1)   //如果有","就是多列排序（不能拿列判断，列名中间可能有","符号）
            {
                //多列排序：
                //sort：ParentId,Sort,AddDate
                //order：asc,desc,asc
                string sortMulti = "";  //拼接排序条件，例：ParentId desc,Sort asc
                string[] sortArray = sort.Split(',');   //列名中间有","符号，这里也要出错。正常不会有
                string[] orderArray = order.Split(',');
                for (int i = 0; i < sortArray.Length; i++)
                {
                    sortMulti += sortArray[i] + " " + orderArray[i] + ",";
                }
                strJson = new MenuBLL().GetPager("tbMenu", "Id,Name,ParentId,Code,LinkAddress,Icon,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy", sortMulti.Trim(','), pagesize, pageindex, strWhere, out totalCount);
            }
            else
            {
                strJson = new MenuBLL().GetPager("tbMenu", "Id,Name,ParentId,Code,LinkAddress,Icon,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);
            }
            var jsonResult = new { total = totalCount.ToString(), rows = strJson };
            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult MenuAdd()
        {
            return View();
        }

        /// <summary>
        /// 新增菜单
        /// </summary>
        /// <returns></returns>
        public ActionResult AddMenu()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                MenuEntity menuAdd = new MenuEntity();
                menuAdd.Name = Request["MenuName"];
                menuAdd.Code = Request["MenuCode"];
                menuAdd.LinkAddress = Request["MenuLinkAddress"];
                menuAdd.Icon = Request["MenuIcon"];
                menuAdd.Sort = int.Parse(Request["MenuSort"]);
                if (Request["MenuParentId"] != null && Request["MenuParentId"] != "")
                {
                    menuAdd.ParentId = Convert.ToInt32(Request["MenuParentId"]);
                }
                else
                {
                    menuAdd.ParentId = 0;
                }
                menuAdd.CreateBy = uInfo.AccountName;
                menuAdd.CreateTime = DateTime.Now;
                menuAdd.UpdateBy = uInfo.AccountName;
                menuAdd.UpdateTime = DateTime.Now;

                int menuId = new MenuBLL().AddMenu(menuAdd);
                if (menuId > 0)
                {
                    return Content("{\"msg\":\"添加成功！\",\"success\":true}");
                }
                else
                {
                    return Content("{\"msg\":\"添加失败！\",\"success\":false}");
                }
            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"添加失败," + ex.Message + "\",\"success\":false}");
            }
        }

        /// <summary>
        /// 编辑页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult MenuEdit()
        {
            return View();
        }

        /// <summary>
        /// 编辑菜单
        /// </summary>
        /// <returns></returns>
        public ActionResult EditMenu()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;     
                int id = Convert.ToInt32(Request["id"]);
                string originalName = Request["originalName"];
                MenuEntity menuEdit = new MenuEntity();
                menuEdit.Id = id;
                menuEdit.Name = Request["MenuName"];
                menuEdit.Code = Request["MenuCode"];
                menuEdit.Icon = Request["MenuIcon"];
                menuEdit.Sort = int.Parse(Request["MenuSort"]);
                menuEdit.LinkAddress = Request["MenuLinkAddress"];
                if (Request["MenuParentId"] != null && Request["MenuParentId"] != "")
                {
                    menuEdit.ParentId = Convert.ToInt32(Request["MenuParentId"]);
                }
                else
                {
                    menuEdit.ParentId = 0;   //根节点
                }
                //menuEdit.CreateBy = uInfo.AccountName;
                //menuEdit.CreateTime = DateTime.Now;
                menuEdit.UpdateBy = uInfo.AccountName;
                menuEdit.UpdateTime = DateTime.Now;
                bool result = new MenuBLL().EditMenu(menuEdit, originalName);
                if (result)
                {
                    return Content("{\"msg\":\"修改成功！\",\"success\":true}");
                }
                else
                {
                    return Content("{\"msg\":\"修改失败！\",\"success\":false}");
                }
            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"修改失败," + ex.Message + "\",\"success\":false}");
            }
        }

        public ActionResult DelMenuByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new MenuBLL().DeleteMenu(Ids))
                    {
                        return Content("{\"msg\":\"删除成功！\",\"success\":true}");
                    }
                    else
                    {
                        return Content("{\"msg\":\"删除失败！\",\"success\":false}");
                    }
                }
                else
                {
                    return Content("{\"msg\":\"删除失败！\",\"success\":false}");
                }
            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"删除失败," + ex.Message + "\",\"success\":false}");
            }
        }

        /// <summary>
        /// 菜单树
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAllMenuTree()
        {
            string menuJson = new MenuBLL().GetAllMenu("");
            return Content(menuJson);
        }

        /// <summary>
        /// 角色菜单树
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAllRoleMenuTree()
        {
            int roleid = Convert.ToInt32(Request["roleid"]);
            string roleMenuJson = new MenuBLL().GetAllMenu(roleid);
            return Content(roleMenuJson);
        }

        /// <summary>
        /// 分配按钮页面
        /// </summary>
        /// <returns></returns>
        public ActionResult MenuButtonSet()
        {
            return View();
        }

        /// <summary>
        /// 分配按钮权限
        /// </summary>
        /// <returns></returns>
        public ActionResult SetMenuButton()
        {
            string menuid = Request["menuid"];
            string buttonids = Request["buttonids"];

            bool result = new MenuButtonBLL().SaveMenuButton(menuid, buttonids);
            if (result)
            {
                return Content("{\"msg\":\"分配按钮成功！\",\"success\":true}");
            }
            else
            {
                return Content("{\"msg\":\"分配按钮失败！\",\"success\":false}");
            }
        }

        /// <summary>
        /// 获取已配置的菜单按钮权限
        /// </summary>
        /// <returns></returns>
        public ActionResult GetMenuButtonByMenuID()
        {
            int mid = Convert.ToInt32(Request["menuid"]);  //菜单id
            string jsonStr = new MenuButtonBLL().GetButtonByMenuId(mid);
            return Content(jsonStr);
        }

        /// <summary>
        /// 角色菜单树
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAllRoleMenuButtonTree()
        {
            int roleid = Convert.ToInt32(Request["roleid"]);
            string roleMenuJson = new MenuBLL().GetAllMenuButtonTree(roleid);
            return Content(roleMenuJson);
        }

    }
}
