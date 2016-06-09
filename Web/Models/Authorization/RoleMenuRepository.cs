using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models.Authorization
{
    public class RoleMenuRepository : BaseCommandRespository
    {

        public IEnumerable<RoleMenu> GetRoleMenu(dynamic param)
        {
            this.Database.Open();
            IEnumerable<RoleMenu> result = this.Database.Query<RoleMenu>("GetRoleMenu", param);
            this.Database.Close();
            return result;
        }

        public void SaveRoleMenu(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("SaveRoleMaster", param);
            this.Database.Close();
        }

        public void AddRoleMenu(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("AddRoleMenu", param);
            this.Database.Close();
        }

        public void DeleteRoleMenu(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("DeleteRoleMenu", param);
            this.Database.Close();
        }

    }
}