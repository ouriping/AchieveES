using AchieveCommon;
using AchieveEntity;
using AchieveInterfaceDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace AchieveDAL
{
    public class DepartmentDAL : IDepartmentDAL
    {
        /// <summary>
        /// 根据用户id获取用户部门
        /// </summary>
        public DataTable GetDepartmentByUserId(int id)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select d.Id departmentid,d.DepartmentName departmentname from tbUserDepartment ud");
            sb.Append(" join tbDepartment d on d.Id=ud.DepartmentId");
            sb.Append(" where ud.UserId=@Id");

            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, sb.ToString(), new SqlParameter("@Id", id));
        }

        /// <summary>
        /// 根据条件获取部门
        /// </summary>
        public DataTable GetAllDepartment(string where)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select Id,DepartmentName,ParentId,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy from tbDepartment");
            if (!string.IsNullOrEmpty(where))
            {
                strSql.Append(" where " + where);
            }
            strSql.Append(" order by ParentId,Sort");
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }

        /// <summary>
        /// 添加部门
        /// </summary>
        public int AddDepartment(DepartmentEntity department)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tbDepartment(DepartmentName,ParentId,Sort,CreateTime,CreateBy,UpdateTime,UpdateBy)");
            strSql.Append(" values ");
            strSql.Append("(@DepartmentName,@ParentId,@Sort,@CreateTime,@CreateBy,@UpdateTime,@UpdateBy)");
            strSql.Append(";SELECT @@IDENTITY");   //返回插入用户的主键
            SqlParameter[] paras = { 
                                   new SqlParameter("@DepartmentName",department.DepartmentName),
                                   new SqlParameter("@ParentId",department.ParentId),
                                   new SqlParameter("@Sort",department.Sort),
                                   new SqlParameter("@CreateTime",department.CreateTime),
                                   new SqlParameter("@CreateBy",department.CreateBy),
                                   new SqlParameter("@UpdateTime",department.UpdateTime),
                                   new SqlParameter("@UpdateBy",department.UpdateBy),
                                   };
            return Convert.ToInt32(SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras));
        }

        /// <summary>
        /// 修改部门
        /// </summary>
        public bool EditDepartment(DepartmentEntity department)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tbDepartment set ");
            strSql.Append("DepartmentName=@DepartmentName,Sort=@Sort,UpdateTime=@UpdateTime,UpdateBy=@UpdateBy ");
            strSql.Append("where Id=@Id");

            SqlParameter[] paras = { 
                                   new SqlParameter("@DepartmentName",department.DepartmentName),
                                   new SqlParameter("@Sort",department.Sort),
                                   new SqlParameter("@Id",department.Id),
                                   new SqlParameter("@UpdateTime",department.UpdateTime),
                                   new SqlParameter("@UpdateBy",department.UpdateBy)
                                   };
            object obj = SqlHelper.ExecuteNonQuery(SqlHelper.connStr, CommandType.Text, strSql.ToString(), paras);
            if (Convert.ToInt32(obj) > 0)
                return true;
            else
                return false;
        }

        /// <summary>
        /// 删除部门
        /// </summary>
        public bool DeleteDepartment(string departmentIds)
        {
            List<string> list = new List<string>();
            list.Add("delete from tbDepartment where Id in (" + departmentIds + ")");
            list.Add("delete from tbUserDepartment where DepartmentId in (" + departmentIds + ")");

            try
            {
                SqlHelper.ExecuteNonQuery(SqlHelper.connStr, list);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 获取部门下的用户个数
        /// </summary>
        public int GetDepartmentUserCount(string departmentIds)
        {
            string sql = "select COUNT(1) from tbUserDepartment ud join tbUser u on ud.UserId = u.Id where ud.DepartmentId in (" + departmentIds + ")";
            object count = SqlHelper.ExecuteScalar(SqlHelper.connStr, CommandType.Text, sql, null);
            return Convert.ToInt32(count);
        }

        /// <summary>
        /// 获取部门下的用户（分页）
        /// </summary>
        public DataTable GetPagerDepartmentUser(string departmentIds, string order, int pageSize, int pageIndex)
        {
            int beginIndex = (pageIndex - 1) * pageSize + 1;   //分页开始页码
            int endIndex = pageIndex * pageSize;   //分页结束页码
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select distinct(T.Id),T.AccountName,T.RealName,T.IsAble,T.IfChangePwd,T.CreateTime from (");
            strSql.Append(" select row_number() over(order by u." + order + ")");
            strSql.Append(" as Rownum,u.Id,u.AccountName,u.RealName,u.IsAble,u.IfChangePwd,u.CreateTime from tbDepartment d");
            strSql.Append(" join tbUserDepartment ud on d.Id = ud.DepartmentId");
            strSql.Append(" join tbUser u on ud.UserId = u.Id");
            strSql.Append(" where d.Id in (" + departmentIds + ")) as T");
            strSql.Append(" where T.Rownum between " + beginIndex + " and " + endIndex + "");
            return SqlHelper.GetDataTable(SqlHelper.connStr, CommandType.Text, strSql.ToString(), null);
        }
    }
}
