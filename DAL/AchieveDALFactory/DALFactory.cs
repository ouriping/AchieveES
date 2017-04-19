using AchieveInterfaceDAL;
using System;
using System.Collections.Generic;
using System.Text;

namespace AchieveDALFactory
{
    /// <summary>
    /// 工厂类：创建访问数据库的实例对象
    /// </summary>
    public class DALFactory
    {
        /// <summary>
        /// 根据传入的类名获取实例对象
        /// </summary>
        private static object GetInstance(string name)
        {
            //ILog log = LogManager.GetLogger(typeof(Factory));  //初始化日志记录器

            string configName = System.Configuration.ConfigurationManager.AppSettings["DataAccess"];
            if (string.IsNullOrEmpty(configName))
            {
                //log.Fatal("没有从配置文件中获取命名空间名称！");   //Fatal致命错误，优先级最高
                throw new InvalidOperationException();    //抛错，代码不会向下执行了
            }

            string className = string.Format("{0}.{1}", configName, name);  //AchieveDAL.传入的类名name

            //加载程序集
            System.Reflection.Assembly assembly = System.Reflection.Assembly.Load(configName);
            //创建指定类型的对象实例
            return assembly.CreateInstance(className);
        }

        public static IAuthorityDAL GetAuthorityDAL()
        {
            IAuthorityDAL dal = GetInstance("Authority") as IAuthorityDAL;
            return dal;
        }

        public static IMenuDAL GetMenuDAL()
        {
            IMenuDAL dal = GetInstance("MenuDAL") as IMenuDAL;
            return dal;
        }


        public static IRoleDAL GetRoleDAL()
        {
            IRoleDAL dal = GetInstance("RoleDAL") as IRoleDAL;
            return dal;
        }

        public static IUserDAL GetUserDAL()
        {
            IUserDAL dal = GetInstance("UserDAL") as IUserDAL;
            return dal;
        }

        public static IUserRoleDAL GetUserRoleDAL()
        {
            IUserRoleDAL dal = GetInstance("UserRoleDAL") as IUserRoleDAL;
            return dal;
        }

        public static IRequestionTypeDAL GetRequestionTypeDAL()
        {
            IRequestionTypeDAL dal = GetInstance("RequestionTypeDAL") as IRequestionTypeDAL;
            return dal;
        }

        public static IRequestionDAL GetRequestionDAL()
        {
            IRequestionDAL dal = GetInstance("RequestionDAL") as IRequestionDAL;
            return dal;
        }

        public static IButtonDAL GetButtonDAL()
        {
            IButtonDAL button = GetInstance("ButtonDAL") as IButtonDAL;
            return button;
        }

        public static IMenuButtonDAL GetMenuButtonDAL()
        {
            IMenuButtonDAL dal = GetInstance("MenuButtonDAL") as IMenuButtonDAL;
            return dal;
        }

        public static IRoleMenuButtonDAL GetRoleMenuButtonDAL()
        {
            IRoleMenuButtonDAL dal = GetInstance("RoleMenuButtonDAL") as IRoleMenuButtonDAL;
            return dal;
        }

        public static IDepartmentDAL GetDepartmentDAL()
        {
            IDepartmentDAL dal = GetInstance("DepartmentDAL") as IDepartmentDAL;
            return dal;
        }

        public static IUserDepartmentDAL GetUserDepartmentDAL()
        {
            IUserDepartmentDAL dal = GetInstance("UserDepartmentDAL") as IUserDepartmentDAL;
            return dal;
        }

        public static INewsTypeDAL GetNewsTypeDAL()
        {
            INewsTypeDAL dal = GetInstance("NewsTypeDAL") as INewsTypeDAL;
            return dal;
        }

        public static INewsDAL GetNewsDAL()
        {
            INewsDAL dal = GetInstance("NewsDAL") as INewsDAL;
            return dal;
        }

        public static IHtmlTypeDAL GetHtmlTypeDAL()
        {
            IHtmlTypeDAL dal = GetInstance("HtmlTypeDAL") as IHtmlTypeDAL;
            return dal;
        }

        public static IDataTypeDAL GetDataTypeDAL()
        {
            IDataTypeDAL dal = GetInstance("DataTypeDAL") as IDataTypeDAL;
            return dal;
        }

        public static ITableDAL GetTableDAL()
        {
            ITableDAL dal = GetInstance("TableDAL") as ITableDAL;
            return dal;
        }
        public static IFieldsDAL GetFieldsDAL()
        {
            IFieldsDAL dal = GetInstance("FieldsDAL") as IFieldsDAL;
            return dal;
        }

        public static IIconsDAL GetIconsDAL()
        {
            IIconsDAL dal = GetInstance("IconsDAL") as IIconsDAL;
            return dal;
        }

        public static ILoginIpLogDAL GetLoginIpLogDAL()
        {
            ILoginIpLogDAL dal = GetInstance("LoginIpLogDAL") as ILoginIpLogDAL;
            return dal;
        }
    }
}
