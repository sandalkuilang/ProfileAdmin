using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebPlatform;
using System.Web.Routing;
using Krokot.ProfileAdmin.Models.Login;

namespace Krokot.ProfileAdmin.Controllers
{
    public class LoginController : LoginPageController
    {

        public LoginController()
        {
           
        }

        public ActionResult Index()
        {
            LoginRepository repo = new LoginRepository();
            List<SelectListItem> listApplication = repo.GetListApplication(new
            {
                NetworkId = WebUtils.ParseUserLogon(HttpContext.User.Identity.Name)
            });
             
            if (listApplication.Count > 1)
            {
                return RedirectToAction(this.PageSettings.IndexPage, ApplicationSettings.Instance.Landing.LandingController);
            }
            else
            {
                /* if more than one application
                switch (listApplication[0].Value)
                {
                    case "100": 
                        ApplicationSettings.Instance.Landing.HomeController = "Krokot.ProfileAdmin";
                        break;
                    case "200": 
                        ApplicationSettings.Instance.Landing.HomeController = "Another Application";
                        break;
                }
                */
                return RedirectToAction(this.PageSettings.IndexPage, ApplicationSettings.Instance.Landing.HomeController);
            }
        }

        public MvcHtmlString AjaxLogin()
        {
            return base.Login() ? MvcHtmlString.Create("true") : MvcHtmlString.Create("false");
        }

        public MvcHtmlString AjaxLogout()
        {
            base.Logout();
            return new MvcHtmlString("true");
        }
    }
}
