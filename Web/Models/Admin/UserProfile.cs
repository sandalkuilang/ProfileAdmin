using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models.Admin
{
    public class UserProfile
    { 
        public string NetworkId { get; set; }
        public string Badge { get; set; }
        public string CAIId { get; set; } 
        public string Name { get; set; }
        public string RoleAlias { get; set; }
        public int? Role { get; set; }
        public string Email { get; set; } 
        public int? Status { get; set; }
        public string StatusAlias { get; set; }
        public int? Company { get; set; }
        public string CompanyAlias { get; set; }
        public string OPG { get; set; }
        public string Division { get; set; }
        public string DivisionAlias { get; set; }
        public string SubDivision { get; set; }
        public string SubDivisionAlias { get; set; }
        public string Department { get; set; }
        public string DepartmentAlias { get; set; }
        public string SubDepartment { get; set; }
        public string SubDepartmentAlias { get; set; }
        public string BackupId { get; set; }
        public string BackupName { get; set; }
        public string IsBackup { get; set; }
        public string IsBackupAlias { get; set; }
        public int? IsActive { get; set; }
        public string IsActiveAlias { get; set; }
        public string DirectReport { get; set; }
        public string DirectReportName { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string ModifiedBy { get; set; } 
    }
}