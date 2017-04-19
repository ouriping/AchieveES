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
    public class RequestionController : Controller
    {
        //
        // GET: /Requestion/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllRequestionInfo()
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
                strJson = new RequestionBLL().GetPager("vw_requestion", "id,ftypeid,ftitle,fcontent,ftypename,fsort,CreateTime,CreateBy,UpdateTime,UpdateBy", sortMulti.Trim(','), pagesize, pageindex, strWhere, out totalCount);
            }
            else
            {
                strJson = new RequestionBLL().GetPager("vw_requestion", "id,ftypeid,ftitle,fcontent,ftypename,fsort,CreateTime,CreateBy,UpdateTime,UpdateBy", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);
            }
            var jsonResult = new { total = totalCount.ToString(), rows = strJson };
            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult RequestionAdd()
        {
            return View();
        }

        [HttpPost]
        [ValidateInput(false)] 
        public ActionResult AddRequestion()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                RequestionEntity requestionAdd = new RequestionEntity();
                requestionAdd.ftitle = Request["FTitle"];
                requestionAdd.ftypeid = int.Parse(Request["FTypeId"]);
                requestionAdd.fcontent = Request["FContent"];
                requestionAdd.CreateBy = uInfo.AccountName;
                requestionAdd.CreateTime = DateTime.Now;
                requestionAdd.UpdateBy = uInfo.AccountName;
                requestionAdd.UpdateTime = DateTime.Now;

                int id = new RequestionBLL().Add(requestionAdd);
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
        public ActionResult RequestionEdit()
        {
            int id = 0;
            if (!string.IsNullOrEmpty(Request["id"]))
            {
                id = int.Parse(Request["id"]);
                RequestionEntity requestionEdit = new RequestionBLL().GetModel(id);
                return View(requestionEdit);
            }
            return new EmptyResult();
        }

        [HttpPost]
        [ValidateInput(false)] 
        public ActionResult EditRequestion()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;

                int id = Convert.ToInt32(Request["id"]);
                RequestionEntity requestionEdit = new RequestionBLL().GetModel(id);
                requestionEdit.ftitle = Request["FTitle"];
                requestionEdit.ftypeid = int.Parse(Request["FTypeId"]);
                requestionEdit.fcontent = Request["FContent"];
                requestionEdit.UpdateBy = uInfo.AccountName;
                requestionEdit.UpdateTime = DateTime.Now;
                int result = new RequestionBLL().Update(requestionEdit);
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

        public ActionResult DelRequestionByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new RequestionBLL().DeleteList(Ids))
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
    }
}
