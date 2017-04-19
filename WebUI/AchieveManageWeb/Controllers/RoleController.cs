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
    public class RoleController : Controller
    {
        //
        // GET: /Role/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllRoleInfo()
        {
            string strWhere = "1=1";
            string sort = Request["sort"] == null ? "Id" : Request["sort"];
            string order = Request["order"] == null ? "asc" : Request["order"];

            //首先获取前台传递过来的参数
            int pageindex = Request["page"] == null ? 1 : Convert.ToInt32(Request["page"]);
            int pagesize = Request["rows"] == null ? 10 : Convert.ToInt32(Request["rows"]);

            if (!string.IsNullOrEmpty(Request["RoleName"]) && !SqlInjection.GetString(Request["RoleName"]))
            {
                strWhere += " and RoleName like '%" + Request["RoleName"] + "%'";
            }

            int totalCount;   //输出参数
            string strJson = new RoleBLL().GetPager("tbRole", "Id,RoleName,Description,CreateTime,CreateBy,UpdateTime,UpdateBy ", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);
            var jsonResult = new { total = totalCount.ToString(), rows = strJson };
            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult RoleAdd()
        {
            return View();
        }

        /// <summary>
        /// 新增 角色
        /// </summary>
        /// <returns></returns>
        public ActionResult AddRole()
        {
            try
            {
                string rolename = Request["RoleName"];
                string description = Request["Description"];

                UserEntity uInfo = ViewData["Account"] as UserEntity;
                RoleEntity roleAdd = new RoleEntity();
                roleAdd.RoleName = rolename.Trim();
                roleAdd.Description = description.Trim();
                roleAdd.CreateBy = uInfo.AccountName;
                roleAdd.CreateTime = DateTime.Now;
                roleAdd.UpdateBy = uInfo.AccountName;
                roleAdd.UpdateTime = DateTime.Now;

                int roleId = new RoleBLL().AddRole(roleAdd);
                if (roleId > 0)
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
        public ActionResult RoleEdit()
        {
            return View();
        }

        /// <summary>
        /// 编辑 用户
        /// </summary>
        /// <returns></returns>
        public ActionResult EditRole()
        {
            try
            {
                int id = Convert.ToInt32(Request["id"]);
                string originalName = Request["originalName"];
                string rolename = Request["RoleName"];
                string description = Request["Description"];
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                RoleEntity roleEdit = new RoleEntity();
                roleEdit.Id = id;
                roleEdit.RoleName = rolename.Trim();
                roleEdit.Description = description.Trim();
                roleEdit.UpdateBy = uInfo.AccountName;
                roleEdit.UpdateTime = DateTime.Now;
                if (new RoleBLL().EditRole(roleEdit, originalName))
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

        public ActionResult DelRoleByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new RoleBLL().DeleteRole(int.Parse(Ids)))
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
        /// 角色菜单权限 页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult RoleMenu()
        {
            return View();
        }

        /// <summary>
        /// 新增 角色菜单权限
        /// </summary>
        /// <returns></returns>
        public ActionResult SetRoleMenu()
        {
            try
            {
                string menuIds = Request["menuIds"].Trim(',');
                int roleId = Convert.ToInt32(Request["roleId"]);
                if (new RoleBLL().SetRoleMenu(roleId, menuIds))
                {
                    return Content("{\"msg\":\"授权成功！\",\"success\":true}");
                }
                else
                {
                    return Content("{\"msg\":\"授权失败！\",\"success\":false}");
                }
            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"授权失败," + ex.Message + "\",\"success\":false}");
            }
        }

        /// <summary>
        /// 获取角色所属用户
        /// </summary>
        /// <returns></returns>
        public ActionResult GetRoleUserByRoleId()
        {
            int roleUserId = int.Parse(Request["roleId"]);
            string sortRoleUser = Request["sort"];  //排序列
            string orderRoleUser = Request["order"];  //排序方式 asc或者desc
            int pageindexRoleUser = int.Parse(Request["page"]);
            int pagesizeRoleUser = int.Parse(Request["rows"]);

            string strJsonRoleUser = new RoleBLL().GetPagerRoleUser(roleUserId, sortRoleUser + " " + orderRoleUser, pagesizeRoleUser, pageindexRoleUser);
            return Content(strJsonRoleUser);
        }

        /// <summary>
        /// 新增 角色菜单按钮权限
        /// </summary>
        /// <returns></returns>
        public ActionResult SetRoleMenuButton() 
        {
            try
            {
                string menuButtonId = Request["menuButtonId"].Trim(',');
                int roleId = Convert.ToInt32(Request["roleId"]);
                
                bool res = new RoleBLL().Authorize(roleId, menuButtonId); //new RoleBLL().Authorize(roleId, menuButtonId)
                if (res)
                {
                    return Content("{\"msg\":\"授权成功！\",\"success\":true}");
                }
                else
                {
                    return Content("{\"msg\":\"授权失败！\",\"success\":false}");
                }
            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"授权失败," + ex.Message + "\",\"success\":false}");
            }
        }

    }
}
