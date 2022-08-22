// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Management.Automation;
using System.Threading;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsHpgw
    {
        
        /// <summary>
        ///     is called by the timer to check if new request is in the list and starts the process
        /// </summary>
        public static void ProcEvent()
        {
            try
            {

                //WT: Disabled - There is a bug where lots of jobs come back for things already completed.
                //var rgReqs = clsRgReq.GetAllRgRequests(ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname);
                //if (rgReqs.Count != 0)
                //{
                //    foreach (var rgReq in rgReqs)
                //    {
                //        if (!rgReq.Notes.ToLower().StartsWith("completed"))
                //        {
                //            clsGwResGov.NewResGov(rgReq, ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname);
                //        }
                //    }
                //}

                var dbs = clsGwDb.GetPendingDbReq(ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname);
                if (dbs != null)
                {if (dbs.Count != 0)
                {
                    foreach (var db in dbs)
                    {
                        var dbreq = clsGwDb.GetDbReq(ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname, db);
                        clsGwDb.NewDb(dbreq, ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname);
                    }
                }}


                //var auditt = Audit.GetallAudit(ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname);
                //if (auditt.Count == 0) return;
                //foreach (var audit in auditt.Where(audit => !audit.State.ToLower().StartsWith("completed")))
                //{
                //    ClsLogfile.Writelog(string.Format("Found DB:{0} to process phase:{1}", audit.DBName, audit.State));
                //    try
                //    {
                //        //mdlMainLib.Status("Processing Event - " + dtRow.Field<string>("State").ToLower());
                //        Dbsettings gwSettings;
                //        switch (audit.State.ToLower())
                //        {
                            
                //            case "debug":
                //                string startcore;
                //                string endcore;
                                
                //                break;
                //        }
                        
                
                //    }
                //    catch (Exception)
                //    {
                //        return;
                //        //if (ex.Message.StartsWith("The availability replica for availability group"))
                //        //{ 
                //        //    ClsLogfile.writelog("BC Failover for NorWest DataBase Failed"); 
                //        //}
                //        //else
                //        //{
                //        //    ClsLogfile.writelog(3, "Error Message: " + ex.Message + Environment.NewLine + " Exception Stack" + ex.StackTrace);
                //        //    ClsAlocDB.SPUpdateAuditField(audit.DBName, "FAILED", "Notes", "Trapped with:" + ex.Message.Replace("'", "\""), true);
                //        //}
                //    }
                //}
                //ClsFileSystem.AgeOutFolders(ClsTimer.Settings.ProdShareUnc, 35, auditt, ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname);
                //ClsFileSystem.AgeOutFolders(ClsTimer.Settings.NonProdShareUnc, 35, auditt, ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname);
            }
            catch (Exception)
            {
                // ignored
            }
            //mdlMainLib.Status("Ready " + DateTime.Now.ToString("yyyy MM dd hh:mm:ss"));
        }

        }
}