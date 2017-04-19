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
    public class IconsDAL : IIconsDAL
    {
        public bool Exists(int Id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1)num from tbIcons");
            strSql.Append(" where ");
            strSql.Append(" Id = @Id  ");
            SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
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
        public bool ExistsIconName(string iconName)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1)num from tbIcons");
            strSql.Append(" where ");
            strSql.Append(" IconName = @IconName  ");
            SqlParameter[] parameters = {
					new SqlParameter("@IconName", SqlDbType.NVarChar,200)
			};
            parameters[0].Value = iconName;
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
        public int Add(IconsEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbIcons(");
            strSql.Append("IconName,IconCssInfo,CreateTime,CreateBy,UpdateTime,UpdateBy");
            strSql.Append(") values (");
            strSql.Append("@IconName,@IconCssInfo,@CreateTime,@CreateBy,@UpdateTime,@UpdateBy");
            strSql.Append(") ");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
			            new SqlParameter("@IconName", SqlDbType.NVarChar,100) ,            
                        new SqlParameter("@IconCssInfo", SqlDbType.NVarChar,2000) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50)             
              
            };

            parameters[0].Value = model.IconName;
            parameters[1].Value = model.IconCssInfo;
            parameters[2].Value = model.CreateTime;
            parameters[3].Value = model.CreateBy;
            parameters[4].Value = model.UpdateTime;
            parameters[5].Value = model.UpdateBy;
            object obj = Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters));
            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 更新一条数据
        /// </summary>
        public int Update(IconsEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbIcons set ");

            strSql.Append(" IconName = @IconName , ");
            strSql.Append(" IconCssInfo = @IconCssInfo , ");
            strSql.Append(" CreateTime = @CreateTime , ");
            strSql.Append(" CreateBy = @CreateBy , ");
            strSql.Append(" UpdateTime = @UpdateTime , ");
            strSql.Append(" UpdateBy = @UpdateBy  ");
            strSql.Append(" where Id=@Id ");

            SqlParameter[] parameters = {
			            new SqlParameter("@Id", SqlDbType.Int,4) ,            
                        new SqlParameter("@IconName", SqlDbType.NVarChar,100) ,            
                        new SqlParameter("@IconCssInfo", SqlDbType.NVarChar,2000) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50)             
              
            };

            parameters[0].Value = model.Id;
            parameters[1].Value = model.IconName;
            parameters[2].Value = model.IconCssInfo;
            parameters[3].Value = model.CreateTime;
            parameters[4].Value = model.CreateBy;
            parameters[5].Value = model.UpdateTime;
            parameters[6].Value = model.UpdateBy;
            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);
            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int Id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tbIcons ");
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
        public bool DeleteList(string Idlist)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbIcons where Id in (" + Idlist + ")");
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
        public IconsEntity GetModel(int Id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select Id, IconName, IconCssInfo, CreateTime, CreateBy, UpdateTime, UpdateBy  ");
            strSql.Append("  from tbIcons ");
            strSql.Append(" where Id=@Id");
            SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
            parameters[0].Value = Id;

            IconsEntity model = new IconsEntity();
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);

            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Id"].ToString() != "")
                {
                    model.Id = int.Parse(dt.Rows[0]["Id"].ToString());
                }
                model.IconName = dt.Rows[0]["IconName"].ToString();
                model.IconCssInfo = dt.Rows[0]["IconCssInfo"].ToString();
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
            strSql.Append(" FROM tbIcons ");
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
            strSql.Append(" FROM tbIcons ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }

    }
}
