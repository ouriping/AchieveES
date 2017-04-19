using AchieveCommon;
using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace AchieveDAL
{
    public class MyTestDAL
    {
        /// <summary>
        /// 获取测试数据
        /// </summary>
        /// <param name="key"></param>
        /// <param name="PageSize"></param>
        /// <param name="CurrentCount"></param>
        /// <param name="TotalCount"></param>
        /// <returns></returns>
        public List<ArticleEntity> GetArticleList(string key, int PageSize, int CurrentCount, out int TotalCount)
        {
            string tabName = string.Format("Article");
            string strWhere = " 1=1";
            if (!string.IsNullOrEmpty(key))
            {
                //SQL关键字过滤 包含关键字则不拼接SQL
                if (!SqlInjection.GetString(key))
                {
                    strWhere += string.Format(" AND (Title LIKE '%{0}%' OR Content LIKE '%{0}%')", key);
                }
            }
            string Order = string.Format("ID DESC");
            DataSet ds = SqlHelper.GetList(SqlHelper.connStr, Order, PageSize, CurrentCount, tabName, strWhere, out TotalCount);
            List<ArticleEntity> list = new List<ArticleEntity>();
            if (ds != null && ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    ArticleEntity model = new ArticleEntity();
                    model.ID = Convert.ToInt32(dr["ID"]);
                    model.Title = dr["Title"].ToString();
                    model.Content = dr["Content"].ToString();
                    list.Add(model);
                }
            }
            return list;
        }


        /// <summary>
        /// 添加菜单
        /// </summary>
        public int AddArticle(AchieveEntity.ArticleEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into Article(Title,Content)");
            strSql.Append(" values ");
            strSql.Append("(@Title,@Content)");
            strSql.Append(";SELECT @@IDENTITY");   //返回插入用户的主键
            SqlParameter[] paras = { 
                                   new SqlParameter("@Title",SqlDbType.VarChar,200),
                                   new SqlParameter("@Content",SqlDbType.VarChar,8000)
                                   };
            paras[0].Value = model.Title;
            paras[1].Value = model.Content;
            return Convert.ToInt32(AchieveCommon.SqlHelper.ExecuteScalar(AchieveCommon.SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras));
        }

    }
}
