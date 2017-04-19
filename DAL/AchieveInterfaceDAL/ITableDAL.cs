using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace AchieveInterfaceDAL
{
    public interface ITableDAL
    {
        #region  成员方法

        bool ExistsTabName(string tabName);

        bool ExistsTabViewName(string tabViewName);

        /// <summary>
        /// 增加一条数据
        /// </summary>
        int Add(TableEntity model);
        /// <summary>
        /// 更新一条数据
        /// </summary>
        int Update(TableEntity model);
        /// <summary>
        /// 删除数据
        /// </summary>
        bool Delete(int id);
        bool DeleteList(string idlist);
        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        TableEntity GetModel(int id);
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
