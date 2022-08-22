// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Data.SqlClient;
using System.IO;
using System.Runtime.InteropServices;
using System.Runtime.InteropServices.ComTypes;

namespace Gateway
{
    /// <summary>
    /// </summary>
    internal class Clsdb
    {
        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strSqldb"></param>
        /// <param name="strSqlqry"></param>
        /// <returns></returns>
        public static bool RunSql(string strSqlServer, string strSqldb, string strSqlqry)
        {
            ClsLogfile.Writelogparam("strSQLServer,  strSQLDB,  strSQLQRY", strSqlServer, strSqldb, strSqlqry);
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqldb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = strSqlqry;
                cmd.CommandTimeout = 0;
                bool res;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to run SQL query", true);
                    res = cmd.ExecuteNonQuery() == 0;
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to run SQL query");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
                return res;
            }
        }

        public static bool DelDb(string strSqlServer, string strSqlDB, string strSqlDb2Del)
        {
            ClsLogfile.Writelogparam("strSqlServer, strSqlDB, strSqlDb2Del", strSqlServer, strSqlDB, strSqlDb2Del);
            string res;
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            strSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText =
                    string.Format("select state from sys.databases where name = '{0}'", strSqlDB);

                try
                {
                    ClsLogfile.Writelog(1, "Checking if in Restoring mode", true);
                    var dr = cmd.ExecuteScalar();
                    res = dr.ToString();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to check if in Restore mode");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    res = "";
                }
                sc.Close();
            }

