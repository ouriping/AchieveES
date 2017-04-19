using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    public class NewsEntity
    {
        public NewsEntity()
        { }

        #region Model
        private int _id;
        private int? _ftypeid;
        private string _ftitle;
        private string _fcontent;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 类型
        /// </summary>
        public int? ftypeid
        {
            set { _ftypeid = value; }
            get { return _ftypeid; }
        }
        /// <summary>
        /// 标题
        /// </summary>
        public string ftitle
        {
            set { _ftitle = value; }
            get { return _ftitle; }
        }
        /// <summary>
        /// 内容
        /// </summary>
        public string fcontent
        {
            set { _fcontent = value; }
            get { return _fcontent; }
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
