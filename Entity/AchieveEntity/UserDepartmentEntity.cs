using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    public class UserDepartmentEntity
    {
        /// <summary>
        /// 主键
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// 用户id
        /// </summary>
        public int UserId { get; set; }

        /// <summary>
        /// 部门id
        /// </summary>
        public int DepartmentId { get; set; }
    }
}
