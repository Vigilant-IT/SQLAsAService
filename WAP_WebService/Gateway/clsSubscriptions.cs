// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Management.Automation;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsSubscriptions
    {
        /// <summary>
        /// </summary>
        /// <param name="sSvrName"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static List<Sub> GetApSubBySvrName(string sSvrName, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sSvrName, sAdminSite, sAuthSite, bSignedCert", sSvrName, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            var sCertValidate = bSignedCert ? "-DisableCertificateValidation" : "";
            command.AddScript(
                string.Format(
                    "Get-MgmtSvcSubscription -Token '{0}' -AdminUri {1} {2} | Where-Object {{$_.SubscriptionName -like '*{3}*'}}",
                    ClsTimer.GetToken(sAuthSite), sAdminSite, sCertValidate, sSvrName));
            ps.Commands = command;
            Collection<PSObject> results;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining Subscription by ServerName", true);
                results = ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain Subscription by ServerName", true);
                ps.Dispose();
                throw;
            }
            ps.Dispose();
            return results.Select(result => new Sub
            {
                Name = result.Members["SubscriptionName"].Value.ToString(),
                State = result.Members["State"].Value.ToString(),
                PlanId = result.Members["PlanID"].Value.ToString(),
                Id = result.Members["SubscriptionID"].Value.ToString(),
                ServerName = sSvrName
            }).ToList();
        }

        /// <summary>
        ///     Returns WAP Subscription searched on username
        /// </summary>
        /// <param name="sUName"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static List<Sub> GetApSubByUName(string sUName, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sUName, sAdminSite, sAuthSite, bSignedCert", sUName, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Get-MgmtSvcSubscription");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter("UserName", sUName);
            if (!bSignedCert)
                command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            Collection<PSObject> results;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining Subscription by UserName", true);
                results = ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain Subscription by UserName", true);
                ps.Dispose();
                throw;
            }
            ps.Dispose();
            return results.Select(result => new Sub
            {
                Name = result.Members["SubscriptionName"].Value.ToString(),
                State = result.Members["State"].Value.ToString(),
                PlanId = result.Members["PlanID"].Value.ToString(),
                Id = result.Members["SubscriptionID"].Value.ToString()
            }).ToList();
        }

        /// <summary>
        ///     Returns the subscription details based upon a Plan ID
        /// </summary>
        /// <param name="sPlanId"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static Sub GetApSubbyPlanId(string sPlanId, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sPlanId, sAdminSite, sAuthSite, bSignedCert", sPlanId, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Get-MgmtSvcSubscription");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter("PlanId", sPlanId);
            if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            Collection<PSObject> results;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining Subscription by PlanID", true);
                results = ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain Subscription by PlanID", true);
                ps.Dispose();
                throw;
            }

            if (results.Count == 0)
            {
                ps.Dispose();
                return null;
            }
            ps.Dispose();
            return new Sub
            {
                Name = results[0].Members["SubscriptionName"].Value.ToString(),
                State = results[0].Members["State"].Value.ToString(),
                PlanId = results[0].Members["PlanID"].Value.ToString(),
                Id = results[0].Members["SubscriptionID"].Value.ToString()
            };
        }

        /// <summary>
        ///     Returns the subscription from the SubID
        /// </summary>
        /// <param name="sSubId"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static Sub GetApSubbySubId(string sSubId, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sSubId, sAdminSite, sAuthSite, bSignedCert", sSubId, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            try
            {
                var ps = PowerShell.Create();
                var command = new PSCommand();
                command.AddCommand("Get-MgmtSvcSubscription");
                command.AddParameter("AdminUri", sAdminSite);
                command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
                command.AddParameter("SubscriptionId", sSubId);
                if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
                ps.Commands = command;
                Collection<PSObject> results;
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining Subscription by SubID", true);
                    results = ps.Invoke();
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain Subscription by SubID", true);
                    ps.Dispose();
                    throw;
                }
                if (results.Count == 0)
                {
                    ps.Dispose();
                    return null;
                }
                ps.Dispose();
                return new Sub
                {
                    Name = results[0].Members["SubscriptionName"].Value.ToString(),
                    State = results[0].Members["State"].Value.ToString(),
                    PlanId = results[0].Members["PlanID"].Value.ToString(),
                    Id = results[0].Members["SubscriptionID"].Value.ToString()
                };
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        ///     Add a new WAP Subscription
        /// </summary>
        /// <param name="sUName"></param>
        /// <param name="sPlan"></param>
        /// <param name="sFriendlyName"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static Sub AddApSub(string sUName, string sPlan, string sFriendlyName, string sAdminSite,
            string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sUName, sPlan, sFriendlyName, sAdminSite, sAuthSite, bSignedCert", sUName, sPlan,
                sFriendlyName, sAdminSite, sAuthSite, bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Add-MgmtSvcSubscription");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter("AccountAdminLiveEmailId", sUName);
            command.AddParameter("AccountAdminLivePuid", sUName);
            command.AddParameter("FriendlyName", sFriendlyName);
            command.AddParameter("PlanId", sPlan);
            if (!bSignedCert)
                command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            Collection<PSObject> results;
            try
            {
                ClsLogfile.Writelog(1, "Creating new Subscription", true);
                results = ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to create new Subscription", true);
                ps.Dispose();
                throw;
            }
            ps.Dispose();
            return new Sub
            {
                Name = results[0].Members["SubscriptionName"].Value.ToString(),
                State = results[0].Members["State"].Value.ToString(),
                PlanId = results[0].Members["PlanID"].Value.ToString(),
                Id = results[0].Members["SubscriptionID"].Value.ToString()
            };
        }

        /// <summary>
        ///     removes WAP subscription
        /// </summary>
        /// <param name="sSubId"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static bool RemoveApSub(string sSubId, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sSubId, sAdminSite, sAuthSite, bSignedCert", sSubId, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            if (GetApSubbySubId(sSubId, sAdminSite, sAuthSite, bSignedCert) == null) return false;
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Remove-MgmtSvcSubscription");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter("SubscriptionId", sSubId);
            command.AddParameter("Force");
            command.AddParameter("Confirm", false);
            if (!bSignedCert)
                command.AddParameter("DisableCertificateValidation");
            try
            {
                ClsLogfile.Writelog(1, "Removing Subscription", true);
                ps.Commands = command;
                ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to remove Subscription", true);
                ps.Dispose();
                throw;
            }
            var res = !ps.HadErrors;
            ps.Dispose();
            return res;
        }
    }

    /// <summary>
    /// </summary>
    public class Sub
    {
        /// <summary>
        /// </summary>
        private static string _name;

        /// <summary>
        /// </summary>
        private static string _state;

        /// <summary>
        /// </summary>
        private static string _planId;

        /// <summary>
        /// </summary>
        private static string _id;

        /// <summary>
        /// </summary>
        private static string _servername;

        /// <summary>
        /// </summary>
        public string Name
        {
            get { return _name; }
            set { _name = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string State
        {
            get { return _state; }
            set { _state = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string PlanId
        {
            get { return _planId; }
            set { _planId = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Id
        {
            get { return _id; }
            set { _id = Setval(value); }
        }

        public string ServerName
        {
            get { return _servername; }
            set { _servername = Setval(value); }
        }

        /// <summary>
        /// </summary>
        private static string Setval(string val)
        {
            return val;
        }
    }
}