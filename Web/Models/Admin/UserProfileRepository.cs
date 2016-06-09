using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc; 

namespace Krokot.ProfileAdmin.Models.Admin
{
    public class UserProfileRepository : BaseCommandRespository
    {
        public IList<UserProfile> GetUserProfile(dynamic param)
        {
            this.Database.Open();
            IList<UserProfile> result = this.Database.Query<UserProfile>("GetUserProfile", param);
            this.Database.Close();
            return result;
        }

        public int AddUser(dynamic param)
        {
            this.Database.Open();
            int result = this.Database.Execute("AddUser", param);
            this.Database.Close();
            return result;
        }

        public int AddUserChare(dynamic param)
        {
            this.Database.Open();
            List<int> result = this.Database.Query<int>("AddUserChare", param);
            this.Database.Close();
            return result[0];
        }

        public int AddUserManual(dynamic param)
        {
            this.Database.Open();
            List<int> result = this.Database.Query<int>("AddUserManual", param);
            this.Database.Close();
            return result[0];
        }

        public IEnumerable<SelectListItem> GetRoleOption(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetRoleOption", param);
            this.Database.Close();
            return result;
        }

        public IEnumerable<UserProfile> GetInformationChareUser(dynamic param)
        {
            this.Database.Open();
            IList<UserProfile> result = this.Database.Query<UserProfile>("GetInformationChareUser", param);
            this.Database.Close();
            return result;
        }

        public IEnumerable<SelectListItem> GetRoleOptionWithoutAnyValue(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetRoleOption", param);
            this.Database.Close();
            SelectListItem except = result.Where(x => x.Value == "").Single();
            result.Remove(except);
            return result;
        }

        public IEnumerable<SelectListItem> GetMasterDivisionOption(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetMasterDivisionOption", param);
            this.Database.Close();
            return result;
        }

        public IEnumerable<SelectListItem> GetMasterDivisionOptionWithoutAnyValue(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetMasterDivisionOption", param);
            this.Database.Close();
            SelectListItem except = result.Where(x => x.Value == "").Single();
            result.Remove(except);
            return result;
        }

        public IEnumerable<SelectListItem> GetMasterSubDivisionOption(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetMasterSubDivisionOption", param);
            this.Database.Close();
            SelectListItem except = result.Where(x => x.Value == "").Single();
            result.Remove(except);
            return result.AsEnumerable();
        }

        public IEnumerable<SelectListItem> GetMasterSubDivisionOptionWithoutAnyValue(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetMasterSubDivisionOption", param);
            this.Database.Close();
            SelectListItem except = result.Where(x => x.Value == "").Single();
            result.Remove(except);
            return result.AsEnumerable();
        }

        public IEnumerable<SelectListItem> GetMasterDepartmentOption(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetMasterDepartmentOption", param);
            this.Database.Close();
            return result;
        }

        public IEnumerable<SelectListItem> GetMasterDepartmentOptionWithoutAnyValue(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetMasterDepartmentOption", param);
            this.Database.Close();
            SelectListItem except = result.Where(x => x.Value == "").Single();
            result.Remove(except);
            return result.AsEnumerable();
        }

        public IEnumerable<SelectListItem> GetMasterSubDepartmentOption(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetMasterSubDepartmentOption", param);
            this.Database.Close();
            return result;
        }

        public IEnumerable<SelectListItem> GetMasterSubDepartmentOptionWithoutAnyValue(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetMasterSubDepartmentOption", param);
            this.Database.Close();
            SelectListItem except = result.Where(x => x.Value == "").Single();
            result.Remove(except);
            return result.AsEnumerable();
        }
         
        public IList<SelectListItem> GetNetworkID(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetNetworkID", param);
            this.Database.Close();
            return result;
        }

        public IList<SelectListItem> GetCAIID(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetCAIID", param);
            this.Database.Close();
            return result;
        }
        
        public IList<SelectListItem> GetUserNameForBackup(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetUserNameForBackup", param);
            this.Database.Close();
            return result;
        }

        public IList<SelectListItem> GetUserNameExcept(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetUserNameExcept", param);
            this.Database.Close();
            return result;
        }
        
        public IList<SelectListItem> GetUserNameOption(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetUserNameOption", param);
            this.Database.Close();
            return result;
        }

        public void SetBackup(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("SetBackup", param);
            this.Database.Close(); 
        }
          
        public void DeleteBackup(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("DeleteBackup", param);
            this.Database.Close(); 
        }

        public IList<SelectListItem> GetChareUser(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetChareUser", param);
            this.Database.Close();
            return result;
        }

        public IList<SelectListItem> GetUserAlreadyBackup(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetUserAlreadyBackup", param);
            this.Database.Close();
            return result;
        }

        public IList<SelectListItem> GetAssignedBackup(dynamic param)
        {
            this.Database.Open();
            IList<SelectListItem> result = this.Database.Query<SelectListItem>("GetAssignedBackup", param);
            this.Database.Close();
            return result;
        }
         
        public AssignedBackupProfileInformation GetUserInformationBackup(dynamic param)
        {
            this.Database.Open();
            IList<AssignedBackupProfileInformation> result = this.Database.Query<AssignedBackupProfileInformation>("GetUserInformationBackup", param);
            this.Database.Close();
            if (result.Any())
                return result[0];

            return new AssignedBackupProfileInformation();
        }

        public void SaveUserProfile(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("SaveUserProfile", param);
            this.Database.Close();
        }

        public void DeleteUserProfile(dynamic param)
        {
            this.Database.Open();
            this.Database.Execute("DeleteUserProfile", param);
            this.Database.Close();
        }

        public IEnumerable<SelectListItem> GetMasterYesNoQuestion(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetYesNo", param);
            this.Database.Close();
            return result;
        }

        public IEnumerable<SelectListItem> GetDirectReport(dynamic param)
        {
            this.Database.Open();
            IEnumerable<SelectListItem> result = this.Database.Query<SelectListItem>("GetDirectReport", param);
            this.Database.Close();
            return result;
        }

    }
}