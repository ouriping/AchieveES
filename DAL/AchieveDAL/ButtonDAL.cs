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
    public class ButtonDAL : IButtonDAL
    {
        /// <summary>
        /// 根据菜单标识码和用户id获取此用户拥有该菜单下的哪些按钮权限
        /// </summary>
        public DataTable GetButtonByMenuCodeAndUserId(string menuCode, int userId)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select distinct(b.Id) id,b.Code code,b.Name name,b.Icon icon,b.Sort sort from tbUser u");
            strSql.Append(" join tbUserRole ur on u.Id=ur.UserId");
            strSql.Append(" join tbRoleMenuButton rmb on ur.RoleId=rmb.RoleId");
            strSql.Append(" join tbMenu m on rmb.MenuId=m.Id");
            strSql.Append(" join tbButton b on rmb.ButtonId=b.Id");
            strSql.Append(" where u.Id=@Id and m.Code=@MenuCode order by b.Sort");
            SqlParameter[] paras = { 
                                   new SqlParameter("@Id",userId),
                                   new SqlParameter("@MenuCode",menuCode)
                                   };
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras);
        }

        /// <summary>
        /// 根据条件获取按钮
        /// </summary>
        public DataTable GetAllButton(string where)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select Id,Name,Code,Icon,Sort,[Description],CreateTime,CreateBy,UpdateTime,UpdateBy from tbButton");
            if (!string.IsNullOrEmpty(where))
            {
                strSql.Append(" where " + where);
            }
            strSql.Append(" order by Sort ");
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }


        /// <summary>
        /// 根据按钮名获取按钮
        /// </summary>
        public ButtonEntity GetButtonByButtonName(string ButtonName)
        {
            string sql = "select top 1 Id,Name,Code,Icon,Sort,[Description],CreateTime,CreateBy,UpdateTime,UpdateBy from tbButton where Name = @ButtonName";
            ButtonEntity Button = null;
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sql, new SqlParameter("@ButtonName", ButtonName));
            if (dt.Rows.Count > 0)
            {
                Button = new ButtonEntity();
                DataRowToModel(Button, dt.Rows[0]);
                return Button;
            }
            else
                return null;
        }

        /// <summary>
        /// 添加按钮
        /// </summary>
        public int AddButton(ButtonEntity Button)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbButton([Name],[Code],[Icon],[Sort],[Description],CreateTime,CreateBy,UpdateTime,UpdateBy)");
            strSql.Append(" values ");
            strSql.Append("(@Name,@Code,@Icon,@Sort,@Description,@CreateTime,@CreateBy,@UpdateTime,@UpdateBy)");
            strSql.Append(";SELECT @@IDENTITY");   //返回插入用户的主键
            SqlParameter[] paras = { 
                                   new SqlParameter("@Name",SqlDbType.VarChar,50),
                                   new SqlParameter("@Code",SqlDbType.VarChar,50),
                                   new SqlParameter("@Icon",SqlDbType.VarChar,50),
                                   new SqlParameter("@Sort",SqlDbType.Int),
                                   new SqlParameter("@Description",SqlDbType.VarChar,100),
                                   new SqlParameter("@CreateTime",SqlDbType.DateTime),
                                   new SqlParameter("@CreateBy",SqlDbType.NVarChar,100),
                                   new SqlParameter("@UpdateTime",SqlDbType.DateTime),
                                   new SqlParameter("@UpdateBy",SqlDbType.NVarChar,100)
                                   };
            paras[0].Value = Button.Name;
            paras[1].Value = Button.Code;
            paras[2].Value = Button.Icon;
            paras[3].Value = Button.Sort;
            paras[4].Value = Button.Description;
            paras[5].Value = Button.CreateTime;
            paras[6].Value = Button.CreateBy;
            paras[7].Value = Button.UpdateTime;
            paras[8].Value = Button.UpdateBy;
            return Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras));
        }

        /// <summary>
        /// 删除按钮（删除按钮同时删除对应的：菜单按钮/角色菜单按钮【即权限】）
        /// </summary>
        public bool DeleteButton(string id)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbButton where Id in (" + id + ")");
            list.Add("delete from [tbMenuButton] where ButtonId in (" + id + ")");
            list.Add("delete from [tbRoleMenuButton] where ButtonId in (" + id + ")");

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
        /// 修改 按钮
        /// </summary>
        public bool EditButton(ButtonEntity Button)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbButton set ");
            strSql.Append("Name=@Name,Code=@Code,Icon=@Icon,Sort=@Sort,Description=@Description,UpdateBy=@UpdateBy,UpdateTime=@UpdateTime");
            strSql.Append(" where Id=@Id");

            SqlParameter[] paras = { 
                                   new SqlParameter("@Id",SqlDbType.Int),
                                   new SqlParameter("@Name",SqlDbType.VarChar,50),
                                   new SqlParameter("@Code",SqlDbType.VarChar,50),
                                   new SqlParameter("@Icon",SqlDbType.VarChar,50),
                                   new SqlParameter("@Sort",SqlDbType.Int),
                                   new SqlParameter("@Description",SqlDbType.VarChar,100),
                                   new SqlParameter("@UpdateTime",SqlDbType.DateTime),
                                   new SqlParameter("@UpdateBy",SqlDbType.NVarChar,100)
                                   };
            paras[0].Value = Button.Id;
            paras[1].Value = Button.Name;
            paras[2].Value = Button.Code;
            paras[3].Value = Button.Icon;
            paras[4].Value = Button.Sort;
            paras[5].Value = Button.Description;
            paras[6].Value = Button.UpdateTime;
            paras[7].Value = Button.UpdateBy;
            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras);
            if (Convert.ToInt32(obj) > 0)
                return true;
            else
                return false;
        }


        /// <summary>
        /// 把DataRow行转成实体类对象
        /// </summary>
        private void DataRowToModel(ButtonEntity model, DataRow dr)
        {
            if (!DBNull.Value.Equals(dr["Id"]))
            {
                model.Id = int.Parse(dr["Id"].ToString());
            }
            if (!DBNull.Value.Equals(dr["Name"]))
            {
                model.Name = dr["Name"].ToString();
            }
            if (!DBNull.Value.Equals(dr["Code"]))
            {
                model.Code = dr["Code"].ToString();
            }
            if (!DBNull.Value.Equals(dr["Icon"]))
            {
                model.Icon = dr["Icon"].ToString();
            }
            if (!DBNull.Value.Equals(dr["Sort"]))
            {
                model.Sort = Convert.ToInt32(dr["Sort"].ToString());
            }

            if (!DBNull.Value.Equals(dr["Description"]))
            {
                model.Description = dr["Description"].ToString();
            }

            if (!DBNull.Value.Equals(dr["CreateTime"]))
            {
                model.CreateTime = Convert.ToDateTime(dr["CreateTime"]);
            }
            if (!DBNull.Value.Equals(dr["CreateBy"]))
            {
                model.CreateBy = dr["CreateBy"].ToString();
            }

            if (!DBNull.Value.Equals(dr["UpdateTime"]))
            {
                model.UpdateTime = Convert.ToDateTime(dr["UpdateTime"]);
            }
            if (!DBNull.Value.Equals(dr["UpdateBy"]))
            {
                model.UpdateBy = dr["UpdateBy"].ToString();
            }
        }
    }
}
