using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    public class HtmlTypeEntity
    {
        public HtmlTypeEntity()
        { }

        #region Model
        private int _id;
        private string _HtmpTypeName;
        private int _Sort;
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
            set { _Sort = value; }
            get { return _Sort; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string HtmlTypeName
        {
            set { _HtmpTypeName = value; }
            get { return _HtmpTypeName; }
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
