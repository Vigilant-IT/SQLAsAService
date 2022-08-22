using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Management.Automation.Runspaces;

namespace Gateway
{
    internal class ClsDbMoves
    {
        /// <summary>
        /// </summary>
        /// <param name="strComputer"></param>
        /// <param name="strCurpath"></param>
        /// <param name="strNewPath"></param>
        public static void MoveFile(string strComputer, string strCurpath, string strNewPath)
        {
            ClsLogfile.Writelogparam("strComputer, strCurpath, strNewPath", strComputer, strCurpath, strNewPath);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strComputer, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strComputer };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            pipe.Commands.AddScript(string.Format("move {0} {1}", strCurpath, strNewPath));
            try
            {
                ClsLogfile.Writelog(1, "Moving file", true);
                pipe.Invoke();
                pipe.Dispose();
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, "Failed to move file");
                ClsLogfile.Writelog(3, ex.Message, true);
                throw;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="strDbName"></param>
        /// <param name="strCurDbPath"></param>
        /// <param name="strCurLogPath"></param>
        /// <param name="strNewDbPath"></param>
        /// <param name="strSqlServer"></param>
        /// <param name="strSqlCollation"></param>
        /// <param name="strNewDbLogPath"></param>
        /// <param name="bolHaSecondSvr"></param>
        public static void MoveDb(string strDbName, string strCurDbPath, string strCurLogPath, string strNewDbPath,
            string strSqlServer, string strSqlCollation, string strNewDbLogPath, bool bolHaSecondSvr)
        {
            ClsLogfile.Writelogparam(
                "strDbName,  strCurDbPath,  strCurLogPath,  strNewDbPath,  strSqlServer,  strSqlCollation,  strNewDbLogPath, bolHaSecondSvr",
                strDbName, strCurDbPath, strCurLogPath, strNewDbPath, strSqlServer, strSqlCollation, strNewDbLogPath,
                bolHaSecondSvr.ToString());
            if (bolHaSecondSvr)
                Clsdb.RunSql(strSqlServer, "Master",
                    string.Format("CREATE DATABASE {0} COLLATE {1}", strDbName, strSqlCollation));
            Clsdb.RunSql(strSqlServer, "Master",
                string.Format(
                    "ALTER DATABASE {0} COLLATE {1};ALTER DATABASE {0} SET SINGLE_USER WITH ROLLBACK IMMEDIATE;EXEC master.dbo.sp_detach_db @dbname = N'{0}'",
                    strDbName, strSqlCollation));
            MoveFile(strSqlServer, strCurDbPath,
                string.Format("{0}\\{1}\\{1}.mdf", strNewDbPath, strDbName));
            MoveFile(strSqlServer, strCurLogPath,
                string.Format("{0}\\{1}\\{1}_log.ldf", strNewDbLogPath, strDbName));
            Clsdb.RunSql(strSqlServer, "Master",
                string.Format(
                    "CREATE DATABASE {0} ON (FILENAME = N'{1}\\{0}\\{0}.mdf' ),(FILENAME = N'{2}\\{0}\\{0}_log.ldf' ) FOR ATTACH",
                    strDbName, strNewDbPath, strNewDbLogPath));
        }

        /// <summary>
        ///     Obtains the file details for a Single Database from a SQL server
        /// </summary>
        /// <param name="sSqlServer"></param>
        /// <param name="sDbName"></param>
        /// <returns></returns>
        public static List<Dbfilesets> Getdbfile(string sSqlServer, string sDbName)
        {
            ClsLogfile.Writelogparam("sSqlServer,  sGwdb", sSqlServer, sDbName);
            var dbfilesettings = new List<Dbfilesets>();

            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            sSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText =
                    string.Format(
                        "select name, physical_name, cast((size*8) /1024 as varchar(15)) as size from sys.master_files where name like '{0}%'",
                        sDbName);
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining DBSettings", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var dbfileset = new Dbfilesets
                            {
                                Name = dr["name"].ToString(),
                                Path = dr["physical_name"].ToString(),
                                Size = dr["size"].ToString()
                            };
                            dbfilesettings.Add(dbfileset);
                        }
                    }
                    sc.Close();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain DBSettings");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    return null;
                }
                sc.Close();
                return dbfilesettings;
            }
        }

        /// <summary>
        ///     Provides a list of Files and DB's as registered in SQL
        /// </summary>
        /// <param name="sSqlServer"></param>
        /// <returns></returns>
        public static List<Dbfilesets> GetAllDBs(string sSqlServer)
        {
            ClsLogfile.Writelogparam("sSqlServer", sSqlServer);
            var dbfilesettings = new List<Dbfilesets>();

            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            sSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText =
                    "select sdb.name as dbname, mf.name as name, physical_name, size from sys.master_files as mf join dbo.sysdatabases as sdb on mf.database_id = sdb.dbid where sdb.name not in ('Master','tempdb','model','msdb')";
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining List of Databases", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var dbfileset = new Dbfilesets
                            {
                                Name = dr["name"].ToString(),
                                Path = dr["physical_name"].ToString(),
                                Size = dr["size"].ToString(),
                                DBName = dr["dbname"].ToString(),
                                ServerId = sSqlServer
                            };
                            dbfilesettings.Add(dbfileset);
                        }
                    }
                    sc.Close();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain List of Databases");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    return null;
                }
                sc.Close();
                return dbfilesettings;
            }
        }
        public static void InjectIntoGlide(string sSqlServer, string sDbName)
        {
            ClsLogfile.Writelogparam("sSqlServer, sDbName", sSqlServer, sDbName);
            using (var sc = new SqlConnection(string.Format("Data Source = {0}; Initial Catalog=Glide;Integrated Security=true;",sSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("INSERT INTO [Backup] (BackupDb) VALUES ('{0}')", sDbName);
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1,"Injecting Database into the Glide Database", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3,"Failed to inject Database into the Glide Database");
                }
            }
        }

    }
    /// <summary>
    /// </summary>
    public class Dbfilesets
    {
        /// <summary>
        /// </summary>
        private string _dbname;

        /// <summary>
        /// </summary>
        private string _name;

        /// <summary>
        /// </summary>
        private string _path;

        /// <summary>
        /// </summary>
        private string _serverid;

        /// <summary>
        /// </summary>
        private string _size;

        /// <summary>
        /// </summary>
        public string Name
        {
            get { return _name; }
            set { _name = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Path
        {
            get { return _path; }
            set { _path = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Size
        {
            get { return _size; }
            set { _size = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string DBName
        {
            get { return _dbname; }
            set { _dbname = Setval(value); }
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
    }
}