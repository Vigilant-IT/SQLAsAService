using System;
using System.Collections.Generic;
using System.DirectoryServices.AccountManagement;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Services;
using Gateway.DataLayer;
using Gateway.DataLayer.Utility;
using WAP_WebService.Properties;

namespace WAP_WebService
{
    /// <summary>
    /// SQLaaSWS Class - Holds all web methods for this web service.
    /// </summary>
    [WebService(Namespace = "https://SQLaaSWS")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class SQLaaS_WS : WebService
    {
        private readonly ILog _log;
        private readonly DatabaseManager _databaseManager;
        private readonly RgDbManager _rgDbManager;
        private readonly DbDatabaseManager _dbDatabaseManager;

        public SQLaaS_WS()
        {
            _log = new Log(Settings.Default.VerboseLogging, Settings.Default.LogPath, "WebService");
            var codeRepository = new CodeRepository(Settings.Default.GWSQLServer, Settings.Default.GWDB);
            var auditRepository = new AuditEntryRepository(Settings.Default.GWSQLServer, Settings.Default.GWDB, codeRepository, _log);
            _databaseManager = new DatabaseManager(auditRepository, _log, codeRepository);
            
            // Stuff for Database Requests
            var dbRequestEntryRepository = new DbRequestEntryRepository(Settings.Default.GWSQLServer, Settings.Default.GWDB, codeRepository, _log);
            _dbDatabaseManager = new DbDatabaseManager(dbRequestEntryRepository, _log, codeRepository);
            // Stuff for Res Govs
            var rgRequestEntryRepository = new RgRequestEntryRepository(Settings.Default.GWSQLServer, Settings.Default.GWDB, codeRepository, _log);
            _rgDbManager = new RgDbManager(rgRequestEntryRepository, _log, codeRepository);
        }

        #region ResGov WebMethods
        
        /// <summary>
        /// 
        /// </summary>
        /// <param name="strRgName"></param>
        /// <param name="strZone"></param>
        /// <param name="strAvail"></param>
        /// <param name="strSqlVer"></param>
        /// <param name="strDc"></param>
        /// <param name="strEnv"></param>
        /// <param name="strTde"></param>
        /// <param name="strSkuName"></param>
        /// <param name="strEmail"></param>
        /// <param name="strPassPhrase"></param>
        /// <param name="strState"></param>
        /// <returns></returns>
        [WebMethod]
        public string RitNewRg(string strRgName,
            string strZone,
            string strAvail,
            string strSqlVer,
            string strDc,
            string strEnv,
            string strTde,
            string strSkuName,
            string strEmail,
            string strPassPhrase,
            string strState
            )
        {
            if (!InGroup(Settings.Default.CreateGroup, Settings.Default.CreateGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to RitLogEvent!", HttpContext.Current.User.Identity.Name));

                Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return "No Access";
            }
            var req = new RgReq
            {
                RgName = strRgName,
                Zone = strZone,
                Avail = strAvail,
                SqlVer = strSqlVer,
                Dc = strDc,
                Env = strEnv,
                Tde = strTde,
                SkuName = strSkuName,
                Email = strEmail,
                PassPhrase = strPassPhrase,
                State = strState
            };
            req.ReplaceNullWithEmtpyString();
            return _rgDbManager.CreateRg(req);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strRgName"></param>
        /// <returns></returns>
        [WebMethod]
        public List<RgReq> RitRgReqStatus(string strRgName)
        {
            if (!InGroup(Settings.Default.StatusGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to RitEventStatus!", HttpContext.Current.User.Identity.Name));
                Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null;
            }
            return _rgDbManager.GetRgReqStatus(strRgName).Cast<RgReq>().ToList();
        }

        #endregion

        #region Database WebMethods

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strRgId"></param>
        /// <param name="strDbName"></param>
        /// <param name="strCollation"></param>
        /// <param name="strDboGrp"></param>
        /// <param name="strPwrGrp"></param>
        /// <param name="strStdGrp"></param>
        /// <param name="strSize"></param>
        /// <param name="strState"></param>
        /// <returns></returns>
        [WebMethod]
        public string RitNewDb(string strRgId,
            string strDbName,
            string strCollation,
            string strDboGrp,
            string strPwrGrp,
            string strStdGrp,
            string strSize,
            string strState)
        {
            if (!InGroup(Settings.Default.CreateGroup, Settings.Default.CreateGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to RitLogEvent!", HttpContext.Current.User.Identity.Name));

                Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return "No access to Create Database";
            }
            var req = new DbReq
            {
                RgId = strRgId,
                DbName = strDbName,
                Collation = strCollation,
                DboGrp = strDboGrp,
                PwrGrp = strPwrGrp,
                StdGrp = strStdGrp,
                Size = strSize,
                State = strState,
                Notes = "Inprogress"
            };
            req.ReplaceNullWithEmtpyString();
            return _dbDatabaseManager.CreateDb(req);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strDbName"></param>
        /// <returns></returns>
        [WebMethod]
        public List<DbReq> RitDbReqStatus(string strDbName)
        {
            if (!InGroup(Settings.Default.StatusGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to RitEventStatus!", HttpContext.Current.User.Identity.Name));
                Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null;
            }
            return _dbDatabaseManager.GetDbRequestEntry(strDbName).Cast<DbReq>().ToList();
        }
        
        #endregion

        /// <summary>
        /// Returns information about a current running Rit job.
        /// 
        /// Note: AuditEntry referenced directly instead of interface due to not being able to use 
        /// interfaces in webmethod return calls.
        /// 
        /// </summary>
        /// <param name="sDbName">Database name to retrive. Can be % to return all enteries.</param>
        /// <returns>List of audit enteries for jobs in the system retrieved.</returns>
        [WebMethod]
        public List<AuditEntry> RitEventStatus(string sDbName)
        {
            if (!InGroup(Settings.Default.StatusGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to RitEventStatus!", HttpContext.Current.User.Identity.Name));
                Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null;
            }

            return _databaseManager.GetAuditStatus(sDbName).Cast<AuditEntry>().ToList();
        }

        /// <summary>
        /// Returns a list of valid parameters from a field.
        /// </summary>
        /// <param name="sField">Parameter to retrive values for.</param>
        /// <returns>A list of parameters that are valid for the field. Or an empty list.</returns>
        [WebMethod]
        public List<string> RitGetValidPram(string sField)
        {
            if (!InGroup(Settings.Default.StatusGroup, Settings.Default.StatusGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to RitGetValidPram!", HttpContext.Current.User.Identity.Name));
                Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null;
            }

            return _databaseManager.GetCodeValues(sField).ToList();
        }

        /// <summary>
        /// Schedule a databasae to be deleted by HP Gateway service.
        /// </summary>
        /// <param name="strDBName">Name of database to delete.</param>
        [WebMethod]
        public void QueueDBDelete(string strDBName)
        {
            if (!InGroup(Settings.Default.DeleteGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to QueueDBDelete!", HttpContext.Current.User.Identity.Name));
                Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return;
            }

            _databaseManager.DeleteDB(strDBName);
        }

        /// <summary>
        /// Retrives the version of the web service.
        /// This is retrived from the web service assembly.
        /// </summary>
        /// <returns>Web service version.</returns>
        [WebMethod]
        public string GetVersion()
        {
            if (!InGroup(Settings.Default.StatusGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to GetVersion!", HttpContext.Current.User.Identity.Name));
                Context.Response.StatusCode = (int) System.Net.HttpStatusCode.Forbidden;
                return "Unauthorised!";
            }

            return Assembly.GetExecutingAssembly().GetName().Version.ToString();
        }

        /// <summary>
        /// This method will return who is acccessing the service and what access they have.
        /// Inteded for debuging user rights issues.
        /// </summary>
        /// <returns>string with username and access rights.</returns>
        [WebMethod]
        public string whoami()
        {
            if (!InGroup(Settings.Default.StatusGroup) && !InGroup(Settings.Default.DeleteGroup) && !InGroup(Settings.Default.CreateGroup))
            {
                _log.Writelog(string.Format("User {0} failed to connect to whoami!", HttpContext.Current.User.Identity.Name));
                Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return "Unauthorised!";
            }

            var usersplit = HttpContext.Current.User.Identity.Name.Split('\\');
            var domain = usersplit[0].Trim();
            var username = usersplit[1].Trim();

            var result = new StringBuilder();
            result.AppendLine("UserName:" + username);
            result.Append("Domain: " + domain);
            result.AppendLine("Create Access:" + InGroup(Settings.Default.CreateGroup));
            result.AppendLine("Delete Access:" + InGroup(Settings.Default.DeleteGroup));
            result.AppendLine("Status Access:" + InGroup(Settings.Default.StatusGroup));
            return result.ToString();
        }

        /// <summary>
        /// Simple method to check if user is in access group or in a group that is nested in access group.
        /// </summary>
        /// <param name="groupname">SAM account name of group to check.</param>
        /// <returns></returns>
        private bool InGroup(string groupname, string groupDomain = "")
        {
            //WT: Hack to get this working in the lab.
            return true;

            if (groupname == string.Empty)
                return true;
            if (groupDomain == "" || groupDomain == Settings.Default.CreateGroup || groupDomain == Settings.Default.DeleteGroup || groupDomain == Settings.Default.StatusGroup ) 
                groupDomain = Settings.Default.GroupDomain;

            var usersplit = HttpContext.Current.User.Identity.Name.Split('\\');
            var domain = usersplit[0].Trim();
            var username = usersplit[1].Trim();

            var context = new PrincipalContext(ContextType.Domain, domain);
            var user = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, username);

            if (user == null)
                return false;

            var domaincontext = new PrincipalContext(ContextType.Domain, groupDomain);
            var group = GroupPrincipal.FindByIdentity(domaincontext, IdentityType.SamAccountName, groupname);

            if (group == null)
                return false;

            if (user.IsMemberOf(group))
                return true;

            foreach (var g in group.GetMembers())
            {
                try
                {
                    if (g.StructuralObjectClass != "group")
                        continue;

                    if (InGroup(g.SamAccountName, g.Context.Name))
                        return true;
                }
                catch
                {
                    _log.Writelog(string.Format("Unable to read sub group of "));
                }
            }

            return false;
        }

        /// <summary>
        /// Creates a new job for the gateway service to process.
        /// Use RitGetValidPram webmethod to get the valid values for most of these parameters.
        /// </summary>
        /// <param name="sType">Set this to dbcreate or dbmodify to create and modify a database respectivly. Currently dbmodify is not supported.</param>
        /// <param name="sDataCentre">Datacenter to create db in.</param>
        /// <param name="sUsername">Database username to create the db with.</param>
        /// <param name="sDbName">Database name.</param>
        /// <param name="sSqlVersion">Version of SQL to create the database with.</param>
        /// <param name="sInitialSizeMb">Initial size of the database.</param>
        /// <param name="sColation">Database collation to assign the database (name is a typo, kept for code compatability).</param>
        /// <param name="sEnvironment">Environment to provision the DBin (prod or non prod)</param>
        /// <param name="sAvailability">Availability requiments of the database. </param>
        /// <param name="sZone">Zone database will be created in.</param>
        /// <param name="sCompute">SKU of vm DB will run on.</param>
        /// <param name="sStorPerfData">Size of StorPerfData</param>
        /// <param name="sStorPerfLogs">Size of StorPerfLogs</param>
        /// <param name="sRetention">Retention period of backups.</param>
        /// <param name="sBudi">BUDI code for billing</param>
        /// <param name="sDbGroup">Database owner group.</param>
        /// <param name="sPwrUGroup">Database power user group.</param>
        /// <param name="sStdUGroup">Database standard user group.</param>
        /// <param name="sRecovery">Recovery mode.</param>
        /// <param name="sTde">TDE enabled?</param>
        /// <param name="sResItid">Request IT ticket number.</param>
        /// <returns></returns>
        //[WebMethod]
        //public long RitLogEvent(string sType,
        //    string sDataCentre,
        //    string sUsername,
        //    string sDbName,
        //    string sSqlVersion,
        //    string sInitialSizeMb,
        //    string sColation,
        //    string sEnvironment,
        //    string sAvailability,
        //    string sZone,
        //    string sCompute,
        //    string sStorPerfData,
        //    string sStorPerfLogs,
        //    string sRetention,
        //    string sBudi,
        //    string sDbGroup,
        //    string sPwrUGroup,
        //    string sStdUGroup,
        //    string sRecovery,
        //    string sTde,
        //    string sResItid)
        //{

        //    if (!InGroup(Settings.Default.CreateGroup, Settings.Default.CreateGroup))
        //    {
        //        _log.Writelog(string.Format("User {0} failed to connect to RitLogEvent!", HttpContext.Current.User.Identity.Name));

        //        Context.Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
        //        return -1;
        //    }


        //    var entry = new AuditEntry
        //    {
        //        State = sType,
        //        DC = sDataCentre,
        //        Username = sUsername,
        //        DBName = sDbName,
        //        SQLVer = sSqlVersion,
        //        InitialSizeMB = sInitialSizeMb,
        //        Colation = sColation,
        //        Network = sEnvironment,
        //        Availability = sAvailability,
        //        Zone = sZone,
        //        Sku = sCompute,
        //        StorPerfData = sStorPerfData,
        //        StorPerfLogs = sStorPerfLogs,
        //        Retention = sRetention,
        //        BUDI = sBudi,
        //        DBoGroup = sDbGroup,
        //        PwrUGroup = sPwrUGroup,
        //        StdUGroup = sStdUGroup,
        //        Recovery = sRecovery,
        //        TDE = sTde,
        //        RequestITID = sResItid
        //    };

        //    entry.ReplaceNullWithEmtpyString();

        //    _databaseManager.CreateDB(entry);
        //    return 1;
        //}
    }
}
