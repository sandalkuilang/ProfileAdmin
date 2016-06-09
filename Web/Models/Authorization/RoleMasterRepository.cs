using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models.Authorization
{
    public class RoleMasterRepository : BaseCommandRespository
    {

        public IEnumerable<Role> GetRoleMaster(dynamic param)
        {
            this.Database.Open();
            IEnumerable<Role> result = this.Database.Query<Role>("GetRoleMaster", param);
            this.Database.Close();
            return result;
        }

        public void SaveRoleMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("SaveRoleMaster", param);
            this.Database.Close(); 
        }

        public void AddRoleMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("AddRoleMaster", param);
            this.Database.Close(); 
        }
         
        public void DeleteRoleMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("DeleteRoleMaster", param);
            this.Database.Close(); 
        }

    }

}