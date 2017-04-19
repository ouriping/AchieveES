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
    public class TableDAL : ITableDAL
    {
        public bool ExistsTabName(string tabName)
        {
            string sql = "select count(1)num from tbTable where TabName = @TabName ";
            SqlParameter[] parameters = {
			            new SqlParameter("@TabName", SqlDbType.NVarChar,50)
            };
            parameters[0].Value = tabName;
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

        public bool ExistsTabViewName(string tabViewName)
        {
            string sql = "select count(1)num from tbTable where TabViewName = @TabViewName";
            SqlParameter[] parameters = {
                        new SqlParameter("@TabViewName", SqlDbType.NVarChar,50)
            };
            parameters[0].Value = tabViewName;
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
        public int Add(TableEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbTable(");
            strSql.Append("TabName,TabViewName,IsActive,CreateTime,CreateBy,UpdateTime,UpdateBy");
            strSql.Append(") values (");
            strSql.Append("@TabName,@TabViewName,@IsActive,@CreateTime,@CreateBy,@UpdateTime,@UpdateBy");
            strSql.Append(") ");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
			            new SqlParameter("@TabName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@TabViewName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@IsActive", SqlDbType.Bit,1) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50)
            };

            parameters[0].Value = model.TabName;
            parameters[1].Value = model.TabViewName;
            parameters[2].Value = model.IsActive;
            parameters[3].Value = model.CreateTime;
            parameters[4].Value = model.CreateBy;
            parameters[5].Value = model.UpdateTime;
            parameters[6].Value = model.UpdateBy;
            object obj = Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters));
            return Convert.ToInt32(obj);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public int Update(TableEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbTable set ");
            strSql.Append(" TabName = @TabName , ");
            strSql.Append(" TabViewName = @TabViewName , ");
            strSql.Append(" IsActive = @IsActive , ");
            strSql.Append(" CreateTime = @CreateTime , ");
            strSql.Append(" CreateBy = @CreateBy , ");
            strSql.Append(" UpdateTime = @UpdateTime , ");
            strSql.Append(" UpdateBy = @UpdateBy  ");
            strSql.Append(" where Id=@Id ");

            SqlParameter[] parameters = {
			            new SqlParameter("@Id", SqlDbType.Int,4) ,            
                        new SqlParameter("@TabName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@TabViewName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@IsActive", SqlDbType.Bit,1) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50)             
              
            };

            parameters[0].Value = model.Id;
            parameters[1].Value = model.TabName;
            parameters[2].Value = model.TabViewName;
            parameters[3].Value = model.IsActive;
            parameters[4].Value = model.CreateTime;
            parameters[5].Value = model.CreateBy;
            parameters[6].Value = model.UpdateTime;
            parameters[7].Value = model.UpdateBy;
            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);

            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tbTable ");
            strSql.Append(" where Id=@Id");
            SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
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
            list.Add("delete from tbTable where Id in (" + idlist + ")");
            list.Add("delete from tbFields where TabId in (" + idlist + ")");

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
        public TableEntity GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select Id, TabName, TabViewName, IsActive, CreateTime, CreateBy, UpdateTime, UpdateBy  ");
            strSql.Append("  from tbTable ");
            strSql.Append(" where Id=@Id");
            SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
            parameters[0].Value = id;


            TableEntity model = new TableEntity();
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);

            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Id"].ToString() != "")
                {
                    model.Id = int.Parse(dt.Rows[0]["Id"].ToString());
                }
                model.TabName = dt.Rows[0]["TabName"].ToString();
                model.TabViewName = dt.Rows[0]["TabViewName"].ToString();
                if (dt.Rows[0]["IsActive"].ToString() != "")
                {
                    if ((dt.Rows[0]["IsActive"].ToString() == "1") || (dt.Rows[0]["IsActive"].ToString().ToLower() == "true"))
                    {
                        model.IsActive = true;
                    }
                    else
                    {
                        model.IsActive = false;
                    }
                }
                if (dt.Rows[0]["CreateTime"].ToString() != "")
                {
                    model.CreateTime = DateTime.Parse(dt.Rows[0]["CreateTime"].ToString());
                }
                model.CreateBy = dt.Rows[0]["CreateBy"].ToString();
                if (dt.Rows[0]["UpdateTime"].ToString() != "")
                {
                    model.UpdateTime = DateTime.Parse(dt.Rows[0]["UpdateTime"].ToString());
                }
                model.UpdateBy = dt.Rows[0]["UpdateBy"].ToString();

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
            strSql.Append("select Id,TabName,TabViewName,IsActive,CreateTime,CreateBy,UpdateTime,UpdateBy ");
            strSql.Append(" FROM tbTable ");
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
            strSql.Append(" Id,TabName,TabViewName,IsActive,CreateTime,CreateBy,UpdateTime,UpdateBy ");
            strSql.Append(" FROM tbTable ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }
    }
}