            try
            {
                if (res == "1")
                {
                    RunSql(strSqlServer, "master",
                        string.Format("RESTORE DATABASE [{0}] WITH RECOVERY", strSqlDB));
                }
                return RunSql(strSqlServer, strSqlDB,
                    string.Format("Alter database [{0}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [{0}]",
                        strSqlDb2Del));
            }
            catch
            {
                return false;
            }
        }


        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strSqldb"></param>
        /// <param name="strSecGrp"></param>
        /// <returns></returns>
        public static bool CheckSqlForAccount(string strSqlServer, string strSqldb, string strSecGrp)
        {
            ClsLogfile.Writelogparam("strSQLServer,  strSQLDB,  strSecGrp", strSqlServer, strSqldb, strSecGrp);
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqldb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("xp_logininfo \'{0}\'", strSecGrp);
                bool res;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to Check User account", true);
                    var dr = cmd.ExecuteReader();
                    res = dr.HasRows;
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to check user account");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    res = false;
                }
                sc.Close();
                return res;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strSqldb"></param>
        /// <param name="strSqlCommand"></param>
        /// <returns></returns>
        public static bool CheckSql(string strSqlServer, string strSqldb, string strSqlCommand)
        {
            ClsLogfile.Writelogparam("strSQLServer,  strSQLDB,  strSqlCommand", strSqlServer, strSqldb, strSqlCommand);
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqldb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = strSqlCommand;
                bool res;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to get a bool result from SQL", true);
                    var dr = cmd.ExecuteReader();
                    res = dr.HasRows;
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to get a bool result from SQL");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    res = false;
                }
                sc.Close();
                return res;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="strDbName"></param>
        /// <param name="intDbDataSize"></param>
        /// <param name="intDbLogSize"></param>
        /// <param name="strSqlServer"></param>
        public static void ChangeDbSize(string strDbName, int intDbDataSize, int intDbLogSize, string strSqlServer)
        {
            ClsLogfile.Writelogparam("strDbName,  intDbDataSize,  intDbLogSize,  strSqlServer", strDbName,
                intDbDataSize.ToString(), intDbLogSize.ToString(), strSqlServer);
            var intDblSize = intDbLogSize/5;
            var intDblfg = intDblSize/50;
            var intDbdfg = 128;
            if (intDblfg < 64)
            {
                intDblfg = 64;
            }
            RunSql(strSqlServer, "Master",
                string.Format(
                    "ALTER DATABASE [{0}] MODIFY FILE ( NAME = N'{0}', SIZE = {1}MB, MAXSIZE = 524288MB, FILEGROWTH = {3}MB );ALTER DATABASE [{0}] MODIFY FILE ( NAME = N'{0}_log', SIZE = {2}MB, MAXSIZE = 102400MB, FILEGROWTH = {4}MB )",
                    strDbName, intDbDataSize, intDblSize, intDbdfg, intDblfg));
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDBname"></param>
        /// <param name="strBudi"></param>
        /// <param name="strSku"></param>
        public static void UpdateHpldbc(string strSqlServer, string strDBname, string strBudi, string strSku)
        {
            ClsLogfile.Writelogparam("strSqlServer, strDBname, strBudi, strSku", strSqlServer, strDBname, strBudi,
                strSku);
            RunSql(strSqlServer, "Master",
                string.Format("insert into HPLDBC (DBName, BUDI, SKU) VALUES ('{0}', '{1}', '{2}')", strDBname, strBudi,
                    strSku));
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDBname"></param>
        /// <param name="strDbGroup"></param>
        /// <param name="bolAltTrace"></param>
        /// <param name="bolStdDb"></param>
        /// <param name="bolPrdDb"></param>
        /// <param name="bolAdminUser"></param>
        /// <param name="bolPwrUser"></param>
        /// <param name="bolStdUser"></param>
        /// <param name="strSqlVer"></param>
        public static void SetDbOwner(string strSqlServer,
            string strDBname,
            string strDbGroup,
            bool bolAltTrace,
            bool bolStdDb,
            bool bolPrdDb,
            bool bolAdminUser,
            bool bolPwrUser,
            bool bolStdUser,
            string strSqlVer)
        {
            var strPerms = bolAdminUser && bolPrdDb
                    ? "CREATE AGGREGATE, CREATE ASYMMETRIC KEY, CREATE CERTIFICATE, CREATE CONTRACT, CREATE DEFAULT, CREATE FUNCTION, " +
                      "CREATE PROCEDURE, CREATE ROLE, CREATE RULE, CREATE SCHEMA, CREATE SYMMETRIC KEY, CREATE SYNONYM, CREATE TABLE, " +
                      "CREATE TYPE, CREATE VIEW, SHOWPLAN, ALTER ANY SCHEMA, ALTER ANY APPLICATION ROLE, ALTER ANY DATABASE EVENT NOTIFICATION, " +
                      "ALTER ANY REMOTE SERVICE BINDING, ALTER ANY SYMMETRIC KEY, CONNECT, CREATE DATABASE DDL EVENT NOTIFICATION, " +
                      "CREATE XML SCHEMA COLLECTION, REFERENCES, SELECT, SUBSCRIBE QUERY NOTIFICATIONS, VIEW DEFINITION, VIEW DATABASE STATE, " +
                      "DELETE, UPDATE, TAKE OWNERSHIP"
                    : "EXECUTE, INSERT, CREATE AGGREGATE, CREATE ASYMMETRIC KEY, CREATE CERTIFICATE, CREATE CONTRACT, CREATE DEFAULT, " +
                      "CREATE FUNCTION, CREATE PROCEDURE, CREATE ROLE, CREATE RULE, CREATE SCHEMA, CREATE SYMMETRIC KEY, CREATE SYNONYM, " +
                      "CREATE TABLE, CREATE TYPE, CREATE VIEW, SHOWPLAN, ALTER ANY SCHEMA, ALTER ANY APPLICATION ROLE, ALTER ANY DATABASE EVENT NOTIFICATION, " +
                      "ALTER ANY REMOTE SERVICE BINDING, ALTER ANY SYMMETRIC KEY, CONNECT, CREATE DATABASE DDL EVENT NOTIFICATION, " +
                      "CREATE XML SCHEMA COLLECTION, REFERENCES, SELECT, SUBSCRIBE QUERY NOTIFICATIONS, VIEW DEFINITION, " +
                      "VIEW DATABASE STATE, DELETE, UPDATE, TAKE OWNERSHIP";
            try
            {
            if (!CheckSqlForAccount(strSqlServer, "Master", strDbGroup))
                RunSql(strSqlServer, "Master",
                    string.Format("CREATE LOGIN [{0}] FROM WINDOWS WITH DEFAULT_DATABASE=[master]", strDbGroup));
            if (strDbGroup != "")
                if (bolAdminUser)

                        RunSql(strSqlServer, strDBname,
                            string.Format(
                                "CREATE USER [{0}] FOR LOGIN [{0}];EXEC dbo.sp_changedbowner @loginame = N'sa'; GRANT {1} TO [{0}]",
                                strDbGroup, strPerms));
            RunSql(strSqlServer, strDBname,
                        string.Format(
                            "GRANT CONTROL ON SCHEMA::[dbo] TO [{0}]",
                            strDbGroup));
                  
            if (strDbGroup != "")
                if (bolAdminUser)
                {
                    var strsqladmin = strSqlVer == "2008R2"
                        ? string.Format(
                            "exec sp_addrolemember [DB_DATAREADER], [{0}];exec sp_addrolemember [DB_DATAWRITER], [{0}];exec sp_addrolemember [db_ddladmin], [{0}]",
                            strDbGroup)
                        : string.Format(
                            "ALTER ROLE [DB_DATAREADER] ADD MEMBER [{0}];ALTER ROLE [DB_DATAWRITER] ADD MEMBER [{0}]; ALTER ROLE [db_ddladmin] ADD MEMBER [{0}]",
                            strDbGroup);
                    RunSql(strSqlServer, strDBname, strsqladmin);

                    if ((!bolPrdDb) && bolStdDb)
                        try
                        {
                            RunSql(strSqlServer, "msdb", string.Format("CREATE USER [{0}] FOR LOGIN [{0}]", strDbGroup));
                        }
                        catch { /* Skipping account has already been added */ }
                         

                    var strsqlMsdbAdmin = strSqlVer == "2008R2"
                        ? string.Format(
                            "exec sp_addrolemember [SQLAgentUserRole], [{0}]",
                            strDbGroup)
                        : string.Format(
                            "ALTER ROLE [SQLAgentUserRole] ADD MEMBER [{0}]",
                            strDbGroup);
                    if ((!bolPrdDb) && bolStdDb)RunSql(strSqlServer, "msdb", strsqlMsdbAdmin);
                    if (bolAltTrace) RunSql(strSqlServer, "master", string.Format("GRANT ALTER TRACE TO [{0}]", strDbGroup));
                    RunSql(strSqlServer, "HPLDBC", string.Format("CREATE USER [{0}] FOR LOGIN [{0}]", strDbGroup));
                }
            if (strDbGroup != "")
                if (bolPwrUser)
                {
                    var strsqlpwr = strSqlVer == "2008R2"
                        ? string.Format(
                            "exec sp_addrolemember [DB_DATAREADER], [{0}];exec sp_addrolemember [DB_DATAWRITER], [{0}]; USE [{1}]; GRANT CONNECT TO [{0}]",
                            strDbGroup, strDBname)
                        : string.Format(
                            "ALTER ROLE [DB_DATAREADER] ADD MEMBER [{0}];ALTER ROLE [DB_DATAWRITER] ADD MEMBER [{0}]; USE [{1}]; GRANT CONNECT TO [{0}]",
                            strDbGroup, strDBname);
                    RunSql(strSqlServer, strDBname, strsqlpwr);
                }

            if (strDbGroup != "")
                if (bolStdUser)
                {
                    var strsqlstd = strSqlVer == "2008R2"
                        ? string.Format("exec sp_addrolemember [DB_DATAREADER], [{0}]; USE [{1}]; GRANT CONNECT TO [{0}]", strDbGroup,strDBname)
                        : string.Format("ALTER ROLE [DB_DATAREADER] ADD MEMBER [{0}]; USE [{1}]; GRANT CONNECT TO [{0}]", strDbGroup, strDBname);
                    RunSql(strSqlServer, strDBname, strsqlstd);
                }
            if (strSqlVer != "2008R2")
                RunSql(strSqlServer, strDBname, string.Format("ALTER USER [{0}] WITH DEFAULT_SCHEMA=[dbo]", strDbGroup));
                    }
            catch (Exception)
            {
                // ignored
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="strPath"></param>
        /// <param name="strSavePath"></param>
        /// <param name="strArg"></param>
        /// <param name="strDbName"></param>
        public static void CreateSqlShortcut(string strPath, string strSavePath, string strArg, string strDbName)
        {
            ClsLogfile.Writelogparam("strPath, strSavePath, strArg, strDbName", strPath, strSavePath, strArg, strDbName);
            // ReSharper disable once SuspiciousTypeConversion.Global
            var link = (IShellLink) new ShellLink();
            link.SetPath(strPath);
            link.SetArguments(strArg);
            // ReSharper disable once SuspiciousTypeConversion.Global
            var file = (IPersistFile) link;
            try
            {
                ClsLogfile.Writelog(1, "Creating SQL Shortcut", true);
                file.Save(Path.Combine(strSavePath, strDbName + ".lnk"), false);
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, "Failed to create SQL Shortcut");
                ClsLogfile.Writelog(3, ex.Message, true);
                throw;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDb"></param>
        /// <param name="strSqlgrp"></param>
        /// <param name="strAccessGrp"></param>
        public static void SetDBoGroups(string strSqlServer, string strDb, string strSqlgrp, string strAccessGrp)
        {
            ClsLogfile.Writelogparam("strSqlServer, strDb, strSqlgrp, strAccessGrp", strSqlServer, strDb, strSqlgrp,
                strAccessGrp);
            RunSql(strSqlServer, strDb, string.Format("ALTER [{0}] ADD MEMBER [{1}]", strSqlgrp, strAccessGrp));
        }

        /// <summary>
        /// </summary>
        /// <param name="bolProd"></param>
        /// <param name="strSqlServer"></param>
        /// <param name="strDbName"></param>
        public static void InjectintoRptDb(bool bolProd, string strSqlServer, string strDbName)
        {
            ClsLogfile.Writelogparam("bolProd, strSqlServer, strDbName", bolProd.ToString(), strSqlServer, strDbName);
            var strenv = bolProd ? "PROD" : "DEV";
            RunSql("IAUNSW617", "GLIDE",
                string.Format("INSERT INTO Repschedule(Server,DB,REM) Values('{0}','{1}','{2}')", strSqlServer,
                    strDbName,
                    strenv));
        }
        /// <summary>
        /// </summary>
        /// <param name="bolProd"></param>
        /// <param name="strSqlServer"></param>
        /// <param name="strDbName"></param>
        public static void DeleteFromRptDb(bool bolProd, string strSqlServer, string strDbName)
        {
            ClsLogfile.Writelogparam("bolProd, strSqlServer, strDbName", bolProd.ToString(), strSqlServer, strDbName);
            RunSql("IAUNSW617", "GLIDE", string.Format("Delete from Repschedule where DB = '{0}'",strDbName));
        }
        /// <summary>
        ///     Obtains the user account which the SQL Service is running as
        /// </summary>
        /// <param name="strServerName"></param>
        /// <returns></returns>
        public static string GetSqlServiceAcc(string strServerName)
        {
            ClsLogfile.Writelogparam("strServerName", strServerName);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            strServerName)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText =
                    "select service_account from sys.dm_server_services where servicename = 'SQL Server (MSSQLSERVER)'";
                string res;
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining SQL Service account", true);
                    var dr = cmd.ExecuteScalar();
                    res = dr.ToString();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain SQL Service account");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    res = "";
                }
                sc.Close();
                return res;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="strServerName"></param>
        /// <param name="strDbName"></param>
        /// <returns></returns>
        public static bool EnableTDE(string strServerName, string strDbName)
        {
            ClsLogfile.Writelogparam("strServerName, strDbName", strServerName,strDbName);
            var res = false;
            RunSql(strServerName, strDbName, string.Format("CREATE DATABASE ENCRYPTION KEY WITH ALGORITHM= AES_128 ENCRYPTION BY SERVER CERTIFICATE {0}_CERT", strServerName.Split('.')[0]));
            res = RunSql(strServerName, strDbName, string.Format("ALTER DATABASE {0} SET ENCRYPTION ON", strDbName));
            return res;
        }

        /// <summary>
        /// </summary>
        [ComImport]
        [Guid("00021401-0000-0000-C000-000000000046")]
        internal class ShellLink
        {
        }

        /// <summary>
        /// </summary>
        [ComImport]
        [Guid("000214F9-0000-0000-C000-000000000046")]
        internal interface IShellLink
        {
            /// <summary>
            /// </summary>
            /// <param name="pszArgs"></param>
            void SetArguments([MarshalAs(UnmanagedType.LPWStr)] string pszArgs);

            /// <summary>
            /// </summary>
            /// <param name="pszFile"></param>
            void SetPath([MarshalAs(UnmanagedType.LPWStr)] string pszFile);
        }
    }
}