using AchieveBLL;
using AchieveCommon;
using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AchieveManageWeb.Controllers
{
    [AchieveManageWeb.App_Start.JudgmentLogin]
    public class NewsController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllNewsInfo()
        {
            string strWhere = "1=1";
            string sort = Request["sort"] == null ? "id" : Request["sort"];
            string order = Request["order"] == null ? "asc" : Request["order"];
            if (!string.IsNullOrEmpty(Request["ftitle"]) && !SqlInjection.GetString(Request["ftitle"]))
            {
                strWhere += " and ftitle like '%" + Request["ftitle"] + "%'";
            }
            if (!string.IsNullOrEmpty(Request["frequstid"]) && !SqlInjection.GetString(Request["frequstid"]))
            {
                strWhere += " and ftypeid =" + Request["frequstid"];
            }

            //首先获取前台传递过来的参数
            int pageindex = Request["page"] == null ? 1 : Convert.ToInt32(Request["page"]);
            int pagesize = Request["rows"] == null ? 10 : Convert.ToInt32(Request["rows"]);
            int totalCount = 0;   //输出参数
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
                strJson = new NewsBLL().GetPager("vw_News", "id,ftypeid,ftitle,fcontent,ftypename,fsort,CreateTime,CreateBy,UpdateTime,UpdateBy", sortMulti.Trim(','), pagesize, pageindex, strWhere, out totalCount);
            }
            else
            {
                strJson = new NewsBLL().GetPager("vw_News", "id,ftypeid,ftitle,fcontent,ftypename,fsort,CreateTime,CreateBy,UpdateTime,UpdateBy", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);
            }
            var jsonResult = new { total = totalCount.ToString(), rows = strJson };
            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult NewsAdd()
        {
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult AddNews()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                NewsEntity NewsAdd = new NewsEntity();
                NewsAdd.ftitle = Request["FTitle"];
                NewsAdd.ftypeid = int.Parse(Request["FTypeId"]);
                NewsAdd.fcontent = Request["FContent"];
                NewsAdd.CreateBy = uInfo.AccountName;
                NewsAdd.CreateTime = DateTime.Now;
                NewsAdd.UpdateBy = uInfo.AccountName;
                NewsAdd.UpdateTime = DateTime.Now;
                int id = new NewsBLL().Add(NewsAdd);
                if (id > 0)
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
                return Content("{\"msg\":\"修改失败," + ex.Message + "\",\"success\":false}");
            }
        }

        /// <summary>
        /// 编辑页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult NewsEdit()
        {
            int id = 0;
            if (!string.IsNullOrEmpty(Request["id"]))
            {
                id = int.Parse(Request["id"]);
                NewsEntity NewsEdit = new NewsBLL().GetModel(id);
                return View(NewsEdit);
            }
            return new EmptyResult();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult EditNews()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;

                int id = Convert.ToInt32(Request["id"]);
                NewsEntity NewsEdit = new NewsBLL().GetModel(id);
                NewsEdit.ftitle = Request["FTitle"];
                NewsEdit.ftypeid = int.Parse(Request["FTypeId"]);
                NewsEdit.fcontent = Request["FContent"];
                NewsEdit.UpdateBy = uInfo.AccountName;
                NewsEdit.UpdateTime = DateTime.Now;
                int result = new NewsBLL().Update(NewsEdit);
                if (result > 0)
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

        public ActionResult DelNewsByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new NewsBLL().DeleteList(Ids))
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
        /// 待完善  暂不使用
        /// </summary>
        /// <returns></returns>
        public ActionResult GetNewsList()
        {
            int newstypeid = int.Parse(Request["newstype"] ?? "0");
            string strWhere = " 1=1 and ftypeid =" + newstypeid;
            DataTable dt = new NewsBLL().GetList(10, strWhere, " id desc ");
            string strJson = "[";
            foreach (DataRow dr in dt.Rows)
            {
                strJson += "{\"text\":\"" + dr["ftitle"].ToString() + "\"},";
            }
            strJson = strJson.TrimEnd(',');
            strJson += "]";
            return Content(strJson);
        }
    }
}
