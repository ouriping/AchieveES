using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    public class DataTypeEntity
    {
        public DataTypeEntity()
        { }

        #region Model
        private int _id;
        private string _DataType;
        private string _DataTypeName;
        private int _sort;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }

        public int Sort
        {
            set { _sort = value; }
            get { return _sort; }
        }

        /// <summary>
        /// 数据类型 例如 int  decimal
        /// </summary>
        public string DataType
        {
            set { _DataType = value; }
            get { return _DataType; }
        }

        /// <summary>
        /// 数据类型显示名称  例如整数 浮点等
        /// </summary>
        public string DataTypeName
        {
            set { _DataTypeName = value; }
            get { return _DataTypeName; }
        }
      
        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间 
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 最后更新人 
        /// </summary>
        public string UpdateBy { get; set; }

        /// <summary>
        /// 最后更新时间 
        /// </summary>
        public DateTime UpdateTime { get; set; }
        #endregion Model

    }
}
