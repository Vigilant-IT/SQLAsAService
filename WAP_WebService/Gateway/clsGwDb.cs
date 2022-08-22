using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Gateway
{
    class clsGwDb
    {
        internal class vhdx
        {
            internal string vhdxpath { get; set; }
            internal int size { get; set; }
            internal int SetNum { get; set; }
        }
        
        public class DbReq
        {
            public int ReqId { get; set; }
            public int RgId { get; set; }
            public string DbName { get; set; }
            public string Email { get; set; }
            public string PlanId { get; set; }
            public string Colation { get; set; }
            public string PassPhrase { get; set; }
            public string SubId { get; set; }
            public string Dns { get; set; }
            public string Env { get; set; }
            public string Avail { get; set; }
            public string ListenerName { get; set; }
            public string VmName { get; set; }
            public int VhdxSetNum { get; set; }
            public string DboGroup { get; set; }
            public string SqlVer { get; set; }
            public int DbSize { get; set; }
            public string PwrUGroup { get; set; }
            public string StdUGroup { get; set; }
            public string Tde { get; set; }
            public string PtrVmName { get; set; }
            public string Ip { get; set; }
            public string AogName { get; set; }
            public bool SwitchDc { get; set; }
        }

        public static List<int> GetPendingDbReq(string strSqlServer, string strSqlDb)
        {
            var listdbids = new List<int>();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                //cmd.CommandText = "select dbreq.id from DBrequests as dbreq join RGJob on dbreq.RGID = rgjob.RGID full join dbjob on dbreq.id = dbjob.DbaseId where RGJob.Notes ='completed' and (dbjob.notes not like 'completed%' or dbjob.notes is null)";
                cmd.CommandText = "select id from DBrequests WHERE Notes IS NULL OR Notes NOT LIKE '%Completed%'";
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to run SQL query", true);
                    var res = cmd.ExecuteReader();
                    if (res.HasRows)
                    {
                        while (res.Read())
                    {
                        var dbid = new int();
                        dbid = int.Parse(res["id"].ToString());
                        listdbids.Add(dbid);
                    }
                        }
                    else
                    {
                        return null;
                    }
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to run SQL query");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    return null;
                }
                sc.Close();
            }
            return listdbids;
        }

        public static DbReq GetDbReq(string strSqlServer, string strSqlDb, int intDbId)
        {
            var db = new DbReq();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("select distinct DBRequests.Id,RGJob.RGID,DBRequests.DBName,RGRequests.Email," +
                                                "rgconfig.PlanID,DBRequests.Collation,RGRequests.RgPassPhrase,RGConfig.SubID," +
                                                "DBRequests.ListenerName,VMSpec.VMName,RGConfig.VHDXSetNum,DBRequests.DBOGrp," +
                                                "VMSpec.MSSQL,DBRequests.Size,DBRequests.PwrGrp,DBRequests.StdGrp,VMSpec.TDE," +
                                                "VMSpec.VMNameClusterPartner,dbrequests.IP,DBRequests.AOGName " +
                                                "from DBRequests " +
                                                "full join RGJob on DBRequests.RGID = RGJob.RGID " +
                                                "full join RGRequests on RGJob.JobID = RGRequests.ReqId " +
                                                "full join RGConfig on RGConfig.RGID = rgjob.RGID " +
                                                "full join VMSpec on vmspec.ID = RGJob.SvrID " +
                                                "where DBRequests.Id = {0}",intDbId);
                cmd.CommandTimeout = 0;
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to run SQL query", true);
                    var res = cmd.ExecuteReader();
                    while (res.Read())
                    {
                        db.ReqId = int.Parse(res["id"].ToString());
                        db.RgId = int.Parse(res["RGID"].ToString());
                        db.DbName = res["DBName"].ToString();
                        db.Email = res["email"].ToString();
                        db.PlanId = res["PlanId"].ToString();
                        db.Colation = res["Collation"].ToString();
                        db.PassPhrase = res["RgPassPhrase"].ToString();
                        db.SubId = res["SubId"].ToString();
                        db.ListenerName = res["ListenerName"].ToString();
                        db.VmName = res["VMName"].ToString();
                        db.VhdxSetNum = int.Parse(res["VhdxSetNum"].ToString());
                        db.DboGroup = res["DBOGrp"].ToString();
                        db.SqlVer = res["MSSQL"].ToString();
                        db.DbSize = int.Parse(res["Size"].ToString());
                        db.PwrUGroup = res["PwrGrp"].ToString();
                        db.StdUGroup = res["StdGrp"].ToString();
                        db.Tde = res["TDE"].ToString();
                        db.PtrVmName = res["VMNameClusterPartner"].ToString();
                        db.Ip = res["IP"].ToString();
                        db.AogName = res["AOGName"].ToString();
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
            return db;
        }

        public static bool NewDb(DbReq request, string strSqlServer, string strSqlDb)
        {
            var isLinux = request.SqlVer == "linux";


            var rgname = clsRgReq.GetRgRequestById(strSqlServer, strSqlDb, request.RgId).RgName;
            var rg = clsRgConfig.GetRgConfig(strSqlServer, strSqlDb, rgname);
            var server = clsSvrConfig.GetSvrDetailsById(strSqlServer, strSqlDb, rg.SvrId);
            var bBc = server.Avail.ToLower() == "businesscritical" && !isLinux;
            var sSQLUser = "SQLUser" + DateTime.Now.ToString("yyyyMMddhhmmss");
            var sUncPath = server.Env.ToLower() == "prod" ? ClsTimer.Settings.ProdShareUnc + "\\" + rgname : ClsTimer.Settings.NonProdShareUnc + "\\" + rgname;
            var plan = ClsPlans.PS_GetPlan(request.PlanId, true, ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer,
                ClsTimer.Settings.SignedCert);

            var sCs = ClsWapdb.PS_AddAPDB(request.Email, request.DbName, plan[0].Id, 10,
                    10, request.Colation, sSQLUser, "SQLaaS2016", request.SubId, request.Dns,
                    ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer, ClsTimer.Settings.TenantServer,
                    ClsTimer.Settings.SignedCert);
            var dns = clsDNS.updateDns(request.DbName, server.Env.ToLower() == "prod" ? ClsTimer.Settings.DNSProd : ClsTimer.Settings.DNSNonProd, 
                server.Avail == "BusinessCritical" ? request.ListenerName : request.VmName, ClsTimer.Settings.DNSServer);

            //var sCs = ClsWapdb.GetDBConnString(request.VmName, request.DbName, sSQLUser)
            //        .Replace(request.VmName, dns);

            //sCs = sCs.Contains("<<Your-DB-password-here>>")
            //    ? sCs.Replace("<<Your-DB-password-here>>", request.PassPhrase)
            //    : "";
            if (sCs == "") throw new Exception("No Connection string");

            //Skip the rest of the process as we can't create and attach vhdx on linux vm.
            if (isLinux)
            {
                using (var sc = new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;", strSqlServer, strSqlDb)))
                using (var cmd = sc.CreateCommand())
                {
                    sc.Open();
                    cmd.CommandText = string.Format("UPDATE DBRequests SET Notes = 'Completed', ConnectionString = '{1}' WHERE DBName = '{0}'", request.DbName, sCs);
                    cmd.CommandTimeout = 0;

                    var res = cmd.ExecuteNonQuery();
                }

                return true;
            }
                

            ClsFileSystem.AssignFolderPerms(sUncPath, request.DboGroup, true, false, false);
            ClsFileSystem.AssignFolderPerms(sUncPath + "\\reports", request.DboGroup, false, true, false);


            if (!string.IsNullOrEmpty(ClsTimer.Settings.UncSharesSecGrps))
            {
                var securityGroups = ClsTimer.Settings.UncSharesSecGrps.Split(';');
                foreach (var securityGrp in securityGroups)
                    ClsFileSystem.AssignFolderPerms(sUncPath, securityGrp, false, false, true);
            }       
            
            var MdfHiPo = new vhdx();
            var LdfHiPo = new vhdx();
            var MdfStd = new vhdx();
            var LdfStd = new vhdx();
            foreach (var rgvhdx in clsVhdx.GetRgVhdxDiskSet(strSqlServer,strSqlDb,request.RgId.ToString(), server.SvrId.ToString()))
            {
                switch (rgvhdx.Purpose)
                {
                    case "Log_Std":
                        LdfStd.size = ClsVmmDisks.GetVmDiskSize(server.VmmName, server.VmName, rgvhdx.VhdxPath);
                        LdfStd.vhdxpath = rgvhdx.VhdxPath;
                        LdfStd.SetNum = rgvhdx.VhdxSetNum;
                        break;
                    case "Log_HiPo":
                        LdfHiPo.size = ClsVmmDisks.GetVmDiskSize(server.VmmName, server.VmName, rgvhdx.VhdxPath);
                        LdfHiPo.vhdxpath = rgvhdx.VhdxPath;
                        LdfHiPo.SetNum = rgvhdx.VhdxSetNum;
                        break;
                    case "Data_Std":
                        MdfStd.size = ClsVmmDisks.GetVmDiskSize(server.VmmName, server.VmName, rgvhdx.VhdxPath);
                        MdfStd.vhdxpath = rgvhdx.VhdxPath;
                        MdfStd.SetNum = rgvhdx.VhdxSetNum;
                        break;
                    case "Data_HiPo":
                        MdfHiPo.size = ClsVmmDisks.GetVmDiskSize(server.VmmName, server.VmName, rgvhdx.VhdxPath);
                        MdfHiPo.vhdxpath = rgvhdx.VhdxPath;
                        MdfHiPo.SetNum = rgvhdx.VhdxSetNum;
                        break;
                }
            }
            if (!(LdfStd.size >= 10000 || LdfHiPo.size >= 10000 || MdfHiPo.size >= 10000 || MdfStd.size >= 10000))
            {
                ClsVmmDisks.ResizeVmDisk(server.VmmName, server.VmName, MdfHiPo.vhdxpath, "500");
                ClsVmmDisks.ResizeVmDisk(server.VmmName, server.VmName, LdfHiPo.vhdxpath, "100");
                ClsVmmDisks.ResizeVmDisk(server.VmmName, server.VmName, MdfStd.vhdxpath, "500");
                ClsVmmDisks.ResizeVmDisk(server.VmmName, server.VmName, LdfStd.vhdxpath, "100");
            }
            else
            {
                var newsetnum = MdfHiPo.SetNum + 1;
                var MdfHiPoDisk = clsVhdx.AttachNewVhdxToRg(server.VmName, server.VmmName, "Data",
                    "HighPerformance", request.SqlVer, newsetnum, rgname, strSqlServer,
                    strSqlDb);
                var MdfStdDisk = clsVhdx.AttachNewVhdxToRg(server.VmName, server.VmmName, "Data",
                    "Standard", request.SqlVer, newsetnum, rgname, strSqlServer,
                    strSqlDb);
                var LdfHiPoDisk = clsVhdx.AttachNewVhdxToRg(server.VmName, server.VmmName, "Log",
                    "HighPerformance", request.SqlVer, newsetnum, rgname, strSqlServer,
                    strSqlDb);
                var LdfStdDisk = clsVhdx.AttachNewVhdxToRg(server.VmName, server.VmmName, "Log",
                    "Standard", request.SqlVer, newsetnum, rgname, strSqlServer,
                    strSqlDb);
                MdfHiPoDisk.RgId = LdfHiPoDisk.RgId = MdfStdDisk.RgId = LdfStdDisk.RgId = request.ReqId;
                MdfHiPoDisk.VhdxSetNum = LdfHiPoDisk.VhdxSetNum = MdfStdDisk.VhdxSetNum = LdfStdDisk.VhdxSetNum = newsetnum;
                MdfHiPoDisk.SvrId = LdfHiPoDisk.SvrId = MdfStdDisk.SvrId = LdfStdDisk.SvrId = server.SvrId;
                MdfHiPoDisk.CurrentPrimary = LdfHiPoDisk.CurrentPrimary = MdfStdDisk.CurrentPrimary = LdfStdDisk.CurrentPrimary = 1;
                clsVhdx.AddNewVhdxToGwDb(MdfHiPoDisk, strSqlServer, strSqlDb);
                clsVhdx.AddNewVhdxToGwDb(LdfHiPoDisk, strSqlServer, strSqlDb);
                clsVhdx.AddNewVhdxToGwDb(MdfStdDisk, strSqlServer, strSqlDb);
                clsVhdx.AddNewVhdxToGwDb(LdfStdDisk, strSqlServer, strSqlDb);
                clsVhdx.UpdateRgVhdxAllocation(request.RgId, MdfHiPo.SetNum + 1, strSqlServer, strSqlDb);
                ClsVmmDisks.ResizeVmDisk(server.VmmName, server.VmName, MdfHiPoDisk.VhdxPath, "500");
                ClsVmmDisks.ResizeVmDisk(server.VmmName, server.VmName, LdfHiPoDisk.VhdxPath, "100");
                ClsVmmDisks.ResizeVmDisk(server.VmmName, server.VmName, MdfStdDisk.VhdxPath, "500");
                ClsVmmDisks.ResizeVmDisk(server.VmmName, server.VmName, LdfStdDisk.VhdxPath, "100");
            }
            var sFpnOldDB = string.Format("{0}\\SQL{1}\\SQLData\\{2}\\{3}", ClsTimer.Settings.MDFPath, request.SqlVer, rgname, request.VhdxSetNum);
            var sFpnOldLog = string.Format("{0}\\SQL{1}\\SQLLog\\{2}\\{3}", ClsTimer.Settings.LDFPath, request.SqlVer, rgname, request.VhdxSetNum);
            var dbdatafileset = new Dbfilesets();
            var dblogfileset = new Dbfilesets();
            var dbfilesets = ClsDbMoves.Getdbfile(request.VmName, request.DbName);
            foreach (var dbfileset in dbfilesets)
            {
                if (dbfileset.Name.ToLower().EndsWith("_log"))
                {
                    dblogfileset = dbfileset;
                }
                else
                {
                    dbdatafileset = dbfileset;
                }
            }
            if (string.IsNullOrEmpty(dbdatafileset.Path)) dbdatafileset.Path = sFpnOldDB + "\\" + request.DbName + ".mdf";
            if (string.IsNullOrEmpty(dblogfileset.Path)) dblogfileset.Path = sFpnOldLog + "\\" + request.DbName + "_log.ldf";
            ClsDbMoves.MoveDb(request.DbName, dbdatafileset.Path, dblogfileset.Path, sFpnOldDB, request.VmName,request.Colation,sFpnOldLog, false);
            if (request.DbSize > int.Parse(dbdatafileset.Size))
            {
                Clsdb.ChangeDbSize(request.DbName, request.DbSize, request.DbSize,request.VmName);
            }
            if (server.Env.ToLower() == "prod" && request.DboGroup != "")
            {
                Clsdb.SetDbOwner(request.VmName, request.DbName, request.DboGroup, true, server.Avail.ToLower() == "standard", server.Env.ToLower() == "prod", true, false, false, request.SqlVer);
            }
            else if (server.Env.ToLower() == "nonprod" && request.DboGroup != "")
            {
                Clsdb.SetDbOwner(request.VmName, request.DbName, request.DboGroup, true, server.Avail.ToLower() == "standard", server.Env.ToLower() == "prod", true, false, false, request.SqlVer);
            }
            if (request.PwrUGroup != "")
            {
                Clsdb.SetDbOwner(request.VmName, request.DbName, request.PwrUGroup, false, server.Avail.ToLower() == "standard", server.Env.ToLower() == "prod", false, true, false, request.SqlVer);
            }
            if (request.StdUGroup != "")
            {
                Clsdb.SetDbOwner(request.VmName, request.DbName, request.StdUGroup, false, server.Avail.ToLower() == "standard", server.Env.ToLower() == "prod", false, false, true, request.SqlVer);
            }
            ClsAd.GrantRdgAccess(request.DbName);
            if (request.PwrUGroup != "") ClsAd.GrantRdgAccess(request.PwrUGroup);
            if (request.StdUGroup != "") ClsAd.GrantRdgAccess(request.StdUGroup);
            if (request.Tde.ToLower() == "yes" && server.Avail != "BusinessCritical")
            {
                Clsdb.EnableTDE(request.VmName, request.DbName);
            }
            ClsTenantSQLSvr.UpdateRgTable(server.VmName, rgname, request.DbName);
            if (bBc)
            {
                var ptrserver = clsSvrConfig.GetSvrDetailsByName(strSqlServer, strSqlDb, server.PtrVmName);
                foreach (var rgvhdx in clsVhdx.GetRgVhdxDiskSet(strSqlServer, strSqlDb, request.RgId.ToString(), ptrserver.SvrId.ToString()))
                {
                    switch (rgvhdx.Purpose)
                    {
                        case "Log_Std":
                            LdfStd.size = ClsVmmDisks.GetVmDiskSize(ptrserver.VmmName, ptrserver.VmName, rgvhdx.VhdxPath);
                            LdfStd.vhdxpath = rgvhdx.VhdxPath;
                            LdfStd.SetNum = rgvhdx.VhdxSetNum;
                            break;
                        case "Log_HiPo":
                            LdfHiPo.size = ClsVmmDisks.GetVmDiskSize(ptrserver.VmmName, ptrserver.VmName, rgvhdx.VhdxPath);
                            LdfHiPo.vhdxpath = rgvhdx.VhdxPath;
                            LdfHiPo.SetNum = rgvhdx.VhdxSetNum;
                            break;
                        case "Data_Std":
                            MdfStd.size = ClsVmmDisks.GetVmDiskSize(ptrserver.VmmName, ptrserver.VmName, rgvhdx.VhdxPath);
                            MdfStd.vhdxpath = rgvhdx.VhdxPath;
                            MdfStd.SetNum = rgvhdx.VhdxSetNum;
                            break;
                        case "Data_HiPo":
                            MdfHiPo.size = ClsVmmDisks.GetVmDiskSize(ptrserver.VmmName, ptrserver.VmName, rgvhdx.VhdxPath);
                            MdfHiPo.vhdxpath = rgvhdx.VhdxPath;
                            MdfHiPo.SetNum = rgvhdx.VhdxSetNum;
                            break;
                    }
                }
                if (!(LdfStd.size >= 10000 || LdfHiPo.size >= 10000 || MdfHiPo.size >= 10000 || MdfStd.size >= 10000))
                {
                    ClsVmmDisks.ResizeVmDisk(ptrserver.VmmName, ptrserver.VmName, MdfHiPo.vhdxpath, "500");
                    ClsVmmDisks.ResizeVmDisk(ptrserver.VmmName, ptrserver.VmName, LdfHiPo.vhdxpath, "100");
                    ClsVmmDisks.ResizeVmDisk(ptrserver.VmmName, ptrserver.VmName, MdfStd.vhdxpath, "500");
                    ClsVmmDisks.ResizeVmDisk(ptrserver.VmmName, ptrserver.VmName, LdfStd.vhdxpath, "100");
                }
                else
                {
                    var newsetnum = MdfHiPo.SetNum + 1;
                    var MdfHiPoDisk = clsVhdx.AttachNewVhdxToRg(ptrserver.VmName, ptrserver.VmmName, "Data",
                        "HighPerformance", request.SqlVer, newsetnum, rgname, strSqlServer,
                        strSqlDb);
                    var MdfStdDisk = clsVhdx.AttachNewVhdxToRg(ptrserver.VmName, ptrserver.VmmName, "Data",
                        "Standard", request.SqlVer, newsetnum, rgname, strSqlServer,
                        strSqlDb);
                    var LdfHiPoDisk = clsVhdx.AttachNewVhdxToRg(ptrserver.VmName, ptrserver.VmmName, "Log",
                        "HighPerformance", request.SqlVer, newsetnum, rgname, strSqlServer,
                        strSqlDb);
                    var LdfStdDisk = clsVhdx.AttachNewVhdxToRg(ptrserver.VmName, ptrserver.VmmName, "Log",
                        "Standard", request.SqlVer, newsetnum, rgname, strSqlServer,
                        strSqlDb);
                    MdfHiPoDisk.RgId = LdfHiPoDisk.RgId = MdfStdDisk.RgId = LdfStdDisk.RgId = request.ReqId;
                    MdfHiPoDisk.VhdxSetNum = LdfHiPoDisk.VhdxSetNum = MdfStdDisk.VhdxSetNum = LdfStdDisk.VhdxSetNum = newsetnum;
                    MdfHiPoDisk.SvrId = LdfHiPoDisk.SvrId = MdfStdDisk.SvrId = LdfStdDisk.SvrId = ptrserver.SvrId;
                    MdfHiPoDisk.CurrentPrimary = LdfHiPoDisk.CurrentPrimary = MdfStdDisk.CurrentPrimary = LdfStdDisk.CurrentPrimary = 1;
                    clsVhdx.AddNewVhdxToGwDb(MdfHiPoDisk, strSqlServer, strSqlDb);
                    clsVhdx.AddNewVhdxToGwDb(LdfHiPoDisk, strSqlServer, strSqlDb);
                    clsVhdx.AddNewVhdxToGwDb(MdfStdDisk, strSqlServer, strSqlDb);
                    clsVhdx.AddNewVhdxToGwDb(LdfStdDisk, strSqlServer, strSqlDb);
                    clsVhdx.UpdateRgVhdxAllocation(request.RgId, MdfHiPo.SetNum + 1, strSqlServer, strSqlDb);
                    ClsVmmDisks.ResizeVmDisk(ptrserver.VmmName, ptrserver.VmName, MdfHiPoDisk.VhdxPath, "500");
                    ClsVmmDisks.ResizeVmDisk(ptrserver.VmmName, ptrserver.VmName, LdfHiPoDisk.VhdxPath, "100");
                    ClsVmmDisks.ResizeVmDisk(ptrserver.VmmName, ptrserver.VmName, MdfStdDisk.VhdxPath, "500");
                    ClsVmmDisks.ResizeVmDisk(ptrserver.VmmName, ptrserver.VmName, LdfStdDisk.VhdxPath, "100");
                }
                var dbfilesetscp = ClsDbMoves.Getdbfile(request.PtrVmName, request.DbName);
                var dbdatafilesetcp = new Dbfilesets();
                var booldbfiles = dbfilesetscp.Count == 0;
                foreach (var dbfilesetcp in dbfilesetscp.Where(dbfilesetcp => !dbfilesetcp.Name.ToLower().EndsWith("_log")))
                {
                    dbdatafilesetcp = dbfilesetcp;
                }
                ClsDbMoves.MoveDb(request.DbName, dbdatafilesetcp.Path, dblogfileset.Path, sFpnOldDB, request.PtrVmName, request.Colation, sFpnOldLog, false);
                if (!booldbfiles)
                {
                    if (request.DbSize > int.Parse(dbdatafileset.Size))
                    {
                        Clsdb.ChangeDbSize(request.DbName, request.DbSize, request.DbSize,request.PtrVmName);
                    }
                }
                else
                {
                    Clsdb.ChangeDbSize(request.DbName, request.DbSize, request.DbSize,request.PtrVmName);
                }
                if (server.Env.ToLower() == "prod" && request.DboGroup != "")
                {
                    Clsdb.SetDbOwner(request.PtrVmName, request.DbName, request.DboGroup, true, server.Avail.ToLower() == "standard", server.Env.ToLower() == "prod", true, false, false,
                        request.SqlVer);
                }
                else if (server.Env.ToLower() == "nonprod" && request.DboGroup != "")
                {
                    Clsdb.SetDbOwner(request.PtrVmName, request.DbName, request.DboGroup, true, server.Avail.ToLower() == "standard", server.Env.ToLower() == "prod", true, false, false, request.SqlVer);
                }

                if (request.PwrUGroup != "")
                {
                    Clsdb.SetDbOwner(request.PtrVmName, request.DbName, request.PwrUGroup, false, server.Avail.ToLower() == "standard", server.Env.ToLower() == "prod", false, true, false,request.SqlVer);
                }
                if (request.StdUGroup != "")
                {
                    Clsdb.SetDbOwner(request.PtrVmName, request.DbName, request.StdUGroup, false, server.Avail.ToLower() == "standard", server.Env.ToLower() == "prod", false, false, true, request.SqlVer);
                }
                var sFpnburs = server.Env.ToLower() == "prod" ? ClsTimer.Settings.ProdShareUnc : ClsTimer.Settings.NonProdShareUnc;
                sFpnburs += "\\" + request.DbName + "\\staging";
                ClsFileSystem.CreateUNCFolder(sFpnburs);
                ClsDbAog.ProvisionAoServerOne(request.VmName, request.DbName, sFpnburs, request.ListenerName,
                    request.PtrVmName,
                    request.Ip, request.AogName);
                ClsDbAog.ProvisionAoServerTwo(request.PtrVmName, request.DbName, sFpnburs, request.AogName, request.VmName);
                if (request.Tde.ToLower() == "yes")
                {
                    Clsdb.EnableTDE(request.VmName, request.DbName);
                }
                ClsTenantSQLSvr.UpdateRgTable(server.PtrVmName, rgname, request.DbName);
                //var sUNCPathsc = "";
                //sUNCPathsc = server.Env.ToLower() == "prod" ? ClsTimer.Settings.ProdShareUNC + "\\" + request.DbName : ClsTimer.Settings.NonProdShareUNC + "\\" + request.DbName;
                //TODO: Fix the Shortcut creation
                //clsdb.createSQLShortcut(@"C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\Ssms.exe", sUNCPathsc, string.Format("-S {0} -d {1}", cAR.sServiceName, sDBName), sDBName);
                if (request.SwitchDc)
                {
                    Thread.Sleep(30000);
                    ClsDbAog.FailOverAog(request.PtrVmName, request.AogName);
                }
            }
            return true;
        }
    }
}
