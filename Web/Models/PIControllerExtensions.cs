using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Krokot.Database.SqlLoader;

namespace ProfitIndicator.Models
{
    public static class PIControllerExtensions
    {
        public static System.IO.StreamReader OpenExcelTemplate(this System.Web.Mvc.Controller controller, string name)
        {
            ResourceSqlLoader excelLoader = new ResourceSqlLoader("excel-template-loader", "ExcelTemplate", typeof(PIControllerExtensions).Assembly);
            excelLoader.Extensions.Clear();
            excelLoader.AddExtension("xlsx");
            return excelLoader.GetStream(name);
        }
    }
}