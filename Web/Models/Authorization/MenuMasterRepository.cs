using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Krokot.ProfileAdmin.Models.Authorization
{
    public class MenuMasterRepository : BaseCommandRespository
    {
        public IEnumerable<SelectListItem> GetMenuName(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetMenuName", param);
            this.Database.Close();
            return result;
        }

        public IEnumerable<SelectListItem> GetMenuDescription(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetMenuDescription", param);
            this.Database.Close();
            return result;
        }
         
        public IEnumerable<Menu> GetMenuMaster(dynamic param)
        {
            this.Database.Open();
            IEnumerable<Menu> result = this.Database.Query<Menu>("GetMenuMaster", param);
            this.Database.Close();
            return result;
        }

        public void SaveMenuMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("SaveMenuMaster", param);
            this.Database.Close(); 
        }

        public void AddMenuMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("AddMenuMaster", param);
            this.Database.Close(); 
        }

        public void DeleteMenuMaster(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("DeleteMenuMaster", param);
            this.Database.Close();
        }
          
    }
}