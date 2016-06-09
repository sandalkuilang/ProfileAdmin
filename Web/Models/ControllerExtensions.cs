using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Krokot.Database.SqlLoader;

namespace Krokot.ProfileAdmin.Models
{
    public static class ControllerExtensions
    {
        public static System.IO.StreamReader OpenExcelTemplate(this System.Web.Mvc.Controller controller, string name)
        {
            ResourceSqlLoader excelLoader = new ResourceSqlLoader("excel-template-loader", "ExcelTemplate", typeof(ControllerExtensions).Assembly);
            excelLoader.Extensions.Clear();
            excelLoader.AddExtension("xlsx");
            return excelLoader.GetStream(name);
        }
    }
}