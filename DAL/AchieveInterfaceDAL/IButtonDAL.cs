using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace AchieveInterfaceDAL
{
    public interface IButtonDAL
    {
        /// <summary>
        /// 根据菜单标识码和用户id获取此用户拥有该菜单下的哪些按钮权限
        /// </summary>
        DataTable GetButtonByMenuCodeAndUserId(string menuCode, int userId);

        /// <summary>
        /// 根据条件获取 按钮
        /// </summary>
        DataTable GetAllButton(string where);

        /// <summary>
        /// 根据按钮名获取按钮
        /// </summary>
        ButtonEntity GetButtonByButtonName(string ButtonName);

        /// <summary>
        /// 添加 按钮
        /// </summary>
        int AddButton(ButtonEntity button);

        /// <summary>
        /// 删除 按钮
        /// </summary>
        bool DeleteButton(string id);


        /// <summary>
        /// 修改 按钮
        /// </summary>
        bool EditButton(ButtonEntity button);
    }
}
