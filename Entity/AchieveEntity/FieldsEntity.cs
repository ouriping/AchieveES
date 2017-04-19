using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    public class FieldsEntity
    {
        public FieldsEntity()
        { }
        #region Model
        private int _id;
        private int _tabid;
        private string _fieldname;
        private string _fieldviewname;
        private int _fielddatatypeid;
        private int _fieldhtmltypeid;
        private bool _isactive;
        private DateTime _createtime;
        private string _createby;
        private DateTime? _updatetime;
        private string _updateby;
        private int _Sort;
        private bool _IsSearch;
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
        public int TabId
        {
            set { _tabid = value; }
            get { return _tabid; }
        }
        /// <summary>
        /// 字段名（数据库）
        /// </summary>
        public string FieldName
        {
            set { _fieldname = value; }
            get { return _fieldname; }
        }
        /// <summary>
        /// 字段显示名
        /// </summary>
        public string FieldViewName
        {
            set { _fieldviewname = value; }
            get { return _fieldviewname; }
        }
        /// <summary>
        /// 数据类型
        /// </summary>
        public int FieldDataTypeId
        {
            set { _fielddatatypeid = value; }
            get { return _fielddatatypeid; }
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
        public bool IsSearch
        {
            set { _IsSearch = value; }
            get { return _IsSearch; }
        }

        public int Sort
        {
            set { _Sort = value; }
            get { return _Sort; }
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
