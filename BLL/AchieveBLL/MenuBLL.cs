using AchieveCommon;
using AchieveDALFactory;
using AchieveEntity;
using AchieveInterfaceDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace AchieveBLL
{
    /// <summary>
    /// 菜单（BLL）
    /// </summary>
    public class MenuBLL
    {
        IMenuDAL dal = DALFactory.GetMenuDAL();

        public DataTable GetUserMenuData(int userId, int parentid)
        {
            return dal.GetUserMenuData(userId, parentid);
        }

        /// <summary>
        /// 根据用户主键id查询用户可以访问的菜单 默认2层
        /// </summary>
        public string GetUserMenu(int id)
        {
            DataTable dt = dal.GetUserMenu(id);
            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            DataRow[] rows = dt.Select("menuparentid = 0");   //赋权限每个角色都必须有父节点的权限，否则一个都不输出了
            if (rows.Length > 0)
            {
                for (int i = 0; i < rows.Length; i++)
                {
                    string stateStr = "open";// "closed";
                    if (i == 0)
                    {
                        stateStr = "open";
                    }
                    sb.Append("{\"id\":\"" + rows[i]["menuid"].ToString() + "\",\"text\":\"" + rows[i]["menuname"].ToString() + "\",\"iconCls\":\"" + rows[i]["icon"].ToString() + "\",\"state\":\"" + stateStr + "\",\"children\":[");
                    sb.Append(GetChildMenuStr(dt, rows[i]["menuid"].ToString(), stateStr));
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]");
            }
            else
            {
                sb.Append("]");
            }
            return sb.ToString();
        }

        public string GetChildMenuStr(DataTable dt, string menuid, string stateStr)
        {
            StringBuilder sb = new StringBuilder();
            DataRow[] r_list = dt.Select(string.Format("menuparentid={0}", menuid));
            if (r_list.Length > 0)
            {
                for (int j = 0; j < r_list.Length; j++)
                {
                    DataRow[] child_list = dt.Select(string.Format("menuparentid={0}", r_list[j]["menuid"].ToString()));
                    if (child_list.Length > 0)
                    {
                        sb.Append("{\"id\":\"" + r_list[j]["menuid"].ToString() + "\",\"text\":\"" + r_list[j]["menuname"].ToString() + "\",\"iconCls\":\"" + r_list[j]["icon"].ToString() + "\",\"state\":\"" + stateStr + "\",\"children\":[");
                        sb.Append(GetChildMenuStr(dt, r_list[j]["menuid"].ToString(), stateStr));
                    }
                    else
                    {
                        sb.Append("{\"id\":\"" + r_list[j]["menuid"].ToString() + "\",\"text\":\"" + r_list[j]["menuname"].ToString() + "\",\"iconCls\":\"" + r_list[j]["icon"].ToString() + "\",\"attributes\":{\"url\":\"" + r_list[j]["linkaddress"].ToString() + "\"}},");
                    }
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]},");
            }
            else  //根节点下没有子节点
            {
                sb.Append("]},");  //跟上面if条件之外的字符串拼上
            }
            return sb.ToString();
        }

        /// <summary>
        /// 根据角色id获取此角色可以访问的菜单和菜单下的按钮（编辑角色-菜单使用）
        /// </summary>
        public string GetAllMenu(int roleId)
        {
            DataTable dt = dal.GetAllMenu(roleId);
            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            DataRow[] rows = dt.Select("parentid = 0");
            if (rows.Length > 0)
            {
                DataView dataView = new DataView(dt);
                for (int i = 0; i < rows.Length; i++)
                {
                    sb.Append("{\"id\":\"" + rows[i]["menuid"].ToString() + "\",\"text\":\"" + rows[i]["menuname"].ToString() + "\",\"attributes\":{\"menuid\":\"" + rows[i]["menuid"].ToString() + "\"},\"children\":[");
                    sb.Append(GetChildMenu(dt, rows[i]["menuid"].ToString(), roleId));
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]");
            }
            else
            {
                sb.Append("]");
            }
            return sb.ToString();
        }

        /// <summary>
        /// 递归
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="menuid"></param>
        /// <returns></returns>
        public string GetChildMenu(DataTable dt, string menuid, int roleId)
        {
            StringBuilder sb = new StringBuilder();
            DataRow[] r_list = dt.Select(string.Format("parentid={0}", menuid));
            if (r_list.Length > 0)
            {
                for (int j = 0; j < r_list.Length; j++)
                {
                    DataRow[] child_list = dt.Select(string.Format("parentid={0}", r_list[j]["menuid"].ToString()));
                    if (child_list.Length > 0)
                    {
                        sb.Append("{\"id\":\"" + r_list[j]["menuid"].ToString() + "\",\"text\":\"" + r_list[j]["menuname"].ToString() + "\",\"attributes\":{\"menuid\":\"" + r_list[j]["menuid"].ToString() + "\"},\"children\":[");
                        sb.Append(GetChildMenu(dt, r_list[j]["menuid"].ToString(), roleId));
                    }
                    else
                    {
                        sb.Append("{\"id\":\"" + roleId + "\",\"text\":\"" + r_list[j]["menuname"].ToString() + "\",\"checked\":" + r_list[j]["checked"].ToString() + ",\"attributes\":{\"menuid\":\"" + r_list[j]["menuid"].ToString() + "\"}},");
                    }
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]},");
            }
            else  //根节点下没有子节点
            {
                sb.Append("]},");  //跟上面if条件之外的字符串拼上
            }
            return sb.ToString();
        }

        /// <summary>
        /// 根据用户主键id查询用户拥有的权限（后台首页“我的权限”）
        /// </summary>
        public string GetMyAuthority(int id)
        {
            DataTable dt = dal.GetMyAuthority(id);
            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            DataRow[] rows = dt.Select("parentid = 0");
            if (rows.Length > 0)
            {
                //distinct取不重复的子节点
                DataView dataView = new DataView(dt);
                DataTable dtDistinct = dataView.ToTable(true, new string[] { "menuname", "menuid", "parentid" });
                for (int i = 0; i < rows.Length; i++)
                {
                    sb.Append("{\"id\":\"" + rows[i]["menuid"].ToString() + "\",\"text\":\"" + rows[i]["menuname"].ToString() + "\",\"children\":[");
                    DataRow[] r_list = dtDistinct.Select(string.Format("parentid = {0}", rows[i]["menuid"]));  //取子节点

                    if (r_list.Length > 0)    //根节点下有子节点
                    {
                        for (int j = 0; j < r_list.Length; j++)
                        {
                            sb.Append("{\"id\":\"" + r_list[j]["menuid"].ToString() + "\",\"text\":\"" + r_list[j]["menuname"].ToString() + "\",\"children\":[");
                            //防止多个角色有同个按钮的权限，distinct一下
                            DataView dataViewBtn = new DataView(dt);
                            DataTable dtDistinctBtn = dataViewBtn.ToTable(true, new string[] { "menuid", "parentid", "buttonid", "buttonname", "checked" });
                            DataRow[] r_listButton = dtDistinctBtn.Select(string.Format("menuid = {0}", r_list[j]["menuid"]));  //子子节点
                            if (r_listButton.Length > 0)    //有子子节点就遍历进去
                            {
                                for (int k = 0; k < r_listButton.Length; k++)
                                {
                                    sb.Append("{\"text\":\"" + r_listButton[k]["buttonname"].ToString() + "\",\"checked\":" + r_listButton[k]["checked"].ToString() + "},");
                                }
                                sb.Remove(sb.Length - 1, 1);
                                sb.Append("]},");
                            }
                            else
                            {
                                sb.Append("]},");    //跟上面if条件之外的字符串拼上
                            }
                        }
                        sb.Remove(sb.Length - 1, 1);
                        sb.Append("]},");
                    }
                    else     //根节点下没有子节点
                    {
                        sb.Append("]},");   //跟上面if条件之外的字符串拼上
                    }
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]");
            }
            else
            {
                sb.Append("]");
            }
            return sb.ToString();
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
            DataTable dt = SqlPagerHelper.GetPager(tableName, columns, order, pageSize, pageIndex, where, out totalCount);
            return JsonHelper.ToJson(dt);
        }

        public DataTable GetMenuList(string strwhere)
        {
            return dal.GetAllMenu(strwhere);
        }

        /// <summary>
        /// 根据条件获取菜单数据
        /// </summary>
        public string GetAllMenu(string strwhere)
        {
            DataTable dt = dal.GetAllMenu(strwhere);
            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            DataRow[] rows = dt.Select("parentid = 0");   //赋权限每个角色都必须有父节点的权限，否则一个都不输出了
            if (rows.Length > 0)
            {
                for (int i = 0; i < rows.Length; i++)
                {
                    sb.Append("{\"id\":\"" + rows[i]["id"].ToString() + "\",\"text\":\"" + rows[i]["name"].ToString() + "\",\"iconCls\":\"" + rows[i]["icon"].ToString() + "\",\"children\":[");
                    sb.Append(GetChildMenu(dt, rows[i]["id"].ToString()));
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]");
            }
            else
            {
                sb.Append("]");
            }
            return sb.ToString();
        }

        public string GetChildMenu(DataTable dt, string id)
        {
            StringBuilder sb = new StringBuilder();
            DataRow[] r_list = dt.Select(string.Format("parentid={0}", id));
            if (r_list.Length > 0)
            {
                for (int j = 0; j < r_list.Length; j++)
                {
                    DataRow[] child_list = dt.Select(string.Format("parentid={0}", r_list[j]["id"].ToString()));
                    if (child_list.Length > 0)
                    {
                        sb.Append("{\"id\":\"" + r_list[j]["id"].ToString() + "\",\"text\":\"" + r_list[j]["name"].ToString() + "\",\"iconCls\":\"" + r_list[j]["icon"].ToString() + "\",\"children\":[");
                        sb.Append(GetChildMenu(dt, r_list[j]["id"].ToString()));
                    }
                    else
                    {
                        sb.Append("{\"id\":\"" + r_list[j]["id"].ToString() + "\",\"text\":\"" + r_list[j]["name"].ToString() + "\",\"iconCls\":\"" + r_list[j]["icon"].ToString() + "\",\"attributes\":{\"url\":\"" + r_list[j]["linkaddress"].ToString() + "\"}},");
                    }
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]},");
            }
            else  //根节点下没有子节点
            {
                sb.Append("]},");  //跟上面if条件之外的字符串拼上
            }
            return sb.ToString();
        }

        /// <summary>
        /// 添加 菜单
        /// </summary>
        public int AddMenu(MenuEntity menu)
        {
            MenuEntity roleCompare = dal.GetMenuByName(menu.Name);
            if (roleCompare != null)
            {
                throw new Exception("已经存在此菜单！");
            }
            return dal.AddMenu(menu);
        }

        /// <summary>
        /// 删除 菜单
        /// </summary>
        public bool DeleteMenu(string id)
        {
            return dal.DeleteMenu(id);
        }

        /// <summary>
        /// 修改 菜单
        /// </summary>
        public bool EditMenu(MenuEntity menu, string originalButtonName)
        {
            if (menu.Name != originalButtonName && dal.GetMenuByName(menu.Name) != null)
            {
                throw new Exception("已经存在此菜单！");
            }
            return dal.EditMenu(menu);
        }

        /// <summary>
        /// 根据角色id获取此角色可以访问的菜单和菜单下的按钮
        /// </summary>
        public string GetAllMenuButtonTree(int roleId)
        {
            DataTable dt = dal.GetAllMenuButton(roleId);
            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            DataRow[] rows = dt.Select("parentid = 0");
            if (rows.Length > 0)
            {
                DataView dataView = new DataView(dt);
                DataTable dtDistinct = dataView.ToTable(true, new string[] { "menuname", "menuid", "parentid" });   //distinct取不重复的子节点
                for (int i = 0; i < rows.Length; i++)
                {
                    string stateStr = "closed";
                    sb.Append("{\"id\":\"" + rows[i]["menuid"].ToString() + "\",\"text\":\"" + rows[i]["menuname"].ToString() + "\",\"state\":\"" + stateStr + "\",\"attributes\":{\"menuid\":\"" + rows[i]["menuid"].ToString() + "\",\"buttonid\":\"0\"},\"children\":[");
                    sb.Append(GetChildMenuButton(dt, dtDistinct, rows[i]["menuid"].ToString(), roleId, stateStr));
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]");
            }
            else
            {
                sb.Append("]");
            }
            return sb.ToString();
        }

        /// <summary>
        /// 递归
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="menuid"></param>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public string GetChildMenuButton(DataTable dt, DataTable dtDistinct, string menuid, int roleId, string stateStr)
        {
            StringBuilder sb = new StringBuilder();
            DataRow[] r_list = dtDistinct.Select(string.Format("parentid={0}", menuid));
            if (r_list.Length > 0)
            {
                for (int j = 0; j < r_list.Length; j++)
                {
                    DataRow[] child_list = dt.Select(string.Format("parentid={0}", r_list[j]["menuid"].ToString()));
                    if (child_list.Length > 0)
                    {
                        sb.Append("{\"id\":\"" + r_list[j]["menuid"].ToString() + "\",\"text\":\"" + r_list[j]["menuname"].ToString() + "\",\"state\":\"" + stateStr + "\",\"attributes\":{\"menuid\":\"" + r_list[j]["menuid"].ToString() + "\",\"buttonid\":\"0\"},\"children\":[");
                        sb.Append(GetChildMenuButton(dt, dtDistinct, r_list[j]["menuid"].ToString(), roleId, stateStr));
                    }
                    else
                    {
                        sb.Append("{\"id\":\"" + r_list[j]["menuid"].ToString() + "\",\"text\":\"" + r_list[j]["menuname"].ToString() + "\",\"state\":\"" + stateStr + "\",\"attributes\":{\"menuid\":\"" + r_list[j]["menuid"].ToString() + "\",\"buttonid\":\"0\"},\"children\":[");
                        DataRow[] r_listButton = dt.Select(string.Format("menuid = {0} ", r_list[j]["menuid"]));  //子子节点.
                        if (r_listButton.Length > 0)    //有子子节点就遍历进去
                        {
                            for (int k = 0; k < r_listButton.Length; k++)
                            {
                                sb.Append("{\"id\":\"" + roleId + "\",\"text\":\"" + r_listButton[k]["buttonname"].ToString() + "\",\"checked\":" + r_listButton[k]["checked"].ToString() + ",\"attributes\":{\"menuid\":\"" + r_listButton[k]["menuid"].ToString() + "\",\"buttonid\":\"" + r_listButton[k]["buttonid"].ToString() + "\"}},");
                            }
                            sb.Remove(sb.Length - 1, 1);
                        }
                        sb.Append("]},");
                    }
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("]},");
            }
            else  //根节点下没有子节点
            {
                sb.Append("]},");  //跟上面if条件之外的字符串拼上
            }
            return sb.ToString();
        }
    }
}
