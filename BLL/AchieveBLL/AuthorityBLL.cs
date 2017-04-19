using AchieveDALFactory;
using AchieveEntity;
using AchieveInterfaceDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveBLL
{
    public class AuthorityBLL
    {
        IAuthorityDAL dal = DALFactory.GetAuthorityDAL();

        /// <summary>
        /// 判断当前用户是否有权限
        /// </summary>
        /// <param name="menuCode">菜单标识码</param>
        /// <param name="buttonCode">按钮标识码</param>
        /// <param name="userId">用户主键</param>
        public bool IfAuthority(string menuCode, string buttonCode, int userId)
        {
            return dal.IfAuthority(menuCode, buttonCode, userId);
        }
    }
}
