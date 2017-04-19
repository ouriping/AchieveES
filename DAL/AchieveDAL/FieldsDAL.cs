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
    public partial class FieldsDAL : IFieldsDAL
    {
        public bool ExistsFieldName(string tabName, int tabId)
        {
            string sql = "select count(1)num from tbFields where FieldName = @FieldName AND TabId=@TabId ";
            SqlParameter[] parameters = {
			            new SqlParameter("@FieldName", SqlDbType.NVarChar,50),
                        new SqlParameter("@TabId", SqlDbType.Int)
            };
            parameters[0].Value = tabName;
            parameters[1].Value = tabId;
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

        public bool ExistsFieldViewName(string fieldViewName, int tabId)
        {
            string sql = "select count(1)num from tbFields where FieldViewName = @FieldViewName AND TabId=@TabId ";
            SqlParameter[] parameters = {
			            new SqlParameter("@FieldViewName", SqlDbType.NVarChar,50),
                        new SqlParameter("@TabId", SqlDbType.Int)
            };
            parameters[0].Value = fieldViewName;
            parameters[1].Value = tabId;
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

        public bool Exists(int Id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1)num from tbFields");
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

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(FieldsEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbFields(");
            strSql.Append("UpdateTime,UpdateBy,TabId,FieldName,FieldViewName,FieldDataTypeId,IsActive,CreateTime,CreateBy,Sort,IsSearch");
            strSql.Append(") values (");
            strSql.Append("@UpdateTime,@UpdateBy,@TabId,@FieldName,@FieldViewName,@FieldDataTypeId,@IsActive,@CreateTime,@CreateBy,@Sort,@IsSearch");
            strSql.Append(") ");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
			            new SqlParameter("@UpdateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@TabId", SqlDbType.Int,4) ,            
                        new SqlParameter("@FieldName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@FieldViewName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@FieldDataTypeId", SqlDbType.Int,4) ,          
                        new SqlParameter("@IsActive", SqlDbType.Bit,1) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@Sort", SqlDbType.Int,4) ,
                        new SqlParameter("@IsSearch", SqlDbType.Bit,1) 
            };

            parameters[0].Value = model.UpdateTime;
            parameters[1].Value = model.UpdateBy;
            parameters[2].Value = model.TabId;
            parameters[3].Value = model.FieldName;
            parameters[4].Value = model.FieldViewName;
            parameters[5].Value = model.FieldDataTypeId;
            parameters[6].Value = model.IsActive;
            parameters[7].Value = model.CreateTime;
            parameters[8].Value = model.CreateBy;
            parameters[9].Value = model.Sort;
            parameters[10].Value = model.IsSearch;
            object obj = Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters));
            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 更新一条数据
        /// </summary>
        public int Update(FieldsEntity model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbFields set ");
            strSql.Append(" UpdateTime = @UpdateTime , ");
            strSql.Append(" UpdateBy = @UpdateBy , ");
            strSql.Append(" TabId = @TabId , ");
            strSql.Append(" FieldName = @FieldName , ");
            strSql.Append(" FieldViewName = @FieldViewName , ");
            strSql.Append(" FieldDataTypeId = @FieldDataTypeId , ");
            strSql.Append(" IsActive = @IsActive , ");
            strSql.Append(" CreateTime = @CreateTime , ");
            strSql.Append(" CreateBy = @CreateBy , ");
            strSql.Append(" Sort = @Sort , ");
            strSql.Append(" IsSearch = @IsSearch ");
            strSql.Append(" where Id=@Id ");

            SqlParameter[] parameters = {
			            new SqlParameter("@Id", SqlDbType.Int,4) ,            
                        new SqlParameter("@UpdateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@UpdateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@TabId", SqlDbType.Int,4) ,            
                        new SqlParameter("@FieldName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@FieldViewName", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@FieldDataTypeId", SqlDbType.Int,4) ,            
                        new SqlParameter("@IsActive", SqlDbType.Bit,1) ,            
                        new SqlParameter("@CreateTime", SqlDbType.DateTime) ,            
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,50) ,            
                        new SqlParameter("@Sort", SqlDbType.Int,4),
                        new SqlParameter("@IsSearch", SqlDbType.Bit,1) 
            };
            parameters[0].Value = model.Id;
            parameters[1].Value = model.UpdateTime;
            parameters[2].Value = model.UpdateBy;
            parameters[3].Value = model.TabId;
            parameters[4].Value = model.FieldName;
            parameters[5].Value = model.FieldViewName;
            parameters[6].Value = model.FieldDataTypeId;
            parameters[7].Value = model.IsActive;
            parameters[8].Value = model.CreateTime;
            parameters[9].Value = model.CreateBy;
            parameters[10].Value = model.Sort;
            parameters[11].Value = model.IsSearch;

            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);
            return Convert.ToInt32(obj);
        }


        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int Id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tbFields ");
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
            list.Add("delete from tbFields where Id in (" + Idlist + ")");
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
        public FieldsEntity GetModel(int Id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select Id, UpdateTime, UpdateBy, TabId, FieldName, FieldViewName, FieldDataTypeId, Sort, IsActive, CreateTime, CreateBy ,IsSearch ");
            strSql.Append("  from tbFields ");
            strSql.Append(" where Id=@Id");
            SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
            parameters[0].Value = Id;


            FieldsEntity model = new FieldsEntity();
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Id"].ToString() != "")
                {
                    model.Id = int.Parse(dt.Rows[0]["Id"].ToString());
                }
                if (dt.Rows[0]["UpdateTime"].ToString() != "")
                {
                    model.UpdateTime = DateTime.Parse(dt.Rows[0]["UpdateTime"].ToString());
                }
                model.UpdateBy = dt.Rows[0]["UpdateBy"].ToString();
                if (dt.Rows[0]["TabId"].ToString() != "")
                {
                    model.TabId = int.Parse(dt.Rows[0]["TabId"].ToString());
                }
                model.FieldName = dt.Rows[0]["FieldName"].ToString();
                model.FieldViewName = dt.Rows[0]["FieldViewName"].ToString();
                if (dt.Rows[0]["FieldDataTypeId"].ToString() != "")
                {
                    model.FieldDataTypeId = int.Parse(dt.Rows[0]["FieldDataTypeId"].ToString());
                }
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
                if (dt.Rows[0]["IsSearch"].ToString() != "")
                {
                    if ((dt.Rows[0]["IsSearch"].ToString() == "1") || (dt.Rows[0]["IsSearch"].ToString().ToLower() == "true"))
                    {
                        model.IsSearch = true;
                    }
                    else
                    {
                        model.IsSearch = false;
                    }
                }
                if (dt.Rows[0]["Sort"].ToString() != "")
                {
                    model.Sort = int.Parse(dt.Rows[0]["Sort"].ToString());
                }
                if (dt.Rows[0]["CreateTime"].ToString() != "")
                {
                    model.CreateTime = DateTime.Parse(dt.Rows[0]["CreateTime"].ToString());
                }
                model.CreateBy = dt.Rows[0]["CreateBy"].ToString();

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
            strSql.Append("select Id, UpdateTime, UpdateBy, TabId, FieldName, FieldViewName, FieldDataTypeId, Sort,IsActive, CreateTime, CreateBy,IsSearch ");
            strSql.Append(" FROM tbFields ");
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
            strSql.Append(" Id, UpdateTime, UpdateBy, TabId, FieldName, FieldViewName, FieldDataTypeId, Sort, IsActive, CreateTime, CreateBy,IsSearch ");
            strSql.Append(" FROM tbFields ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }

    }
}
