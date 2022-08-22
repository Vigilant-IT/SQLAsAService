// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Linq;
using System.Management.Automation;
using System.Timers;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsTimer
    {
        /// <summary>
        /// </summary>
        public static Timer Timer;

        /// <summary>
        /// </summary>
        public static DateTime DtAuthTokenExpire = DateTime.Now;

        /// <summary>
        /// </summary>
        public static string SAuthToken;

        /// <summary>
        /// </summary>
        public static ClsWapSettings Settings = new ClsWapSettings();

        /// <summary>
        /// </summary>
        public static void MainInit_init()
        {
            ClsLogfile.Writelog("MainInit_init");
            //ClsDal.OpenDb(dbcon, "GW");
        }

        /// <summary>
        /// </summary>
        /// <param name="sAuthSite"></param>
        /// <returns></returns>
        public static string GetToken(string sAuthSite)
        {
            ClsLogfile.Writelogparam("sAuthSite", sAuthSite);
            if (DateTime.Now <= DtAuthTokenExpire) return Settings.Token;
            Settings.Token = ClsAuthentication.GetWindowsToken(sAuthSite);
            DtAuthTokenExpire = DateTime.Now.AddMinutes(30);
            return Settings.Token;
        }

        /// <summary>
        /// </summary>
        /// <param name="ps"></param>
        /// <returns></returns>
        public static string DisplayError(PowerShell ps)
        {
            return ps.Streams.Error.Cast<object>()
                .Aggregate("Error : \n", (current, pse) => current + pse.ToString() + "\n");
        }
    }
}