
using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace AchieveInterfaceDAL
{
    /// <summary>
    /// 接口层tbLoginIpLog
    /// </summary>
    public interface ILoginIpLogDAL
    {
        #region  成员方法
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        bool Exists(int Id);

        /// <summary>
        /// 增加一条数据
        /// </summary>
        int Add(LoginIpLogEntity model);

        /// <summary>
        /// 更新一条数据
        /// </summary>
        int Update(LoginIpLogEntity model);

        /// <summary>
        /// 删除数据
        /// </summary>
        bool Delete(int Id);

        bool DeleteList(string idList);

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        LoginIpLogEntity GetModel(int Id);

        /// <summary>
        /// 获得数据列表
        /// </summary>
        DataTable GetList(string strWhere);

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        DataTable GetList(int Top, string strWhere, string filedOrder);

        #endregion  成员方法
    }
}