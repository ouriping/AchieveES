using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AchieveManageWeb.Models
{
    public class SysModuleNavModel
    {
        public string id { get; set; }
        public string text { get; set; }
        public string iconCls { get; set; }
        public string attributes { get; set; }
        public string state { get; set; }
        public List<SysModuleNavModel> children { get; set; }
    }

}