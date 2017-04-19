using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace AchieveEntity
{
    public class ArticleEntity
    {
        [Display(Name = "信息编号")]
        public int ID { get; set; }

        [Display(Name = "信息标题")]
        public string Title { get; set; }

        [Display(Name = "信息内容")]
        public string Content { get; set; }

        [Display(Name = "附件")]
        public string FilePath { get; set; } 
    }
}
