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
    public class UserController : Controller
    {
        //
        // GET: /User/

        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 更新密码
        /// </summary>
        /// <param name="UserPwd"></param>
        /// <param name="NewPwd"></param>
        /// <param name="ConfirmPwd"></param>
        /// <returns></returns>
        public ActionResult UpdatePwd(string UserPwd, string NewPwd, string ConfirmPwd)
        {
            try
            {
                string result = "";
                UserEntity uInfo = ViewData["Account"] as UserEntity;

                UserEntity userChangePwd = new UserEntity();
                userChangePwd.ID = uInfo.ID;
                userChangePwd.Password = Md5.GetMD5String(NewPwd);   //md5加密

                if (Md5.GetMD5String(UserPwd) == uInfo.Password)
                {
                    if (new UserBLL().ChangePwd(userChangePwd))
                    {
                        result = "{\"msg\":\"修改成功，请重新登录！\",\"success\":true}";
                    }
                    else
                    {
                        result = "{\"msg\":\"修改失败！\",\"success\":false}";
                    }
                }
                else
                {
                    result = "{\"msg\":\"原密码不正确！\",\"success\":false}";
                }
                return Content(result);
            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"修改失败," + ex.Message + "\",\"success\":false}");
            }
        }

        public ActionResult ChangePwd()
        {
            return View();
        }

        public ActionResult GetAllUserInfo()
        {
            string strWhere = "1=1";
            string sort = Request["sort"] == null ? "ID" : Request["sort"];
            string order = Request["order"] == null ? "asc" : Request["order"];

            //首先获取前台传递过来的参数
            int pageindex = Request["page"] == null ? 1 : Convert.ToInt32(Request["page"]);
            int pagesize = Request["rows"] == null ? 10 : Convert.ToInt32(Request["rows"]);
            string userid = Request["accountid"] == null ? "" : Request["accountid"];
            string username = Request["username"] == null ? "" : Request["username"];
            string isable = Request["isable"] == null ? "" : Request["isable"];
            string ifchangepwd = Request["ifchangepwd"] == null ? "" : Request["ifchangepwd"];
            string userperson = Request["userperson"] == null ? "" : Request["userperson"];
            string adddatestart = Request["adddatestart"] == null ? "" : Request["adddatestart"];
            string adddateend = Request["adddateend"] == null ? "" : Request["adddateend"];

            if (userid.Trim() != "" && !SqlInjection.GetString(userid))   //防止sql注入
                strWhere += string.Format(" and AccountName like '%{0}%'", userid.Trim());
            if (username.Trim() != "" && !SqlInjection.GetString(username))
                strWhere += string.Format(" and RealName like '%{0}%'", username.Trim());
            if (isable.Trim() != "select" && isable.Trim() != "")
                strWhere += " and IsAble = '" + isable.Trim() + "'";
            if (ifchangepwd.Trim() != "select" && ifchangepwd.Trim() != "")
                strWhere += " and IfChangePwd = '" + ifchangepwd.Trim() + "'";
            if (adddatestart.Trim() != "")
                strWhere += " and CreateTime > '" + adddatestart.Trim() + "'";
            if (adddateend.Trim() != "")
                strWhere += " and CreateTime < '" + adddateend.Trim() + "'";

            int totalCount;   //输出参数
            string strJson = new UserBLL().GetPager("tbUser", "ID,AccountName,[Password],RealName,MobilePhone,Email,IsAble,IfChangePwd,[Description],CreateTime,CreateBy,UpdateTime,UpdateBy", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);
            var jsonResult = new { total = totalCount.ToString(), rows = strJson };
            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult UserAdd()
        {
            return View();
        }

        /// <summary>
        /// 新增 用户
        /// </summary>
        /// <returns></returns>
        public ActionResult AddUser()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                string userid = Request["UserID"];
                string username = Request["UserName"];
                bool isable = bool.Parse(Request["Isable"]);
                bool ifchangepwd = bool.Parse(Request["IfChangepwd"]);
                string description = Request["Description"];

                UserEntity userAdd = new UserEntity();
                userAdd.AccountName = userid.Trim();
                userAdd.RealName = username.Trim();
                userAdd.Password = Md5.GetMD5String("q123456");   //md5加密
                userAdd.IsAble = isable;
                userAdd.IfChangePwd = ifchangepwd;
                userAdd.Description = description.Trim();
                userAdd.MobilePhone = Request["MobilePhone"];
                userAdd.Email = Request["Email"];
                userAdd.CreateTime = DateTime.Now;
                userAdd.CreateBy = uInfo.AccountName;
                userAdd.UpdateTime = DateTime.Now;
                userAdd.UpdateBy = uInfo.AccountName;
                int userId = new UserBLL().AddUser(userAdd);
                if (userId > 0)
                {
                    return Content("{\"msg\":\"添加成功！默认密码是【q123456】！\",\"success\":true}");
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
        public ActionResult UserEdit()
        {
            return View();
        }

        /// <summary>
        /// 编辑 用户
        /// </summary>
        /// <returns></returns>
        public ActionResult EditUser()
        {
            try
            {
                int id = Convert.ToInt32(Request["id"]);
                string originalName = Request["originalName"];
                string userid = Request["UserID"];
                string username = Request["UserName"];
                bool isable = bool.Parse(Request["Isable"]);
                bool ifchangepwd = bool.Parse(Request["IfChangepwd"]);
                string description = Request["Description"];

                UserEntity userEdit = new UserEntity();
                userEdit.ID = id;
                userEdit.AccountName = userid.Trim();
                userEdit.RealName = username.Trim();
                userEdit.IsAble = isable;
                userEdit.IfChangePwd = ifchangepwd;
                userEdit.Description = description.Trim();
                userEdit.MobilePhone = Request["MobilePhone"];
                userEdit.Email = Request["Email"];
                userEdit.UpdateTime = DateTime.Now;

                if (new UserBLL().EditUser(userEdit, originalName))
                {
                    return Content("{\"msg\":\"修改成功！\",\"success\":true}");
                }
                else
                {
                    return Content("{\"msg\":\"修改失败！\",\"success\":true}");
                }

            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"修改失败," + ex.Message + "\",\"success\":false}");
            }
        }

        public ActionResult DelUserByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new UserBLL().DeleteUser(Ids))
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
        /// 用户角色权限页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult UserRole()
        {
            return View();
        }

        /// <summary>
        /// 新增 用户角色权限
        /// </summary>
        /// <returns></returns>
        public ActionResult SetUserRole()
        {
            try
            {
                string UserIDs = Request["UserIDs"] ?? "";  //用户id，可能是多个 
                string RoleIDs = Request["RoleIDs"] ?? "";  //角色id，可能是多个

                if (UserIDs.IndexOf(",") == -1)  //单个用户分配角色
                {
                    if (UserIDs != "" && new UserRoleBLL().SetRoleSingle(Convert.ToInt32(UserIDs), RoleIDs))
                    {
                        return Content("{\"msg\":\"设置成功！\",\"success\":true}");
                    }
                    else
                    {
                        return Content("{\"msg\":\"设置失败！\",\"success\":true}");
                    }
                }
                else   //批量设置用户角色
                {
                    if (UserIDs != "" && new UserRoleBLL().SetRoleBatch(UserIDs, RoleIDs))
                    {
                        return Content("{\"msg\":\"设置成功！\",\"success\":true}");
                    }
                    else
                    {
                        return Content("{\"msg\":\"设置失败！\",\"success\":true}");
                    }
                }
            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"设置失败," + ex.Message + "\",\"success\":false}");
            }
        }

        /// <summary>
        /// 获取所有用户
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAllRoleInfo()
        {
            string roleJson = new RoleBLL().GetAllRole("1=1");
            return Content(roleJson);
        }


        public ActionResult SetUserDept()
        {
            return View();
        }

        public ActionResult UserDeptSet()
        {
            string UserIds = Request["UserIds"];
            string DeptIds = Request["DeptIds"];

            if (UserIds.IndexOf(",") == -1)  //单个用户设置部门
            {
                if (UserIds != "" && new UserDepartmentBLL().SetDepartmentSingle(Convert.ToInt32(UserIds), DeptIds))
                {
                    return Content("{\"msg\":\"设置成功！\",\"success\":true}");
                }
                else
                {
                    return Content("{\"msg\":\"设置失败！\",\"success\":true}");
                }
            }
            else   //批量设置用户部门
            {
                if (UserIds != "" && new UserDepartmentBLL().SetDepartmentBatch(UserIds, DeptIds))
                {
                    return Content("{\"msg\":\"设置成功！\",\"success\":true}");
                }
                else
                {
                    return Content("{\"msg\":\"设置失败！\",\"success\":true}");
                }
            }
        }
    }
}
