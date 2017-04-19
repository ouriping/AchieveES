using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using AchieveEntity;
using AchieveInterfaceDAL;
using AchieveCommon;
using System.Transactions;

namespace AchieveDAL
{
    /// <summary>
    /// 角色
    /// </summary>
    public class RoleDAL : IRoleDAL
    {
        /// <summary>
        /// 根据用户id获取用户角色
        /// </summary>
        public DataTable GetRoleByUserId(int id)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select r.id roleid,r.rolename rolename from tbUserRole ur");
            sb.Append(" join tbRole r on r.Id=ur.RoleId");
            sb.Append(" where ur.UserId=@Id");

            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sb.ToString(), new SqlParameter("@Id", id));
        }

        /// <summary>
        /// 根据条件获取角色
        /// </summary>
        public DataTable GetAllRole(string where)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select [Id],[RoleName],[Description],[CreateBy],[CreateTime],[UpdateBy],[UpdateTime] from tbRole");
            if (!string.IsNullOrEmpty(where))
            {
                strSql.Append(" where " + where);
            }
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }

        /// <summary>
        /// 根据角色名获取角色
        /// </summary>
        public RoleEntity GetRoleByRoleName(string roleName)
        {
            string sql = "select top 1 [Id],[RoleName],[Description],[CreateBy],[CreateTime],[UpdateBy],[UpdateTime] from tbRole where RoleName = @RoleName";
            RoleEntity role = null;
            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sql, new SqlParameter("@RoleName", roleName));
            if (dt.Rows.Count > 0)
            {
                role = new RoleEntity();
                DataRowToModel(role, dt.Rows[0]);
                return role;
            }
            else
                return null;
        }

        /// <summary>
        /// 添加角色
        /// </summary>
        public int AddRole(RoleEntity role)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbRole(RoleName,Description,CreateBy,CreateTime,UpdateBy,UpdateTime)");
            strSql.Append(" values ");
            strSql.Append("(@RoleName,@Description,@CreateBy,@CreateTime,@UpdateBy,@UpdateTime)");
            strSql.Append(";SELECT @@IDENTITY");   //返回插入用户的主键
            SqlParameter[] paras = { 
                                   new SqlParameter("@RoleName",role.RoleName),
                                   new SqlParameter("@Description",role.Description),
                                   new SqlParameter("@CreateBy",role.CreateBy),
                                   new SqlParameter("@CreateTime",role.CreateTime),
                                   new SqlParameter("@UpdateBy",role.UpdateBy),
                                   new SqlParameter("@UpdateTime",role.UpdateTime)
                                   };
            return Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras));
        }

        /// <summary>
        /// 删除角色（删除角色同时删除对应的：用户角色/角色菜单按钮【即权限】）
        /// </summary>
        public bool DeleteRole(int id)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbRole where Id in (" + id + ")");
            list.Add("delete from tbUserRole where RoleId in (" + id + ")");

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
        /// 角色授权
        /// </summary>
        /// <param name="roleId">要授权的角色Id</param>
        /// <param name="menuIds">菜单按钮Id 格式：1,2,3 </param>
        public bool SetRoleMenu(int roleId, string menuIds)
        {
            //先批量删除该角色下所以角色菜单权限 然后批量插入新的;
            List<string> list = new List<string>();
            list.Add("delete from tbRoleMenu where RoleId in (" + roleId + ")");
            string[] mengidArr = menuIds.Split(',');
            try
            {
                foreach (string menuid in mengidArr)
                {
                    list.Add("insert into tbRoleMenu(RoleId,MenuId) Values(" + roleId + "," + menuid + ")");
                }
                //list.Add("insert into tbRoleMenu SELECT DISTINCT " + roleId + " roleid,ParentId FROM tbMenu WHERE id IN (SELECT menuid FROM tbRoleMenu WHERE RoleId=" + roleId + " )");

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
        /// 修改角色
        /// </summary>
        public bool EditRole(RoleEntity role)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbRole set ");
            strSql.Append("RoleName=@RoleName,Description=@Description,UpdateBy=@UpdateBy,UpdateTime=@UpdateTime");
            strSql.Append(" where Id=@Id");

            SqlParameter[] paras = { 
                                   new SqlParameter("@RoleName",role.RoleName),
                                   new SqlParameter("@Description",role.Description),
                                   new SqlParameter("@UpdateBy",role.UpdateBy),  
                                   new SqlParameter("@UpdateTime",role.UpdateTime),  
                                   new SqlParameter("@Id",role.Id)
                                   };
            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras);
            if (Convert.ToInt32(obj) > 0)
                return true;
            else
                return false;
        }

        /// <summary>
        /// 根据角色Id获取对应的菜单按钮权限
        /// </summary>
        public DataTable GetMenuButtonIdByRoleId(int roleId)
        {
            string sql = "select MenuId,ButtonId from tbRoleMenuButton where RoleId = @roleId and (ButtonId is not null and ButtonId <> 0)";
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sql, new SqlParameter("@roleId", roleId));
        }

        /// <summary>
        /// 获取父节点Id
        /// </summary>
        public int GetParentMenuId(int roleId, int menuId)
        {
            //获取当前目录的父目录Id
            string sqlParentId = "select ParentId from tbMenu where Id = @MenuId";
            object parentId = SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, sqlParentId, new SqlParameter("@MenuId", menuId));

            //判断是否已经有父目录的记录
            string sqlIfExistsParentRecord = "select * from tbRoleMenuButton where RoleId = @RoleId and MenuId = @ParentId and ButtonId = 0";
            SqlParameter[] paras = { 
                                   new SqlParameter("@RoleId",roleId),
                                   new SqlParameter("@ParentId",Convert.ToInt32(parentId))
                                   };

            DataTable dt = SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sqlIfExistsParentRecord, paras);
            if (dt.Rows.Count > 0)
                return -1;  //找到就返回-1
            else
                return Convert.ToInt32(parentId);   //没找到就返回父节点id
        }

        /// <summary>
        /// 获取权限下的用户个数
        /// </summary>
        public int GetRoleUserCount(int roleId)
        {
            string sql = "select COUNT(1) from tbUserRole ur join tbUser u on ur.UserId = u.ID where ur.RoleId = @roleId";
            object count = SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, sql, new SqlParameter("@roleId", roleId));
            return Convert.ToInt32(count);
        }

        /// <summary>
        /// 获取权限下的用户（分页）
        /// </summary>
        public DataTable GetPagerRoleUser(int roleId, string order, int pageSize, int pageIndex)
        {
            int beginIndex = (pageIndex - 1) * pageSize + 1;   //分页开始页码
            int endIndex = pageIndex * pageSize;   //分页结束页码
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select T.ID,T.AccountName,T.RealName,T.IsAble,T.IfChangePwd,T.CreateTime from (");
            strSql.Append(" select row_number() over(order by u." + order + ")");
            strSql.Append(" as Rownum,u.ID,u.AccountName,u.RealName,u.IsAble,u.IfChangePwd,u.CreateTime from tbRole r");
            strSql.Append(" join tbUserRole ur on r.Id = ur.RoleId");
            strSql.Append(" join tbUser u on ur.UserId = u.ID");
            strSql.Append(" where r.Id = @roleId) as T");
            strSql.Append(" where T.Rownum between " + beginIndex + " and " + endIndex + "");   //int类型不需要防sql注入
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), new SqlParameter("@roleId", roleId));
        }

        /// <summary>
        /// 把DataRow行转成实体类对象
        /// </summary>
        private void DataRowToModel(RoleEntity model, DataRow dr)
        {
            if (!DBNull.Value.Equals(dr["Id"]))
                model.Id = int.Parse(dr["Id"].ToString());

            if (!DBNull.Value.Equals(dr["RoleName"]))
                model.RoleName = dr["RoleName"].ToString();

            if (!DBNull.Value.Equals(dr["Description"]))
                model.Description = dr["Description"].ToString();

            if (!DBNull.Value.Equals(dr["CreateTime"]))
                model.CreateTime = Convert.ToDateTime(dr["CreateTime"]);

            if (!DBNull.Value.Equals(dr["CreateBy"]))
                model.CreateBy = dr["CreateBy"].ToString();

            if (!DBNull.Value.Equals(dr["UpdateTime"]))
                model.UpdateTime = Convert.ToDateTime(dr["UpdateTime"]);

            if (!DBNull.Value.Equals(dr["UpdateBy"]))
                model.UpdateBy = dr["UpdateBy"].ToString();
        }


        /// <summary>
        /// 角色授权
        /// </summary>
        /// <param name="role_menu_button_addlist">需要添加的</param>
        /// <param name="role_menu_button_deletelist">需要删除的</param>
        public bool Authorize(List<RoleMenuButtonEntity> addlist) 
        {
            Hashtable sqlStringList = new Hashtable();
            for (int i = 0; i < addlist.Count; i++)  //新增的用户按钮
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("insert into tbRoleMenuButton(");
                sb.Append("RoleId,MenuId,ButtonId)");
                sb.Append(" values (");
                sb.Append("@RoleId,@MenuId,@ButtonId)");
                sb.Append(";select @@IDENTITY");
                SqlParameter[] paras = { 
                                       new SqlParameter("@RoleId", addlist[i].RoleId),
                                       new SqlParameter("@MenuId", addlist[i].MenuId),
                                       new SqlParameter("@ButtonId",addlist[i].ButtonId)
                                       };
                sqlStringList.Add(sb, paras);  
            }
            try
            {
                SqlHelper.ExecuteNonQuery(SqlHelper.connStr, sqlStringList);   //批量插入（事务）
                return true;
            }
            catch
            {
                return false;
            }
        }

    }
}
