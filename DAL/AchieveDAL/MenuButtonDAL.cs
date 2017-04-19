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
    public class MenuButtonDAL : IMenuButtonDAL
    {
        /// <summary>
        /// 分配 菜单按钮 执行事务 先批量删除 再批量插入
        /// </summary>
        public bool SaveMenuButton(string menuid, string buttonids)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbMenuButton where MenuId =" + menuid);
            foreach (string btnid in buttonids.TrimStart(',').TrimEnd(',').Split(','))
            {
                if (btnid != "0")
                {
                    list.Add("INSERT INTO tbMenuButton(MenuId,ButtonId)VALUES(" + menuid + "," + btnid + ")");
                }
            }
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
        /// 根据菜单id查询所有分配的按钮
        /// </summary>
        public DataTable GetButtonByMenuId(int menuId)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(" SELECT Id,MenuId,ButtonId FROM tbMenuButton ");
            strSql.Append(" where MenuId=@MenuId ");
            SqlParameter[] paras = { 
                                   new SqlParameter("@MenuId",SqlDbType.Int)
                                   };
            paras[0].Value = menuId;
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras);
        }

        /// <summary>
        /// 分配 菜单按钮 执行事务 先批量删除 再批量插入
        /// </summary>
        public bool DelRoleMenuButtonByRoleId(int RoleId)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbRoleMenuButton where RoleId =" + RoleId);
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
    }
}
