using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Management.Automation.Language;
using System.Security.Policy;
using System.Threading;

namespace Gateway
{
    class clsGwResGov
    {
        public static string SqlInfoMessage;

        internal class rgvm
        {
            public int SvrId { get; set; }
            public int PtrSvrId { get; set; }
            public string VMName { get; set; }
            public string VMMName { get; set; }
            public string PTRVMName { get; set; }
            public string PTRVMMName { get; set; }
            public int AvailCores { get; set; }
            public int StartCore { get; set; }
            public int EndCore { get; set; }
            public int MaxMem { get; set; }
            public int JobId { get; set; }
            public int PtrJobId { get; set; }

        }

        internal class Rg
        {
            public string SubID { get; set; }
            public string PlanID { get; set; }
            public string RGName { get; set; }
            public string ServerName { get; set; }
            public int MdfBus { get; set; }
            public int MdfLun { get; set; }
            public string MdfPath { get; set; }
            public int LdfBus { get; set; }
            public int LdfLun { get; set; }
            public string LdfPath { get; set; }
            public int StartCore { get; set; }
            public int EndCore { get; set; }
            public string VmHost { get; set; }
            public string VmStatus { get; set; }
            public int VhdxSetNum { get; set; }

        }

        public static bool NewResGov(clsRgReq.RgReq request, string strSqlServer, string strSqlDb)
        {
            //clsPoSH.ResetPoshSessions("740hvt02p001");
            //clsPoSH.ResetPoshSessions("740vmm02v001");
            if (string.IsNullOrEmpty(request.RgName))
            {
                ClsLogfile.Writelog(3, "No ResGov Name Provided");
                throw new Exception("No ResGov Name Provided");
            }
            if (string.IsNullOrEmpty(request.Zone))
            {
                ClsLogfile.Writelog(3, "No Zone provided");
                throw new Exception("No Zone Provided");
            }
            if (string.IsNullOrEmpty(request.Avail))
            {
                ClsLogfile.Writelog(3, "No Availability definition provided");
                throw new Exception("No Availability definition provided");
            }
            if (string.IsNullOrEmpty(request.SqlVer))
            {
                ClsLogfile.Writelog(3, "No SQL Version Provided");
                throw new Exception("No SQL Version Provided");
            }
            if (string.IsNullOrEmpty(request.Dc))
            {
                ClsLogfile.Writelog(3, "No Datacentre Provided");
                throw new Exception("No Datacentre Provided");
            }
            if (string.IsNullOrEmpty(request.Env))
            {
                ClsLogfile.Writelog(3, "No Environment Provided");
                throw new Exception("No Environment Provided");
            }
            if (string.IsNullOrEmpty(request.Tde))
            {
                ClsLogfile.Writelog(3, "No TDE provided");
                throw new Exception("No TDE provided");
            }
            //var bBc = request.Avail.ToLower() == "businesscritical";
            var tensvr = new rgvm();
            var sku = clsSKU.GetSKU(strSqlServer, strSqlDb, request.SkuName);
            var vms = new List<rgvm>();

            //if (bBc && request.Dc != "Burwood") request.Dc = "Burwood";
            vms = getAvilVms(request.Zone, request.Avail, request.SqlVer, request.Dc != "Default" ? request.Dc : "%", request.Env, request.Tde, int.Parse(sku.CORES), strSqlServer, strSqlDb);
            if (vms.Count != 0)
            {
                foreach (rgvm vm in vms)
                {
                    //Hack to get linux working
                    if (request.SqlVer == "linux")
                    {
                        tensvr = vm;
                        tensvr.StartCore = 2;
                        tensvr.EndCore = 10;
                        break;
                    }

                    if (vm.AvailCores > 0)
                    {
                        int startcore;
                        int endcore;
                        ClsTenantSQLSvr.GetAvilableResGovCoreFromTenentSvr(vm.VMName, int.Parse(sku.CORES),
                            out startcore,
                            out endcore);
                        if (endcore != 0)
                        {
                            tensvr = vm;
                            tensvr.StartCore = startcore;
                            tensvr.EndCore = endcore;
                            break;
                        }
                    }
                    else
                    {
                        throw new Exception(string.Format("No Cores found for {0}Zone:{1},{0}Availability:{2},{0}SQLVersion:{3},{0}DataCentre:{4},{0}Environment:{5},{0}TDE:{6}",
                            Environment.NewLine,
                            request.Zone,
                            request.Avail,
                            request.SqlVer,
                            request.Dc,
                            request.Env,
                            request.Tde));
                    }
                }
                if (string.IsNullOrEmpty(tensvr.VMName))
                {
                    throw new Exception(
                        string.Format(
                            "No Contiguios Cores Avilable for Configuration on servers with the following Configuration. Size too big.{0}Zone:{1},{0}Availability:{2},{0}SQLVersion:{3},{0}DataCentre:{4},{0}Environment:{5},{0}TDE:{6}",
                            Environment.NewLine,
                            request.Zone,
                            request.Avail,
                            request.SqlVer,
                            request.Dc,
                            request.Env,
                            request.Tde));
                }
                clsRgJob.AddRgJob(strSqlServer, strSqlDb, request.ReqId, tensvr.SvrId);
                tensvr.JobId = clsRgJob.GetRgJodId(strSqlServer, strSqlDb, request.ReqId, tensvr.SvrId);
                tensvr.PtrJobId = 0;
                if (tensvr.JobId == 0)
                    throw new Exception(string.Format("Could not find JobId for RG:{0} and ServerID:{1}", request.ReqId,
                        tensvr.SvrId));
                //if (bBc)
                //{
                //    var strptr = GetVmmHost(tensvr.VMName, strSqlServer, strSqlDb);
                //    tensvr.PTRVMMName = strptr.Split('|')[1];
                //    tensvr.PtrSvrId = int.Parse(strptr.Split('|')[0]);
                //    clsRgJob.AddRgJob(strSqlServer, strSqlDb, request.ReqId, tensvr.PtrSvrId);
                //    tensvr.PtrJobId = clsRgJob.GetRgJodId(strSqlServer, strSqlDb, request.ReqId, tensvr.PtrSvrId);
                //    if (tensvr.PtrJobId == 0)
                //        throw new Exception(string.Format("Could not find JobId for RG:{0} and ServerID:{1}",
                //            request.ReqId, tensvr.PtrSvrId));
                //}
                clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "StartCore", tensvr.StartCore.ToString());
                if (tensvr.PtrJobId != 0)
                    clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.PtrJobId, "StartCore",
                        tensvr.StartCore.ToString());
                clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "EndCore", tensvr.EndCore.ToString());
                if (tensvr.PtrJobId != 0)
                    clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.PtrJobId, "EndCore", tensvr.EndCore.ToString());
                tensvr.MaxMem = int.Parse(sku.MEMORY);
                var rgConfig = ProcessRequest(tensvr, request, false, strSqlServer, strSqlDb);
                rgConfig.StartCore = tensvr.StartCore;
                rgConfig.EndCore = tensvr.EndCore;
                rgConfig.ServerName = tensvr.VMName;
                rgConfig.RGName = request.RgName;
                clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "Notes", "Completed");
                if (tensvr.PtrJobId != 0)
                {
                    var ptrrgconfig = ProcessRequest(tensvr, request, true, strSqlServer, strSqlDb);
                    ptrrgconfig.StartCore = tensvr.StartCore;
                    ptrrgconfig.EndCore = tensvr.EndCore;
                    ptrrgconfig.ServerName = tensvr.VMName;
                    ptrrgconfig.RGName = request.RgName;
                    clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.PtrJobId, "Notes", "Completed");
                }
                var ResGovConfig = new clsRgConfig.RgConfig
                {
                    RgName = request.RgName,
                    SvrId = tensvr.SvrId,
                    SkuId = int.Parse(sku.SKUID),
                    PassPhrase = request.RgPassPhrase,
                    SubId = rgConfig.SubID,
                    PlanId = rgConfig.PlanID,
                    StartCore = tensvr.StartCore,
                    EndCore = tensvr.EndCore,
                    VhdxSetNum = 0,
                    RgId = request.ReqId
                };
                clsRgConfig.NewRgConfig(strSqlServer, strSqlDb, ResGovConfig);
            }
            return true;
        }

        public static Rg ProcessRequest(rgvm tensvr, clsRgReq.RgReq request, bool bolPTR, string strSqlServer,
            string strSqlDb)
        {
            //var sk = clsSKU.GetSKU(strSqlServer, strSqlDb, request.SkuName);
            var rg = new Rg();
            if (bolPTR)
            {
                tensvr.VMName = tensvr.PTRVMName;
                tensvr.VMMName = tensvr.PTRVMMName;
                tensvr.JobId = tensvr.PtrJobId;
            }
            var maxmempercent = int.Parse(DBResGov.CalcMemPercent(tensvr.VMName, tensvr.MaxMem).ToString());
            try
            {
                //var MdfHiPoDisk = clsVhdx.AttachNewVhdxToRg(tensvr.VMName, tensvr.VMMName, "Data",
                //    "HighPerformance", request.SqlVer, 0, request.RgName, strSqlServer,
                //    strSqlDb);
                //var MdfStdDisk = clsVhdx.AttachNewVhdxToRg(tensvr.VMName, tensvr.VMMName, "Data",
                //    "Standard", request.SqlVer, 0, request.RgName, strSqlServer,
                //    strSqlDb);
                //var LdfHiPoDisk = clsVhdx.AttachNewVhdxToRg(tensvr.VMName, tensvr.VMMName, "Log",
                //    "HighPerformance", request.SqlVer, 0, request.RgName, strSqlServer,
                //    strSqlDb);
                //var LdfStdDisk = clsVhdx.AttachNewVhdxToRg(tensvr.VMName, tensvr.VMMName, "Log",
                //    "Standard", request.SqlVer, 0, request.RgName, strSqlServer,
                //    strSqlDb);
                //MdfHiPoDisk.RgId = LdfHiPoDisk.RgId = MdfStdDisk.RgId = LdfStdDisk.RgId = request.ReqId;
                //MdfHiPoDisk.VhdxSetNum = LdfHiPoDisk.VhdxSetNum = MdfStdDisk.VhdxSetNum = LdfStdDisk.VhdxSetNum = 0;
                //MdfHiPoDisk.SvrId = LdfHiPoDisk.SvrId = MdfStdDisk.SvrId = LdfStdDisk.SvrId = tensvr.SvrId;
                //MdfHiPoDisk.CurrentPrimary = LdfHiPoDisk.CurrentPrimary = MdfStdDisk.CurrentPrimary = LdfStdDisk.CurrentPrimary = 1;
                //clsVhdx.AddNewVhdxToGwDb(MdfHiPoDisk, strSqlServer, strSqlDb);
                //clsVhdx.AddNewVhdxToGwDb(LdfHiPoDisk, strSqlServer, strSqlDb);
                //clsVhdx.AddNewVhdxToGwDb(MdfStdDisk, strSqlServer, strSqlDb);
                //clsVhdx.AddNewVhdxToGwDb(LdfStdDisk, strSqlServer, strSqlDb);
                //clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "VHDXAllocated", DateTime.Now.ToString());
                if (!DBResGov.AllocateResourceGov(tensvr.VMName, request.RgName, tensvr.StartCore, tensvr.EndCore, request.SqlVer, maxmempercent)) throw new Exception(string.Format("Error creating Resoruce Govenor:{0} on server:{1}", request.RgName, tensvr.VMName));
                if (!ClsTenantSQLSvr.AllocateRGCores(tensvr.VMName, request.RgName, tensvr.StartCore, tensvr.EndCore)) throw new Exception(string.Format("Error updating core allocation on SQL Server:{0}", tensvr.VMName));
                if (!boolUpdateCoreUsed(request.RgName, tensvr.VMName, tensvr.EndCore - tensvr.StartCore, strSqlServer, strSqlDb)) throw new Exception(string.Format("Could not update the Cores allocated to Cluster Partner:{0}", tensvr.PTRVMName));
                ClsTenantSQLSvr.AllocateRGCores(tensvr.VMName, request.RgName, tensvr.StartCore, tensvr.EndCore);
                clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "RGAllocated", DateTime.Now.ToString());
                //if (!bolPTR)
                //{
                    if (ClsUsers.GetUser(request.Email, ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer,
                        ClsTimer.Settings.SignedCert) == null)
                    {
                        if (ClsUsers.PS_AddAPUser(request.Email, ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer,
                            ClsTimer.Settings.SignedCert).Count == 0) throw new Exception(string.Format("User:{0} not created", request.Email));
                        clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "WapUserAllocated", DateTime.Now.ToString());
                    }
                    var strPlanShortName = string.Format("{0}_{1}_{2}_{3}_{4}_{5}_{6}",
                    GetCodeAbrv("SQLVersion", request.SqlVer, strSqlServer, strSqlDb),
                    GetCodeAbrv("DataCentre", request.Dc, strSqlServer, strSqlDb),
                    GetCodeAbrv("Environment", request.Env, strSqlServer, strSqlDb),
                    GetCodeAbrv("Availability", request.Avail, strSqlServer, strSqlDb),
                    GetCodeAbrv("Zone", request.Zone, strSqlServer, strSqlDb),
                    tensvr.VMName.Split('.')[0],
                    request.RgName);

                    clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "PlanShortName", strPlanShortName);
                    var lstPlan = ClsPlans.PS_GetPlan(strPlanShortName, false, ClsTimer.Settings.AdminServer,
                        ClsTimer.Settings.AuthServer,
                        ClsTimer.Settings.SignedCert) ??
                                  ClsPlans.PS_AddPlan(strPlanShortName, ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer,
                                      ClsTimer.Settings.SignedCert);
                    rg.PlanID = lstPlan[0].Id;
                    if (lstPlan[0].ServiceQuotas.Count == 0)
                    {
                        ClsPlans.PS_AddRP2Plan(lstPlan[0].Id, "sqlservers", ClsTimer.Settings.AdminServer,
                            ClsTimer.Settings.AuthServer, ClsTimer.Settings.SignedCert);
                        ClsPlans.PS_AddRPGrp2Plan(lstPlan[0].Id, "sqlservers", strPlanShortName,
                            ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer, ClsTimer.Settings.SignedCert);
                        clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "WapPlanAllocated", DateTime.Now.ToString());
                        //ClsLogfile.writelogparam("sDBName, sEvnt, bNewline", sDBName, "Added");
                    }
                    var lstSubDetl = ClsSubscriptions.GetApSubbyPlanId(rg.PlanID, ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer, ClsTimer.Settings.SignedCert);
                    rg.SubID = lstSubDetl == null
                        ? ClsSubscriptions.AddApSub(request.Email, rg.PlanID,
                            strPlanShortName + "_" + request.RgName, ClsTimer.Settings.AdminServer,
                            ClsTimer.Settings.AuthServer, ClsTimer.Settings.SignedCert).Id
                        : lstSubDetl.Id;
                    clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "WapSubAllocated", DateTime.Now.ToString());
                    var sUncPath = request.Env.ToLower() == "prod" ? ClsTimer.Settings.ProdShareUnc + "\\" + request.RgName : ClsTimer.Settings.NonProdShareUnc + "\\" + request.RgName;
                    ClsFileSystem.CreateUNCFolder(sUncPath);
                    ClsFileSystem.CreateUNCFolder(sUncPath + "\\reports");
                    if (request.Avail.ToLower() == "businesscritical")
                    {
                        ClsFileSystem.CreateUNCFolder(sUncPath + "\\staging");
                        ClsFileSystem.AssignFolderPerms(sUncPath + "\\staging", Clsdb.GetSqlServiceAcc(tensvr.VMName),true,false,false);
                    }
                //}
                return rg;
            }
            catch (Exception ex)
            {
                //clsRgJob.UpdateRgJob(strSqlServer, strSqlDb, tensvr.JobId, "Notes", ex.Message.ToString());
                //TODO: Add checks to see if the exists before attempting to delete them!
                if(!ClsSubscriptions.RemoveApSub(rg.SubID, ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer,
                    ClsTimer.Settings.SignedCert)) throw new Exception(string.Format("Could not delete Subscription id:{0}",rg.SubID));
                if(!ClsPlans.PS_DeletePlan(rg.PlanID,ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer, ClsTimer.Settings.SignedCert)) throw new Exception(string.Format("Could not delete Plan ID:{0}",rg.PlanID));
                ClsUsers.PS_RemoveAPUser(request.Email, ClsTimer.Settings.AdminServer, ClsTimer.Settings.AuthServer, ClsTimer.Settings.SignedCert);
                if(!DBResGov.RemoveResGov(tensvr.VMName,request.RgName))throw new Exception(string.Format("Could not delete Res Gov object:{0} from SQL Server:{1}",request.RgName,tensvr.VMName));
                if(!ClsTenantSQLSvr.UnallocateRGCores(tensvr.VMName,request.RgName)) throw new Exception(string.Format("Error deallocating cores from server:{0} for RG:{1}", tensvr.VMName,request.RgName));
                if(!ClsAlocDB.SpDelVmUsed(tensvr.VMName)) throw new Exception(string.Format("Could not deallocate cores in the {0} for Res Gov:{1}", strSqlDb,request.RgName));
                if(!ClsVmmDisks.Unmount(tensvr.VMName,request.RgName,request.SqlVer)) throw new Exception(string.Format("Could not unmount Disk for RG:{0} from VM:{1}",request.RgName,tensvr.VMName));
                if(!ClsVmmDisks.RemoveVhdx(tensvr.VMName,tensvr.VMMName,request.RgName))throw new Exception(string.Format("Could not remove VHDX for RG:{0} on VM:{1}",request.RgName,tensvr.VMName));
                //TODO: If folder containing VHDX empty Remove it
                throw;
            }
          
        }

        public static List<rgvm> getAvilVms(string strZone, string strAvail, string strSqlVer, string strDc,
            string strEnv, string strTde, int intReqCores, string strSqlServer, string strSqlDb)
        {

            //WT: Hack to get linux vm.
            if (strSqlVer == "linux")
                return new List<rgvm> {
                    new rgvm{
                        SvrId = 5,
                        VMMName = "740vmm02v001.sqlaas.lab",
                        VMName = "linsql",
                        AvailCores = 20,
                        StartCore = 0,
                        EndCore = 20,
                        MaxMem = 10
                    }
                };


            var res = new List<rgvm>();
            var sSQL =
                string.Format(
                    "Select SCVMM, spec.VMName, VMNameClusterPartner, VCore, spec.ID, DC, case when ((vcore - sum(isnull(used,0)) - {0})) >= 0 then 1 else 0 end  as 'Core Available' " +
                    "from VMSpec as spec full join VMUsed as used on spec.VMName = used.VMName " +
                    "Where Env ='{1}' and Zone ='{2}' and Avail ='{3}' and MSSQL ='{4}' and spec.Expire >'{5}' and TDE = '{6}' and DC like '{7}' " +
                    "group by spec.VMName, SCVMM, VCore, used,spec.id,VMNameClusterPartner, DC",
                    intReqCores,
                    strEnv,
                    strZone,
                    strAvail,
                    strSqlVer,
                    DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"),
                    strTde,
                    strDc);
            var dt = new DataTable();
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = sSQL;
                try
                {
                    dt.Load(cmd.ExecuteReader());
                    ClsLogfile.Writelog(1, string.Format("getting data from VMSpec Table for Database type{0}Zone:{1},{0}Availability:{2},{0}SQLVersion:{3},{0}DataCentre:{4},{0}Environment:{5},{0}TDE:{6}", 
                    Environment.NewLine, 
                    strZone, 
                    strAvail, 
                    strSqlVer,
                    strDc,
                    strEnv, 
                    strTde), true);
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, string.Format("No Cores Avilable for Configuration{0}Zone:{1},{0}Availability:{2},{0}SQLVersion:{3},{0}DataCentre:{4},{0}Environment:{5},{0}TDE:{6}",
                    Environment.NewLine,
                    strZone,
                    strAvail,
                    strSqlVer,
                    strDc,
                    strEnv,
                    strTde));
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
                if (dt.Rows.Count ==0) {throw new Exception(string.Format("No Cores Avilable for Configuration{0}Zone:{1},{0}Availability:{2},{0}SQLVersion:{3},{0}DataCentre:{4},{0}Environment:{5},{0}TDE:{6}", 
                    Environment.NewLine, 
                    strZone, 
                    strAvail, 
                    strSqlVer,
                    strDc,
                    strEnv, 
                    strTde));}
                res.AddRange(from DataRow vm in dt.Rows
                    select new rgvm
                    {
                        SvrId = vm.Field<int>("ID"),
                        VMName = vm.Field<string>("VMName"),
                        VMMName = vm.Field<string>("SCVMM"),
                        PTRVMName = vm.Field<string>("VMNameClusterPartner"),
                        AvailCores = vm.Field<int>("Core Available")
                    });
             }
            return res;
        }

        public static string GetVmmHost(string strVM, string strSqlServer, string strSqlDb)
        {
            var resout = "";
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("Select SCVMM, ID from VMSpec Where VMName ='{0}'", strVM);
                try
                {
                    var res = cmd.ExecuteReader();
                    while (res.Read())
                    {
                        resout = res["ID"] + "|" + res["SCVMM"];
                    }
                    ClsLogfile.Writelog(1, string.Format("Getting VMM Server for VM:{0}", strVM), true);
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, string.Format("failed to get VMM Server for VM:{0}", strVM));
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
                sc.Close();
                return resout;
            }
        }
        
        public static bool boolUpdateCoreUsed(string strRgName, string strVmName, int intUsed, string strSQLServer, string strSqlDb)
        {
            ClsLogfile.Writelogparam("strRgName, strVmName, intUsed, strSQLServer, strSqlDb", strRgName, strVmName, intUsed.ToString(),
                strSQLServer, strSqlDb);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSQLServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    string.Format("INSERT INTO VMUsed (VMName,DBName,Used,Expire) values ('{0}','{1}',{2},'{3}')",
                        strVmName,
                        strRgName,
                        intUsed,
                        DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
                try
                {
                    ClsLogfile.Writelog(1, "Inserting details into the VMUsed Table in GW", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to insert details into the VMUsed Table in GW");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }

                sc.Close();
                return SqlInfoMessage == null;
            }
        }
        
        public static string GetCodeAbrv(string sCode, string sValue, string sSQLServer, string sGwdb)
        {
            ClsLogfile.Writelogparam("sCode, sValue, sSQLServer, sGwdb", sCode, sValue, sSQLServer, sGwdb);
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            sSQLServer,
                            sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                var sStr = string.Format("Select Notes from Codes Where Code ='{0}' and Value ='{1}'",
                    sCode, sValue);
                try
                {
                    sc.Open();
                    cmd.CommandText = sStr;
                    var o = cmd.ExecuteScalar();
                    sc.Close();
                    ClsLogfile.Writelog(1, string.Format("Succeded in Obtaining the code details for: {0}", sCode), true);
                    return o.ToString();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, string.Format("Failed to Obtain the code details for: {0}", sCode));
                    ClsLogfile.Writelog(3, ex.Message, true);
                    throw;
                }
            }
        }

        public static Rg getRgDetails()
        {
            return null;
        }
        
        static void conn_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            SqlInfoMessage = e.Message;
        }
    }
}
