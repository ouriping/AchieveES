using AchieveBLL;
using AchieveCommon;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AchieveManageWeb.Controllers
{
    public class ValidatorController : Controller
    {
        //
        // GET: /Validator/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetValidatorGraphics()
        {
            string code = new ValidatorCodeBLL().NewValidateCode();
            //采用cookie
            CookiesHelper.SetCookie("ValidatorCode", code);
            byte[] graphic = new ValidatorCodeBLL().NewValidateCodeGraphic(code);
            return File(graphic, @"image/jpeg");
        }

    }
}
