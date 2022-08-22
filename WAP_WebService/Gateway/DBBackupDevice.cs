using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class DBBackupDevice
    {
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
        /// <param name="strSqlServer"></param>
        /// <param name="strDbName"></param>
        /// <param name="strBackupPath"></param>
        public static void CreateBackupDevice(string strSqlServer, string strDbName, string strBackupPath)
        {
            ClsLogfile.Writelogparam("strSqlServer, strDbName, strBackupPath", strSqlServer, strDbName, strBackupPath);
            try
            {
                Clsdb.RunSql(strSqlServer, "Master",
                string.Format(
                    "EXEC master.dbo.sp_addumpdevice  @devtype = N'disk', @logicalname = N'{0}', @physicalname = N'{1}\\{0}_adhoc.bak'",
                    strDbName, strBackupPath));
            }
            catch
            {
                ClsLogfile.Writelog(3, "Backup Device did no create : BATMANERROR", true);
            } 
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDbName"></param>
        /// <returns></returns>
        public static bool DeleteBackupDevice(string strSqlServer, string strDbName)
        {
            ClsLogfile.Writelogparam("strSqlServer, strDbName", strSqlServer, strDbName);
            if (CheckBackUpDevice(strSqlServer, strDbName))
                return Clsdb.RunSql(strSqlServer, "Master",
                    string.Format("EXEC master.dbo.sp_dropdevice @logicalname = N'{0}'", strDbName));
            return false;
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDbName"></param>
        /// <returns></returns>
        public static bool CheckBackUpDevice(string strSqlServer, string strDbName)
        {
            ClsLogfile.Writelogparam("strSqlServer, strDbName", strSqlServer, strDbName);
            return Clsdb.CheckSql(strSqlServer, "Master",
                string.Format("select * from sys.backup_devices where name = '{0}'", strDbName));
        }

        /// <summary>
        /// </summary>
        /// <param name="sSqlServer"></param>
        /// <returns></returns>
        public static List<DBBackupDevice> ListAllBackUpDeviceForServer(string sSqlServer)
        {
            ClsLogfile.Writelogparam("sSqlServer", sSqlServer);
            var dbfilesettings = new List<DBBackupDevice>();

            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            sSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = "select name, physical_name from sys.backup_devices";
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining List of Backup Devices", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var dbfileset = new DBBackupDevice
                            {
                                Name = dr["name"].ToString(),
                                Path = dr["physical_name"].ToString(),
                                ServerId = sSqlServer
                            };
                            dbfilesettings.Add(dbfileset);
                        }
                    }
                    sc.Close();
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain List of Backup Devices", true);
                    return null;
                }
                sc.Close();
                return dbfilesettings;
            }
        }
    }
}