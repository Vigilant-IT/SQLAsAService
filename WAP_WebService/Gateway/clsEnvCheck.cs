using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsEnvCheck
    {
        public static void CheckEnv()
        {
            var sSQLServer = ClsTimer.Settings.Gwsqlserver;
            var sGwdb = ClsTimer.Settings.Gwdbname;
            var sSQL = "Select SCVMM, VMName, MSSQL from VMSpec";
            var dt = new DataTable();
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            sSQLServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = sSQL;
                try
                {
                    ClsLogfile.Writelog(1, "getting data from Audit Table for Settings Audit", true);
                    dt.Load(cmd.ExecuteReader());
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed getting data from Audit Table for Settings Audit");
                    ClsLogfile.Writelog(3, ex.Message, true);
                }
                sc.Close();
            }
            var dbs = new List<Dbfilesets>();
            var subs = new List<Sub>();
            var plans = new List<Plan>();
            var bds = new List<DBBackupDevice>();
            var rgs = new List<DBResGov>();
            var aogs = new List<ClsDbAog>();
            var vmmdisks = new List<ClsVmmDisks>();
            var mps = new List<MountPoint>();
            var vhdxs = new List<Vhdx>();
            foreach (DataRow row in dt.Rows)
            {
                var sSvr = row.Field<string>("VMName");
                var sVmmSvr = row.Field<string>("SCVMM");
                var sSqlVer = row.Field<string>("MSSQL");
                try
                {
                    dbs.AddRange(ClsDbMoves.GetAllDBs(sSvr));
                }
                catch (Exception)
                {
                    // ignored
                }
                try
                {
                    subs.AddRange(ClsSubscriptions.GetApSubBySvrName(sSvr.Split('.')[0], ClsTimer.Settings.AdminServer,
                        ClsTimer.Settings.AuthServer,
                        ClsTimer.Settings.SignedCert));
                }
                catch (Exception)
                {
                    // ignored
                }
                try
                {
                    plans.AddRange(ClsPlans.PS_GetPlansForServer(sSvr.Split('.')[0], ClsTimer.Settings.AdminServer,
                        ClsTimer.Settings.AuthServer,
                        ClsTimer.Settings.SignedCert));
                }
                catch (Exception)
                {
                    // ignored
                }
                try
                {
                    bds.AddRange(DBBackupDevice.ListAllBackUpDeviceForServer(sSvr));
                }
                catch (Exception)
                {
                    // ignored
                }
                try
                {
                    rgs.AddRange(DBResGov.ListAllResGovForServer(sSvr));
                }
                catch (Exception)
                {
                    // ignored
                }
                try
                {
                    aogs.AddRange(ClsDbAog.GetAllAogforSvr(sSvr));
                }
                catch (Exception)
                {
                    // ignored
                }
                try
                {
                    vmmdisks.AddRange(ClsVmmDisks.GetVmDiskSizes(sVmmSvr, sSvr));
                }
                catch (Exception)
                {
                    // ignored
                }
                try
                {
                    mps.AddRange(ClsFileSystem.GetMountPointForVm(sSvr, sSqlVer));
                }
                catch (Exception)
                {
                    // ignored
                }
                try
                {
                    vhdxs.AddRange(ClsFileSystem.GetVhdxFilesForVm(sSvr, sVmmSvr));
                }
                catch (Exception)
                {
                    // ignored
                }
            }
            var sSqLdel = "delete from dbfilesettings;" +
                          "delete from subsettings;" +
                          "delete from plansettings;" +
                          "delete from backupdevicesettings;" +
                          "delete from dbresgovsettings;" +
                          "delete from dbaogsettings;" +
                          "delete from vmmdisksettings;" +
                          "delete from mountpointsettings;" +
                          "delete from vhdxsettings;";
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            sSQLServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = sSqLdel;
                try
                {
                    ClsLogfile.Writelog(1, "Purging Settings Tables", true);
                    cmd.ExecuteReader();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to Purge Settings Tables");
                    ClsLogfile.Writelog(3, ex.Message, true);
                }
                sc.Close();
            }
            foreach (var db in dbs)
            {
                var sDbQry =
                    string.Format(
                        "INSERT INTO [dbo].[dbfilesettings] ([ServerID],[dbname],[name],[path],[size],[timestamp])VALUES('{0}','{1}','{2}','{3}','{4}','{5}')",
                        db.ServerId, db.DBName, db.Name, db.Path, db.Size,
                        DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sDbQry);
            }
            dbs.Clear();
            foreach (var sub in subs)
            {
                var sSubQry =
                    string.Format(
                        "INSERT INTO [dbo].[subsettings]([serverid],[name],[state],[planid],[subid],[timestamp])VALUES('{0}','{1}','{2}','{3}','{4}','{5}')",
                        sub.ServerName, sub.Name, sub.State, sub.PlanId, sub.Id,
                        DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sSubQry);
            }
            subs.Clear();
            foreach (var plan in plans)
            {
                var sPlanQry =
                    string.Format(
                        "INSERT INTO [dbo].[plansettings]([serverid],[planid],[displayname],[state],[subcount],[timestamp])VALUES('{0}','{1}','{2}','{3}','{4}','{5}')",
                        plan.ServerName, plan.Id, plan.DisplayName, plan.State, plan.SubscriptionCount,
                        DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sPlanQry);
            }
            plans.Clear();
            foreach (var bd in bds)
            {
                var sBdQry =
                    string.Format(
                        "INSERT INTO [dbo].[backupdevicesettings] ([serverid],[name],[path],[timestamp]) VALUES ('{0}' ,'{1}','{2}','{3}')",
                        bd.ServerId, bd.Name, bd.Path, DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sBdQry);
            }
            bds.Clear();
            foreach (var rg in rgs)
            {
                var sRgQry =
                    string.Format(
                        "INSERT INTO [dbo].[dbresgovsettings] ([serverid],[capcpu],[maxcpu],[maxmem],[maxmempool],[minmempool],[name],[timestamp])VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')",
                        rg.ServerId, rg.Capcpu, rg.Maxcpu, rg.Maxmem, rg.Maxmempool, rg.Minmempool, rg.Name,
                        DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sRgQry);
            }
            rgs.Clear();
            foreach (var aog in aogs)
            {
                var sAogQry =
                    string.Format(
                        "INSERT INTO [dbo].[dbaogsettings]([serverid],[dbname],[dns],[ipaddress],[ipmask],[name],[port],[timestamp])VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')",
                        aog.ServerId, aog.Database, aog.Dns, aog.IpAddress, aog.IpMask, aog.Name, aog.Port,
                        DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sAogQry);
            }
            aogs.Clear();
            foreach (var vmmdisk in vmmdisks)
            {
                var sVmmDiskQry =
                    string.Format(
                        "INSERT INTO [dbo].[vmmdisksettings]([serverid],[diskname],[size],[timestamp])VALUES('{0}','{1}','{2}','{3}')",
                        vmmdisk.ServerName, vmmdisk.DiskName, vmmdisk.Size,
                        DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sVmmDiskQry);
            }
            vmmdisks.Clear();
            foreach (var mp in mps)
            {
                var sMpQry =
                    string.Format(
                        "INSERT INTO [dbo].[mountpointsettings]([serverid],[name],[path],[timestamp])VALUES('{0}','{1}','{2}','{3}')",
                        mp.Vm, mp.Name, mp.Path, DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sMpQry);
            }
            mps.Clear();
            foreach (var vhdx in vhdxs)
            {
                var sVhdxQry =
                    string.Format(
                        "INSERT INTO [dbo].[vhdxsettings]([serverid],[name],[size],[host],[path],[timestamp])VALUES('{0}','{1}','{2}','{3}','{4}','{5}')",
                        vhdx.Vm, vhdx.Name, vhdx.Size, vhdx.Host, vhdx.Path,
                        DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                Clsdb.RunSql(sSQLServer, sGwdb, sVhdxQry);
            }
            vhdxs.Clear();
        }
    }
}