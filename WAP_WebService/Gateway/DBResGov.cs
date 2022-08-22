using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class DBResGov
    {
        public static string SqlInfoMessage;
        /// <summary>
        /// </summary>
        private string _capcpu;

        /// <summary>
        /// </summary>
        private string _maxcpu;

        /// <summary>
        /// </summary>
        private string _maxmem;

        /// <summary>
        /// </summary>
        private string _maxmempool;

        /// <summary>
        /// </summary>
        private string _minmempool;

        /// <summary>
        /// </summary>
        private string _name;

        /// <summary>
        /// </summary>
        private string _serverid;

        /// <summary>
        /// </summary>
        public string Name
        {
            get { return _name; }
            set { _name = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Maxmem
        {
            get { return _maxmem; }
            set { _maxmem = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Maxcpu
        {
            get { return _maxcpu; }
            set { _maxcpu = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Maxmempool
        {
            get { return _maxmempool; }
            set { _maxmempool = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Minmempool
        {
            get { return _minmempool; }
            set { _minmempool = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Capcpu
        {
            get { return _capcpu; }
            set { _capcpu = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string ServerId
        {
            get { return _serverid; }
            set { _serverid = Setval(value); }
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
        /// <returns></returns>
        public static List<DBResGov> ListAllResGovForServer(string sSqlServer)
        {
            ClsLogfile.Writelogparam("sSqlServer", sSqlServer);
            var dbfilesettings = new List<DBResGov>();

            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            sSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText =
                    "select wg.name, request_max_memory_grant_percent, max_cpu_percent, max_memory_percent, min_memory_percent, cap_cpu_percent " +
                    "from sys.resource_governor_workload_groups as wg join sys.resource_governor_resource_pools rp on wg.pool_id = rp.pool_id " +
                    "where wg.name not in ('internal','default')";
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining List of Resource Governors", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var dbfileset = new DBResGov
                            {
                                Name = dr["name"].ToString(),
                                Maxmem = dr["request_max_memory_grant_percent"].ToString(),
                                Maxcpu = dr["max_cpu_percent"].ToString(),
                                Maxmempool = dr["max_memory_percent"].ToString(),
                                Minmempool = dr["min_memory_percent"].ToString(),
                                Capcpu = dr["cap_cpu_percent"].ToString(),
                                ServerId = sSqlServer
                            };
                            dbfilesettings.Add(dbfileset);
                        }
                    }
                    sc.Close();
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain List of Resource Governors", true);
                    return null;
                }
                sc.Close();
                return dbfilesettings;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strRgName"></param>
        /// <returns></returns>
        public static bool RemoveResGov(string strSqlServer, string strRgName)
        {
            ClsLogfile.Writelogparam("strSqlServer, strRgName", strSqlServer, strRgName);
            var bRg = false;
            try
            {
                if (CheckResGov(strSqlServer, strRgName))
                    bRg = Clsdb.CheckSql(strSqlServer, "master",
                        string.Format(
                            "DROP WORKLOAD GROUP [{0}] ; DROP RESOURCE POOL [{0}] ;ALTER RESOURCE GOVERNOR RECONFIGURE",
                            strRgName));
            }
            catch (Exception)
            {
                bRg = false;
            }
            return bRg;
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDbName"></param>
        /// <returns></returns>
        public static bool CheckResGov(string strSqlServer, string strDbName)
        {
            ClsLogfile.Writelogparam("strSqlServer, strRgName", strSqlServer, strDbName);
            return Clsdb.CheckSql(strSqlServer, "master",
                string.Format("select * from sys.resource_governor_workload_groups where name = '{0}'", strDbName));
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strRgName"></param>
        /// <param name="strSku"></param>
        /// <param name="sSqlVer"></param>
        /// <param name="affinityCpuStart"></param>
        //public static void AllocateResourceGov(string strSqlServer, string strRgName, string strSku, string sSqlVer,
        //    int affinityCpuStart)
        //{
        //    if (affinityCpuStart < 0) affinityCpuStart = 0;
        //    ClsLogfile.Writelogparam("strSqlServer, strRgName, strSku, strSqlVer, affinityCpuStart", strSqlServer,
        //        strRgName, strSku, sSqlVer, affinityCpuStart.ToString());
        //    var strMaxCpu = "6";
        //    var strMaxMem = "6";
        //    var strAffinity = affinityCpuStart + " TO " + (affinityCpuStart + 1);
        //    var strMaxDop = "1";
        //    //switch (strSKU)
        //    switch (ClsAlocDB.GetCoreReqd(strSku))
        //    {
        //        case 1:
        //            strMaxCpu = "6";
        //            strMaxMem = "4";
        //            strAffinity = affinityCpuStart.ToString();
        //            strMaxDop = "1";
        //            break;
        //        case 2:
        //            strMaxCpu = "12";
        //            strMaxMem = "8";
        //            strAffinity = affinityCpuStart + " TO " + (affinityCpuStart + 1);
        //            strMaxDop = "2";
        //            break;
        //        case 4:
        //            strMaxCpu = "25";
        //            strMaxMem = "15";
        //            strAffinity = affinityCpuStart + " TO " + (affinityCpuStart + 3);
        //            strMaxDop = "4";
        //            break;
        //        case 8:
        //            strMaxCpu = "50";
        //            strMaxMem = "30";
        //            strAffinity = affinityCpuStart + " TO " + (affinityCpuStart + 7);
        //            strMaxDop = "8";
        //            break;
        //        case 16:
        //            strMaxCpu = "50";
        //            strMaxMem = "60";
        //            strAffinity = affinityCpuStart + " TO " + (affinityCpuStart + 7);
        //            strMaxDop = "8";
        //            break;
        //        case 256:
        //            strMaxCpu = "6";
        //            strMaxMem = "6";
        //            strAffinity = affinityCpuStart + " TO " + (affinityCpuStart + 1);
        //            strMaxDop = "1";
        //            break;
        //    }

        //    //
        //    string sSqlTplt;
        //    if (sSqlVer == "2008R2")
        //    {
        //        sSqlTplt =
        //            "CREATE RESOURCE POOL [{0}] WITH (min_cpu_percent={1}, max_cpu_percent={1}, min_memory_percent={2}, max_memory_percent={2});CREATE WORKLOAD GROUP [{0}] WITH (importance=medium, max_dop={3}) USING [{0}];ALTER WORKLOAD GROUP {0} USING {0};ALTER RESOURCE GOVERNOR RECONFIGURE";
        //        Clsdb.RunSql(strSqlServer, "Master", string.Format(sSqlTplt, strRgName, strMaxCpu, strMaxMem, strMaxDop));
        //    }
        //    else
        //    {
        //        sSqlTplt =
        //            "ALTER RESOURCE POOL [default] WITH(min_cpu_percent=0,max_cpu_percent=100,min_memory_percent=0,max_memory_percent=100,cap_cpu_percent=100,AFFINITY SCHEDULER=(0 TO 3));CREATE RESOURCE POOL [{0}] WITH (min_cpu_percent=0, max_cpu_percent=100, cap_cpu_percent=100, min_memory_percent={1}, max_memory_percent={1},AFFINITY SCHEDULER=({2}));CREATE WORKLOAD GROUP [{0}] WITH (importance=medium, max_dop=0) USING [{0}];ALTER WORKLOAD GROUP {0} USING {0};ALTER RESOURCE GOVERNOR RECONFIGURE";
        //        Clsdb.RunSql(strSqlServer, "Master", string.Format(sSqlTplt, strRgName, strMaxMem, strAffinity));
        //    }
            

        //    //                sSQLTplt = sSQLTplt.Replace("cap_cpu_percent=100,", ""); // 2008 doesnt support cap CPU
        //}

        public static bool AllocateResourceGov(string strSqlServer, string strRgName, int intFirstCore, int intLastCore, string strSqlVer, int intMaxMem)
        {
            string sSqlTplt;
            if (strSqlVer == "2008R2")
            {
                sSqlTplt = string.Format("CREATE RESOURCE POOL [{0}] WITH (min_cpu_percent={1}, " +
                                         "max_cpu_percent={1}, " +
                                         "min_memory_percent={2}, " +
                                         "max_memory_percent={2});" +
                                         "CREATE WORKLOAD GROUP [{0}] WITH (importance=medium, " +
                                         "max_dop={3}) USING [{0}];" +
                                         "ALTER WORKLOAD GROUP {0} USING {0};" +
                                         "ALTER RESOURCE GOVERNOR RECONFIGURE", 
                                         strRgName, 
                                         intLastCore - intFirstCore, 
                                         intMaxMem, 
                                         intLastCore - intFirstCore);
            }
            else
            {
                sSqlTplt = string.Format("ALTER RESOURCE POOL [default] WITH(min_cpu_percent=0," +
                                  "max_cpu_percent=100," +
                                  "min_memory_percent=0," +
                                  "max_memory_percent=100," +
                                  "cap_cpu_percent=100," +
                                  "AFFINITY SCHEDULER=(0 TO 1))" +
                                  ";CREATE RESOURCE POOL [{0}] WITH (min_cpu_percent=0, " +
                                  "max_cpu_percent=100, " +
                                  "cap_cpu_percent=100, " +
                                  "min_memory_percent={1}, " +
                                  "max_memory_percent={1}," +
                                  "AFFINITY SCHEDULER=({2} TO {3}));" +
                                  "CREATE WORKLOAD GROUP [{0}] WITH (importance=medium, " +
                                  "max_dop={4}) USING [{0}];" +
                                  "ALTER WORKLOAD GROUP {0} USING {0};" +
                                  "ALTER RESOURCE GOVERNOR RECONFIGURE", 
                                  strRgName, 
                                  intMaxMem, 
                                  intFirstCore,
                                  intLastCore,
                                  intLastCore - intFirstCore);
            }
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, "Master")))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText = sSqlTplt;
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, string.Format("Attempting to up RG:{0}",strRgName), true);
                    cmd.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, string.Format("Failed to Create RG:{0}",strRgName));
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
                return SqlInfoMessage == null;
            }
        }

        public static int CalcMemPercent(string strSqlServer, int intMaxMem)
        {
            int resout;
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, "Master")))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    "SELECT [total_physical_memory_kb] / 1000000 AS [MemoryinGb] FROM [master].[sys].[dm_os_sys_memory]";
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, string.Format("Attempting obtain amount of Memory on SQL Server:{0}",strSqlServer), true);
                    var res = cmd.ExecuteScalar().ToString();
                    resout = int.Parse(((double)intMaxMem/int.Parse(res) * 100).ToString("00"));
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, string.Format("Failed to obtain amount Memory on SQL Server:{0}", strSqlServer));
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
         
            }
            
            return resout;
            //return SqlInfoMessage == null;
        }

        static void conn_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            SqlInfoMessage = e.Message;
        }
    }
}