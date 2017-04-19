using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveEntity
{
    public class IconsEntity
    {
        /// <summary>
        /// Id
        /// </summary>		
        private int _id;
        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }
        /// <summary>
        /// IconName
        /// </summary>		
        private string _iconname;
        public string IconName
        {
            get { return _iconname; }
            set { _iconname = value; }
        }
        /// <summary>
        /// IconCssInfo
        /// </summary>		
        private string _iconcssinfo;
        public string IconCssInfo
        {
            get { return _iconcssinfo; }
            set { _iconcssinfo = value; }
        }
        /// <summary>
        /// CreateTime
        /// </summary>		
        private DateTime _createtime;
        public DateTime CreateTime
        {
            get { return _createtime; }
            set { _createtime = value; }
        }
        /// <summary>
        /// CreateBy
        /// </summary>		
        private string _createby;
        public string CreateBy
        {
            get { return _createby; }
            set { _createby = value; }
        }
        /// <summary>
        /// UpdateTime
        /// </summary>		
        private DateTime _updatetime;
        public DateTime UpdateTime
        {
            get { return _updatetime; }
            set { _updatetime = value; }
        }
        /// <summary>
        /// UpdateBy
        /// </summary>		
        private string _updateby;
        public string UpdateBy
        {
            get { return _updateby; }
            set { _updateby = value; }
        }

    }
}
