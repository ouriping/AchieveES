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
    public class FieldsController : Controller
    {
        //
        // GET: /Fields/

        public ActionResult Index()
        {
            return View();
        }


        public ActionResult GetAllFieldsInfo()
        {
            string strWhere = "1=1";
            string sort = Request["sort"] == null ? "Id" : Request["sort"];
            string order = Request["order"] == null ? "asc" : Request["order"];
            if (!string.IsNullOrEmpty(Request["FieldName"]) && !SqlInjection.GetString(Request["FieldName"]))
            {
                strWhere += " and FieldName like '%" + Request["FieldName"] + "%'";
            }
            if (!string.IsNullOrEmpty(Request["FieldViewName"]) && !SqlInjection.GetString(Request["FieldViewName"]))
            {
                strWhere += " and FieldViewName like '%" + Request["FieldViewName"] + "%'";
            }
            if (!string.IsNullOrEmpty(Request["SelTabId"]))
            {
                strWhere += " and TabId = '" + Request["SelTabId"] + "'";
            }
            //首先获取前台传递过来的参数
            int pageindex = Request["page"] == null ? 1 : Convert.ToInt32(Request["page"]);
            int pagesize = Request["rows"] == null ? 10 : Convert.ToInt32(Request["rows"]);
            int totalCount = 0;
            string strJson = "";    //输出结果
            if (order.IndexOf(',') != -1)   //如果有","就是多列排序（不能拿列判断，列名中间可能有","符号）
            {
                //多列排序：
                //sort：ParentId,Sort,AddDate
                //order：asc,desc,asc
                string sortMulti = "";  //拼接排序条件，例：TabId desc,Sort asc
                string[] sortArray = sort.Split(',');   //列名中间有","符号，这里也要出错。正常不会有
                string[] orderArray = order.Split(',');
                for (int i = 0; i < sortArray.Length; i++)
                {
                    sortMulti += sortArray[i] + " " + orderArray[i] + ",";
                }
                strJson = new FieldsBLL().GetPager("vw_Fields", "Id,TabId,FieldName,FieldViewName,FieldDataTypeId,IsActive,IsSearch,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy,DataType,DataTypeName,TabName,TabViewName", sortMulti.Trim(','), pagesize, pageindex, strWhere, out totalCount);
            }
            else
            {
                strJson = new FieldsBLL().GetPager("vw_Fields", "Id,TabId,FieldName,FieldViewName,FieldDataTypeId,IsActive,IsSearch,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy,DataType,DataTypeName,TabName,TabViewName", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);
            }
            var jsonResult = new { total = totalCount.ToString(), rows = strJson };
            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult FieldsAdd()
        {
            return View();
        }

        /// <summary>
        /// 新增字段
        /// </summary>
        /// <returns></returns>
        public ActionResult AddFields()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                FieldsEntity entityAdd = new FieldsEntity();
                entityAdd.TabId = int.Parse(Request["TabId"]);
                entityAdd.FieldName = Request["FieldName"].Trim();
                entityAdd.FieldViewName = Request["FieldViewName"].Trim();
                entityAdd.FieldDataTypeId = int.Parse(Request["FieldDataTypeId"]);
                entityAdd.IsActive = bool.Parse(Request["IsActive"]);
                entityAdd.IsSearch = bool.Parse(Request["IsSearch"]);
                entityAdd.CreateBy = uInfo.AccountName;
                entityAdd.CreateTime = DateTime.Now;
                entityAdd.UpdateBy = uInfo.AccountName;
                entityAdd.UpdateTime = DateTime.Now;
                entityAdd.Sort = int.Parse(Request["Sort"]);
                bool ExistsFieldName = new FieldsBLL().ExistsFieldName(entityAdd.FieldName, entityAdd.TabId);
                bool ExistsFieldViewName = new FieldsBLL().ExistsFieldViewName(entityAdd.FieldViewName, entityAdd.TabId);
                if (ExistsFieldName)
                {
                    return Content("{\"msg\":\"添加失败,字段名已存在！\",\"success\":false}");
                }
                else if (ExistsFieldViewName)
                {
                    return Content("{\"msg\":\"添加失败,字段显示名已存在！\",\"success\":false}");
                }
                else
                {
                    int entityId = new FieldsBLL().Add(entityAdd);
                    if (entityId > 0)
                    {
                        //新增数据库表字段 获取表信息
                        TableEntity tabEntity = new TableBLL().GetModel(entityAdd.TabId);
                        DataTypeEntity dataTypeEntity = new DataTypeBLL().GetModel(entityAdd.FieldDataTypeId);
                        string dbTabName = "tb_" + tabEntity.TabName;
                        if (Comm.AddTabField(dbTabName, entityAdd.FieldName, dataTypeEntity.DataType))
                        {
                            return Content("{\"msg\":\"添加成功！\",\"success\":true}");
                        }
                        else
                        {
                            return Content("{\"msg\":\"添加失败！\",\"success\":false}");
                        }
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
        public ActionResult FieldsEdit()
        {
            return View();
        }

        /// <summary>
        /// 编辑字段
        /// </summary>
        /// <returns></returns>
        public ActionResult EditFields()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;

                int id = Convert.ToInt32(Request["id"]);
                string originalName = Request["originalName"];
                string originalViewName = Request["originalViewName"];

                FieldsEntity entityEdit = new FieldsBLL().GetModel(id);
                entityEdit.FieldName = Request["FieldName"].Trim();
                entityEdit.FieldViewName = Request["FieldViewName"].Trim();
                entityEdit.FieldDataTypeId = int.Parse(Request["FieldDataTypeId"]);
                entityEdit.IsActive = bool.Parse(Request["IsActive"]);
                entityEdit.IsSearch = bool.Parse(Request["IsSearch"]);
                entityEdit.Sort = int.Parse(Request["Sort"]);
                entityEdit.UpdateBy = uInfo.AccountName;
                entityEdit.UpdateTime = DateTime.Now;
                bool ExistsFieldViewName = new FieldsBLL().ExistsFieldViewName(entityEdit.FieldViewName, entityEdit.TabId);
                if (entityEdit.FieldViewName != originalViewName && ExistsFieldViewName)
                {
                    return Content("{\"msg\":\"修改失败,字段显示名已存在！\",\"success\":false}");
                }
                else
                {
                    int result = new FieldsBLL().Update(entityEdit);
                    if (result > 0)
                    {
                        //新增数据库表字段 获取表信息
                        TableEntity tabEntity = new TableBLL().GetModel(entityEdit.TabId);
                        DataTypeEntity dataTypeEntity = new DataTypeBLL().GetModel(entityEdit.FieldDataTypeId);
                        string dbTabName = "tb_" + tabEntity.TabName;
                        if (Comm.UpdateTabField(dbTabName, entityEdit.FieldName, dataTypeEntity.DataType))
                        {
                            return Content("{\"msg\":\"修改成功！\",\"success\":true}");
                        }
                        else
                        {
                            return Content("{\"msg\":\"修改失败！\",\"success\":false}");
                        }
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

        public ActionResult DelFieldsByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    string[] idArr = Ids.TrimEnd(',').Split(',');
                    int num = 0;
                    foreach (string id in idArr)
                    {
                        FieldsEntity model = new FieldsBLL().GetModel(int.Parse(id));
                        TableEntity tabEntity = new TableBLL().GetModel(model.TabId);
                        string dbTabName = "tb_" + tabEntity.TabName;
                        if (Comm.DelTabField(dbTabName, model.FieldName))
                        {
                            num = num + 1;
                        }
                    }
                    if (idArr.Length == num)
                    {
                        if (new FieldsBLL().DeleteList(Ids))
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
                        return Content("{\"msg\":\"删除物理数据表失败！\",\"success\":false}");
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
