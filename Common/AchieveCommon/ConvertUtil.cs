using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace AchieveCommon
{
    /// <summary>
    /// 转换工具类
    /// </summary>
    public class ConvertUtil
    {
        /// <summary>
        /// 返回指定类型值
        /// </summary>
        /// <typeparam name="T">返回值类型</typeparam>
        /// <param name="obj">对象</param>
        /// <returns></returns>
        public static T Get<T>(object obj)
            where T : IConvertible
        {
            T defaultValue = default(T);
            return Get(obj, defaultValue);
        }

        /// <summary>
        /// 返回指定类型值
        /// </summary>
        /// <typeparam name="T">返回值类型</typeparam>
        /// <param name="obj">对象</param>
        /// <param name="defaultValue">默认值</param>
        /// <returns></returns>
        public static T Get<T>(object obj, T defaultValue)
            where T : IConvertible
        {
            if (obj == null)
                return defaultValue;
            try
            {
                return (T)Convert.ChangeType(obj, typeof(T));
            }
            catch { }

            return defaultValue;
        }

        /// <summary>
        /// 根据参数名从请求中获取数据
        /// </summary>
        /// <typeparam name="T">要求返回的参数类型</typeparam>
        /// <param name="name">参数名</param>
        /// <returns>参数值</returns>
        public static T GetRequestParam<T>(string name) where T : IConvertible
        {
            return GetRequestParam<T>(name, default(T));
        }

        /// <summary>
        /// 根据参数名从请求中获取数据
        /// </summary>
        /// <typeparam name="T">要求返回的参数类型</typeparam>
        /// <param name="name">参数名</param>
        /// <param name="defaultValue">参数默认值</param>
        /// <returns>参数值</returns>
        public static T GetRequestParam<T>(string name, T defaultValue) where T : IConvertible
        {
            return GetObject<T>(name, defaultValue,
               ((string parName) =>
               {
                   var paramValue = HttpContext.Current.Request.QueryString[parName];
                   if (string.IsNullOrEmpty(paramValue))
                   {
                       paramValue = HttpContext.Current.Request.Form[parName];
                   }
                   //if (string.IsNullOrEmpty(paramValue))
                   //{
                   //    paramValue = HttpContext.Current.Request.Params[parName];
                   //}
                   if (!string.IsNullOrEmpty(paramValue))
                   {
                       paramValue = HttpUtility.UrlDecode(paramValue);
                       paramValue = paramValue.Trim().Replace("'", "''").Replace("%", "\\%");
                       return IsDanger(paramValue);
                   }
                   return null;
               })
            );
        }

        protected static string IsDanger(string ParamText)
        {
            string word = @"exec|insert|select|delete|update|master|truncate|char|declare|join|iframe|href|script|<|>|request";

            if (string.IsNullOrEmpty(ParamText))
            {
                return "";
            }
            if (Regex.IsMatch(ParamText, word))
            {
                return "";
            }
            return ParamText;
        }

        /// <summary>
        /// 根据参数名从请求中获取数据
        /// </summary>
        /// <typeparam name="T">要求返回的参数类型</typeparam>
        /// <param name="name">参数名</param>
        /// <param name="defaultValue">参数默认值</param>
        /// <param name="handler">调用委托</param>
        /// <returns></returns>
        private static T GetObject<T>(string name, T defaultValue, Func<string, object> handler) where T : IConvertible
        {
            object objRequest = handler(name);
            if (objRequest != null)
            {
                try
                {
                    return (T)Convert.ChangeType(objRequest, typeof(T));
                }
                catch
                {
                    return defaultValue;
                }
            }
            return defaultValue;
        }
    }
}
