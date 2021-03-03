using System;

namespace Oqtane.Models
{
    public class HtmlText : IAuditable
    {
        public int HtmlTextId { get; set; }
        public int ModuleId { get; set; }
        public string Content { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
    }
}
