using Krokot.ProfileAdmin.Models.Login;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebPlatform; 

namespace Krokot.ProfileAdmin.Controllers
{
    public class HomeController : LoginPageController
    {

        public override void Startup()
        {
            
        }

        public ActionResult Index()
        {
            LoginRepository repo = new LoginRepository();
            
            ApplicationSettings.Instance.UI.Theme = Theme.Blue;
            ApplicationSettings.Instance.Environment.ApplicationId = "100";
            string impersonateUser = repo.GetImpersonateUser(new
            {
                NetworkId = WebUtils.ParseUserLogon(HttpContext.User.Identity.Name),
                Application = ApplicationSettings.Instance.Environment.ApplicationId
            });

            if (!base.Login(impersonateUser))
            {
                return RedirectToAction(this.PageSettings.IndexPage, ApplicationSettings.Instance.Security.UnauthorizedControlller);
            }
             
            return View();
        }

    }
}
