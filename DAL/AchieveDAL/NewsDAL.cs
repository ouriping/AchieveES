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
    public class NewsDAL : INewsDAL
    {
        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(NewsEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbNews(");
            strSql.Append("ftypeid,ftitle,fcontent,CreateBy,CreateTime,UpdateBy,UpdateTime");
            strSql.Append(") values (");
            strSql.Append("@ftypeid,@ftitle,@fcontent,@CreateBy,@CreateTime,@UpdateBy,@UpdateTime");
            strSql.Append(") ");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
			            new SqlParameter("@ftypeid", SqlDbType.Int,4) ,            
                        new SqlParameter("@ftitle", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@fcontent", SqlDbType.Text) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime)             
              
            };

            parameters[0].Value = model.ftypeid;
            parameters[1].Value = model.ftitle;
            parameters[2].Value = model.fcontent;
            parameters[3].Value = model.CreateBy;
            parameters[4].Value = model.CreateTime;
            parameters[5].Value = model.UpdateBy;
            parameters[6].Value = model.UpdateTime;
            object obj = Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters));
            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 更新一条数据
        /// </summary>
        public int Update(NewsEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbNews set ");

            strSql.Append(" ftypeid = @ftypeid , ");
            strSql.Append(" ftitle = @ftitle , ");
            strSql.Append(" fcontent = @fcontent , ");
            strSql.Append(" CreateBy = @CreateBy , ");
            strSql.Append(" CreateTime = @CreateTime , ");
            strSql.Append(" UpdateBy = @UpdateBy , ");
            strSql.Append(" UpdateTime = @UpdateTime  ");
            strSql.Append(" where id=@id ");

            SqlParameter[] parameters = {
			            new SqlParameter("@id", SqlDbType.Int,4) ,            
                        new SqlParameter("@ftypeid", SqlDbType.Int,4) ,            
                        new SqlParameter("@ftitle", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@fcontent", SqlDbType.Text) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime)             
              
            };

            parameters[0].Value = model.id;
            parameters[1].Value = model.ftypeid;
            parameters[2].Value = model.ftitle;
            parameters[3].Value = model.fcontent;
            parameters[4].Value = model.CreateBy;
            parameters[5].Value = model.CreateTime;
            parameters[6].Value = model.UpdateBy;
            parameters[7].Value = model.UpdateTime;
            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);
            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tbNews ");
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
            list.Add("delete from tbNews where ID in (" + idlist + ")");

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
        public NewsEntity GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id, ftypeid, ftitle, fcontent, CreateBy, CreateTime, UpdateBy, UpdateTime  ");
            strSql.Append("  from tbNews ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;


            NewsEntity model = new NewsEntity();
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);

            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["id"].ToString() != "")
                {
                    model.id = int.Parse(dt.Rows[0]["id"].ToString());
                }
                if (dt.Rows[0]["ftypeid"].ToString() != "")
                {
                    model.ftypeid = int.Parse(dt.Rows[0]["ftypeid"].ToString());
                }
                model.ftitle = dt.Rows[0]["ftitle"].ToString();
                model.fcontent = dt.Rows[0]["fcontent"].ToString();
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
            strSql.Append("select * ");
            strSql.Append(" FROM tbNews ");
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
            strSql.Append(" * ");
            strSql.Append(" FROM tbNews ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }

    }
}
