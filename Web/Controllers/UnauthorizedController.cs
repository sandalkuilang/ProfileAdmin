using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebPlatform;

namespace Krokot.ProfileAdmin.Controllers
{
    public class UnauthorizedController : Controller
    {
        public UnauthorizedController()
        {

        }

        public ActionResult Index()
        {
            return View();
        }
    }
}
