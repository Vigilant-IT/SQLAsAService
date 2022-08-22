// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Management.Automation;
using System.Runtime.Serialization;
using Microsoft.WindowsAzure.Server.Management;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsPlans
    {
        /// <summary>
        /// </summary>
        /// <param name="sSvrName"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static List<Plan> PS_GetPlansForServer(string sSvrName, string sAdminSite, string sAuthSite,
            bool bSignedCert)
        {
            var lplan = new List<Plan>();
            ClsLogfile.Writelogparam("sSvrName, sAdminSite, sAuthSite, bSignedCert", sSvrName,
                sAdminSite, sAuthSite, bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Get-MgmtSvcPlan");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter("DisplayName", string.Format("*{0}*", sSvrName));
            if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining Plans For Server Name", true);
                var results = ps.Invoke();
                if (results.Count == 0)
                {
                    ClsLogfile.Writelog(1, "No Plans", true);
                }

                foreach (var result in results)
                {
                    var pl = new Plan
                    {
                        Id = result.Members["Id"].Value.ToString(),
                        DisplayName = result.Members["DisplayName"].Value.ToString(),
                        ServerName = sSvrName
                    };
                    int i;
                    int.TryParse(result.Members["SubscriptionCount"].Value.ToString(), out i);
                    pl.SubscriptionCount = i;
                    var lsq = ((IEnumerable) result.Members["ServiceQuotas"].Value).Cast<ServiceQuota>().ToList();
                    pl.ServiceQuotas = lsq;
                    lplan.Add(pl);
                }
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed tp obtain Plans For Server Name", true);
            }
            ps.Dispose();
            return lplan;
        }

        /// <summary>
        /// </summary>
        /// <param name="sPlan"></param>
        /// <param name="bPid"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static List<Plan> PS_GetPlan(string sPlan, bool bPid, string sAdminSite, string sAuthSite,
            bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sPlan, bPid, sAdminSite, sAuthSite, bSignedCert", sPlan, bPid.ToString(),
                sAdminSite, sAuthSite, bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Get-MgmtSvcPlan");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter(bPid ? "PlanID" : "DisplayName", sPlan);
            if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining Plans", true);
                var results = ps.Invoke();
                if (results.Count == 0)
                {
                    ClsLogfile.Writelog(1, "No Plans", true);
                    return null;
                }
                var lplan = new List<Plan>();

                foreach (var result in results)
                {
                    var pl = new Plan
                    {
                        Id = result.Members["Id"].Value.ToString(),
                        DisplayName = result.Members["DisplayName"].Value.ToString()
                    };
                    int i;
                    int.TryParse(result.Members["SubscriptionCount"].Value.ToString(), out i);
                    pl.SubscriptionCount = i;
                    var lsq = ((IEnumerable) result.Members["ServiceQuotas"].Value).Cast<ServiceQuota>().ToList();
                    pl.ServiceQuotas = lsq;
                    lplan.Add(pl);
                }
                ps.Dispose();
                return lplan;
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed tp obtain Plans", true);
                ps.Dispose();
                return null;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="sPlanName"></param>
        /// <param name="sService"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static bool PS_AddRP2Plan(string sPlanName, string sService, string sAdminSite, string sAuthSite,
            bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sPlanName, sService, sAdminSite, sAuthSite, bSignedCert", sPlanName, sService,
                sAdminSite, sAuthSite, bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Add-MgmtSvcPlanService");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
            var rp = PS_GetSQLResPro(sService, sAdminSite, sAuthSite, bSignedCert)[0];
            if (rp.Id != "")
            {
                command.AddParameter("InstanceId", rp.Id);
                command.AddParameter("ServiceName", rp.Name);
                command.AddParameter("PlanId", sPlanName);
                ps.Commands = command;
                Collection<PSObject> results;
                try
                {
                    ClsLogfile.Writelog(1, "Adding SQL Resource Provider to Plan", true);
                    results = ps.Invoke();
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to add SQL Resource Provider to plan", true);
                    ps.Dispose();
                    throw;
                }
                ps.Dispose();
                return results.Count > 0;
            }
            ps.Dispose();
            throw new Exception("SQL Server Missing from WAP registration for plan: " + sPlanName);
        }

        /// <summary>
        /// </summary>
        /// <param name="sPlanName"></param>
        /// <param name="sService"></param>
        /// <param name="sSQLGrp"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static bool PS_AddRPGrp2Plan(string sPlanName, string sService, string sSQLGrp, string sAdminSite,
            string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sPlanName, sService, sSQLGrp, sAdminSite, sAuthSite, bSignedCert", sPlanName,
                sService, sSQLGrp, sAdminSite, sAuthSite, bSignedCert.ToString());
            var ps = PowerShell.Create();
            var psCmd = new PSCommand();
            var adminUri = sAdminSite;
            var token = (char) 34 + ClsTimer.GetToken(sAuthSite) + (char) 34;
            var strResPro = (char) 34 + PS_GetSQLResPro(sService, sAdminSite, sAuthSite, bSignedCert)[0].Id + (char) 34;
            var strplan = (char) 34 + sPlanName + (char) 34;
            var sScript = "$wapadminsite = \"" + adminUri + "\"" + Environment.NewLine;
            sScript += " $token = " + token + Environment.NewLine;
            sScript += " $sqlserverRPinstID =" + strResPro + Environment.NewLine;
            sScript += " $planid = " + strplan + Environment.NewLine;
            sScript += " $QuotaList = New-MgmtSvcQuotaList" + Environment.NewLine;
            sScript +=
                " $SqlQuota = Add-MgmtSvcListQuota -QuotaList $QuotaList -ServiceName sqlservers -ServiceInstanceId $sqlserverRPinstID" +
                Environment.NewLine;
            sScript +=
                " $sqlquotares = Add-MgmtSvcQuotaSetting -Quota $SqlQuota -Key Editions -Value '[{\"displayName\":\"" +
                sSQLGrp + "\",\"groupName\":\"" + sSQLGrp +
                "\",\"resourceCount\":\"1000\",\"resourceSize\":\"1024000\",\"resourceSizeLimit\":\"1024000\",\"offerEditionId\":\"081313063701\",\"groupType\":null}]'" +
                Environment.NewLine;
            sScript +=
                " Update-MgmtSvcPlanQuota -AdminUri $wapadminsite -Token $token -QuotaList $QuotaList -PlanId $planid -DisableCertificateValidation" +
                Environment.NewLine;
            psCmd.AddScript(sScript);
            ps.Commands = psCmd;
            Collection<PSObject> updQuota;
            try
            {
                ClsLogfile.Writelog(1, "Create and add Resource Provider Quotas for Plan", true);
                updQuota = ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to create and add Resource Provider Quotas for Plan", true);
                ps.Dispose();
                throw;
            }
            ps.Dispose();
            return updQuota.Count > 0;
        }

        /// <summary>
        /// </summary>
        /// <param name="sName"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static List<Plan> PS_AddPlan(string sName, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sName, sAdminSite, sAuthSite, bSignedCert", sName, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            try
            {
                var ps = PowerShell.Create();
                var command = new PSCommand();
                command.AddCommand("Add-MgmtSvcPlan");
                command.AddParameter("AdminUri", sAdminSite);
                command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
                command.AddParameter("DisplayName", sName);
                if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
                ps.Commands = command;
                Collection<PSObject> results;
                try
                {
                    ClsLogfile.Writelog(1, "Create Plan", true);
                    results = ps.Invoke();
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to create Plan", true);
                    ps.Dispose();
                    throw;
                }

                if (ps.HadErrors)
                {
                    ClsLogfile.Writelog(ClsTimer.DisplayError(ps));
                }
                var lplan = new List<Plan>();

                foreach (var result in results)
                {
                    var pl = new Plan
                    {
                        Id = result.Members["Id"].Value.ToString(),
                        DisplayName = result.Members["DisplayName"].Value.ToString()
                    };
                    int i;
                    int.TryParse(result.Members["SubscriptionCount"].Value.ToString(), out i);
                    pl.SubscriptionCount = i;
                    var lsq = ((IEnumerable) result.Members["ServiceQuotas"].Value).Cast<ServiceQuota>().ToList();
                    pl.ServiceQuotas = lsq;
                    lplan.Add(pl);
                }
                ps.Dispose();
                return lplan;
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="sPlanId"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static bool PS_DeletePlan(string sPlanId, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sPlanId, sAdminSite, sAuthSite, bSignedCert", sPlanId, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            if (PS_GetPlan(sPlanId, true, sAdminSite, sAuthSite, bSignedCert) == null) return false;
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Remove-MgmtSvcPlan");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter("PlanId", sPlanId);
            command.AddParameter("Confirm", false);
            if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            try
            {
                ClsLogfile.Writelog(1, "Deleting Plan", true);
                ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to delete Plan", true);
                ps.Dispose();
                throw;
            }
            var res = !ps.HadErrors;
            ps.Dispose();
            return res;
        }

        /// <summary>
        /// </summary>
        /// <param name="sService"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static List<ResPro> PS_GetSQLResPro(string sService, string sAdminSite, string sAuthSite,
            bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sService, sAdminSite, sAuthSite, bSignedCert", sService, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Get-MgmtSvcResourceProvider");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            if (!string.IsNullOrEmpty(sService)) command.AddParameter("Name", sService);
            if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            Collection<PSObject> updQuota;
            try
            {
                ClsLogfile.Writelog(1, "Getting SQL Resource Provider", true);
                updQuota = ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to get SQL Resource Provider", true);
                ps.Dispose();
                throw;
            }
            ps.Dispose();
            return updQuota.Select(result => new ResPro
            {
                Id = result.Members["InstanceID"].Value.ToString(),
                Name = result.Members["Name"].Value.ToString()
            }).ToList();
        }
    }

    /// <summary>
    /// </summary>
    public class ResPro
    {
        /// <summary>
        /// </summary>
        private static string _id;

        /// <summary>
        /// </summary>
        private static string _name;

        /// <summary>
        /// </summary>
        public string Id
        {
            get { return _id; }
            set { _id = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Name
        {
            get { return _name; }
            set { _name = Setval(value); }
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

    /// <summary>
    /// </summary>
    [DataContract(Namespace = "http://schemas.microsoft.com/windowsazure")]
    public enum PlanState
    {
        /// <summary>
        ///     The plan is private.  Only Admin can see and manage it.
        /// </summary>
        [EnumMember] Private = 0,

        /// <summary>
        ///     The plan is public.  Tenants can see an self-subscribe to it.
        /// </summary>
        [EnumMember] Public,

        /// <summary>
        ///     The plan is decommissioned. New subscriptions will not be able to use the add-on.
        /// </summary>
        [EnumMember] Decommissioned
    }

    /// <summary>
    /// </summary>
    public enum QuotaConfigurationState
    {
        /// <summary>
        ///     Plan/add-on is not configured.
        /// </summary>
        [EnumMember] NotConfigured = 0,

        /// <summary>
        ///     Plan/add-on is configured.
        /// </summary>
        [EnumMember] Configured
    }

    /// <summary>
    /// </summary>
    public enum QuotaSyncState
    {
        /// <summary>
        ///     The in sync
        /// </summary>
        [EnumMember] InSync = 0,

        /// <summary>
        ///     The syncing
        /// </summary>
        [EnumMember] Syncing,

        /// <summary>
        ///     The out of sync
        /// </summary>
        [EnumMember] OutOfSync
    }

    /// <summary>
    /// </summary>
    public class PlanAdvertisement : IExtensibleDataObject
    {
        /// <summary>
        ///     Gets or sets the language code (e.g. en-us ).
        /// </summary>
        [DataMember(Order = 0)]
        public string LanguageCode { get; set; }

        /// <summary>
        ///     Gets or sets the language-specific display name of the plan.
        /// </summary>
        [DataMember(Order = 1)]
        public string DisplayName { get; set; }

        /// <summary>
        ///     Gets or sets the language-specific plan description.
        /// </summary>
        [DataMember(Order = 2)]
        public string Description { get; set; }

        /// <summary>
        ///     Gets or sets the structure that contains extra data.
        /// </summary>
        public ExtensionDataObject ExtensionData { get; set; }
    }

    /// <summary>
    /// </summary>
    public class ServiceQuotaSetting : IExtensibleDataObject
    {
        /// <summary>
        ///     Gets or sets the setting key.
        /// </summary>
        [DataMember(Order = 0, IsRequired = true)]
        public string Key { get; set; }

        /// <summary>
        ///     Gets or sets the setting value.
        /// </summary>
        [DataMember(Order = 1, IsRequired = true)]
        public string Value { get; set; }

        /// <summary>
        ///     Gets or sets the structure that contains extra data.
        /// </summary>
        public ExtensionDataObject ExtensionData { get; set; }
    }

    /// <summary>
    /// </summary>
    public class PlanAddOnReference
    {
        /// <summary>
        ///     Gets or sets the add on id.
        /// </summary>
        [DataMember(Order = 0)]
        public string AddOnId { get; set; }

        /// <summary>
        ///     Gets the add on instance id.
        /// </summary>
        [DataMember(Order = 1)]
        public string AddOnInstanceId { get; set; }

        /// <summary>
        ///     Gets the acquisition time.
        /// </summary>
        [DataMember(Order = 2)]
        public DateTime? AcquisitionTime { get; set; }
    }

    /// <summary>
    /// </summary>
    public class PlanAddOn
    {
        /// <summary>
        ///     Gets or sets the id.
        /// </summary>
        [DataMember(Order = 0)]
        public string Id { get; set; }

        /// <summary>
        ///     Gets or sets the display name.
        /// </summary>
        [DataMember(Order = 1)]
        public string DisplayName { get; set; }

        /// <summary>
        ///     Gets or sets the state.
        /// </summary>
        [DataMember(Order = 2)]
        public PlanState State { get; set; }

        /// <summary>
        ///     Gets the state of the config.
        /// </summary>
        [DataMember(Order = 3)]
        public QuotaConfigurationState ConfigState { get; set; }

        /// <summary>
        ///     Gets the quota sync state.
        /// </summary>
        [DataMember(Order = 4)]
        public QuotaSyncState QuotaSyncState { get; set; }

        /// <summary>
        ///     Gets or sets the last error message.
        /// </summary>
        [DataMember(Order = 5)]
        public string LastErrorMessage { get; set; }

        /// <summary>
        ///     Gets the advertisements.
        /// </summary>
        [DataMember(Order = 6)]
        public IList<PlanAdvertisement> Advertisements { get; set; }

        /// <summary>
        ///     Gets the service quotas.
        /// </summary>
        [DataMember(Order = 7)]
        public IList<ServiceQuota> ServiceQuotas { get; set; }

        /// <summary>
        ///     Gets or sets the subscription count.
        /// </summary>
        [DataMember(Order = 8)]
        public int SubscriptionCount { get; set; }

        /// <summary>
        ///     Gets the associated plans.
        /// </summary>
        [DataMember(Order = 9)]
        public IList<Plan> AssociatedPlans { get; set; }

        /// <summary>
        ///     Gets or sets the max occurrences per plan.
        /// </summary>
        [DataMember(Order = 10)]
        public int MaxOccurrencesPerPlan { get; set; }

        /// <summary>
        ///     Gets or sets the price.
        /// </summary>
        [DataMember(Order = 11)]
        public string Price { get; set; }

        /// <summary>
        ///     Gets or sets the structure that contains extra data.
        /// </summary>
        public ExtensionDataObject ExtensionData { get; set; }
    }

    /// <summary>
    /// </summary>
    public class Plan
    {
        /// <summary>
        ///     Gets or sets the id.
        /// </summary>
        private static string _id;

        /// <summary>
        /// </summary>
        [DataMember(Order = 0)]
        public string Id
        {
            get { return _id; }
            set { _id = Setval(value); }
        }

        /// <summary>
        ///     Gets or sets the display name.
        /// </summary>
        [DataMember(Order = 1)]
        public string DisplayName { get; set; }

        /// <summary>
        ///     Gets or sets the state.
        /// </summary>
        [DataMember(Order = 2)]
        public PlanState State { get; set; }

        /// <summary>
        ///     Gets the state of the configuration.
        /// </summary>
        [DataMember(Order = 3)]
        public QuotaConfigurationState ConfigState { get; set; }


        /// <summary>
        ///     Gets the quota sync state.
        /// </summary>
        [DataMember(Order = 4)]
        public QuotaSyncState QuotaSyncState { get; set; }

        /// <summary>
        ///     Gets or sets the last error message.
        /// </summary>
        [DataMember(Order = 5)]
        public string LastErrorMessage { get; set; }

        /// <summary>
        ///     Gets the advertisements.
        /// </summary>
        [DataMember(Order = 6)]
        public IList<PlanAdvertisement> Advertisements { get; set; }

        /// <summary>
        ///     Gets the service quotas.
        /// </summary>
        [DataMember(Order = 7)]
        public IList<ServiceQuota> ServiceQuotas { get; set; }

        /// <summary>
        ///     Gets or sets the subscription count.
        /// </summary>
        [DataMember(Order = 8)]
        public int SubscriptionCount { get; set; }

        /// <summary>
        ///     Gets or sets the max subscriptions per account.
        /// </summary>
        [DataMember(Order = 9)]
        public int MaxSubscriptionsPerAccount { get; set; }

        /// <summary>
        ///     Gets the add on references.
        /// </summary>
        [DataMember(Order = 10)]
        public IList<PlanAddOnReference> AddOnReferences { get; set; }

        /// <summary>
        ///     Gets the add-ons.
        /// </summary>
        [DataMember(Order = 11)]
        public IList<PlanAddOn> AddOns { get; set; }

        /// <summary>
        ///     Gets or sets the invitation code.
        /// </summary>
        [DataMember(Order = 12)]
        public string InvitationCode { get; set; }

        /// <summary>
        ///     Gets or sets the price.
        /// </summary>
        [DataMember(Order = 13)]
        public string Price { get; set; }

        /// <summary>
        ///     Gets or sets the structure that contains extra data.
        /// </summary>
        [DataMember(Order = 14)]
        public string ServerName { get; set; }

        public ExtensionDataObject ExtensionData { get; set; }

        /// <summary>
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private static string Setval(string val)
        {
            return val;
        }
    }

    /// <summary>
    /// </summary>
    public class ResourceProviderReference
    {
        /// <summary>
        ///     Gets or sets the resource provider name.
        /// </summary>
        [DataMember(Order = 0)]
        public string Name { get; set; }

        /// <summary>
        ///     Gets or sets the instance id.
        /// </summary>
        [DataMember(Order = 1)]
        public string InstanceId { get; set; }

        /// <summary>
        ///     Gets or sets the state of the configuration.
        /// </summary>
        [DataMember(Order = 2)]
        public QuotaConfigurationState ConfigState { get; set; }

        /// <summary>
        ///     Gets or sets the extension data.
        /// </summary>
        public ExtensionDataObject ExtensionData { get; set; }
    }
}