using AchieveEntity;
using System.Collections.Generic;

namespace AchieveInterfaceDAL
{
    /// <summary>
    /// 用户角色接口（不同的数据库访问类实现接口达到多数据库的支持）
    /// </summary>
    public interface IUserRoleDAL
    {
        /// <summary>
        /// 设置用户角色（单个用户）
        /// </summary>
        /// <param name="role_addList">要增加的</param>
        /// <param name="role_deleteList">要删除的</param>
        bool SetRoleSingle(List<UserRoleEntity> role_addList, List<UserRoleEntity> role_deleteList);

        /// <summary>
        /// 设置用户角色（批量设置）
        /// </summary>
        /// <param name="role_addList">要增加的</param>
        /// <param name="role_deleteList">要删除的</param>
        bool SetRoleBatch(List<UserRoleEntity> role_addList, List<UserRoleEntity> role_deleteList);

    }
}
