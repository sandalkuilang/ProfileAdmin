using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models.Authorization
{
    public class Menu
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Module { get; set; }
        public string Remarks { get; set; }
        public string ParentId { get; set; }
        public string Url { get; set; }
        public DateTime LastUpdate { get; set; }
        public string UpdateBy { get; set; } 
    }
}