// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Management;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsLogfile
    {
        //Function writelog
        //description: appends the .log file in the format which will allow for the Microsoft cmtrace.exe log file viewer to format in an easy way to read
        //inputs:   Message [string]: this is a free text field which accepts multi line strings like stacktraces and alike but still presents in the logfile as single line.
        //          Severity [int]: this allows CMtrace to colour cohde the messages when rendoring, the scheme is;  1 informational
        //                                                                                                          2 Warning
        //                                                                                                          3 Error
        //          Component [string]: this allows you to know where in the script it logs, use <System.Reflection.MethodBase.GetCurrentMethod().Name> for the current method calling writelog
        //          logfile [string]: this is the full path to the log file, as example of this is: <c:\windows\logs\HPSQLaaSWS\HPSQLaaSWS.log>
        //outputs: NULL

        /// <summary>
        ///     logs a set of function parameters to the default log file
        /// </summary>
        /// <param name="sPramName"></param>
        /// <param name="args"></param>
        public static void Writelogparam(string sPramName, params string[] args)
        {
            if (ClsTimer.Settings.LogLevel.ToLower() != "verbose") return;
            var s = "Parameters = " + Environment.NewLine;
            try
            {
                for (var i = 0; i < sPramName.Split(',').Length; i++)
                {
                    s += sPramName.Split(',')[i].Trim() + " ='" + args[i].Trim() + "'" + Environment.NewLine;
                }
            }
            catch
            {
                s += "<<Parameter Mismatch>>";
            }
            Writelog(1, s, new StackTrace().GetFrame(1).GetMethod().Name, ClsTimer.Settings.LogFile);
        }

        /// <summary>
        /// </summary>
        /// <param name="message"></param>
        /// <param name="verbose"></param>
        public static void Writelog(string message, bool verbose = false)
        {
            if (verbose)
            {
                if (ClsTimer.Settings.LogLevel.ToLower() == "verbose")
                    Writelog(1, message, new StackTrace().GetFrame(1).GetMethod().Name, ClsTimer.Settings.LogFile);
            }
            else
            {
                Writelog(1, message, new StackTrace().GetFrame(1).GetMethod().Name, ClsTimer.Settings.LogFile);
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="severity"></param>
        /// <param name="message"></param>
        /// <param name="verbose"></param>
        public static void Writelog(int severity, string message, bool verbose = false)
        {
            if (verbose)
            {
                if (ClsTimer.Settings.LogLevel.ToLower() == "verbose")
                    Writelog(severity, message, new StackTrace().GetFrame(1).GetMethod().Name, ClsTimer.Settings.LogFile);
            }
            else
            {
                Writelog(severity, message, new StackTrace().GetFrame(1).GetMethod().Name, ClsTimer.Settings.LogFile);
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="severity"></param>
        /// <param name="message"></param>
        /// <param name="component"></param>
        /// <param name="logfile"></param>
        public static void Writelog(int severity, string message, string component, string logfile)
        {
            try
            {
                var qry = new SelectQuery("Select Bias from Win32_TimeZone");
                var searcher = new ManagementObjectSearcher(qry);
                var bias = searcher.Get().Cast<ManagementObject>().Select(m => m["Bias"].ToString()).ToList()[0];
                var strDate = DateTime.Now.ToString("MM-dd-yyyy");
                var strTime = DateTime.Now.ToString("HH:mm:ss.fff");
                var logstr =
                    string.Format(
                        "<![LOG[{0}]LOG]!><time=\"{1}+{2}\" date=\"{3}\" component=\"{4}\" context=\"\" type=\"{5}\" thread=\"\" file=\"\">",
                        message, strTime, bias, strDate, component, severity);
                //if (!File.Exists(string.Format("{0}\\SQLaaS_{1}.log",logfile,strDate)))
                //{
                    
                //}
               // var file = new FileInfo(logfile);
                //if (file.Length >= 204880000) file.MoveTo(logfile.Replace(".log", DateTime.Now + ".log"));
                var objWriter = new StreamWriter(string.Format("{0}\\SQLaaS_{1}.log", logfile, strDate), true);
                objWriter.WriteLine(logstr);
                objWriter.Close();
            }
            catch (Exception)
            {
                // ignored
            }
        }
    }
}