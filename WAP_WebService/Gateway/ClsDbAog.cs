using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading;

namespace Gateway
{
    internal class ClsDbAog
    {
        /// <summary>
        /// </summary>
        private string _database;

        /// <summary>
        /// </summary>
        private string _dns;

        /// <summary>
        /// </summary>
        private string _ipaddress;

        /// <summary>
        /// </summary>
        private string _ipmask;

        /// <summary>
        /// </summary>
        private string _name;

        /// <summary>
        /// </summary>
        private string _port;

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
        public string Dns
        {
            get { return _dns; }
            set { _dns = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Port
        {
            get { return _port; }
            set { _port = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string IpAddress
        {
            get { return _ipaddress; }
            set { _ipaddress = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string IpMask
        {
            get { return _ipmask; }
            set { _ipmask = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Database
        {
            get { return _database; }
            set { _database = Setval(value); }
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
        public static List<ClsDbAog> GetAllAogforSvr(string sSqlServer)
        {
            ClsLogfile.Writelogparam("sSqlServer", sSqlServer);
            var dbfilesettings = new List<ClsDbAog>();

            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog=Master;Integrated Security=true;",
                            sSqlServer)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText =
                    "select name, dns_name, port, ip_address,ip_subnet_mask, database_name from sys.availability_groups as ag " +
                    "join sys.availability_group_listeners as agl on ag.group_id = agl.group_id " +
                    "join sys.availability_group_listener_ip_addresses as agli on agl.listener_id = agli.listener_id " +
                    "join sys.availability_databases_cluster as adc on ag.group_id = adc.group_id";
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining List of Always on Groups", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var dbfileset = new ClsDbAog
                            {
                                Name = dr["name"].ToString(),
                                Dns = dr["dns_name"].ToString(),
                                Port = dr["port"].ToString(),
                                IpAddress = dr["ip_address"].ToString(),
                                IpMask = dr["ip_subnet_mask"].ToString(),
                                Database = dr["database_name"].ToString(),
                                ServerId = sSqlServer
                            };
                            dbfilesettings.Add(dbfileset);
                        }
                    }
                    sc.Close();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain List of Always on Groups");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    return null;
                }
                sc.Close();
                return dbfilesettings;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strSqlaog"></param>
        /// <returns></returns>
        public static bool CheckAog(string strSqlServer, string strSqlaog)
        {
            ClsLogfile.Writelogparam("strSqlServer, strSqlaog", strSqlServer, strSqlaog);
            return Clsdb.CheckSql(strSqlServer, "master",
                string.Format("select * from sys.availability_groups where name = '{0}'", strSqlaog));
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strSqlaog"></param>
        /// <returns></returns>
        public static bool CheckPrimAOG(string strSqlServer, string strSqlaog)
        {
            ClsLogfile.Writelogparam("strSqlServer, strSqlaog", strSqlServer, strSqlaog);
            return Clsdb.CheckSql(strSqlServer, "master", string.Format("select * from sys.dm_hadr_availability_replica_states as ars inner join sys.availability_groups_cluster as AGC on AGC.group_id = ars.group_id where ars.role_desc = 'PRIMARY' and AGC.name = '{0}'",strSqlaog));
        }
        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strSqlaog"></param>
        /// <returns></returns>
        public static bool RemoveAog(string strSqlServer, string strSqlaog)
        {
            ClsLogfile.Writelogparam("strSqlServer, strSqlaog", strSqlServer, strSqlaog);
            return CheckAog(strSqlServer, strSqlaog) &&
                   Clsdb.CheckSql(strSqlServer, "master", string.Format("DROP AVAILABILITY GROUP [{0}]", strSqlaog));
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strEndPointPartner"></param>
        public static void AddHaEndPoint(string strSqlServer, string strEndPointPartner)
        {
            ClsLogfile.Writelogparam("strSqlServer, strEndPointPartner", strSqlServer, strEndPointPartner);
            Clsdb.RunSql(strSqlServer, "Master",
                string.Format(
                    "IF (SELECT state FROM sys.endpoints WHERE Name = N'Hadr_endpoint') <> 0;BEGIN;ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED;END;GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [{0}]",
                    strEndPointPartner));
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        public static void EnableAwaysOn(string strSqlServer)
        {
            ClsLogfile.Writelogparam("strSqlServer", strSqlServer);
            Clsdb.RunSql(strSqlServer, "Master",
                "IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE Name='AlwaysOn_health');BEGIN;ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);END;IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE Name='AlwaysOn_health');BEGIN;ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;END;");
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strAogName"></param>
        public static void FailOverAog(string strSqlServer, string strAogName)
        {
            ClsLogfile.Writelogparam("strSqlServer, strAogName", strSqlServer, strAogName);
            Clsdb.RunSql(strSqlServer, "Master", string.Format("ALTER AVAILABILITY GROUP [{0}] FAILOVER", strAogName));
        }


        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDBName"></param>
        public static void RemoveDbFromAog(string strSqlServer, string strDBName, string strAogName)
        {
            ClsLogfile.Writelogparam("strSqlServer, strDBName", strSqlServer, strDBName);
            try
            {
                Clsdb.RunSql(strSqlServer, "Master", string.Format("ALTER AVAILABILITY GROUP [{0}] REMOVE DATABASE [{1}];", strAogName, strDBName));
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, "Failed to remove DB from Always on group");
                ClsLogfile.Writelog(3, ex.Message, true);
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDbName"></param>
        /// <param name="strNewUncdbPath"></param>
        /// <param name="sListenerName"></param>
        /// <param name="strSqlServerPtr"></param>
        /// <param name="strAoListernerIp"></param>
        /// <param name="strAogName"></param>
        public static void ProvisionAoServerOne(string strSqlServer, string strDbName, string strNewUncdbPath,
            string sListenerName, string strSqlServerPtr, string strAoListernerIp, string strAogName)
        {
            ClsLogfile.Writelogparam(
                "strSqlServer, strDbName, strNewUncdbPath, sListenerName, strSqlServerPtr, strAoListernerIp, strAogName",
                strSqlServer, strDbName, strNewUncdbPath, sListenerName, strSqlServerPtr, strAoListernerIp, strAogName);
            Clsdb.RunSql(strSqlServer, "Master",
                string.Format(@"BACKUP DATABASE [{0}] TO  DISK = N'{1}\{0}.bak' WITH NOFORMAT, NOINIT, SKIP, NOREWIND, NOUNLOAD, STATS = 10;
                BACKUP LOG [{0}] TO  DISK = N'{1}\{0}.trn' WITH NOFORMAT, NOINIT, NOSKIP, REWIND, NOUNLOAD, STATS = 10;
                CREATE AVAILABILITY GROUP [{2}] WITH (AUTOMATED_BACKUP_PREFERENCE = SECONDARY) FOR DATABASE [{0}] 
                REPLICA ON N'{7}' WITH (ENDPOINT_URL = N'TCP://{3}:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = NO)),
                N'{8}' WITH (ENDPOINT_URL = N'TCP://{4}:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));
                ALTER AVAILABILITY GROUP [{2}]
                ADD LISTENER N'{6}' (WITH IP ((N'{5}', N'255.255.255.0')) , PORT=1433);", strDbName, strNewUncdbPath,
                    strAogName, strSqlServer, strSqlServerPtr, strAoListernerIp, sListenerName.Split('.')[0],
                    strSqlServer.Split('.')[0],
                    strSqlServerPtr.Split('.')[0]));
        }

        /// <summary>
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strDbName"></param>
        /// <param name="strNewUncdbPath"></param>
        /// <param name="strAogName"></param>
        /// <param name="sSqlPrimaryAog"></param>
        public static void ProvisionAoServerTwo(string strSqlServer, string strDbName, string strNewUncdbPath,
            string strAogName, string sSqlPrimaryAog)
        {
            ClsLogfile.Writelogparam("strSqlServer, strDbName, strNewUncdbPath, strAogName", strSqlServer, strDbName,
                strNewUncdbPath, strAogName);
            Clsdb.RunSql(strSqlServer, "Master",
                string.Format(@"ALTER DATABASE [{0}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;", strDbName));

            Clsdb.RunSql(strSqlServer, "Master",
                string.Format(@"RESTORE DATABASE [{0}] FROM  DISK = N'{1}\{0}.bak' WITH  NORECOVERY, REPLACE,  NOUNLOAD,  STATS = 10;
            RESTORE LOG [{0}] FROM  DISK = N'{1}\{0}.trn' WITH  NORECOVERY, NOUNLOAD,  STATS = 10;", strDbName,
                    strNewUncdbPath));

            Clsdb.RunSql(strSqlServer, "Master", string.Format(@"ALTER AVAILABILITY GROUP [{0}] JOIN;", strAogName));
            Clsdb.RunSql(strSqlServer, "Master", string.Format(@"begin try
			declare @conn bit;
			declare @count int;
			declare @replica_id uniqueidentifier;
			declare @group_id uniqueidentifier;
			set @conn = 0;
			set @count = 30 -- wait for 5 minutes;
			if (serverproperty('IsHadrEnabled') = 1)
				and (isnull((select member_state from master.sys.dm_hadr_cluster_members where upper(member_name COLLATE Latin1_General_CI_AS) = upper(cast(serverproperty('ComputerNamePhysicalNetBIOS') as nvarchar(256)) COLLATE Latin1_General_CI_AS)), 0) <> 0) 
				and (isnull((select state from master.sys.database_mirroring_endpoints), 1) = 0) 
			begin
				select @group_id = ags.group_id from master.sys.availability_groups as ags where Name = N'{1}';
				select @replica_id = replicas.replica_id from master.sys.availability_replicas as replicas where upper(replicas.replica_server_name COLLATE Latin1_General_CI_AS) = upper(@@SERVERNAME COLLATE Latin1_General_CI_AS) and group_id = @group_id;
				while @conn <> 1 and @count > 0 
				begin
					set @conn = isnull((select connected_state from master.sys.dm_hadr_availability_replica_states as states where states.replica_id = @replica_id), 1);
				if @conn = 1 
					begin
						break;
					end
				waitfor delay '00:00:10';
				set @count = @count - 1;
				end
			end
			end try
			begin catch
			-- If the wait loop fails, do not stop execution of the alter database statement
			end catch
			ALTER DATABASE [{0}] SET HADR AVAILABILITY GROUP = [{1}];", strDbName, strAogName));
            Thread.Sleep(30*1000);
            Clsdb.RunSql(sSqlPrimaryAog, "master",
                string.Format(
                    "ALTER AVAILABILITY GROUP [{0}] MODIFY REPLICA ON N'{1}' WITH (SECONDARY_ROLE(ALLOW_CONNECTIONS = READ_ONLY))",
                    strAogName, strSqlServer.Split('.')[0]));
            Clsdb.RunSql(sSqlPrimaryAog, "master",
                string.Format(
                    "ALTER AVAILABILITY GROUP [{0}] MODIFY REPLICA ON N'{1}' WITH (SECONDARY_ROLE(ALLOW_CONNECTIONS = READ_ONLY))",
                    strAogName, sSqlPrimaryAog.Split('.')[0]));
            Clsdb.RunSql(sSqlPrimaryAog, "master",
                string.Format(
                    "ALTER AVAILABILITY GROUP [{0}] MODIFY REPLICA ON N'{1}' WITH (SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'TCP://{2}:1433'))",
                    strAogName, strSqlServer.Split('.')[0], strSqlServer));
            Clsdb.RunSql(sSqlPrimaryAog, "master",
                string.Format(
                    "ALTER AVAILABILITY GROUP [{0}] MODIFY REPLICA ON N'{1}' WITH (SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'TCP://{2}:1433'))",
                    strAogName, sSqlPrimaryAog.Split('.')[0], sSqlPrimaryAog));
            Clsdb.RunSql(sSqlPrimaryAog, "master",
                string.Format(
                    "ALTER AVAILABILITY GROUP [{0}] MODIFY REPLICA ON N'{1}' WITH (PRIMARY_ROLE (READ_ONLY_ROUTING_LIST=('{2}')))",
                    strAogName, sSqlPrimaryAog.Split('.')[0], strSqlServer.Split('.')[0]));
            Clsdb.RunSql(sSqlPrimaryAog, "master",
                string.Format(
                    "ALTER AVAILABILITY GROUP [{0}] MODIFY REPLICA ON N'{1}' WITH (PRIMARY_ROLE (READ_ONLY_ROUTING_LIST=('{2}')))",
                    strAogName, strSqlServer.Split('.')[0], sSqlPrimaryAog.Split('.')[0]));
        }
    }
}