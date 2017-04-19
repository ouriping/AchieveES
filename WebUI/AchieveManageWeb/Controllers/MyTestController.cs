using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using AchieveCommon;
using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Text;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using Webdiyer.WebControls.Mvc;

namespace AchieveManageWeb.Controllers
{
    /// <summary>
    /// 测试控制器 
    /// </summary>
    public class MyTestController : Controller
    {
        /// <summary>
        /// 缓存测试
        /// </summary>
        /// <returns></returns>
        [OutputCache(Duration = 10)]
        public ActionResult Index()
        {
            ViewBag.CurrentTime = DateTime.Now;
            return View();
        }

        /// <summary>
        /// 同步分页测试
        /// </summary>
        /// <param name="id">pageIndex</param>
        /// <param name="key">关键字</param>
        /// <returns></returns>
        public ActionResult MVCPager(int? id = 1, string key = null)
        {
            int totalCount = 0;
            int pageIndex = id ?? 1;
            int pageSize = 5;
            List<ArticleEntity> infoList = new AchieveDAL.MyTestDAL().GetArticleList(key, pageSize, (pageIndex - 1) * pageSize, out totalCount);
            PagedList<ArticleEntity> InfoPager = infoList.AsQueryable().OrderByDescending(o => o.ID).ToPagedList(pageIndex, pageSize);
            InfoPager.TotalItemCount = totalCount;
            InfoPager.CurrentPageIndex = (int)(id ?? 1);
            Session["pager_totalcount"] = totalCount;
            //数据组装到viewModel
            Models.MyTest.MVCPager model = new Models.MyTest.MVCPager();
            model.Articles = InfoPager;
            return View(model);
        }

        /// <summary>
        /// 异步分页测试
        /// </summary>
        /// <param name="id">pageIndex</param>
        /// <param name="key">关键字</param>
        /// <returns></returns>
        public ActionResult AjaxPaging(int? id = 1, string key = null)
        {
            int totalCount = 0;
            int pageIndex = id ?? 1;
            int pageSize = 5;
            List<ArticleEntity> infoList = new AchieveDAL.MyTestDAL().GetArticleList(key, pageSize, (pageIndex - 1) * pageSize, out totalCount);
            PagedList<ArticleEntity> InfoPager = infoList.AsQueryable().OrderByDescending(o => o.ID).ToPagedList(pageIndex, pageSize);
            InfoPager.TotalItemCount = totalCount;
            InfoPager.CurrentPageIndex = (int)(id ?? 1);
            Session["pager_totalcount"] = totalCount;
            Models.MyTest.AjaxPager model = new Models.MyTest.AjaxPager();
            model.Articles = InfoPager;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_ArticleList", model);
            }
            return View(model);
        }



        /// <summary>
        /// 批量导出
        /// </summary>
        /// <returns></returns>
        public FileResult ExportStu()
        {
            //创建Excel文件的对象
            NPOI.HSSF.UserModel.HSSFWorkbook book = new NPOI.HSSF.UserModel.HSSFWorkbook();
            //添加一个sheet
            NPOI.SS.UserModel.ISheet sheet1 = book.CreateSheet("Sheet1");
            int pager_totalcount = (int)Session["pager_totalcount"];
            int totalCount = 0;
            //获取list数据
            List<ArticleEntity> infoList = new AchieveDAL.MyTestDAL().GetArticleList("", pager_totalcount, 1, out totalCount);

            //给sheet1添加第一行的头部标题
            NPOI.SS.UserModel.IRow row1 = sheet1.CreateRow(0);
            //创建时间	名称	商户订单号 | 交易号	对方	金额(元)	状态
            row1.CreateCell(0).SetCellValue("编号");
            row1.CreateCell(1).SetCellValue("标题");
            row1.CreateCell(2).SetCellValue("内容");
            int Width = 256;
            sheet1.SetColumnWidth(0, 10 * Width);
            sheet1.SetColumnWidth(1, 25 * Width);
            sheet1.SetColumnWidth(2, 60 * Width);
            if (infoList != null)
            {
                var list = infoList.OrderByDescending(p => p.ID);

                if (list != null)
                {
                    int i = 0;
                    //将数据逐步写入sheet1各个行
                    foreach (var item in list)
                    {
                        i = i + 1;
                        NPOI.SS.UserModel.IRow rowtemp = sheet1.CreateRow(i);
                        rowtemp.CreateCell(0).SetCellValue(item.ID.ToString());
                        rowtemp.CreateCell(1).SetCellValue(item.Title == null ? "" : item.Title.ToString());
                        rowtemp.CreateCell(2).SetCellValue(item.Content == null ? "" : item.Content.ToString());
                    }
                }
            }
            // 写入到客户端 
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            book.Write(ms);
            ms.Seek(0, System.IO.SeekOrigin.Begin);
            return File(ms, "application/vnd.ms-excel", HttpUtility.UrlEncode("导出", Encoding.UTF8).ToString() + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls");

        }

        /// <summary>
        /// 批量导入
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ImportStu()
        {
            HttpPostedFileBase file = Request.Files["file"];
            string FileName;
            string savePath;
            if (file == null || file.ContentLength <= 0)
            {
                return Content("<script>alert('上传失败,请选择上传文件!');location.href='/MyTest/MVCPager';</script>");
            }
            else
            {
                string filename = Path.GetFileName(file.FileName);
                int filesize = file.ContentLength;//获取上传文件的大小单位为字节byte
                string fileEx = System.IO.Path.GetExtension(filename);//获取上传文件的扩展名
                string NoFileName = System.IO.Path.GetFileNameWithoutExtension(filename);//获取无扩展名的文件名
                string FileType = ".xls,.xlsx";//定义上传文件的类型字符串
                if (FileType.Contains(".exe"))//EXCEL
                {
                    return Content("<script>alert('上传文件类型格式错误,不允许导入exe格式的文件!');location.href='/MyTest/MVCPager';</script>");
                }
                FileName = NoFileName + DateTime.Now.ToString("yyyyMMddhhmmss") + fileEx;
                string path = AppDomain.CurrentDomain.BaseDirectory + "uploads/";
                savePath = Path.Combine(path, FileName);
                file.SaveAs(savePath);

                if (FileType.Contains(fileEx))//EXCEL
                {
                    string strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + savePath + ";" + "Extended Properties=Excel 8.0";
                    OleDbConnection conn = new OleDbConnection(strConn);
                    conn.Open();
                    OleDbDataAdapter myCommand = new OleDbDataAdapter("select * from [Sheet1$]", strConn);
                    DataSet myDataSet = new DataSet();
                    try
                    {
                        myCommand.Fill(myDataSet, "ExcelInfo");
                    }
                    catch (Exception ex)
                    {
                        return Content("<script>alert('上传失败," + ex.Message + "!');location.href='/MyTest/MVCPager';</script>");
                    }
                    //列顺序 标题 内容
                    DataTable table = myDataSet.Tables["ExcelInfo"].DefaultView.ToTable();

                    //事物 异常回滚
                    using (TransactionScope transaction = new TransactionScope())
                    {
                        for (int i = 0; i < table.Rows.Count; i++)
                        {
                            ArticleEntity model = new ArticleEntity();
                            model.Title = table.Rows[i][0].ToString();
                            model.Content = table.Rows[i][1].ToString();
                            new AchieveDAL.MyTestDAL().AddArticle(model);
                        }
                        transaction.Complete();
                    }
                }

                return RedirectToAction("MVCPager", "MyTest");
            }
        }
    }
}
