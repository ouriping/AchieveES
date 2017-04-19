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
    public class HtmlTypeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllHtmlTypeInfo()
        {
            string strWhere = "1=1";
            string sort = Request["sort"] == null ? "id" : Request["sort"];
            string order = Request["order"] == null ? "asc" : Request["order"];
            if (!string.IsNullOrEmpty(Request["HtmlTypeName"]) && !SqlInjection.GetString(Request["HtmlTypeName"]))
            {
                strWhere += " and HtmlTypeName like '%" + Request["HtmlTypeName"] + "%'";
            }

            //首先获取前台传递过来的参数
            int pageindex = Request["page"] == null ? 1 : Convert.ToInt32(Request["page"]);
            int pagesize = Request["rows"] == null ? 10 : Convert.ToInt32(Request["rows"]);
            int totalCount = 0;   //输出参数
            string strJson = new HtmlTypeBLL().GetPager("tbHtmlType", "Id,HtmlTypeName,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);

            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult HtmlTypeAdd()
        {
            return View();
        }

        /// <summary>
        /// 新增
        /// </summary>
        /// <returns></returns>
        public ActionResult AddHtmlType()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                HtmlTypeEntity typeAdd = new HtmlTypeEntity();
                typeAdd.HtmlTypeName = Request["HtmlTypeName"];
                typeAdd.Sort = int.Parse(Request["Sort"]);
                typeAdd.CreateBy = uInfo.AccountName;
                typeAdd.CreateTime = DateTime.Now;
                typeAdd.UpdateBy = uInfo.AccountName;
                typeAdd.UpdateTime = DateTime.Now;
                bool exists = new HtmlTypeBLL().Exists(typeAdd.HtmlTypeName);
                if (exists)
                {
                    return Content("{\"msg\":\"添加失败,类型名称已存在！\",\"success\":false}");
                }
                else
                {
                    int typeId = new HtmlTypeBLL().Add(typeAdd);
                    if (typeId > 0)
                    {
                        return Content("{\"msg\":\"添加成功！\",\"success\":true}");
                    }
                    else
                    {
                        return Content("{\"msg\":\"添加失败！\",\"success\":false}");
                    }
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
        public ActionResult HtmlTypeEdit()
        {
            return View();
        }

        /// <summary>
        /// 编辑
        /// </summary>
        /// <returns></returns>
        public ActionResult EditHtmlType()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;

                int id = Convert.ToInt32(Request["id"]);
                string originalName = Request["originalName"];

                HtmlTypeEntity typeEdit = new HtmlTypeBLL().GetModel(id);
                typeEdit.HtmlTypeName = Request["HtmlTypeName"];
                typeEdit.Sort = int.Parse(Request["Sort"]);
                typeEdit.UpdateBy = uInfo.AccountName;
                typeEdit.UpdateTime = DateTime.Now;
                bool exists = new HtmlTypeBLL().Exists(typeEdit.HtmlTypeName);
                if (typeEdit.HtmlTypeName != originalName && exists)
                {
                    return Content("{\"msg\":\"修改失败,类型名称已存在！\",\"success\":false}");
                }
                else
                {
                    int result = new HtmlTypeBLL().Update(typeEdit);
                    if (result > 0)
                    {
                        return Content("{\"msg\":\"修改成功！\",\"success\":true}");
                    }
                    else
                    {
                        return Content("{\"msg\":\"修改失败！\",\"success\":false}");
                    }
                }
            }
            catch (Exception ex)
            {
                return Content("{\"msg\":\"修改失败," + ex.Message + "\",\"success\":false}");
            }
        }

        public ActionResult DelHtmlTypeByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new HtmlTypeBLL().DeleteList(Ids))
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

        public ActionResult GetAllHtmlTypeDrop()
        {
            string roleJson = new HtmlTypeBLL().GetAllHtmlTypeInfo("1=1");
            return Content(roleJson);

        }
    }
}
