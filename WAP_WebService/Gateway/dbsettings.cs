// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 30/12/2015
// 
// as part of the Gateway Project

using System;
using System.Data.SqlClient;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class Dbsettings
    {
        /// <summary>
        /// </summary>
        private string _iDB;

        /// <summary>
        /// </summary>
        private string _sAlwaysOnGroup;

        /// <summary>
        /// </summary>
        private string _sConnString;

        /// <summary>
        /// </summary>
        private string _sDataCentre;

        /// <summary>
        /// </summary>
        private string _sDns;

        /// <summary>
        /// </summary>
        private string _sHost;

        /// <summary>
        /// </summary>
        private string _sIpAddress;

        /// <summary>
        /// </summary>
        private string _sListenerName;

        /// <summary>
        /// </summary>
        private string _sLunDB;

        /// <summary>
        /// </summary>
        private string _sLunDbcp;

        /// <summary>
        /// </summary>
        private string _sLunLog;

        /// <summary>
        /// </summary>
        private string _sLunLogCp;

        /// <summary>
        /// </summary>
        private string _sPlanId;

        /// <summary>
        /// </summary>
        private string _sPlanShortName;

        /// <summary>
        /// </summary>
        private string _sSQLUser;

        /// <summary>
        /// </summary>
        private string _sSubId;

        /// <summary>
        /// </summary>
        private string _sSwitchBc;

        /// <summary>
        /// </summary>
        private string _sVm;

        /// <summary>
        /// </summary>
        private string _sVmm;

        /// <summary>
        /// </summary>
        private string _vmcp;

        /// <summary>
        /// </summary>
        private string _vmmcp;

        /// <summary>
        /// </summary>
        public string DB
        {
            get { return _iDB; }
            set { _iDB = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string AlwaysOnGroup
        {
            get { return _sAlwaysOnGroup; }
            set { _sAlwaysOnGroup = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string DataCentre
        {
            get { return _sDataCentre; }
            set { _sDataCentre = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string IpAddress
        {
            get { return _sIpAddress; }
            set { _sIpAddress = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string ListenerName
        {
            get { return _sListenerName; }
            set { _sListenerName = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string LunDB
        {
            get { return _sLunDB; }
            set { _sLunDB = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string LunDbcp
        {
            get { return _sLunDbcp; }
            set { _sLunDbcp = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string LunLog
        {
            get { return _sLunLog; }
            set { _sLunLog = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string LunLogCp
        {
            get { return _sLunLogCp; }
            set { _sLunLogCp = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string PlanShortName
        {
            get { return _sPlanShortName; }
            set { _sPlanShortName = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Host
        {
            get { return _sHost; }
            set { _sHost = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Vmm
        {
            get { return _sVmm; }
            set { _sVmm = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Dns
        {
            get { return _sDns; }
            set { _sDns = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Vm
        {
            get { return _sVm; }
            set { _sVm = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string PlanId
        {
            get { return _sPlanId; }
            set { _sPlanId = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string SubId
        {
            get { return _sSubId; }
            set { _sSubId = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string SQLUser
        {
            get { return _sSQLUser; }
            set { _sSQLUser = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string ConnString
        {
            get { return _sConnString; }
            set { _sConnString = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string SwitchBc
        {
            get { return _sSwitchBc; }
            set { _sSwitchBc = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Vmcp
        {
            get { return _vmcp; }
            set { _vmcp = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Vmmcp
        {
            get { return _vmmcp; }
            set { _vmmcp = Setval(value); }
        }

        /// <summary>
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private static string Setval(string val)
        {
            return val;
        }

        /// <summary>
        /// </summary>
        /// <param name="sDbid"></param>
        /// <param name="sSqlServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        public static Dbsettings Getdbsettings(string sDbid, string sSqlServer, string sGwdb)
        {
            ClsLogfile.Writelogparam("sDbid,  sSqlServer,  sGwdb", sDbid, sSqlServer, sGwdb);
            var dbset = new Dbsettings();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        sSqlServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("select top 1 * from dbsettings where DBID = '{0}'", sDbid);
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining DBSettings", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            dbset.DB = sDbid;
                            dbset.AlwaysOnGroup = dr["AlwaysOnGroup"].ToString();
                            dbset.DataCentre = dr["DataCentre"].ToString();
                            dbset.IpAddress = dr["IPAddress"].ToString();
                            dbset.ListenerName = dr["ListenerName"].ToString();
                            dbset.LunDB = dr["LunDB"].ToString();
                            dbset.LunDbcp = dr["LunDBCP"].ToString();
                            dbset.LunLog = dr["LunLog"].ToString();
                            dbset.LunLogCp = dr["LunLogCP"].ToString();
                            dbset.PlanShortName = dr["PlanShortName"].ToString();
                            dbset.Host = dr["Host"].ToString();
                            dbset.Vmm = dr["VMM"].ToString();
                            dbset.Dns = dr["DNS"].ToString();
                            dbset.Vm = dr["VM"].ToString();
                            dbset.PlanId = dr["PlanID"].ToString();
                            dbset.SubId = dr["SubId"].ToString();
                            dbset.SQLUser = dr["SQLUser"].ToString();
                            dbset.ConnString = dr["ConnString"].ToString();
                            dbset.SwitchBc = dr["SwitchBC"].ToString();
                            dbset.Vmcp = dr["VMCP"].ToString();
                            dbset.Vmmcp = dr["VMMCP"].ToString();
                        }
                    }
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain DBSettings", true);
                    return null;
                }
                sc.Close();
                return dbset;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="sDbid"></param>
        /// <param name="sAlwaysOnGroup"></param>
        /// <param name="sDataCentre"></param>
        /// <param name="sIpAddress"></param>
        /// <param name="sListenerName"></param>
        /// <param name="sLunDb"></param>
        /// <param name="sLunDbcp"></param>
        /// <param name="sLunLog"></param>
        /// <param name="sLunLogCp"></param>
        /// <param name="sPlanShortName"></param>
        /// <param name="sHost"></param>
        /// <param name="sVmm"></param>
        /// <param name="sDns"></param>
        /// <param name="sVm"></param>
        /// <param name="sSwitchBcPrim"></param>
        /// <param name="sPlanId"></param>
        /// <param name="sSubId"></param>
        /// <param name="sSqlUser"></param>
        /// <param name="sConnString"></param>
        /// <param name="vmcp"></param>
        /// <param name="vmmcp"></param>
        /// <param name="sGwsqlServer"></param>
        /// <param name="sGwdBname"></param>
        public static void UpdateDbSettings(string sDbid,
            string sAlwaysOnGroup,
            string sDataCentre,
            string sIpAddress,
            string sListenerName,
            string sLunDb,
            string sLunDbcp,
            string sLunLog,
            string sLunLogCp,
            string sPlanShortName,
            string sHost,
            string sVmm,
            string sDns,
            string sVm,
            string sSwitchBcPrim,
            string sPlanId,
            string sSubId,
            string sSqlUser,
            string sConnString,
            string vmcp,
            string vmmcp,
            string sGwsqlServer,
            string sGwdBname)
        {
            ClsLogfile.Writelogparam(
                "sDbid, sAlwaysOnGroup, sDataCentre, sIpAddress, sListenerName, sLunDb, sLunDbcp, sLunLog, sLunLogCp, " +
                "sPlanShortName, sHost, sVmm, sDns, sVm, sSwitchBcPrim, sPlanId, sSubId, sSqlUser, sConnString, vmcp, " +
                "vmmcp, sGwsqlServer, sGwdBname",
                sDbid, sAlwaysOnGroup, sDataCentre, sIpAddress, sListenerName, sLunDb, sLunDbcp, sLunLog, sLunLogCp,
                sPlanShortName, sHost, sVmm, sDns, sVm, sSwitchBcPrim, sPlanId, sSubId, sSqlUser, sConnString, vmcp,
                vmmcp, sGwsqlServer, sGwdBname);
            var insertstr = "";
            if (!Clsdb.CheckSql(sGwsqlServer, sGwdBname, string.Format("select * from dbsettings where DBID = '{0}'", sDbid)))
            {
                insertstr = string.Format("insert into DBSettings ([DBID],[AlwaysOnGroup],[Datacentre],[IPAddress],[ListenerName],[LunDB],[LunDBCP],[LunLog],[LunLogCP],[PlanShortName],[Host],[VMM],[DNS],[VM],[PlanID],[SubID],[SQLUser],[ConnString],[SwitchBC],[VMCP],[VMMCP]) " +
                                          "VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}','{18}','{19}','{20}')",
                sDbid,
                sAlwaysOnGroup,
                sDataCentre,
                sIpAddress,
                sListenerName,
                sLunDb,
                sLunDbcp,
                sLunLog,
                sLunLogCp,
                sPlanShortName,
                sHost,
                sVmm,
                sDns,
                sVm,
                sPlanId,
                sSubId,
                sSqlUser,
                sConnString,
                sSwitchBcPrim,
                vmcp,
                vmmcp);
            }
            else
            {
                insertstr = string.Format("update dbsettings set AlwaysOnGroup = '{1}',Datacentre = '{2}',IPAddress= '{3}',ListenerName='{4}',LunDB='{5}',LunDBCP='{6}',LunLog='{7}',LunLogCP='{8}',PlanShortName='{9}',Host='{10}',VMM='{11}',DNS='{12}',VM='{13}',PlanID='{14}',SubID='{15}',SQLUser='{16}',ConnString='{17}', SwitchBC='{18}', VMCP='{19}', VMMCP='{20}' " +
                                          "where dbID = '{0}'",
                sDbid,
                sAlwaysOnGroup,
                sDataCentre,
                sIpAddress,
                sListenerName,
                sLunDb,
                sLunDbcp,
                sLunLog,
                sLunLogCp,
                sPlanShortName,
                sHost,
                sVmm,
                sDns,
                sVm,
                sPlanId,
                sSubId,
                sSqlUser,
                sConnString,
                sSwitchBcPrim,
                vmcp,
                vmmcp);
            }

            Clsdb.RunSql(sGwsqlServer, sGwdBname, insertstr);
        }
    }
}