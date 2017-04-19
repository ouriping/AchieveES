
using AchieveCommon;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AchieveBLL
{
    public class ValidatorCodeBLL
    {
        /// <summary>
        /// 生成验证码数字
        /// </summary>
        /// <param name="id">验证码位数，默认为5</param>
        /// <returns></returns>
        public string NewValidateCode(int id = 5)
        {
            ValidatorCodeTools obj = new ValidatorCodeTools();
            return obj.CreateValidateCode(5);
        }
        /// <summary>
        /// 验证码图片
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public byte[] NewValidateCodeGraphic(string code)
        {
            ValidatorCodeTools obj = new ValidatorCodeTools();
            return obj.CreateValidateGraphic(code);
        }
    }
}
