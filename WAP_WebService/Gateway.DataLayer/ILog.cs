using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Management;
using Gateway.DataLayer.Utility;

namespace Gateway.DataLayer
{
    public interface ILog
    {
        void Writelogobject(string objectContext, object obj);
        void Writelogparam(string pramName, params string[] args);
        void Writelog(string message, bool verbose = false);
        void Writelog(int severity, string message, bool verbose = false);
        void Writelog(int severity, string message, string component);
    }

    public class Log : ILog
    {
        
        private readonly bool _verbos;
        private readonly string _logfolder;
        private readonly string _logname;

        public Log(bool verbos, string logfolder, string logname)
        {
            _verbos = verbos;
            _logfolder = logfolder;
            _logname = logname;
        }

        public void Writelogobject(string objectContext, object obj)
        {
            if (!_verbos)
                return;

            string component;
            try { component = new StackTrace().GetFrame(1).GetMethod().Name; }
            catch { component = "Unknown"; }

            Writelog(1, objectContext + ":" + obj.GetDataObjectString(), component);

        }

        public void Writelogparam(string pramName, params string[] args)
        {
            if (!_verbos)
                return;

            string component;
            try { component = new StackTrace().GetFrame(1).GetMethod().Name; }
            catch { component = "Unknown"; }
            var message = "Parameters = " + Environment.NewLine;
            try
            {
                for (var i = 0; i < pramName.Split(',').Length; i++)
                {
                    message += pramName.Split(',')[i].Trim() + " ='" + args[i].Trim() + "'" + Environment.NewLine;
                }
            }
            catch
            {
                message += "<<Parameter Mismatch>>";
            }

            Writelog(1, message, component);
            
        }

        public void Writelog(string message, bool verbose = false)
        {
            string component;
            try { component = new StackTrace().GetFrame(1).GetMethod().Name; }
            catch { component = "Unknown"; }

            if (!verbose || _verbos)
            {
                Writelog(1, message, component);
            }
        }

        public void Writelog(int severity, string message, bool verbose = false)
        {
            string component;
            try { component = new StackTrace().GetFrame(1).GetMethod().Name;}catch{component = "Unknown";}
            
            if (!verbose || _verbos)
            {
                Writelog(severity, message, component);
            }
        }

        public void Writelog(int severity, string message, string component)
        {
            var bias = GetBias();
            using (var writer = File.AppendText(string.Format("{0}\\{1}-{2:yyyy-MM-dd}.log", _logfolder, _logname, DateTime.Now)))
            {
                writer.WriteLine(string.Format("<![LOG[{0}]LOG]!><time=\"{1:HH:mm:ss tt zz.fff}+{2}\" date=\"{1:yy-MM-dd-yyyy}\" component=\"{3}\" context=\"\" type=\"{4}\" thread=\"\" file=\"\">", message, DateTime.Now, bias, component, severity));
                writer.Close();
            }
        }

        private string GetBias()
        {
            var qry = new SelectQuery("Select Bias from Win32_TimeZone");
            var searcher = new ManagementObjectSearcher(qry);
            return searcher.Get().Cast<ManagementObject>().Select(m => m["Bias"].ToString()).ToList()[0];
        }
    }
}
