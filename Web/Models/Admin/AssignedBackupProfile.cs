using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models.Admin
{
    public class AssignedBackupProfileInformation
    {
        public string NetworkId { get; set; }
        public int Role { get; set; }
        public string RoleAlias { get; set; }
        public string BackupId { get; set; }
        public string BackupAlias { get; set; }
        public string Division { get; set; }
        public string Department { get; set; }
    }
}