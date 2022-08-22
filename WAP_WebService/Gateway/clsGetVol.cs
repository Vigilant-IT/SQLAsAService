using System.Collections.Generic;
using System.Linq;
using System.Management;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsGetVol
    {
        /// <summary>
        /// </summary>
        public static List<VolStore> CVolStore = new List<VolStore>();

        /// <summary>
        ///     Uses WMI to get the available volumes from the Host servers. to allow for the creations of the VHDX's
        /// </summary>
        /// <param name="sPm"></param>
        /// <returns></returns>
        public static VolStore GetVolShare(string sPm, string strPurpose, string strHighPerformance)
        {
            ClsLogfile.Writelogparam("sPm", sPm);
            var outvol = new VolStore();
            var scope = new ManagementScope(@"\\" + sPm + @"\root\cimv2");
            var query = new SelectQuery("win32_volume");
            var searcher = new ManagementObjectSearcher(scope, query);
            foreach (var vol in from ManagementBaseObject m in searcher.Get()
            select new VolStore
                {
                    Label = string.IsNullOrEmpty(m["Label"].ToString()) ? "" : m["Label"].ToString(),
                    Pm = sPm,
                    Freespace = long.Parse(m["FreeSpace"].ToString()),
                    Caption = string.IsNullOrEmpty(m["Caption"].ToString()) ? "" : m["Caption"].ToString(),
                    Capacity = long.Parse(m["Capacity"].ToString()),
                    Performance = "Standard",
                    Purpose = "Other"
                })
            {
                if (vol.Label.ToUpper().EndsWith("H")) vol.Performance = "HighPerformance";
                if (vol.Label.ToUpper().Contains("SQLDB")) vol.Purpose = "Data";
                if (vol.Label.ToUpper().Contains("SQLLG")) vol.Purpose = "Log";
                if (vol.Purpose == strPurpose && vol.Performance == strHighPerformance && vol.Freespace >= 1000000)
                {
                    outvol = vol;
                    break;
                }
            }
            return outvol; 
        }

        /// <summary>
        ///     keep the volume data for the life of the allocation
        /// </summary>
        public class VolStore
        {
            /// <summary>
            /// </summary>
            private long _capacity;

            /// <summary>
            /// </summary>
            private string _caption;

            /// <summary>
            /// </summary>
            private long _freespace;

            /// <summary>
            /// </summary>
            private string _label;

            /// <summary>
            /// </summary>
            private string _performance;

            /// <summary>
            /// </summary>
            private string _pm;

            /// <summary>
            /// </summary>
            private string _purpose;

            /// <summary>
            /// </summary>
            public string Pm
            {
                get { return _pm; }
                set { _pm = Setval(value); }
            }

            /// <summary>
            /// </summary>
            public long Freespace
            {
                get { return _freespace; }
                set { _freespace = Setval(value); }
            }

            /// <summary>
            /// </summary>
            public string Label
            {
                get { return _label; }
                set { _label = Setval(value); }
            }

            /// <summary>
            /// </summary>
            public string Caption
            {
                get { return _caption; }
                set { _caption = Setval(value); }
            }

            /// <summary>
            /// </summary>
            public long Capacity
            {
                get { return _capacity; }
                set { _capacity = Setval(value); }
            }

            /// <summary>
            /// </summary>
            public string Performance
            {
                get { return _performance; }
                set { _performance = Setval(value); }
            }

            /// <summary>
            /// </summary>
            public string Purpose
            {
                get { return _purpose; }
                set { _purpose = Setval(value); }
            }

            /// <summary>
            ///     Sets Values for strings
            /// </summary>
            /// <param name="val"></param>
            /// <returns></returns>
            private static string Setval(string val)
            {
                return val;
            }

            /// <summary>
            ///     Sets value for long numbers
            /// </summary>
            /// <param name="val"></param>
            /// <returns></returns>
            private static long Setval(long val)
            {
                return val;
            }
        }
    }
}