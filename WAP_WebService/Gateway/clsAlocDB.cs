// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsAlocDB
    {
        /// <summary>
        ///     returns a clsalocrslt object which contains all of the information on how to provision the database which needs to
        ///     be obtained.
        /// </summary>
        /// <param name="sSQL"></param>
        /// <param name="sAvail"></param>
        /// <param name="sZone"></param>
        /// <param name="sEnv"></param>
        /// <param name="sDataCentre"></param>
        /// <param name="sSku"></param>
        /// <param name="sStorPerfData"></param>
        /// <param name="iStorSizeData"></param>
        /// <param name="sStorPerfLogs"></param>
        /// <param name="iStorSizeLogs"></param>
        /// <param name="sTDE"></param>
        /// <param name="iDbiD"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        //public static ClsAlocRslt GetPlan(string sSQL, string sAvail, string sZone, string sEnv, string sDataCentre,
        //    string sSku, string sStorPerfData, int iStorSizeData, string sStorPerfLogs, int iStorSizeLogs, string sTDE,
        //    int iDbiD,
        //    string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam(
        //        "sSQL, sAvail, sZone, sEnv, sDataCentre, sSku, sStorPerfData, iStorSizeData, sStorPerfLogs, iStorSizeLogs, sTDE, sSQLServer, sGwdb",
        //        sSQL, sAvail, sZone, sEnv, sDataCentre, sSku, sStorPerfData, iStorSizeData.ToString(), sStorPerfLogs,
        //        iStorSizeLogs.ToString(), sTDE, sSQLServer, sGwdb);

        //    var cAlocRslt = new ClsAlocRslt();
        //    if (string.IsNullOrEmpty(sSQL) || string.IsNullOrEmpty(sAvail) || string.IsNullOrEmpty(sZone) ||
        //        string.IsNullOrEmpty(sEnv) || string.IsNullOrEmpty(sDataCentre) || string.IsNullOrEmpty(sSku) ||
        //        string.IsNullOrEmpty(sStorPerfData))
        //    {throw new Exception("One or multiple Mandatory items are empty. Please review the submitted request.");}

        //    // This is a CSV list of DC, PM, VM, LunDB, LunLog
        //    ClsLogfile.Writelog(1, "Obtaining the Lun Details", true);
        //    cAlocRslt = GetDcvmLun(sZone, sEnv, sDataCentre, sSku, sSQL, sAvail, sStorPerfData, iStorSizeData,
        //        sStorPerfLogs,
        //        iStorSizeLogs, sTDE, iDbiD, sSQLServer, sGwdb);

        //    cAlocRslt.SPlan = string.Format("{0}_{1}_{2}_{3}_{4}_{5}",
        //        GetCodeAbrv("SQLVersion", sSQL, iDbiD, sSQLServer, sGwdb),
        //        GetCodeAbrv("DataCentre", cAlocRslt.SDc, iDbiD, sSQLServer, sGwdb),
        //        GetCodeAbrv("Environment", sEnv, iDbiD, sSQLServer, sGwdb),
        //        GetCodeAbrv("Availability", sAvail, iDbiD, sSQLServer, sGwdb),
        //        GetCodeAbrv("Zone", sZone, iDbiD, sSQLServer, sGwdb),
        //        cAlocRslt.SVm.Split('.')[0]);
        //    ClsLogfile.Writelog(1, "succeded getting DBSettings", true);
        //    return cAlocRslt;
        //}

        /// <summary>
        ///     Get the abbreviation for Plan elements
        /// </summary>
        /// <param name="sCode"></param>
        /// <param name="sValue"></param>
        /// <param name="iDbiD"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        //public static string GetCodeAbrv(string sCode, string sValue, int iDbiD, string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam("sCode, sValue, sSQLServer, sGwdb", sCode, sValue, sSQLServer, sGwdb);
        //    using (
        //        var sc =
        //            new SqlConnection(
        //                string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                    sSQLServer,
        //                    sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        var sStr = string.Format("Select Notes from Codes Where Code ='{0}' and Value ='{1}'",
        //            sCode, sValue);
        //        try
        //        {
        //            sc.Open();
        //            cmd.CommandText = sStr;
        //            var o = cmd.ExecuteScalar();
        //            sc.Close();
        //            ClsLogfile.Writelog(1, string.Format("Succeded in Obtaining the code details for: {0}", sCode), true);
        //            return o.ToString();
        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, string.Format("Failed to Obtain the code details for: {0}", sCode));
        //            Audit.SpUpdateAuditNotesField(iDbiD, sSQLServer, sGwdb,
        //                string.Format("Failed to Obtain the code details for: {0}", sCode));
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }
        //    }
        //}

        /// <summary>
        ///     Get the DC and the VM and LUNS
        /// </summary>
        /// <param name="sVpn"></param>
        /// <param name="sEnv"></param>
        /// <param name="sDc"></param>
        /// <param name="sSku"></param>
        /// <param name="sSQL"></param>
        /// <param name="sAvail"></param>
        /// <param name="sStorPerfData"></param>
        /// <param name="iStorSizeData"></param>
        /// <param name="sStorPerfLogs"></param>
        /// <param name="iStorSizeLogs"></param>
        /// <param name="sTDE"></param>
        /// <param name="iDbid"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
    //    public static ClsAlocRslt GetDcvmLun(string sVpn, string sEnv, string sDc, string sSku, string sSQL,
    //        string sAvail,
    //        string sStorPerfData, int iStorSizeData, string sStorPerfLogs, int iStorSizeLogs, string sTDE, int iDbid,
    //        string sSQLServer, string sGwdb)
    //    {
    //        ClsLogfile.Writelogparam(
    //            "sSQL, sAvail, sEnv, sStorPerfData, iStorSizeData, sStorPerfLogs, iStorSizeLogs, sTDE, sSQLServer, sGwdb",
    //            sSQL, sAvail,
    //            sEnv, sStorPerfData, iStorSizeData.ToString(), sStorPerfLogs, iStorSizeLogs.ToString(), sTDE,
    //            sSQLServer, sGwdb);
    //        if (sDc.ToLower() != "default")
    //        {
    //            ClsLogfile.Writelog(1, string.Format("Datacentre : {0} selected", sDc), true);
    //            var cAr = DcAvailPmvmLunAo(sDc, sVpn, sEnv, sSku, sSQL, sAvail, sStorPerfData, iStorSizeData,
    //                sStorPerfLogs,
    //                iStorSizeLogs, sTDE, iDbid, sSQLServer, sGwdb);
    //            cAr.SDc = sDc;
    //            return cAr;
    //        }
    //        else
    //        {
    //        // IF LOCATION is DEFAULT then choose between the sites, select site with most % core free, provided that there is space available
    //        ClsLogfile.Writelog(1, "No datacentre selected, using Default checks", true);
    //        var cArbw = DcAvailPmvmLunAo("Burwood", sVpn, sEnv, sSku, sSQL, sAvail, sStorPerfData, iStorSizeData,
    //            sStorPerfLogs, iStorSizeLogs, sTDE, iDbid, sSQLServer, sGwdb);
    //        var cArnw = DcAvailPmvmLunAo("Norwest", sVpn, sEnv, sSku, sSQL, sAvail, sStorPerfData, iStorSizeData,
    //            sStorPerfLogs, iStorSizeLogs, sTDE, iDbid, sSQLServer, sGwdb);
    //        if (cArbw.SVm != "" && cArnw.SVm != "")
    //        {
    //            // Can choose, what is the VCore loading of each site, take the least VCore loaded
    //            return DcLoadCore("Burwood", sSQL, sVpn, sEnv, sAvail, sTDE, sSQLServer, sGwdb) <
    //                   DcLoadCore("Norwest", sSQL, sVpn, sEnv, sAvail, sTDE, sSQLServer, sGwdb)
    //                ? cArbw
    //                : cArnw;
    //        }
    //        // Both were not available so take what is available
    //        return cArbw.SVm != "" ? cArbw : (cArnw.SVm != "" ? cArnw : new ClsAlocRslt());
    //    }
    //}

        /// <summary>
        ///     What is the VM and Luns that this should be loaded on for this DC
        /// </summary>
        /// <param name="sDc"></param>
        /// <param name="sVpn"></param>
        /// <param name="sEnv"></param>
        /// <param name="sSku"></param>
        /// <param name="sSQLVer"></param>
        /// <param name="sAvail"></param>
        /// <param name="sStorPerfData"></param>
        /// <param name="iSizeData"></param>
        /// <param name="sStorPerfLogs"></param>
        /// <param name="iSizeLogs"></param>
        /// <param name="sTDE"></param>
        /// <param name="iDbid"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        //public static ClsAlocRslt DcAvailPmvmLunAo(string sDc, string sVpn, string sEnv, string sSku, string sSQLVer,
        //    string sAvail, string sStorPerfData, int iSizeData, string sStorPerfLogs, int iSizeLogs, string sTDE,
        //    int iDbid,
        //    string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam(
        //        "sDC, sVPN, sEnv, sSKU, sSQLVer, sAvail, sStorPerfData, iSizeData, sStorPerfLogs, iSizeLogs, sTDE, sSQLServer, sGwdb",
        //        sDc,
        //        sVpn, sEnv, sSku, sSQLVer, sAvail, sStorPerfData, iSizeData.ToString(), sStorPerfLogs,
        //        iSizeLogs.ToString(), sTDE, sSQLServer, sGwdb);
        //    // Assume nothing is available
        //    var bBc = sAvail.ToLower() == "businesscritical";
        //    var SKU = clsSKU.GetSKU(sSQLServer, sGwdb, sSku);
        //    var cAlocRslt = new ClsAlocRslt();
        //    var sSQL =
        //        string.Format(
        //            "Select SCVMM, PMName, VMName, VMNameClusterPartner, VCore from VMSpec Where DC ='{0}' and Env ='{1}' and Zone ='{2}' and Avail ='{3}' and MSSQL ='{4}' and Expire >'{5}' and TDE = '{6}'",
        //            sDc,
        //            sEnv,
        //            sVpn,
        //            sAvail,
        //            sSQLVer,
        //            DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"),
        //            sTDE);
        //    var dt = new DataTable();
        //    using (
        //        var sc =
        //            new SqlConnection(
        //                string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                    sSQLServer, sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        sc.Open();
        //        cmd.CommandText = sSQL;
        //        try
        //        {
        //            dt.Load(cmd.ExecuteReader());
        //            ClsLogfile.Writelog(1, "getting data from VMSpec Table for Database type", true);
        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, "No Servers with the required Spec exist in the VMSpec Table (Before checking if there are Available CPU).");
        //            Audit.SpUpdateAuditNotesField(iDbid, sSQLServer, sGwdb,
        //                "No Servers with the required Spec exist in the VMSpec Table (Before checking if there are Available CPU).");
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }
        //        sc.Close();
        //    }
        //    if (dt.Rows.Count == 0)
        //    {
        //        ClsLogfile.Writelog(3, "No Servers with the required Spec exist in the VMSpec Table (Before checking if there are Available CPU).");
        //        Audit.SpUpdateAuditNotesField(iDbid, sSQLServer, sGwdb,
        //            "No Servers with the required Spec exist in the VMSpec Table (Before checking if there are Available CPU).");
        //        //exit back
        //        throw new Exception("No Servers with the required Spec exist in the VMSpec Table (Before checking if there are Available CPU).");
        //    }
        //    //else
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        var sScvmm = dr.Field<string>("SCVMM");
        //        var sVm = dr.Field<string>("VMName");
        //        var sVmcp = dr.Field<string>("VMNameClusterPartner");
        //        var o = dr.Field<int>("VCore");
        //        string sStatus;
        //        int iLun;
        //        int ibus;
        //        string sPm;
        //        ClsVmmDisks.GetVmmGuest(sScvmm, sVm, out iLun, out ibus, out sPm, out sStatus);
        //        var sSvceName = GetFreeAo(sVm, sAvail, sSQLServer, sGwdb);
        //        if (sSvceName[0] == "") continue;
        //        var lstVolStor = ClsGetVol.GetVolShare(sPm);
        //        if (int.Parse(SKU.CORES) <= o - GetCoreUsed(sVm, sSQLServer, sGwdb))
        //        {
        //            //TODO: pass in a Core Req for the SKU
        //            int startcore;
        //            int endcore;
        //            ClsTenantSQLSvr.GetAvilableResGovCoreFromTenentSvr(sVm, int.Parse(SKU.CORES), out startcore, out endcore);
        //            if (endcore != 0)
        //            {
        //                ClsLogfile.Writelog(1, string.Format("vCores available in {0} database", sGwdb), true);
        //                string sLunData = "", sLunLogs = "", sLunDataCp = "", sLunLogsCp = "";
        //                var sLuns = StorAvailable(lstVolStor, sPm, sVpn, sStorPerfData, iSizeData, sStorPerfLogs,
        //                    iSizeLogs);
        //                if (sLuns.Count == 2)
        //                {
        //                    if (!bBc)
        //                    {
        //                        sLunData = sLuns[0];
        //                        sLunLogs = sLuns[1];
        //                    }
        //                    else
        //                    {
        //                        // its a BC get the partner Name
        //                        string sCpVmm;
        //                        using (
        //                            var sc =
        //                                new SqlConnection(
        //                                    string.Format(
        //                                        "Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                                        sSQLServer, sGwdb)))
        //                        using (var cmd = sc.CreateCommand())
        //                        {
        //                            sc.Open();
        //                            cmd.CommandText =
        //                                string.Format("Select SCVMM from VMSpec Where VMName ='{0}' and Expire >'{1}'",
        //                                    sVmcp,
        //                                    DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
        //                            try
        //                            {
        //                                ClsLogfile.Writelog(1, "Obtaining the VMM Server for Cluster Partner", true);
        //                                sCpVmm = cmd.ExecuteScalar().ToString();
        //                            }
        //                            catch (Exception ex)
        //                            {
        //                                ClsLogfile.Writelog(3, "failed to obtain the VMM Server for Cluster Partner");
        //                                Audit.SpUpdateAuditNotesField(iDbid, sSQLServer, sGwdb,
        //                                    "Business Critical Partner not found in Gateway Database");
        //                                ClsLogfile.Writelog(3, ex.Message, true);
        //                                throw;
        //                            }
        //                            sc.Close();
        //                        }
        //                        string sPmcp;
        //                        //ClsVmmDisks.GetVmmGuest(sCpVmm, sVmcp, out iLun, out sPmcp, out sStatus);
        //                        //if (sPmcp != "")
        //                        //{
        //                        //    var lstVolStorCp = ClsGetVol.GetVolShare(sPmcp);
        //                        //    var sLunsCp = StorAvailable(lstVolStorCp, sPmcp, sVpn, sStorPerfData, iSizeData,
        //                        //        sStorPerfLogs, iSizeLogs);
        //                        //    if (sLunsCp.Count == 2)
        //                        //    {
        //                        //        sLunData = sLuns[0];
        //                        //        sLunLogs = sLuns[1];
        //                        //        sLunDataCp = sLunsCp[0];
        //                        //        sLunLogsCp = sLunsCp[1];
        //                        //    }
        //                        //}
        //                    }

        //                }

        //                if (!string.IsNullOrEmpty(sLunData))
        //                    // the Data for the primary lun will only have been populated if ALL the storage required was available
        //                {
        //                    cAlocRslt.SDc = sDc;
        //                    cAlocRslt.SScvmm = dr.Field<string>("SCVMM");
        //                    cAlocRslt.SPm = sPm;
        //                    cAlocRslt.SVm = dr.Field<string>("VMName");
        //                    cAlocRslt.SLunDB = sLunData;
        //                    cAlocRslt.SLunLog = sLunLogs;
        //                    cAlocRslt.SLunDbcp = sLunDataCp;
        //                    cAlocRslt.SLunLogCp = sLunLogsCp;
        //                    var ao = GetFreeAo(dr.Field<string>("VMName"), sAvail, sSQLServer, sGwdb);
        //                    cAlocRslt.SServiceName = ao[0];
        //                    if (sAvail == "BusinessCritical")
        //                    {
        //                        cAlocRslt.SIpAddr = ao[1];
        //                        cAlocRslt.SListenerName = ao[2];
        //                    }
        //                    else
        //                    {
        //                        cAlocRslt.SListenerName = "";
        //                        cAlocRslt.SIpAddr = "";
        //                    }
        //                    break;
        //                }
        //            }
        //            else
        //            {
        //                ClsLogfile.Writelog(3,string.Format("No Continous Cores avilable on SQL Server:{0}", sVm));
        //            }
        //        }
        //        else
        //        {
        //            ClsLogfile.Writelog(3, string.Format("vCores unavailable in {0} Records",sGwdb), true);
        //        }
        //    }
        //    return cAlocRslt;
        //}

        /// <summary>
        ///     Captures the drives which to create the Data and Log VHDx's
        /// </summary>
        /// <param name="lstVs"></param>
        /// <param name="sPm"></param>
        /// <param name="sVpn"></param>
        /// <param name="sStorPerfData"></param>
        /// <param name="iSizeData"></param>
        /// <param name="sStorPerfLogs"></param>
        /// <param name="iSizeLogs"></param>
        /// <returns></returns>
        //public static List<string> StorAvailable(List<ClsGetVol.VolStore> lstVs, string sPm, string sVpn,
        //    string sStorPerfData,
        //    int iSizeData, string sStorPerfLogs, int iSizeLogs)
        //{
        //    var lOut = new List<string>();
        //    var sCaption = lstVs.Aggregate("", (current, cap) => current + cap.Label + ":");
        //    ClsLogfile.Writelogparam("sPM, sVPN, sStorPerfData, iSizeData, sStorPerfLogs, iSizeLogs, sCaption", sPm,
        //        sVpn, sStorPerfData, iSizeData.ToString(), sStorPerfLogs, iSizeLogs.ToString(), sCaption);
        //    lOut.Add(GetFreeStor(lstVs, "data", sPm, sStorPerfData, iSizeData));
        //    lOut.Add(GetFreeStor(lstVs, "data", sPm, sStorPerfData, iSizeLogs));
        //    //TODO: change back to logs once available
        //    return lOut;
        //}

        ///// <summary>
        /////     What is the loading for this DC for Version, VPN and Env Available/Used
        ///// </summary>
        ///// <param name="sDc"></param>
        ///// <param name="sSQL"></param>
        ///// <param name="sVpn"></param>
        ///// <param name="sEnv"></param>
        ///// <param name="savail"></param>
        ///// <param name="sTDE"></param>
        ///// <param name="sSQLServer"></param>
        ///// <param name="sGwdb"></param>
        ///// <returns></returns>
        //public static double DcLoadCore(string sDc, string sSQL, string sVpn, string sEnv, string savail, string sTDE,
        //    string sSQLServer,
        //    string sGwdb)
        //{
        //    ClsLogfile.Writelogparam("sDC, sSQL, sVPN, sEnv, savail,  sTDE, sSQLServer, sGwdb", sDc, sSQL, sVpn, sEnv,
        //        savail, sTDE, sSQLServer,
        //        sGwdb);
        //    int o;
        //    using (var sc =
        //        new SqlConnection(
        //            string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                sSQLServer, sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        sc.Open();
        //        cmd.CommandText =
        //            string.Format(
        //                "Select sum(VCore) from VMSpec Where Expire >'{0}' and DC = '{1}' and MSSQL = '{2}' and Zone = '{3}' and Env = '{4}' and avail = '{5}' and TDE = '{6}'",
        //                DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"),
        //                sDc,
        //                sSQL,
        //                sVpn,
        //                sEnv,
        //                savail,
        //                sTDE);
        //        try
        //        {
        //            ClsLogfile.Writelog(1, "Obtaining number of vCores for ZONE", true);
        //            o = (int) cmd.ExecuteScalar();
        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, "Failed to obtain number of vCores for ZONE");
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }

        //        sc.Close();
        //    }

        //    var iTotl = o;
        //    if (iTotl == 0)
        //        return 100;
        //    int ob;
        //    using (var sc =
        //        new SqlConnection(
        //            string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                sSQLServer, sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        sc.Open();
        //        cmd.CommandText =
        //            string.Format(
        //                "Select isnull(sum(Used),0)  from VMUsed Inner Join VMSpec on VMSpec.VMName=VMUsed.VMName Where VMUsed.Expire >'{0}' and DC = '{1}' and MSSQL = '{2}' and Zone = '{3}' and Env = '{4}' and Avail = '{5}' and TDE = '{6}'",
        //                DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"),
        //                sDc,
        //                sSQL,
        //                sVpn,
        //                sEnv,
        //                savail,
        //                sTDE);
        //        try
        //        {
        //            ClsLogfile.Writelog(1, "Obtaining number of vCores used for ZONE", true);
        //            ob = (int) cmd.ExecuteScalar();
        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, "Failed to obtain number of vCores used for ZONE");
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }

        //        sc.Close();
        //    }
        //    var iUsed = ob;

        //    // ReSharper disable once PossibleLossOfFraction
        //    return iUsed/iTotl;
        //}

        /// <summary>
        ///     How many cores are allocated to this VM
        /// </summary>
        /// <param name="sVmName"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        //public static int GetCoreUsed(string sVmName, string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam("sVMName, sSQLServer, sGwdb", sVmName, sSQLServer, sGwdb);
        //    int iRslt;
        //    object o;
        //    using (var sc =
        //        new SqlConnection(
        //            string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                sSQLServer, sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        sc.Open();
        //        cmd.CommandText = string.Format("Select sum(Used) from VMUsed Where VMName ='{0}'", sVmName);
        //        try
        //        {
        //            ClsLogfile.Writelog(1, "Obtaining number of vCores used for Server", true);
        //            o = cmd.ExecuteScalar();
        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, "Failed to obtain number of vCores used for Server");
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }

        //        sc.Close();
        //    }

        //    if (o != DBNull.Value && int.TryParse(o.ToString(), out iRslt))
        //        return iRslt;
        //    return 0;
        //}

        /// <summary>
        ///     Confirms the vCPU which is required per SKU type
        /// </summary>
        /// <param name="sSku"></param>
        /// <returns></returns>
        //public static int GetCoreReqd(string sSku)
        //{
        //    ClsLogfile.Writelogparam("sSKU", sSku);
        //    var res = 0;
        //    switch (sSku.ToLower())
        //    {
        //        case "small":
        //            res = 1;
        //            break;
        //        case "medium":
        //            res = 2;
        //            break;
        //        case "large":
        //            res = 4;
        //            break;
        //        case "extralarge":
        //            res = 8;
        //            break;
        //        case "extralargehimem":
        //            res = 16;
        //            break;
        //    }
        //    return res;
        //}

        /// <summary>
        ///     Getting Free disk means looking at the underlying physical machine, return the LUN (Caption)
        /// </summary>
        /// <param name="lstVs"></param>
        /// <param name="sPurpose"></param>
        /// <param name="sPmName"></param>
        /// <param name="sStorPerf"></param>
        /// <param name="iSize"></param>
        /// <returns></returns>
        //public static string GetFreeStor(List<ClsGetVol.VolStore> lstVs, string sPurpose, string sPmName,
        //    string sStorPerf, int iSize)
        //{
        //    var sLun = "";
        //    foreach (var cVs in lstVs)
        //    {
        //        ClsLogfile.Writelogparam(
        //            "cVS.PM, sPMName, cVS.Performance, sStorPerf, cVS.Freespace, iSize, sPurpose, cVS.Purpose", cVs.Pm,
        //            sPmName, cVs.Performance, sStorPerf, cVs.Freespace.ToString(), iSize.ToString(), sPurpose.ToUpper(),
        //            cVs.Purpose.ToUpper());
        //        if (cVs.Pm != sPmName || cVs.Performance != sStorPerf || cVs.Freespace <= iSize ||
        //            !string.Equals(sPurpose, cVs.Purpose, StringComparison.CurrentCultureIgnoreCase)) continue;
        //        sLun = cVs.Caption;
        //        break;
        //    }
        //    return sLun;
        //}

        /// <summary>
        ///     Get a Free Always on Group
        /// </summary>
        /// <param name="sVmName"></param>
        /// <param name="serviceNameType"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        //public static List<string> GetFreeAo(string sVmName, string serviceNameType, string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam("sVMName, ServiceNameType, sSQLServer, sGwdb", sVmName, serviceNameType, sSQLServer,
        //        sGwdb);
        //    var aOsettings = new List<string>();
        //    using (var sc =
        //        new SqlConnection(
        //            string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                sSQLServer, sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        sc.Open();
        //        cmd.CommandText =
        //            string.Format(
        //                "Select ServiceName, IPAddr, ListenerName from NameSpec Where not exists (select ServiceName from NameUsed where NameSpec.ServiceName = NameUsed.ServiceName ) and ServiceNameType='{0}' and (VMNameBur='{1}' OR VMNameNor='{1}')",
        //                serviceNameType,
        //                sVmName);
        //        try
        //        {
        //            ClsLogfile.Writelog(1, "Obtaining a valid DNS address from GW", true);
        //            using (var dr = cmd.ExecuteReader())
        //            {
        //                while (dr.Read())
        //                {
        //                    aOsettings.Add(dr["ServiceName"].ToString());
        //                    aOsettings.Add(dr["IPAddr"].ToString());
        //                    aOsettings.Add(dr["ListenerName"].ToString());
        //                }
        //            }

        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, "Failed to obtain a valid DNS address from GW");
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }
        //        sc.Close();
        //    }
        //    return aOsettings;
        //}

        /// <summary>
        ///     Update the DB to reserve the elements allocated
        /// </summary>
        /// <param name="sDBName"></param>
        /// <param name="cAlocRslt"></param>
        /// <param name="sSku"></param>
        /// <param name="iStorSizeData"></param>
        /// <param name="iStorSizeLogs"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        /// <returns></returns>
        //public static bool ReserveAllocatedElememts(string sDBName, ClsAlocRslt cAlocRslt, string sSku,
        //    int iStorSizeData,
        //    int iStorSizeLogs, string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam("sDBName, sSku, iStorSizeData, iStorSizeLogs, sSQLServer, sGwdb", sDBName, sSku,
        //        iStorSizeData.ToString(), iStorSizeLogs.ToString(), sSQLServer, sGwdb);
        //    // reserve the Cores
        //    SpUpdateCoreUsed(sDBName, cAlocRslt.SVm, GetCoreReqd(sSku), sSQLServer, sGwdb);
        //    // reserve the Storage
        //    SpUpdateStorTypeUsed("Data", sDBName, cAlocRslt.SVm, cAlocRslt.SLunDB, iStorSizeData, sSQLServer, sGwdb);
        //    SpUpdateStorTypeUsed("Logs", sDBName, cAlocRslt.SVm, cAlocRslt.SLunLog, iStorSizeLogs, sSQLServer, sGwdb);
        //    // reserve the Storage Cluster Partner
        //    if (cAlocRslt.SLunDbcp != "")
        //    {
        //        SpUpdateStorTypeUsed("Data", sDBName, cAlocRslt.SVm, cAlocRslt.SLunDbcp, iStorSizeData, sSQLServer,
        //            sGwdb);
        //        SpUpdateStorTypeUsed("Logs", sDBName, cAlocRslt.SVm, cAlocRslt.SLunLogCp, iStorSizeLogs, sSQLServer,
        //            sGwdb);
        //    }
        //    // reserve the AOs
        //    SpUpdateAoUsed(cAlocRslt.SServiceName, sDBName, sSQLServer, sGwdb);
        //    return true;
        //}


        /// <summary>
        ///     Clean up NameUsed
        /// </summary>
        /// <param name="sDBName"></param>
        /// <returns></returns>
        public static bool SpDelNameUsed(string sDBName)
        {
            ClsLogfile.Writelogparam("sDBName", sDBName);
            return Clsdb.CheckSql(ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname,
                string.Format("DELETE FROM [NameUsed] WHERE db = '{0}'", sDBName));
        }

        /// <summary>
        ///     Clean up VMUsed
        /// </summary>
        /// <param name="sDBName"></param>
        /// <returns></returns>
        public static bool SpDelVmUsed(string sDBName)
        {
            ClsLogfile.Writelogparam("sDBName", sDBName);
            return Clsdb.CheckSql(ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname,
                string.Format("DELETE FROM [VMUsed] WHERE DBName = '{0}'", sDBName));
        }

        /// <summary>
        ///     Update the numbers of cores which have been used
        /// </summary>
        /// <param name="sDBName"></param>
        /// <param name="sVmName"></param>
        /// <param name="iUsed"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        //public static bool SpUpdateCoreUsed(string sDBName, string sVmName, int iUsed, string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam("sDBName, sVMName, iUsed, sSQLServer, sGwdb", sDBName, sVmName, iUsed.ToString(),
        //        sSQLServer, sGwdb);
        //    using (
        //        var sc =
        //            new SqlConnection(
        //                string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                    sSQLServer, sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        sc.Open();
        //        cmd.CommandText =
        //            string.Format("INSERT INTO VMUsed (VMName,DBName,Used,Expire) values ('{0}','{1}',{2},'{3}')",
        //                sVmName,
        //                sDBName,
        //                iUsed,
        //                DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
        //        bool res;
        //        try
        //        {
        //            ClsLogfile.Writelog(1, "Inserting details into the VMUsed Table in GW", true);
        //            res = cmd.ExecuteNonQuery() == 0;
        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, "Failed to insert details into the VMUsed Table in GW");
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }

        //        sc.Close();
        //        return res;
        //    }
        //}

        /// <summary>
        ///     Update the Storage which has been used.
        /// </summary>
        /// <param name="sType"></param>
        /// <param name="sDBName"></param>
        /// <param name="sVmName"></param>
        /// <param name="sLun"></param>
        /// <param name="iUsed"></param>
        /// <param name="sSQLServer"></param>
        /// <param name="sGwdb"></param>
        //public static bool SpUpdateStorTypeUsed(string sType, string sDBName, string sVmName, string sLun, int iUsed,
        //    string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam("sType, sDBName, sVMName, sLun, iUsed, sSQLServer, sGwdb", sType, sDBName, sVmName,
        //        sLun,
        //        iUsed.ToString(), sSQLServer, sGwdb);
        //    using (
        //        var sc =
        //            new SqlConnection(
        //                string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                    sSQLServer, sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        sc.Open();
        //        cmd.CommandText =
        //            string.Format(
        //                "INSERT INTO StorUsed (DBName,DataLog,Used,Date) values ('{0}','{1}','{2}','{3}')",
        //                sDBName,
        //                sType,
        //                iUsed,
        //                DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
        //        bool res;
        //        try
        //        {
        //            ClsLogfile.Writelog(1, "Inserting details into the StorUsed Table in GW", true);
        //            res = cmd.ExecuteNonQuery() == 0;
        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, "Failed to insert details into the StorUsed Table in GW");
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }
        //        sc.Close();
        //        return res;
        //    }
        //}

        ///// <summary>
        /////     Update the Always on groups used
        ///// </summary>
        ///// <param name="sAoGroup"></param>
        ///// <param name="sDBName"></param>
        ///// <param name="sSQLServer"></param>
        ///// <param name="sGwdb"></param>
        //public static bool SpUpdateAoUsed(string sAoGroup, string sDBName, string sSQLServer, string sGwdb)
        //{
        //    ClsLogfile.Writelogparam("sAOGroup, sDBName, sSQLServer, sGwdb", sAoGroup, sDBName, sSQLServer, sGwdb);
        //    if (string.IsNullOrEmpty(sAoGroup)) return true;
        //    using (
        //        var sc =
        //            new SqlConnection(
        //                string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
        //                    sSQLServer, sGwdb)))
        //    using (var cmd = sc.CreateCommand())
        //    {
        //        sc.Open();
        //        cmd.CommandText =
        //            string.Format("INSERT INTO NameUsed (ServiceName,DB,Expire) values ('{0}','{1}','{2}')",
        //                sAoGroup,
        //                sDBName,
        //                DateTime.Now.ToString("yyyyMMdd HH:mm:ss.fff"));
        //        bool res;
        //        try
        //        {
        //            ClsLogfile.Writelog(1, "Inserting details into the NameUsed Table in GW", true);
        //            res = cmd.ExecuteNonQuery() == 0;
        //        }
        //        catch (Exception ex)
        //        {
        //            ClsLogfile.Writelog(3, "Failed to insert details into the NameUsed Table in GW");
        //            ClsLogfile.Writelog(3, ex.Message, true);
        //            throw;
        //        }
        //        sc.Close();
        //        return res;
        //    }
        //}

        ///// <summary>
        /////     clsAlocRslt Defined
        ///// </summary>
        //public class ClsAlocRslt
        //{
        //    /// <summary>
        //    /// </summary>
        //    public string SAoGrup;

        //    /// <summary>
        //    /// </summary>
        //    public string SAttr;

        //    /// <summary>
        //    /// </summary>
        //    public string SDc;

        //    /// <summary>
        //    /// </summary>
        //    public string SIpAddr;

        //    /// <summary>
        //    /// </summary>
        //    public string SListenerName;

        //    /// <summary>
        //    /// </summary>
        //    public string SLunDB;

        //    /// <summary>
        //    /// </summary>
        //    public string SLunDbcp;

        //    /// <summary>
        //    /// </summary>
        //    public string SLunLog;

        //    /// <summary>
        //    /// </summary>
        //    public string SLunLogCp;

        //    /// <summary>
        //    /// </summary>
        //    public string SPlan;

        //    /// <summary>
        //    /// </summary>
        //    public string SPm;

        //    /// <summary>
        //    /// </summary>
        //    public string SScvmm;

        //    /// <summary>
        //    /// </summary>
        //    public string SServiceName;

        //    /// <summary>
        //    /// </summary>
        //    public string SVm;
        //}
    }
}