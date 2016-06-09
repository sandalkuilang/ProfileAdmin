using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models.Authorization
{
    public class FeatureMasterRepository : BaseCommandRespository
    {

        public IEnumerable<Feature> GetFeatureMaster(dynamic param)
        {
            this.Database.Open();
            IEnumerable<Feature> result = this.Database.Query<Feature>("GetFeatureMaster", param);
            this.Database.Close();
            return result;
        }

        public void SaveFeatureMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("SaveFeatureMaster", param);
            this.Database.Close();
        }

        public void AddFeatureMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("AddFeatureMaster", param);
            this.Database.Close();
        }

        public void DeleteFeatureMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("DeleteFeatureMaster", param);
            this.Database.Close();
        }

    }
}