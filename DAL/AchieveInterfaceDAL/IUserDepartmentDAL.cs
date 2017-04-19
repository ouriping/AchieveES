using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveInterfaceDAL
{
    public interface IUserDepartmentDAL
    {
        /// <summary>
        /// 设置用户部门（单个用户）
        /// </summary>
        /// <param name="dep_addList">要增加的</param>
        /// <param name="dep_deleteList">要删除的</param>
        bool SetDepartmentSingle(List<UserDepartmentEntity> dep_addList, List<UserDepartmentEntity> dep_deleteList);

        /// <summary>
        /// 设置用户部门（批量设置）
        /// </summary>
        /// <param name="dep_addList">要增加的</param>
        /// <param name="dep_deleteList">要删除的</param>
        bool SetDepartmentBatch(List<UserDepartmentEntity> dep_addList, List<UserDepartmentEntity> dep_deleteList);
    }
}
