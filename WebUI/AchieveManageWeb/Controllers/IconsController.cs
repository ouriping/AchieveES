using AchieveBLL;
using AchieveCommon;
using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AchieveManageWeb.Controllers
{
    [AchieveManageWeb.App_Start.JudgmentLogin]
    public class IconsController : Controller
    {
        //
        // GET: /Icons/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetAllIconsInfo()
        {
            string strWhere = "1=1";
            string sort = Request["sort"] == null ? "id" : Request["sort"];
            string order = Request["order"] == null ? "asc" : Request["order"];
            if (!string.IsNullOrEmpty(Request["IconName"]) && !SqlInjection.GetString(Request["IconName"]))
            {
                strWhere += " and IconName like '%" + Request["IconName"] + "%'";
            }

            //首先获取前台传递过来的参数
            int pageindex = Request["page"] == null ? 1 : Convert.ToInt32(Request["page"]);
            int pagesize = Request["rows"] == null ? 10 : Convert.ToInt32(Request["rows"]);
            int totalCount = 0;   //输出参数
            string strJson = new IconsBLL().GetPager("tbIcons", "Id,IconName,IconCssInfo,CreateTime,CreateBy,UpdateTime,UpdateBy", sort + " " + order, pagesize, pageindex, strWhere, out totalCount);

            return Content("{\"total\": " + totalCount.ToString() + ",\"rows\":" + strJson + "}");
        }

        /// <summary>
        /// 新增页面展示
        /// </summary>
        /// <returns></returns>
        public ActionResult IconsAdd()
        {
            return View();
        }

        /// <summary>
        /// 新增
        /// </summary>
        /// <returns></returns>
        public ActionResult AddIcons()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;
                IconsEntity typeAdd = new IconsEntity();
                typeAdd.IconName = Request["IconName"];
                typeAdd.IconCssInfo = Request["IconCssInfo"];
                typeAdd.CreateBy = uInfo.AccountName;
                typeAdd.CreateTime = DateTime.Now;
                typeAdd.UpdateBy = uInfo.AccountName;
                typeAdd.UpdateTime = DateTime.Now;
                bool exists = new IconsBLL().ExistsIconName(typeAdd.IconName);
                if (exists)
                {
                    return Content("{\"msg\":\"添加失败,图标名称已存在！\",\"success\":false}");
                }
                else
                {
                    int typeId = new IconsBLL().Add(typeAdd);
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
        public ActionResult IconsEdit()
        {
            return View();
        }

        /// <summary>
        /// 编辑
        /// </summary>
        /// <returns></returns>
        public ActionResult EditIcons()
        {
            try
            {
                UserEntity uInfo = ViewData["Account"] as UserEntity;

                int id = Convert.ToInt32(Request["id"]);
                string originalName = Request["originalName"];

                IconsEntity typeEdit = new IconsBLL().GetModel(id);
                typeEdit.IconName = Request["IconName"];
                typeEdit.IconCssInfo = Request["IconCssInfo"];
                typeEdit.UpdateBy = uInfo.AccountName;
                typeEdit.UpdateTime = DateTime.Now;
                bool exists = new IconsBLL().ExistsIconName(typeEdit.IconName);
                if (typeEdit.IconName != originalName && exists)
                {
                    return Content("{\"msg\":\"修改失败,图标名称已存在！\",\"success\":false}");
                }
                else
                {
                    int result = new IconsBLL().Update(typeEdit);
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

        public ActionResult DelIconsByIDs()
        {
            try
            {
                string Ids = Request["IDs"] == null ? "" : Request["IDs"];
                if (!string.IsNullOrEmpty(Ids))
                {
                    if (new IconsBLL().DeleteList(Ids))
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
        /// 获取按钮树
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAllIconsTree()
        {
            string jsonStr = new IconsBLL().GetAllIconsTree("1=1");
            return Content(jsonStr);
        }

        /// <summary>
        /// 获取所有图片 并显示
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAllImgInfo()
        {
            FileInfo[] fs = (new DirectoryInfo(Server.MapPath("~/Content/themes/icon"))).GetFiles();
            string sb = "[";
            foreach (FileInfo file in fs)
            {
                string iconName = "icon-" + Path.GetFileNameWithoutExtension(file.Name);
                sb += "{\"id\":\"" + iconName + "\",\"text\":\"" + iconName + "\",\"iconCls\":\"" + iconName + "\"},";
            }
            sb = sb.Trim(",".ToCharArray());
            sb += "]";
            return Content(sb.ToString());
        }
    }
}
