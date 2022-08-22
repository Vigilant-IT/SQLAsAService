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
    public class ClsUsers
    {
        /// <summary>
        ///     Cheacks if user exists in WAP
        /// </summary>
        /// <param name="sMail"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static User GetUser(string sMail, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sMail, sAdminURI, sAuthSite, bSignedCert", sMail, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Get-MgmtSvcUser");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter("Name", sMail);
            if (!bSignedCert) command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            Collection<PSObject> results;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining User", true);
                results = ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain User", true);
                ps.Dispose();
                throw;
            }
            if (ps.InvocationStateInfo.State != PSInvocationState.Completed)
                throw new Exception(string.Format("Issues finding user:{0}", sMail));
            ps.Dispose();
            if (results.Count == 0) return null;
            return new User
            {
                Name = results[0].Members["Name"].Value.ToString(),
                Email = results[0].Members["Email"].Value.ToString(),
                Creationdate = results[0].Members["CreatedTime"].Value.ToString(),
                SubCount = results[0].Members["SubscriptionCount"].Value.ToString()
            };
        }

        /// <summary>
        ///     Adds a new User to WAP
        /// </summary>
        /// <param name="sMail"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static List<User> PS_AddAPUser(string sMail, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sMail, sAdminURI, sAuthSite, bSignedCert", sMail, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            var ps = PowerShell.Create();
            var command = new PSCommand();
            command.AddCommand("Add-MgmtSvcUser");
            command.AddParameter("AdminUri", sAdminSite);
            command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
            command.AddParameter("Name", sMail);
            command.AddParameter("Email", sMail);
            command.AddParameter("state", "Active");
            command.AddParameter("ActivationSyncState", "InSync");
            if (!bSignedCert)
                command.AddParameter("DisableCertificateValidation");
            ps.Commands = command;
            Collection<PSObject> results;
            try
            {
                ClsLogfile.Writelog(1, "Creating User in WAP", true);
                results = ps.Invoke();
                if (ps.InvocationStateInfo.State != PSInvocationState.Completed)
                    throw new Exception(string.Format("Issues finding user:{0}", sMail));
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to create User in WAP", true);
                ps.Dispose();
                throw;
            }
            ps.Dispose();
            return results.Select(result => new User
            {
                Name = result.Members["Name"].Value.ToString(),
                Email = result.Members["Email"].Value.ToString()
            }).ToList();
        }

        /// <summary>
        /// </summary>
        /// <param name="sMail"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static bool PS_RemoveAPUser(string sMail, string sAdminSite, string sAuthSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sMail, sAdminURI, sAuthSite, bSignedCert", sMail, sAdminSite, sAuthSite,
                bSignedCert.ToString());
            var user = GetUser(sMail, sAdminSite, sAuthSite, bSignedCert);
            if (user == null) return true;
            if (user.SubCount == "0")
            {
                var ps = PowerShell.Create();
                var command = new PSCommand();
                command.AddCommand("remove-MgmtSvcUser");
                command.AddParameter("AdminUri", sAdminSite);
                command.AddParameter("Token", ClsTimer.GetToken(sAuthSite));
                command.AddParameter("Name", sMail);
                command.AddParameter("confirm", false);
                if (!bSignedCert)
                    command.AddParameter("DisableCertificateValidation");
                ps.Commands = command;
                try
                {
                    ClsLogfile.Writelog(1, "Removing User from WAP", true);
                    ps.Invoke();
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to remove User from WAP", true);
                    ps.Dispose();
                    throw;
                }
                var res = !ps.HadErrors;
                ps.Dispose();
                return res;
            }
            return false;
        }
    }

    /// <summary>
    /// </summary>
    public class User
    {
        /// <summary>
        /// </summary>
        private static string _name;

        /// <summary>
        /// </summary>
        private static string _email;

        /// <summary>
        /// </summary>
        private static string _creationdate;

        /// <summary>
        /// </summary>
        private static string _subcount;

        /// <summary>
        /// </summary>
        public string Name
        {
            get { return _name; }
            set { _name = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Email
        {
            get { return _email; }
            set { _email = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Creationdate
        {
            get { return _creationdate; }
            set { _creationdate = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string SubCount
        {
            get { return _subcount; }
            set { _subcount = Setval(value); }
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
}