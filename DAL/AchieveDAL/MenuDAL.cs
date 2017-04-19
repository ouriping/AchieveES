using AchieveCommon;
using AchieveEntity;
using AchieveInterfaceDAL;
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace AchieveDAL
{
    /// <summary>
    /// 菜单（SQL Server数据库实现）
    /// </summary>
    public class MenuDAL : IMenuDAL
    {
        public DataTable GetUserMenuData(int userId, int parentid)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select distinct(m.Name) menuname,m.Id menuid,m.Icon icon,m.ParentId menuparentid,m.Sort menusort,m.LinkAddress linkaddress from tbUser u");
            strSql.Append(" join tbUserRole ur on u.Id=ur.UserId");
            strSql.Append(" join tbRoleMenuButton rmb on ur.RoleId=rmb.RoleId");
            strSql.Append(" join tbMenu m on rmb.MenuId=m.Id");
            strSql.Append(" where u.Id=@UserId AND m.ParentId=@ParentId order by m.ParentId,m.Sort");
            SqlParameter[] parameters = {
			            new SqlParameter("@UserId", SqlDbType.Int),
                        new SqlParameter("@ParentId", SqlDbType.Int)
            };
            parameters[0].Value = userId;
            parameters[1].Value = parentid;
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), parameters);
        }

        /// <summary>
        /// 根据用户主键id查询用户可以访问的菜单
        /// </summary>
        public DataTable GetUserMenu(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select distinct(m.Name) menuname,m.Id menuid,m.Icon icon,u.Id userid,u.AccountName username,m.ParentId menuparentid,m.Sort menusort,m.LinkAddress linkaddress from tbUser u");
            strSql.Append(" join tbUserRole ur on u.Id=ur.UserId");
            strSql.Append(" join tbRoleMenuButton rmb on ur.RoleId=rmb.RoleId");
            strSql.Append(" join tbMenu m on rmb.MenuId=m.Id");
            strSql.Append(" where u.Id=@Id order by m.ParentId,m.Sort");

            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), new SqlParameter("@Id", id));
            //StringBuilder strSql = new StringBuilder();
            //strSql.Append("select distinct(m.Name) menuname,m.Id menuid,m.Icon icon,u.ID userid,u.AccountName username,m.ParentId menuparentid,m.Sort menusort,m.LinkAddress linkaddress from tbUser u");
            //strSql.Append(" join tbUserRole ur on u.ID=ur.UserId");
            //strSql.Append(" join tbRoleMenu rmb on ur.RoleId=rmb.RoleId");
            //strSql.Append(" join tbMenu m on rmb.MenuId=m.Id");
            //strSql.Append(" where u.ID=@Id order by m.ParentId,m.Sort");

            //return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), new SqlParameter("@Id", id));
        }

        /// <summary>
        /// 根据角色id获取此角色可以访问的菜单和菜单下的菜单（编辑角色-菜单使用）
        /// </summary>
        public DataTable GetAllMenu(int roleId)
        {
            StringBuilder sqlStr = new StringBuilder();
            sqlStr.Append("select m.Id menuid,m.Name menuname,m.ParentId parentid,m.Icon menuicon,rmb.RoleId roleid,case when isnull(rmb.RoleId , 0) = 0 then 'false' else 'true' end checked");
            sqlStr.Append(" from tbMenu m");
            sqlStr.Append(" left join tbRoleMenu rmb on(m.Id=rmb.MenuId and rmb.RoleId = @RoleId)");
            sqlStr.Append(" order by m.ParentId,m.Sort");
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sqlStr.ToString(), new SqlParameter("@RoleId", roleId));
        }

        /// <summary>
        /// 根据角色id获取此角色可以访问的菜单和菜单下的按钮（编辑角色-菜单使用）
        /// </summary>
        public DataTable GetAllMenuButton(int roleId)
        {
            StringBuilder sqlStr = new StringBuilder();
            sqlStr.Append("select m.Id menuid,m.Name menuname,m.ParentId parentid,m.Icon menuicon,mb.ButtonId buttonid,b.Name buttonname,b.Icon buttonicon,rmb.RoleId roleid,case when isnull(rmb.ButtonId , 0) = 0 then 'false' else 'true' end checked");
            sqlStr.Append(" from tbMenu m");
            sqlStr.Append(" left join tbMenuButton mb on m.Id=mb.MenuId");
            sqlStr.Append(" left join tbButton b on mb.ButtonId=b.Id");
            sqlStr.Append(" left join tbRoleMenuButton rmb on(mb.MenuId=rmb.MenuId and mb.ButtonId=rmb.ButtonId and rmb.RoleId = @RoleId)");
            sqlStr.Append(" order by m.ParentId,m.Sort,b.Sort");
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sqlStr.ToString(), new SqlParameter("@RoleId", roleId));
        }

        /// <summary>
        /// 根据用户主键id查询用户拥有的权限（后台首页“我的权限”）
        /// </summary>
        public DataTable GetMyAuthority(int id)
        {
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.StoredProcedure, "sp_GetAuthorityByUserId", new SqlParameter("@userId", id));
        }

        /// <summary>
        /// 根据条件获取菜单数据
        /// </summary>
        public DataTable GetAllMenu(string strwhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" select m.Id ,m.Name ,m.ParentId ,m.Icon ,m.Code ,m.LinkAddress ,m.Sort ,m.CreateTime,m.CreateBy,m.UpdateTime,m.UpdateBy ");
            strSql.Append(" from tbMenu m WHERE 1=1 " + strwhere);
            strSql.Append(" order by m.ParentId,m.Sort ");
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }


        /// <summary>
        /// 根据菜单名获取菜单信息
        /// </summary>
        public MenuEntity GetMenuByName(string name)
        {
            string sql = "select top 1 * from tbMenu where Name = @name";
            MenuEntity Menu = null;
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sql, new SqlParameter("@name", name));
            if (dt.Rows.Count > 0)
            {
                Menu = new MenuEntity();
                DataRowToModel(Menu, dt.Rows[0]);
                return Menu;
            }
            else
                return null;
        }

        /// <summary>
        /// 添加菜单
        /// </summary>
        public int AddMenu(MenuEntity menu)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbMenu([Name],[Code],[Icon],[Sort],[ParentId],[LinkAddress],CreateTime,CreateBy,UpdateTime,UpdateBy)");
            strSql.Append(" values ");
            strSql.Append("(@Name,@Code,@Icon,@Sort,@ParentId,@LinkAddress,@CreateTime,@CreateBy,@UpdateTime,@UpdateBy)");
            strSql.Append(";SELECT @@IDENTITY");   //返回插入用户的主键
            SqlParameter[] paras = { 
                                   new SqlParameter("@Name",SqlDbType.VarChar,50),
                                   new SqlParameter("@Code",SqlDbType.VarChar,50),
                                   new SqlParameter("@Icon",SqlDbType.VarChar,50),
                                   new SqlParameter("@Sort",SqlDbType.Int),
                                   new SqlParameter("@ParentId",SqlDbType.Int),
                                   new SqlParameter("@LinkAddress",SqlDbType.VarChar,100),
                                   new SqlParameter("@CreateTime",SqlDbType.DateTime),
                                   new SqlParameter("@CreateBy",SqlDbType.NVarChar,50),
                                   new SqlParameter("@UpdateTime",SqlDbType.DateTime),
                                   new SqlParameter("@UpdateBy",SqlDbType.NVarChar,50)
                                   };
            paras[0].Value = menu.Name;
            paras[1].Value = menu.Code;
            paras[2].Value = menu.Icon;
            paras[3].Value = menu.Sort;
            paras[4].Value = menu.ParentId;
            paras[5].Value = menu.LinkAddress;
            paras[6].Value = menu.CreateTime;
            paras[7].Value = menu.CreateBy;
            paras[8].Value = menu.UpdateTime;
            paras[9].Value = menu.UpdateBy;
            return Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras));
        }

        /// <summary>
        /// 删除菜单（删除菜单同时删除对应的：按钮菜单/角色菜单【即权限】）
        /// </summary>
        public bool DeleteMenu(string id)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbMenu where Id in (" + id + ")");
            list.Add("delete from tbRoleMenu where MenuId in (" + id + ")");
            list.Add("delete from tbRoleMenuButton where MenuId in (" + id + ")");
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
        /// 修改 菜单
        /// </summary>
        public bool EditMenu(MenuEntity menu)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbMenu set ");
            strSql.Append("Name=@Name,Code=@Code,Icon=@Icon,Sort=@Sort,ParentId=@ParentId,LinkAddress=@LinkAddress,UpdateTime=@UpdateTime,UpdateBy=@UpdateBy");
            strSql.Append(" where Id=@Id ");

            SqlParameter[] paras = { 
                                   new SqlParameter("@Id",SqlDbType.Int),
                                   new SqlParameter("@Name",SqlDbType.VarChar,50),
                                   new SqlParameter("@Code",SqlDbType.VarChar,50),
                                   new SqlParameter("@Icon",SqlDbType.VarChar,50),
                                   new SqlParameter("@Sort",SqlDbType.Int),
                                   new SqlParameter("@ParentId",SqlDbType.Int),
                                   new SqlParameter("@LinkAddress",SqlDbType.VarChar,100),
                                   new SqlParameter("@UpdateTime",SqlDbType.DateTime),
                                   new SqlParameter("@UpdateBy",SqlDbType.NVarChar,50)
                                   };
            paras[0].Value = menu.Id;
            paras[1].Value = menu.Name;
            paras[2].Value = menu.Code;
            paras[3].Value = menu.Icon;
            paras[4].Value = menu.Sort;
            paras[5].Value = menu.ParentId;
            paras[6].Value = menu.LinkAddress;
            paras[7].Value = menu.UpdateTime;
            paras[8].Value = menu.UpdateBy;
            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras);
            if (Convert.ToInt32(obj) > 0)
                return true;
            else
                return false;
        }


        /// <summary>
        /// 把DataRow行转成实体类对象
        /// </summary>
        private void DataRowToModel(MenuEntity model, DataRow dr)
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
            if (!DBNull.Value.Equals(dr["ParentId"]))
            {
                model.ParentId = Convert.ToInt32(dr["ParentId"].ToString());
            }
            if (!DBNull.Value.Equals(dr["LinkAddress"]))
            {
                model.LinkAddress = dr["LinkAddress"].ToString();
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
                model.LinkAddress = dr["UpdateBy"].ToString();
            }
        }

    }
}
