using AchieveDALFactory;
using AchieveEntity;
using AchieveInterfaceDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace AchieveBLL
{
    public class MenuButtonBLL
    {
        IMenuButtonDAL dal = DALFactory.GetMenuButtonDAL();

        /// <summary>
        /// 分配 菜单按钮
        /// </summary>
        public bool SaveMenuButton(string menuid, string buttonids)
        {
            return dal.SaveMenuButton(menuid, buttonids);
        }

        /// <summary>
        /// 根据菜单id查询所有分配的按钮
        /// </summary>
        public string GetButtonByMenuId(int menuId)
        {
            string ids = "";
            DataTable dt = dal.GetButtonByMenuId(menuId);
            foreach (DataRow dr in dt.Rows)
            {
                ids += dr["ButtonId"].ToString() + ",";
            }
            return ids.TrimEnd(',');
        }

        /// <summary>
        /// 分配 菜单按钮 执行事务 先批量删除 再批量插入
        /// </summary>
        public bool DelRoleMenuButtonByRoleId(int RoleId)
        {
            return dal.DelRoleMenuButtonByRoleId(RoleId);
        }
    }
}
