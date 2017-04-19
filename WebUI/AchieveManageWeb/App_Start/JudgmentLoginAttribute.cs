using AchieveCommon;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AchieveManageWeb.App_Start
{
    /// <summary>
    /// 判断是否登录的过滤器
    /// </summary>
    public class JudgmentLoginAttribute : ActionFilterAttribute
    {
        public AchieveEntity.UserEntity accountmodelJudgment;

        //执行Action之前操作
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {

            //判断是否登录或是否用权限，如果有那么就进行相应的操作，否则跳转到登录页或者授权页面
            string s_accountId = AES.DecryptStr(CookiesHelper.GetCookieValue("UserID"));
          
            int i_accountId = 0;
            //判断是否有cookie
            if (int.TryParse(s_accountId, out i_accountId))
            {
                AchieveEntity.UserEntity m_account = new AchieveBLL.UserBLL().GetUserById(i_accountId.ToString());
                if (m_account != null)
                {
                    accountmodelJudgment = m_account;
                    filterContext.Controller.ViewData["Account"] = m_account;
                    filterContext.Controller.ViewData["AccountName"] = m_account.AccountName;
                    filterContext.Controller.ViewData["RealName"] = m_account.RealName;

                    //处理Action之前操作内容根据我们提供的规则来定义这部分内容
                    base.OnActionExecuting(filterContext);
                }
                else
                {
                    CookiesHelper.AddCookie("UserID", System.DateTime.Now.AddDays(-1));
                    filterContext.Result = new RedirectResult("/Login/Index");
                }
            }
            else
            {
                filterContext.Result = new RedirectResult("/Login/Index");
            }
        }
    }
}