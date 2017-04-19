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
    public class ButtonBLL
    {
        IButtonDAL dal = DALFactory.GetButtonDAL();

        /// <summary>
        /// 根据菜单标识码和用户id获取此用户拥有该菜单下的哪些按钮权限
        /// </summary>
        public DataTable GetButtonByMenuCodeAndUserId(string menuCode, int userId)
        {
            return dal.GetButtonByMenuCodeAndUserId(menuCode, userId);
        }

        /// <summary>
        /// 根据条件获取 按钮
        /// </summary>
        public string GetAllButtonTree(string where) 
        {
            DataTable dt = dal.GetAllButton(where);

            string sb = "[{\"id\":\"0\",\"text\":\"全选\",\"children\": [";
            foreach (DataRow dr in dt.Rows)
            {
                sb += "{\"id\":\"" + dr["id"] + "\",\"text\":\"" + dr["name"] + "\"},";
            }
            sb = sb.Trim(",".ToCharArray());
            sb += "]}]";
            return sb;
            //return AchieveCommon.JsonHelper.ToJson(dal.GetAllButton(where));
        }

        /// <summary>
        /// 获取分页数据
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <param name="columns">要取的列名（逗号分开）</param>
        /// <param name="order">排序</param>
        /// <param name="pageSize">每页大小</param>
        /// <param name="pageIndex">当前页</param>
        /// <param name="where">查询条件</param>
        /// <param name="totalCount">总记录数</param>
        public string GetPager(string tableName, string columns, string order, int pageSize, int pageIndex, string where, out int totalCount)
        {
            DataTable dt = AchieveCommon.SqlPagerHelper.GetPager(tableName, columns, order, pageSize, pageIndex, where, out totalCount);
            return AchieveCommon.JsonHelper.ToJson(dt);
        }


        /// <summary>
        /// 添加 按钮
        /// </summary>
        public int AddButton(ButtonEntity button)
        {
            ButtonEntity roleCompare = dal.GetButtonByButtonName(button.Name);
            if (roleCompare != null)
            {
                throw new Exception("已经存在此按钮！");
            }
            return dal.AddButton(button);
        }

        /// <summary>
        /// 删除 按钮
        /// </summary>
        public bool DeleteButton(string id)
        {
            return dal.DeleteButton(id);
        }

        /// <summary>
        /// 修改 按钮
        /// </summary>
        public bool EditButton(ButtonEntity button, string originalButtonName)
        {
            if (button.Name != originalButtonName && dal.GetButtonByButtonName(button.Name) != null)
            {
                throw new Exception("已经存在此按钮！");
            }
            return dal.EditButton(button);
        }
    }
}
