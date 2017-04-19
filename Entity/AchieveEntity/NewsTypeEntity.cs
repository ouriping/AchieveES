using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    public class NewsTypeEntity
    {
        public NewsTypeEntity()
        { }

        #region Model
        private int _id;
        private string _ftypename;
        private int _fsort;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }

        public int fsort
        {
            set { _fsort = value; }
            get { return _fsort; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string ftypename
        {
            set { _ftypename = value; }
            get { return _ftypename; }
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
