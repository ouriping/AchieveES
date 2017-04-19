using AchieveEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace AchieveInterfaceDAL
{
    public interface IDepartmentDAL
    {
        /// <summary>
        /// 根据用户id获取用户部门
        /// </summary>
        DataTable GetDepartmentByUserId(int id);

        /// <summary>
        /// 根据条件获取部门
        /// </summary>
        DataTable GetAllDepartment(string where);

        /// <summary>
        /// 添加部门
        /// </summary>
        int AddDepartment(DepartmentEntity department);

        /// <summary>
        /// 修改部门
        /// </summary>
        bool EditDepartment(DepartmentEntity department);

        /// <summary>
        /// 删除部门
        /// </summary>
        bool DeleteDepartment(string departmentIds);

        /// <summary>
        /// 获取部门下的用户个数
        /// </summary>
        int GetDepartmentUserCount(string departmentIds);

        /// <summary>
        /// 获取部门下的用户（分页）
        /// </summary>
        DataTable GetPagerDepartmentUser(string departmentIds, string order, int pageSize, int pageIndex);
    }
}
