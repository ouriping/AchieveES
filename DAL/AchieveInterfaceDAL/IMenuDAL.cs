using AchieveEntity;
using System.Collections.Generic;
using System.Data;

namespace AchieveInterfaceDAL
{
    /// <summary>
    /// 菜单接口（不同的数据库访问类实现接口达到多数据库的支持）
    /// </summary>
    public interface IMenuDAL
    {
        DataTable GetUserMenuData(int userId, int parentid);

        /// <summary>
        /// 根据用户主键id查询用户可以访问的菜单
        /// </summary>
        DataTable GetUserMenu(int id);

        /// <summary>
        /// 根据角色id获取此角色可以访问的菜单（编辑角色-菜单使用）
        /// </summary>
        DataTable GetAllMenu(int roleId);

        /// <summary>
        /// 根据角色id获取此角色可以访问的菜单和菜单下的按钮（编辑角色-菜单使用）
        /// </summary>
        DataTable GetAllMenuButton(int roleId);

        /// <summary>
        /// 根据用户主键id查询用户拥有的权限（后台首页“我的权限”）
        /// </summary>
        DataTable GetMyAuthority(int id);

        /// <summary>
        /// 根据条件获取菜单数据
        /// </summary>
        DataTable GetAllMenu(string strwhere);


        /// <summary>
        /// 根据菜单名获取菜单
        /// </summary>
        MenuEntity GetMenuByName(string name);

        /// <summary>
        /// 添加 菜单
        /// </summary>
        int AddMenu(MenuEntity menu);

        /// <summary>
        /// 删除 菜单
        /// </summary>
        bool DeleteMenu(string id);

        /// <summary>
        /// 修改 菜单
        /// </summary>
        bool EditMenu(MenuEntity menu);
    }
}
