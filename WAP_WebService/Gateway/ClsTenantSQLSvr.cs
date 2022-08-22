using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gateway
{
    class ClsTenantSQLSvr
    {
        public static string SqlInfoMessage;

        static void conn_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            SqlInfoMessage = e.Message;
        }

        public static bool CheckTable(string strSqlServer, string strSqldb, string strSqlTable)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSQLServer,  strSQLDB,  strSqlTable", strSqlServer, strSqldb, strSqlTable);
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqldb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    string.Format(
                        "IF OBJECT_ID(N\'dbo.{0}\', N\'U\') IS NOT NULL PRINT \'Table Exists\'; else print \'Table does not exist\'",
                        strSqlTable);
                cmd.CommandTimeout = 0;
                var res = "";
                try
                {
                    ClsLogfile.Writelog(1, string.Format("Attempting to find Table:{0}", strSqlTable), true);
                    cmd.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to run SQL query for Table Search");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
                return SqlInfoMessage == "Table Exists";
            }
        }

        public static bool CreateRgTable(string strSqlServer)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSqlServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, "Master")))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    "CREATE TABLE [dbo].[ResGovConfig]([ResGov] [varchar](max) NOT NULL, [CPUCORE] [INT] NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]";
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to create Table:ResGovConfig", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to create table:ResGovConfig");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return SqlInfoMessage == "Command(s) completed successfully.";
        }

        public static bool CreateRgCpuTable(string strSqlServer)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSqlServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, "Master")))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    "CREATE TABLE [dbo].[ResGovCPUAllocation]([ResGov] [varchar](max), [CPU_NUM] [varchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]";
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to create Table:ResGovCPUAllocation", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to create table:ResGovCPUAllocation");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return SqlInfoMessage == "Command(s) completed successfully.";
        }

        public static bool CheckResGovClassifierAllocation(string strSqlServer)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSQLServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            strSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    "if (SELECT object_name(classifier_function_id) AS [function_name] FROM sys.dm_resource_governor_configuration) = 'fnSQLaaSUserClassifier' PRINT \'Res Gov Classifer configured correctly\'; else print \'Res Gov Classifer not configured correctly\'";
                cmd.CommandTimeout = 0;
                var res = "";
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to check if Res Gov Classifer is set correctly", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain Res Gov Classifer if set correctly");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
                return SqlInfoMessage == "Res Gov Classifer configured correctly";
            }
        }

        public static bool CheckResGovClassifierConfiguration(string strSqlServer)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSQLServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            strSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    string.Format(
                        "if (SELECT OBJECT_DEFINITION (OBJECT_ID('dbo.fnSQLaaSUserClassifier'))) = '{0}CREATE FUNCTION fnSQLaaSUserClassifier() RETURNS SYSNAME WITH SCHEMABINDING As BEGIN declare @gov varchar(max) set @gov = (SELECT ResGov FROM [dbo].[ResGovConfig] WHERE DBName = ORIGINAL_DB_NAME()) IF @gov IS NOT NULL BEGIN RETURN @gov END RETURN ''default'' END;' print 'correct' else print 'incorrect'",
                        Environment.NewLine);
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to check if Res Gov Classifer is set correctly", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain Res Gov Classifer if set correctly");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
                return SqlInfoMessage == "correct";
            }
        }

        public static bool CheckResGovClassifierFnExists(string strSqlServer)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSQLServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            strSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    "IF OBJECT_ID(N'fnSQLaaSUserClassifier') IS NOT NULL PRINT 'Function Exists'; else print 'Function does not exist'";
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to check if Res Gov Classifer function exists", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain Res Gov Classifer function exists");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
                return SqlInfoMessage == "Function Exists";
            }
        }

        public static bool CreateResGovClassifier(string strSqlServer)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSQLServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            strSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    "CREATE FUNCTION fnSQLaaSUserClassifier() RETURNS SYSNAME WITH SCHEMABINDING As BEGIN declare @gov varchar(max) set @gov = (SELECT ResGov FROM [dbo].[ResGovConfig] WHERE DBName = ORIGINAL_DB_NAME()) IF @gov IS NOT NULL BEGIN RETURN @gov END RETURN \'default\' END;";
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to create Res Gov Classifer function", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to create Res Gov Classifer function");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
                return SqlInfoMessage == "Command(s) completed successfully.";
            }
        }

        public static bool DeleteResGovClassifierFn(string strSqlServer)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSQLServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            strSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    "IF OBJECT_ID(N\'fnSQLaaSUserClassifier\') IS NOT NULL ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION=null);ALTER RESOURCE GOVERNOR RECONFIGURE; DROP FUNCTION fnSQLaaSUserClassifier";
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to delete Res Gov Classifer function", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to delete Res Gov Classifer function");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
                return SqlInfoMessage == "Command(s) completed successfully.";
            }
        }

        public static bool AllocateResGovClassifier(string strSqlServer)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSQLServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            strSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    "ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION=dbo.fnSQLaaSUserClassifier);ALTER RESOURCE GOVERNOR RECONFIGURE";
                cmd.CommandTimeout = 0;
                var res = "";
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to Allocate Res Gov Classifer function", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to Allocate Res Gov Classifer function");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
                return SqlInfoMessage == "Command(s) completed successfully.";
            }
        }

        public static void GetAvilableResGovCoreFromTenentSvr(string strSqlServer, int intreqcores, out int strStartCore, out int strEndCore)
        {
            ClsLogfile.Writelogparam("strSQLServer", strSqlServer);
            var listcpu = new List<int>();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, "Master")))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = "select ResGov, CPU_NUM from ResGovCPUAllocation where resgov is null";
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to run SQL query", true);
                    var res = cmd.ExecuteReader();
                    while (res.Read())
                    {
                        var cpu = new int();
                        cpu = int.Parse(res["CPU_NUM"].ToString());
                        listcpu.Add(cpu);
                    }
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to run SQL query");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
            }
            var startcore = listcpu[0];
            var endcore = 0;
            foreach (var rgcpu in listcpu)
            {
                if (startcore + intreqcores - 1 == rgcpu)
                {
                    endcore = rgcpu;
                    break;
                }
                else if (startcore + intreqcores - 1 < rgcpu)
                {
                    startcore = rgcpu;
                }
            }
            strStartCore = startcore;
            strEndCore = endcore;
        }

        public static bool AllocateRGCores(string strSqlServer, string strRgName, int intStartCore, int intEndCore)
        {
            int corenum = intStartCore;
            var corestr = "";
            while (corenum <= intEndCore)
            {
                corestr = string.Format("{0}'{1}',", corestr, corenum);
                corenum++;
            }
            corestr = corestr.TrimEnd(',');
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSqlServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, "Master")))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    string.Format("update ResGovCPUAllocation set [ResGov] = '{0}' where CPU_NUM in ({1})",strRgName, corestr);
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to Assigned cores to RG", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to asign cores to RG");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return SqlInfoMessage == null;
        }

        public static bool UpdateRgTable(string strSqlServer, string strRgName, string strDbName)
        {
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSqlServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, "Master")))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    string.Format("insert into ResGovConfig ([ResGov],[DBName) Values ({0},{1})", strRgName, strDbName);
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to Assigned DB to RG", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to asign DB to RG");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return SqlInfoMessage == null;
        }

        public static bool UnallocateRGCores(string strSqlServer, string strRgName)
        {
           
            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSqlServer", strSqlServer);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, "Master")))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                sc.FireInfoMessageEventOnUserErrors = true;
                cmd.CommandText =
                    string.Format("update ResGovCPUAllocation set [ResGov] = null where ResGov ='{0}'", strRgName);
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to remove cores from RG", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to remove Cores from RG");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return SqlInfoMessage == null;
        }

        public static bool SetupSQLTenantSvr(string strSqlServer)
        {
            // check if RG CPU Allocation Table exists in the Master DB
            //  if not exists create
            //check if RG Table exists in Master DB
            // if not exists create
            //Check if Classifer function exists
            // if not exist create
            //check if classifer fuction allocated
            //if not assign.
            if (!CheckTable(strSqlServer, "Master", "ResGovCPUAllocation"))
            {
                    ClsLogfile.Writelog(string.Format("RG CPU Allocation table didn't exist on SQL Server:{0}, creating now", strSqlServer), true);
                if (!CreateRgCpuTable(strSqlServer))
                {
                    ClsLogfile.Writelog(
                        string.Format("Failed to create RG CPU Allocation table on SQL Server:{0}", strSqlServer), true);
                    throw new Exception(string.Format("Failed to create RG CPU Allocation table on SQL Server:{0}", strSqlServer));
                
            }
            }
            if (!CheckTable(strSqlServer, "Master", "ResGovConfig"))
            {
                    ClsLogfile.Writelog(
                        string.Format("RG table didn't exist in the master DB on server:{0}, creating now", strSqlServer),
                        true);
                if (!CreateRgTable(strSqlServer))
                {
                    ClsLogfile.Writelog(string.Format("Failed to create the RG table on SQL server:{0}", strSqlServer),
                        true);
                    throw new Exception(string.Format("Failed to create the RG table on SQL server:{0}", strSqlServer));
                }
            }

            if (!CheckResGovClassifierFnExists(strSqlServer))
            {
                    ClsLogfile.Writelog(string.Format("RG Classifier function does not exist on server:{0}",
                        strSqlServer),true);
                    if(!CreateResGovClassifier(strSqlServer))
                    {
                    ClsLogfile.Writelog(string.Format("Failed to Create the RG Classifier Function on server:{0}",
                        strSqlServer),true);
                    throw new Exception(string.Format("Failed to Create the RG Classifier Function on server:{0}",strSqlServer));
                    }
            }
            else
            {
                ClsLogfile.Writelog(string.Format("Checking RG Classifer is correct on Server:{0}", strSqlServer));
                if (!CheckResGovClassifierConfiguration(strSqlServer))
                {
                    ClsLogfile.Writelog(string.Format("RG Classifer is incorrectly setup on Server:{0}, fixing now",
                        strSqlServer), true);
                        if(DeleteResGovClassifierFn(strSqlServer))
                        if (!CreateResGovClassifier(strSqlServer))
                        {
                            ClsLogfile.Writelog(
                                string.Format("Failed to Correct the RG Classifer on server:{0}", strSqlServer), true);
                            throw new Exception(string.Format("Failed to Correct the RG Classifer on server:{0}",
                                strSqlServer));
                        }
                        else
                        {
                            ClsLogfile.Writelog(
                                string.Format("Failed to Correct the RG Classifer on server:{0}, delete routine", strSqlServer), true);
                            throw new Exception(string.Format("Failed to Correct the RG Classifer on server:{0}, delete routine",
                                strSqlServer));
                        }
                }
            }

            if (!CheckResGovClassifierAllocation(strSqlServer))
            {
                try
                {
                    ClsLogfile.Writelog(
                        string.Format("RG classifier wasn't allocated on server:{0}, allocating now", strSqlServer),
                        true);
                    AllocateResGovClassifier(strSqlServer);
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(
                        string.Format("failed to allocate the RG Classifer on server:{0}", strSqlServer),
                        true);
                    throw;
                }
            }

            return true;
        }
    }
}
