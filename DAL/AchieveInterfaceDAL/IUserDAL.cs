using AchieveEntity;
using System.Collections.Generic;
using System.Data;

namespace AchieveInterfaceDAL
{
    /// <summary>
    /// 用户接口（不同的数据库访问类实现接口达到多数据库的支持）
    /// </summary>
    public interface IUserDAL
    {
        /// <summary>
        /// 根据用户id获取用户
        /// </summary>
        UserEntity GetUserByUserId(string userId);

        /// <summary>
        /// 根据id获取用户
        /// </summary>
        UserEntity GetUserById(string id);

        /// <summary>
        /// 首次登陆强制修改密码
        /// </summary>
        bool InitUserPwd(UserEntity user);

        /// <summary>
        /// 修改密码
        /// </summary>
        bool ChangePwd(UserEntity user);

        /// <summary>
        /// 用户登录
        /// </summary>
        UserEntity UserLogin(string loginId, string loginPwd);

        /// <summary>
        /// 根据用户id判断用户是否可用
        /// </summary>
        UserEntity CheckLoginByUserId(string userId);

        /// <summary>
        /// 添加用户
        /// </summary>
        int AddUser(UserEntity user);

        /// <summary>
        /// 删除用户（可批量删除，删除用户同时删除对应的：角色/权限/部门）
        /// </summary>
        bool DeleteUser(string idList);

        /// <summary>
        /// 修改用户
        /// </summary>
        bool EditUser(UserEntity user);

        /// <summary>
        /// 获取用户信息（“我的信息”）
        /// </summary>
        DataTable GetUserInfo(int userId);

    }
}
