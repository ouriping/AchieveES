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
    //tbLoginIpLog
    public class LoginIpLogDAL : ILoginIpLogDAL
    {
        public bool Exists(int Id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1)num from tbLoginIpLog");
            strSql.Append(" where ");
            strSql.Append(" Id = @Id  ");
            SqlParameter[] parameters = {
                new SqlParameter("@Id", SqlDbType.Int, 4)
            };
            parameters[0].Value = Id;
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);
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
        public int Add(LoginIpLogEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbLoginIpLog(");
            strSql.Append("IpAddress,CreateTime,CreateBy,UpdateTime,UpdateBy");
            strSql.Append(") values (");
            strSql.Append("@IpAddress,@CreateTime,@CreateBy,@UpdateTime,@UpdateBy");
            strSql.Append(") ");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
			            new SqlParameter("@IpAddress", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50)             
              
            };

            parameters[0].Value = model.IpAddress;
            parameters[1].Value = model.CreateTime;
            parameters[2].Value = model.CreateBy;
            parameters[3].Value = model.UpdateTime;
            parameters[4].Value = model.UpdateBy;
            //insert
            object obj = Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters));
            return Convert.ToInt32(obj);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public int Update(LoginIpLogEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbLoginIpLog set ");

            strSql.Append(" IpAddress = @IpAddress , ");
            strSql.Append(" CreateTime = @CreateTime , ");
            strSql.Append(" CreateBy = @CreateBy , ");
            strSql.Append(" UpdateTime = @UpdateTime , ");
            strSql.Append(" UpdateBy = @UpdateBy  ");
            strSql.Append(" where Id=@Id");

            SqlParameter[] parameters = {
			            new SqlParameter("@Id", SqlDbType.Int,4) ,            
                        new SqlParameter("@IpAddress", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50)             
              
            };

            parameters[0].Value = model.Id;
            parameters[1].Value = model.IpAddress;
            parameters[2].Value = model.CreateTime;
            parameters[3].Value = model.CreateBy;
            parameters[4].Value = model.UpdateTime;
            parameters[5].Value = model.UpdateBy;
            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);
            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int Id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tbLoginIpLog ");
            strSql.Append(" where Id=@Id");
            SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
            parameters[0].Value = Id;
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
        public bool DeleteList(string IdList)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbLoginIpLog where Id in (" + IdList + ")");
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
        public LoginIpLogEntity GetModel(int Id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select Id, IpAddress, CreateTime, CreateBy, UpdateTime, UpdateBy  ");
            strSql.Append("  from tbLoginIpLog ");
            strSql.Append(" where Id=@Id");
            SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
            parameters[0].Value = Id;
            LoginIpLogEntity model = new LoginIpLogEntity();
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);

            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Id"].ToString() != "")
                {
                    model.Id = int.Parse(dt.Rows[0]["Id"].ToString());
                }
                model.IpAddress = dt.Rows[0]["IpAddress"].ToString();
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
            strSql.Append("select * ");
            strSql.Append(" FROM tbLoginIpLog ");
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
            strSql.Append(" FROM tbLoginIpLog ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }


    }
}

