using AchieveCommon;
using AchieveDALFactory;
using AchieveEntity;
using AchieveInterfaceDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace AchieveBLL
{
    /// <summary>
    /// 角色（BLL）
    /// </summary>
    public class RoleBLL
    {
        IRoleDAL dal = DALFactory.GetRoleDAL();

        /// <summary>
        /// 根据用户id获取用户角色
        /// </summary>
        public DataTable GetRoleByUserId(int id)
        {
            return dal.GetRoleByUserId(id);
        }

        /// <summary>
        /// 根据条件获取角色
        /// </summary>
        public string GetAllRole(string where)
        {
            return JsonHelper.ToJson(dal.GetAllRole(where));
        }

        /// <summary>
        /// 获取分页数据
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <param name="columns">要取的列名（逗号分开）</param>
        /// <param name="order">排序</param>
        /// <param name="pageSize">每页大小</param>
        /// <param name="pageIndex">当前页</param>
        /// <param name="where">查询条件</param>
        /// <param name="totalCount">总记录数</param>
        public string GetPager(string tableName, string columns, string order, int pageSize, int pageIndex, string where, out int totalCount)
        {
            DataTable dt = SqlPagerHelper.GetPager(tableName, columns, order, pageSize, pageIndex, where, out totalCount);
            return JsonHelper.ToJson(dt);
        }

        /// <summary>
        /// 添加角色
        /// </summary>
        public int AddRole(RoleEntity role)
        {
            RoleEntity roleCompare = dal.GetRoleByRoleName(role.RoleName);
            if (roleCompare != null)
            {
                throw new Exception("已经存在此角色！");
            }
            return dal.AddRole(role);
        }

        /// <summary>
        /// 删除角色（删除角色同时删除对应的：用户角色/角色菜单按钮【即权限】）
        /// </summary>
        public bool DeleteRole(int id)
        {
            return dal.DeleteRole(id);
        }

        /// <summary>
        /// 修改角色
        /// </summary>
        public bool EditRole(RoleEntity role, string originalRoleName)
        {
            if (role.RoleName != originalRoleName && dal.GetRoleByRoleName(role.RoleName) != null)
            {
                throw new Exception("已经存在此角色！");
            }
            return dal.EditRole(role);
        }

        /// <summary>
        /// 获取权限下的用户（分页）
        /// </summary>
        public string GetPagerRoleUser(int roleId, string order, int pageSize, int pageIndex)
        {
            if (SqlInjection.GetString(order))   //简单的sql注入过滤
                order = "CreateTime asc";
            int totalCount = dal.GetRoleUserCount(roleId);
            DataTable dt = dal.GetPagerRoleUser(roleId, order, pageSize, pageIndex);

            string strjson = JsonHelper.ToJson(dt);
            return "{\"total\": " + totalCount.ToString() + ",\"rows\":" + strjson + "}";
        }


        /// <summary>
        /// 角色授权
        /// </summary>
        /// <param name="roleId">要授权的角色Id</param>
        /// <param name="menuIds">菜单按钮Id 格式：1,2,3 </param>
        public bool SetRoleMenu(int roleId, string menuIds)
        {
            return dal.SetRoleMenu(roleId, menuIds);
        }


        /// <summary>
        /// 角色授权
        /// </summary>
        /// <param name="roleId">要授权的角色Id</param>
        /// <param name="roleMenuButtonId">菜单按钮Id 格式：5 1,5 2,7 1,10 1,11 1</param>
        public bool Authorize(int roleId, string roleMenuButtonId)
        {
            try
            {
                //先删除所有权限 再重新批量插入
                new MenuButtonBLL().DelRoleMenuButtonByRoleId(roleId);
                List<RoleMenuButtonEntity> addlist = new List<RoleMenuButtonEntity>();

                string[] menubuttonids = roleMenuButtonId.Split(',');
                //用户新勾选的按钮（要添加本角色下的按钮）
                if (!string.IsNullOrEmpty(roleMenuButtonId))
                {
                    List<int> listParentMenuId = new List<int>();   //需要添加的父目录id
                    for (int i = 0; i < menubuttonids.Length; i++)
                    {
                        int menuId = Convert.ToInt32(menubuttonids[i].Split(' ')[0]);
                        int buttonId = Convert.ToInt32(menubuttonids[i].Split(' ')[1]);

                        RoleMenuButtonEntity roleMenuButton = new RoleMenuButtonEntity();
                        roleMenuButton.RoleId = roleId;
                        roleMenuButton.MenuId = menuId;
                        roleMenuButton.ButtonId = buttonId;
                        addlist.Add(roleMenuButton);
                    }
                }
                if (addlist.Count != 0)
                {
                    return dal.Authorize(addlist);
                }
                else
                {
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

    }
}
