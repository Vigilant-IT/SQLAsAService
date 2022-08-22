// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 30/12/2015
// 
// as part of the Gateway Project

using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Gateway
{
    /// <summary>
    ///     the Audit object is to hold the information returned from the Audit SQL Table in GW
    /// </summary>
    public class Audit
    {
        /// <summary>
        /// </summary>
        private string _availability;

        /// <summary>
        /// </summary>
        private string _budi;

        /// <summary>
        /// </summary>
        private string _colation;

        /// <summary>
        /// </summary>
        private string _connection;

        /// <summary>
        /// </summary>
        private string _dbName;

        /// <summary>
        /// </summary>
        private string _dBoGroup;

        /// <summary>
        /// </summary>
        /// <summary>
        /// </summary>
        private string _dc;

        /// <summary>
        /// </summary>
        private string _expire;

        /// <summary>
        /// </summary>
        /// <summary>
        /// </summary>
        private string _id;

        /// <summary>
        /// </summary>
        private string _initialSizeMB;

        /// <summary>
        /// </summary>
        private string _logged;

        /// <summary>
        /// </summary>
        private string _network;

        /// <summary>
        /// </summary>
        private string _notes;

        /// <summary>
        /// </summary>
        private string _pwrUGroup;

        /// <summary>
        /// </summary>
        private string _recovery;

        /// <summary>
        /// </summary>
        private string _retention;

        /// <summary>
        /// </summary>
        private string _sku;

        /// <summary>
        /// </summary>
        private string _sqlVer;

        /// <summary>
        /// </summary>
        private string _state;

        /// <summary>
        /// </summary>
        private string _stdUGroup;

        /// <summary>
        /// </summary>
        private string _storPerfData;

        /// <summary>
        /// </summary>
        private string _storPerfLogs;

        /// <summary>
        /// </summary>
        private string _tde;

        /// <summary>
        /// </summary>
        private string _username;

        /// <summary>
        /// </summary>
        private string _zone;

        /// <summary>
        /// </summary>
        private string _requestItid;

        /// <summary>
        /// </summary>
        public string Id
        {
            get { return _id; }
            set { _id = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string State
        {
            get { return _state; }
            set { _state = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Dc
        {
            get { return _dc; }
            set { _dc = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Username
        {
            get { return _username; }
            set { _username = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string DBName
        {
            get { return _dbName; }
            set { _dbName = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string SQLVer
        {
            get { return _sqlVer; }
            set { _sqlVer = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string InitialSizeMB
        {
            get { return _initialSizeMB; }
            set { _initialSizeMB = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Colation
        {
            get { return _colation; }
            set { _colation = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Network
        {
            get { return _network; }
            set { _network = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Availability
        {
            get { return _availability; }
            set { _availability = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Zone
        {
            get { return _zone; }
            set { _zone = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Sku
        {
            get { return _sku; }
            set { _sku = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string StorPerfData
        {
            get { return _storPerfData; }
            set { _storPerfData = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string StorPerfLogs
        {
            get { return _storPerfLogs; }
            set { _storPerfLogs = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Retention
        {
            get { return _retention; }
            set { _retention = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string BUDI
        {
            get { return _budi; }
            set { _budi = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string DBoGroup
        {
            get { return _dBoGroup; }
            set { _dBoGroup = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Recovery
        {
            get { return _recovery; }
            set { _recovery = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string TDE
        {
            get { return _tde; }
            set { _tde = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Connection
        {
            get { return _connection; }
            set { _connection = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Notes
        {
            get { return _notes; }
            set { _notes = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Logged
        {
            get { return _logged; }
            set { _logged = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Expire
        {
            get { return _expire; }
            set { _expire = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string PwrUGroup
        {
            get { return _pwrUGroup; }
            set { _pwrUGroup = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string StdUGroup
        {
            get { return _stdUGroup; }
            set { _stdUGroup = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string RequestItid
        {
            get { return _requestItid; }
            set { _requestItid = Setval(value); }
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
        /// <param name="sSqlServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        public static List<Audit> GetallAudit(string sSqlServer, string sGwdb)
        {
            ClsLogfile.Writelogparam("sSqlServer,  sGwdb", sSqlServer, sGwdb);
            var laudit = new List<Audit>();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        sSqlServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = "select * from audit";
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining Audit for a ALL DBs", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var audit = new Audit
                            {
                                Id = dr["ID"].ToString(),
                                State = dr["State"].ToString(),
                                Dc = dr["DC"].ToString(),
                                Username = dr["Username"].ToString(),
                                DBName = dr["DBName"].ToString(),
                                SQLVer = dr["SQLVer"].ToString(),
                                InitialSizeMB = dr["InitialSizeMB"].ToString(),
                                Colation = dr["Colation"].ToString(),
                                Network = dr["Network"].ToString(),
                                Availability = dr["Availability"].ToString(),
                                Zone = dr["Zone"].ToString(),
                                Sku = dr["SKU"].ToString(),
                                StorPerfData = dr["StorPerfData"].ToString(),
                                StorPerfLogs = dr["StorPerfLogs"].ToString(),
                                Retention = dr["Retention"].ToString(),
                                BUDI = dr["BUDI"].ToString(),
                                DBoGroup = dr["DBoGroup"].ToString(),
                                Recovery = dr["Recovery"].ToString(),
                                TDE = dr["TDE"].ToString(),
                                Connection = dr["Connection"].ToString(),
                                Notes = dr["Notes"].ToString(),
                                Logged = dr["Logged"].ToString(),
                                Expire = dr["Expire"].ToString(),
                                RequestItid = dr["RequestITID"].ToString(),
                                PwrUGroup = dr["PwrUGroup"].ToString(),
                                StdUGroup = dr["StdUGroup"].ToString()
                            };
                            laudit.Add(audit);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain Audit for a ALL DBs");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    return null;
                }
                sc.Close();
                return laudit;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="sDbid"></param>
        /// <param name="sSqlServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        public static Audit Getaudit(string sDbid, string sSqlServer, string sGwdb)
        {
            ClsLogfile.Writelogparam("sDbid,  sSqlServer,  sGwdb", sDbid, sSqlServer, sGwdb);
            var audit = new Audit();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        sSqlServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("select top 1 * from audit where id = '{0}'", sDbid);
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining Audit for a single DB", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            audit.Id = sDbid;
                            audit.State = dr["State"].ToString();
                            audit.Dc = dr["DC"].ToString();
                            audit.Username = dr["Username"].ToString();
                            audit.DBName = dr["DBName"].ToString();
                            audit.SQLVer = dr["SQLVer"].ToString();
                            audit.InitialSizeMB = dr["InitialSizeMB"].ToString();
                            audit.Colation = dr["Colation"].ToString();
                            audit.Network = dr["Network"].ToString();
                            audit.Availability = dr["Availability"].ToString();
                            audit.Zone = dr["Zone"].ToString();
                            audit.Sku = dr["SKU"].ToString();
                            audit.StorPerfData = dr["StorPerfData"].ToString();
                            audit.StorPerfLogs = dr["StorPerfLogs"].ToString();
                            audit.Retention = dr["Retention"].ToString();
                            audit.BUDI = dr["BUDI"].ToString();
                            audit.DBoGroup = dr["DBoGroup"].ToString();
                            audit.Recovery = dr["Recovery"].ToString();
                            audit.TDE = dr["TDE"].ToString();
                            audit.Connection = dr["Connection"].ToString();
                            audit.Notes = dr["Notes"].ToString();
                            audit.Logged = dr["Logged"].ToString();
                            audit.Expire = dr["Expire"].ToString();
                            audit.RequestItid = dr["RequestITID"].ToString();
                            audit.PwrUGroup = dr["PwrUGroup"].ToString();
                            audit.StdUGroup = dr["StdUGroup"].ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain Audit for a single DB");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    return null;
                }
                sc.Close();
                return audit;
            }
        }

        /// <summary>
        ///     Update the Any field in the Audit table
        /// </summary>
        /// <param name="sDBId"></param>
        /// <param name="sGwdb"></param>
        /// <param name="sFild"></param>
        /// <param name="sValu"></param>
        /// <param name="sSQLServer"></param>
        public static void SpUpdateAuditField(string sDBId, string sSQLServer, string sGwdb, string sFild, string sValu)
        {
            ClsLogfile.Writelogparam("sDBId, sFild, sValu, sSQLServer, sGwdb", sDBId, sFild, sValu, sSQLServer, sGwdb);
            using (var sc =
                new SqlConnection(
                    string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        sSQLServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("update Audit set {0} = '{1}' where Id = '{2}'",
                    sFild,
                    sValu,
                    sDBId);
                try
                {
                    ClsLogfile.Writelog(1, "Updating Audit table in GW", true);
                    cmd.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to update Audit table in GW");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
            }
        }

        /// <summary>
        ///     Update the note field in the Audit table
        /// </summary>
        /// <param name="sGwdb"></param>
        /// <param name="sValu"></param>
        /// <param name="sDBName"></param>
        /// <param name="sSQLServer"></param>
        public static void SpUpdateAuditNotesField(string sDBName, string sSQLServer, string sGwdb, string sValu)
        {
            ClsLogfile.Writelogparam("sDBId, sFild, sValu, sSQLServer, sGwdb", sDBName, sValu, sSQLServer, sGwdb);
            using (var sc =
                new SqlConnection(
                    string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        sSQLServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("update Audit set Notes = '{0}' where DBName = '{1}'",
                    sValu,
                    sDBName);
                try
                {
                    ClsLogfile.Writelog(1, "Updating Notes Audit table in GW", true);
                    cmd.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to update Notes Audit table in GW");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
            }
        }

        /// <summary>
        ///     Update the note field in the Audit table
        /// </summary>
        /// <param name="sDBId"></param>
        /// <param name="sGwdb"></param>
        /// <param name="sValu"></param>
        /// <param name="sSQLServer"></param>
        public static void SpUpdateAuditNotesField(int sDBId, string sSQLServer, string sGwdb, string sValu)
        {
            ClsLogfile.Writelogparam("sDBId, sFild, sValu, sSQLServer, sGwdb", sDBId.ToString(), sValu, sSQLServer,
                sGwdb);
            using (var sc =
                new SqlConnection(
                    string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        sSQLServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("update Audit set Notes = '{0}' where Id = '{1}'",
                    sValu,
                    sDBId);
                try
                {
                    ClsLogfile.Writelog(1, "Updating Notes Audit table in GW", true);
                    cmd.ExecuteScalar();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to update Notes Audit table in GW");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
            }
        }

        /// <summary>
        ///     update phase of DB provisioning
        /// </summary>
        /// <param name="sDbid"></param>
        /// <param name="sPhase"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        public static bool SpChangePhaseAuditField(string sDbid, string sPhase, string sSQLServer, string sGwdb)
        {
            ClsLogfile.Writelogparam("sDbid, sPhase, sSQLServer, sGwdb", sDbid, sPhase, sSQLServer, sGwdb);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            sSQLServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("Update Audit Set State ='{0}' where Id='{1}'", sPhase, sDbid);
                bool res;
                try
                {
                    ClsLogfile.Writelog(1, "Updating state in Audit table in GW", true);
                    res = cmd.ExecuteNonQuery() == 0;
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to update state in Audit table in GW");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }

                sc.Close();
                return res;
            }
        }
    }
}