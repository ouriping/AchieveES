using AchieveCommon;
using AchieveEntity;
using AchieveInterfaceDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace AchieveDAL
{
    public class HtmlTypeDAL : IHtmlTypeDAL
    {
        public bool Exists(string name)
        {
            string sql = "select count(1)num from tbHtmlType where HtmlTypeName = @HtmlTypeName";
            SqlParameter[] parameters = {
			            new SqlParameter("@HtmlTypeName", SqlDbType.NVarChar,50)
            };
            parameters[0].Value = name;
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sql, parameters);
            if (int.Parse(dt.Rows[0]["num"].ToString()) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(HtmlTypeEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbHtmlType(");
            strSql.Append("HtmlTypeName,Sort,CreateBy,CreateTime,UpdateBy,UpdateTime");
            strSql.Append(") values (");
            strSql.Append("@HtmlTypeName,@Sort,@CreateBy,@CreateTime,@UpdateBy,@UpdateTime");
            strSql.Append(") ");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
			            new SqlParameter("@HtmlTypeName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime),
                        new SqlParameter("@Sort", SqlDbType.Int)                
            };

            parameters[0].Value = model.HtmlTypeName;
            parameters[1].Value = model.CreateBy;
            parameters[2].Value = model.CreateTime;
            parameters[3].Value = model.UpdateBy;
            parameters[4].Value = model.UpdateTime;
            parameters[5].Value = model.Sort;
            object obj = Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters));
            return Convert.ToInt32(obj);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public int Update(HtmlTypeEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbHtmlType set ");
            strSql.Append(" HtmlTypeName = @HtmlTypeName , ");
            strSql.Append(" Sort = @Sort , ");
            strSql.Append(" CreateBy = @CreateBy , ");
            strSql.Append(" CreateTime = @CreateTime , ");
            strSql.Append(" UpdateBy = @UpdateBy , ");
            strSql.Append(" UpdateTime = @UpdateTime  ");
            strSql.Append(" where id=@id ");

            SqlParameter[] parameters = {
			            new SqlParameter("@id", SqlDbType.Int,4) ,            
                        new SqlParameter("@HtmlTypeName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime),
                        new SqlParameter("@Sort", SqlDbType.Int)  
              
            };

            parameters[0].Value = model.id;
            parameters[1].Value = model.HtmlTypeName;
            parameters[2].Value = model.CreateBy;
            parameters[3].Value = model.CreateTime;
            parameters[4].Value = model.UpdateBy;
            parameters[5].Value = model.UpdateTime;
            parameters[6].Value = model.Sort;

            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);
            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tbHtmlType ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;
            int rows = Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters));
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 批量删除一批数据
        /// </summary>
        public bool DeleteList(string idlist)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbHtmlType where Id in (" + idlist + ")");
            list.Add("delete from tbNews where ftypeid in (" + idlist + ")");

            try
            {
                if (SqlHelper.ExecuteNonQuery(SqlHelper.connStr, list) > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch
            {
                return false;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public HtmlTypeEntity GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id, HtmlTypeName, Sort, CreateTime,CreateBy,UpdateTime,UpdateBy ");
            strSql.Append("  from tbHtmlType ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;


            HtmlTypeEntity model = new HtmlTypeEntity();
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);

            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["id"].ToString() != "")
                {
                    model.id = int.Parse(dt.Rows[0]["id"].ToString());
                }
                model.HtmlTypeName = dt.Rows[0]["HtmlTypeName"].ToString();
                if (dt.Rows[0]["Sort"].ToString() != "")
                {
                    model.Sort = int.Parse(dt.Rows[0]["Sort"].ToString());
                }
                model.CreateBy = dt.Rows[0]["CreateBy"].ToString();
                if (dt.Rows[0]["CreateTime"].ToString() != "")
                {
                    model.CreateTime = DateTime.Parse(dt.Rows[0]["CreateTime"].ToString());
                }
                model.UpdateBy = dt.Rows[0]["UpdateBy"].ToString();
                if (dt.Rows[0]["UpdateTime"].ToString() != "")
                {
                    model.UpdateTime = DateTime.Parse(dt.Rows[0]["UpdateTime"].ToString());
                }
                return model;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataTable GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select Id,HtmlTypeName,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy ");
            strSql.Append(" FROM tbHtmlType ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataTable GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" Id,HtmlTypeName,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy ");
            strSql.Append(" FROM tbHtmlType ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }
    }
}
