using AchieveBLL;
using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AchieveManageWeb.Controllers
{
    [AchieveManageWeb.App_Start.JudgmentLogin]
    public class DepartmentController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllDepartmentInfo()
        {
            string strJson = new DepartmentBLL().GetAllDepartment(null);
            return Content(strJson);
        }

        public ActionResult GetDepartmentUser()
        {
            string userDepartmentIds = Request["departmentId"];
            string sortDepartmentUser = Request["sort"];  //排序列
            string orderDepartmentUser = Request["order"];  //排序方式 asc或者desc
            int pageindexDepartmentUser = int.Parse(Request["page"]);
            int pagesizeDepartmentUser = int.Parse(Request["rows"]);

            string strJsonDepartmentUser = new DepartmentBLL().GetPagerDepartmentUser(userDepartmentIds, sortDepartmentUser + " " + orderDepartmentUser, pagesizeDepartmentUser, pageindexDepartmentUser);
            return Content(strJsonDepartmentUser);
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult DepartmentAdd()
        {
            return View();
        }

        /// <summary>
        /// 新增
        /// </summary>
        /// <returns></returns>
        public ActionResult AddDepartment()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;       
                DepartmentEntity departmentAdd = new DepartmentEntity();
                departmentAdd.DepartmentName = Request["DepartmentName"];
                departmentAdd.Sort = Convert.ToInt32(Request["Sort"]);
                if (Request["ParentId"] != null && Request.Params["ParentId"] != "")
                {
                    departmentAdd.ParentId = Convert.ToInt32(Request["ParentId"]);
                }
                else
                {
                    departmentAdd.ParentId = 0;   //根节点
                }
                departmentAdd.CreateBy = uInfo.AccountName;
                departmentAdd.CreateTime = DateTime.Now;
                departmentAdd.UpdateBy = uInfo.AccountName;
                departmentAdd.UpdateTime = DateTime.Now;
                int departmentId = new DepartmentBLL().AddDepartment(departmentAdd);
                if (departmentId > 0)
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
        public ActionResult DepartmentEdit()
        {
            return View();
        }

        /// <summary>
        /// 编辑
        /// </summary>
        /// <returns></returns>
        public ActionResult EditDepartment()
        {
            try
            {
                int id = Convert.ToInt32(Request["id"]);
                UserEntity uInfo = ViewData["Account"] as UserEntity;      
                DepartmentEntity departmentEdit = new DepartmentEntity();
                departmentEdit.Id = id;
                departmentEdit.DepartmentName = Request["DepartmentName"];
                departmentEdit.Sort = Convert.ToInt32(Request["Sort"]);
                departmentEdit.UpdateBy = uInfo.AccountName;
                departmentEdit.UpdateTime = DateTime.Now;
                bool result = new DepartmentBLL().EditDepartment(departmentEdit);
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

        public ActionResult DelDepartmentByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new DepartmentBLL().DeleteDepartment(Ids))
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

        public ActionResult GetAllDepartmentTree()
        {
            string jsonStr = new DepartmentBLL().GetAllDepartment("1=1");
            return Content(jsonStr);
        }

    }
}
