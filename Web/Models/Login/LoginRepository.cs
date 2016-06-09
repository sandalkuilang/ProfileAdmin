using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Krokot.ProfileAdmin.Models.Login
{
    public class LoginRepository : BaseCommandRespository
    {

        public string GetImpersonateUser(dynamic param)
        {
            this.Database.Open();
            List<string> result = this.Database.Query<string>("GetImpersonateUser", param);
            this.Database.Close();
            if (result.Any())
                return result[0];
            
            return string.Empty;
        }

        public bool IsLanding(dynamic param)
        {
            this.Database.Open();
            List<string> result = this.Database.Query<string>("GetListApplication", param);
            this.Database.Close();
            if (result.Count > 1)
                return true;

            return false;
        }

        public List<SelectListItem> GetListApplication(dynamic param)
        {
            this.Database.Open();
            List<SelectListItem> result = this.Database.Query<SelectListItem>("GetListApplication", param);
            this.Database.Close();
            return result;
        }

    }
}