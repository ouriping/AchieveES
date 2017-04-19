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
    public class NewsTypeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllNewsTypeInfo()
        {
            string strWhere = "1=1";
            string sort = Request["sort"] == null ? "id" : Request["sort"];
            string order = Request["order"] == null ? "asc" : Request["order"];
            if (!string.IsNullOrEmpty(Request["FTypeName"]) && !SqlInjection.GetString(Request["FTypeName"]))
            {
                strWhere += " and ftypename like '%" + Request["FTypeName"] + "%'";
            }
            //首先获取前台传递过来的参数
            int pageindex = Request["page"] == null ? 1 : Convert.ToInt32(Request["page"]);
            int pagesize = Request["rows"] == null ? 10 : Convert.ToInt32(Request["rows"]);
            int totalCount = 0;   //输出参数
            string strJson = new NewsTypeBLL().GetPager("tbNewsType", "[id],[ftypename],fsort,CreateTime,CreateBy,UpdateTime,UpdateBy", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);

            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult NewsTypeAdd()
        {
            return View();
        }

        /// <summary>
        /// 新增公告类型
        /// </summary>
        /// <returns></returns>
        public ActionResult AddNewsType()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                NewsTypeEntity typeAdd = new NewsTypeEntity();
                typeAdd.ftypename = Request["TypeName"];
                typeAdd.fsort = int.Parse(Request["Sort"] == null ? "0" : Request["Sort"]);
                typeAdd.CreateBy = uInfo.AccountName;
                typeAdd.CreateTime = DateTime.Now;
                typeAdd.UpdateBy = uInfo.AccountName;
                typeAdd.UpdateTime = DateTime.Now;
                bool exists = new NewsTypeBLL().Exists(typeAdd.ftypename);
                if (exists)
                {
                    return Content("{\"msg\":\"添加失败,类型名称已存在！\",\"success\":false}");
                }
                else
                {
                    int typeId = new NewsTypeBLL().Add(typeAdd);
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
        public ActionResult NewsTypeEdit()
        {
            return View();
        }

        /// <summary>
        /// 编辑公告类型
        /// </summary>
        /// <returns></returns>
        public ActionResult EditNewsType()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;

                int id = Convert.ToInt32(Request["id"]);
                string originalName = Request["originalName"];

                NewsTypeEntity typeEdit = new NewsTypeBLL().GetModel(id);
                typeEdit.ftypename = Request["TypeName"];
                typeEdit.fsort = int.Parse(Request["Sort"] == null ? "0" : Request["Sort"]);
                typeEdit.UpdateBy = uInfo.AccountName;
                typeEdit.UpdateTime = DateTime.Now;
                bool exists = new NewsTypeBLL().Exists(typeEdit.ftypename);
                if (typeEdit.ftypename != originalName && exists)
                {
                    return Content("{\"msg\":\"修改失败,类型名称已存在！\",\"success\":false}");
                }
                else
                {
                    int result = new NewsTypeBLL().Update(typeEdit);
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

        public ActionResult DelNewsTypeByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new NewsTypeBLL().DeleteList(Ids))
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

        public ActionResult GetAllNewsTypeDrop()
        {
            string roleJson = new NewsTypeBLL().GetAllNewsTypeInfo("1=1");
            return Content(roleJson);

        }
    }
}
