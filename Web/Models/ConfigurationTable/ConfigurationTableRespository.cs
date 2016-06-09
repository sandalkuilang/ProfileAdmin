using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Krokot.ProfileAdmin.Models.ConfigurationTable
{
    public class ConfigurationTableRepository : BaseCommandRespository
    {

        public IEnumerable<Configuration> GetConfigurationTable(dynamic param)
        {
            this.Database.Open();
            IEnumerable<Configuration> result = this.Database.Query<Configuration>("GetConfigurationTable", param);
            this.Database.Close();
            return result;
        }

        public IEnumerable<SelectListItem> GetConfigTableParameterName(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetConfigTableParameterName", param);
            this.Database.Close();
            return result;
        }

        public void AddConfigurationTable(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("AddConfigurationTable", param);
            this.Database.Close();
        }

        public void SaveConfigurationTable(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("SaveConfigurationTable", param);
            this.Database.Close();
        }

        public void DeleteConfigurationTable(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("DeleteConfigurationTable", param);
            this.Database.Close();
        }
    }
}