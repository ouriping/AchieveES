using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    public class TableEntity
    {
        public TableEntity()
        { }
        #region Model
        private int _id;
        private string _tabname;
        private string _tabviewname;
        private bool _isactive;
        private DateTime _createtime;
        private string _createby;
        private DateTime? _updatetime;
        private string _updateby;
        /// <summary>
        /// 
        /// </summary>
        public int Id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string TabName
        {
            set { _tabname = value; }
            get { return _tabname; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string TabViewName
        {
            set { _tabviewname = value; }
            get { return _tabviewname; }
        }
        /// <summary>
        /// 
        /// </summary>
        public bool IsActive
        {
            set { _isactive = value; }
            get { return _isactive; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime CreateTime
        {
            set { _createtime = value; }
            get { return _createtime; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CreateBy
        {
            set { _createby = value; }
            get { return _createby; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? UpdateTime
        {
            set { _updatetime = value; }
            get { return _updatetime; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string UpdateBy
        {
            set { _updateby = value; }
            get { return _updateby; }
        }
        #endregion Model
    }
}
