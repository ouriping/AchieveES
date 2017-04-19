using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    /// <summary>
    /// 角色能操作的菜单
    /// </summary>
    public class RoleMenuEntity
    {
        /// <summary>
        /// id
        /// </summary>
        public int Id { get; set; } 

        /// <summary>
        /// 角色id
        /// </summary>
        public int RoleId { get; set; }

        /// <summary>
        /// 导航菜单id
        /// </summary>
        public int MenuId { get; set; }

    }
}
