using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Krokot.ProfileAdmin.Models.Authorization
{
    public class User : WebPlatform.Credential.User, IUser
    {
        public Guid UserId { get; set; } 
        public string PasswordHash { get; set; }
        public string SecurityStamp { get; set; }
         
        public string Id
        {
            get { return UserId.ToString(); }
        }
    }
}