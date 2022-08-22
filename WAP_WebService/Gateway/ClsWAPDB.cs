// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Data.SqlClient;
using System.IO;
using System.Management.Automation;

namespace Gateway
{
    /// <summary>
    /// </summary>
    internal class ClsWapdb
    {
        /// <summary>
        ///     Add an Azure Pack DataBase for Tenant
        /// </summary>
        /// <param name="sUName"></param>
        /// <param name="sDBName"></param>
        /// <param name="sWapsqlGrp"></param>
        /// <param name="iSqlbaseSize"></param>
        /// <param name="iSqlmaxSize"></param>
        /// <param name="sSQLCollation"></param>
        /// <param name="sSQLAdminUser"></param>
        /// <param name="sSqlpword"></param>
        /// <param name="sSubId"></param>
        /// <param name="sServiceName"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="sTenantSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static string PS_AddAPDB(string sUName, string sDBName, string sWapsqlGrp, int iSqlbaseSize,
            int iSqlmaxSize, string sSQLCollation, string sSQLAdminUser, string sSqlpword, string sSubId,
            string sServiceName, string sAdminSite, string sAuthSite, string sTenantSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam(
                "sUName, sDBName, sWapsqlGrp, iSqlbaseSize, iSqlmaxSize, sSQLCollation, sSQLAdminUser, sSqlpword, sSubId, sServiceName, sAdminSite, sAuthSite, sTenantSite, bSignedCert",
                sUName, sDBName, sWapsqlGrp, iSqlbaseSize.ToString(), iSqlmaxSize.ToString(), sSQLCollation,
                sSQLAdminUser, sSqlpword, sSubId, sServiceName, sAdminSite, sAuthSite, sTenantSite,
                bSignedCert.ToString());

            var ps = PowerShell.Create();
            var upDcmd = new PSCommand();
            var sScript = "$SusbcriptionID = " + (char) 34 + sSubId + (char) 34 + Environment.NewLine;
            sScript += "$token = " + (char) 34 + ClsTimer.GetToken(sAuthSite) + (char) 34 + Environment.NewLine;
            sScript += "$AdminUri = " + (char) 34 + sAdminSite + (char) 34 + Environment.NewLine;
            sScript += "$TenantUri = " + (char) 34 + sTenantSite + (char) 34 + Environment.NewLine;
            sScript += "$BodyHashTable = @{" + Environment.NewLine;
            sScript += "Name = \"{0}\" -f " + (char) 34 + sDBName + (char) 34 + Environment.NewLine;
            //sScript += "Edition = " + (char) 34 + sWapsqlGrp + (char) 34 + Environment.NewLine;
            sScript += "Edition = " + (char)34 + "LINUX" + (char)34 + Environment.NewLine;
            //sScript += "BaseSizeMB = " + (char) 34 + iSqlbaseSize + (char) 34 + Environment.NewLine;
            //sScript += "MaxSizeMB = " + (char) 34 + iSqlmaxSize + (char) 34 + Environment.NewLine;
            sScript += "Collation =  " + (char) 34 + sSQLCollation + (char) 34 + Environment.NewLine;
            sScript += "BaseSizeMB = " + (char)34 + 1024 + (char)34 + Environment.NewLine;
            sScript += "MaxSizeMB = " + (char)34 + 1024 + (char)34 + Environment.NewLine;
            sScript += "Iscontained = \"false\"" + Environment.NewLine;
            sScript += "CreationDate = \"0001-01-01T00:00:00+00:00\"" + Environment.NewLine;
            sScript += "Status = \"0\"" + Environment.NewLine;
            sScript += "AdminLogon = " + (char) 34 + sSQLAdminUser + (char) 34 + Environment.NewLine;
            sScript += "Password = " + (char) 34 + sSqlpword + (char) 34 + Environment.NewLine;
            sScript += "}" + Environment.NewLine;
            sScript += "$BodyJSON = ConvertTo-Json $BodyHashTable" + Environment.NewLine;
            sScript +=
                "$UserID = (Get-MgmtSvcSubscription -AdminUri $AdminUri -Token $Token -DisableCertificateValidation | Where-Object {$_.SubscriptionId -eq $SusbcriptionID}).AccountAdminLiveEmailId" +
                Environment.NewLine;
            sScript += "$Headers = @{Authorization = \"Bearer $Token\"" + Environment.NewLine;
            sScript += "        \"x-ms-principal-id\" = $UserID}" + Environment.NewLine;
            sScript += "$FullUri = $TenantUri + \"/\" + $SusbcriptionID + \"/services/sqlservers/databases/\"" +
                       Environment.NewLine;
            sScript +=
                "$res = Invoke-RestMethod -Uri $FullUri -Headers $Headers -Body $BodyJSON -ContentType 'application/json; charset=utf8' -Method POST -timeoutsec 120" +
                Environment.NewLine;
            sScript += "$res.ConnectionString";
            upDcmd.AddScript(sScript);
            File.WriteAllText("c:\\temp\\dbcreatetest_WS.txt", sScript);
            ps.Commands = upDcmd;
            var sout = "";
            var sElem = sWapsqlGrp.Split('_');
            try
            {
                ClsLogfile.Writelog(1, "Adding Database to WAP", true);
                var updQuota = ps.Invoke();
                if (!ps.HadErrors && updQuota.Count > 0 && updQuota[0] != null)
                {
                    sout =
                        updQuota[0].ToString()
                            .Replace(sElem[sElem.Length - 1], sServiceName)
                            .Replace("<<Your-DB-password-here>>", sSqlpword);
                }
                if (sout.Contains(sSqlpword)) return sout;
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, "Failed to add Database to WAP", true);
                ps.Dispose();
                return "Exception Please Log Ticket with Support: " + ex.Message;
            }

            if (!ps.HadErrors) {ps.Dispose(); return sout;}
            var s = ClsTimer.DisplayError(ps);
            s = s.Substring(s.IndexOf("Message>", StringComparison.Ordinal) + 8);
            s = s.Substring(1, s.IndexOf("</Message>", StringComparison.Ordinal) - 1);
            if (s.Contains("500")) sout = "";
            ps.Dispose();
            return sout;
        }

        /// <summary>
        ///     Gets SQL Connection string in the following format:
        ///     "Data Source=ESQL12ST101;Initial Catalog=DB0000003ABP_Manual;User
        ///     Id=sa00001;Password=Your-DB-password-here;Asynchronous Processing=True"
        /// </summary>
        /// <param name="server"></param>
        /// <param name="database"></param>
        /// <param name="sSQLAdminUser"></param>
        /// <returns></returns>
        public static string GetDBConnString(string server, string database, string sSQLAdminUser)
        {
            ClsLogfile.Writelogparam("server, database, sSQLAdminUser", server, database, sSQLAdminUser);
            var sRslt = "";

            var sqlConnection =
                new SqlConnection("Data Source=" + server + ";Initial Catalog=master;Integrated Security=True;");
            sqlConnection.Open();
            try
            {
                ClsLogfile.Writelog(1, "Obtaining DB Conn String", true);
                var reader =
                    new SqlCommand("select * from master.dbo.sysdatabases where Name='" + database + "'", sqlConnection)
                        .ExecuteReader();
                if (reader.HasRows)
                    sRslt = "Data Source=" + server + ";Initial Catalog=" + database + ";User Id=" + sSQLAdminUser +
                            ";Password=<<Your-DB-password-here>>;Asynchronous Processing=True";
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain DB Conn String", true);
                throw;
            }
            return sRslt;
        }

        /// <summary>
        ///     Deletes a Database from Tenant
        /// </summary>
        /// <param name="sUName"></param>
        /// <param name="sDBName"></param>
        /// <param name="sSubId"></param>
        /// <param name="sAdminSite"></param>
        /// <param name="sAuthSite"></param>
        /// <param name="sTenantSite"></param>
        /// <param name="bSignedCert"></param>
        /// <returns></returns>
        public static string PS_DELETEAPDB(string sUName, string sDBName, string sSubId, string sAdminSite,
            string sAuthSite, string sTenantSite, bool bSignedCert)
        {
            ClsLogfile.Writelogparam("sUName, sDBName, sSubId, sAdminSite, sAuthSite, sTenantSite, bSignedCert", sUName,
                sDBName, sSubId, sAdminSite, sAuthSite, sTenantSite, bSignedCert.ToString());
            var ps = PowerShell.Create();
            var upDcmd = new PSCommand();
            var sScript = "$SusbcriptionID = " + (char) 34 + sSubId + (char) 34 + Environment.NewLine;
            sScript += "$token = " + (char) 34 + ClsTimer.GetToken(sAuthSite) + (char) 34 + Environment.NewLine;
            sScript += "$AdminUri = " + (char) 34 + sAdminSite + (char) 34 + Environment.NewLine;
            sScript += "$TenantUri = " + (char) 34 + sTenantSite + (char) 34 + Environment.NewLine;
            sScript +=
                "$UserID = (Get-MgmtSvcSubscription -AdminUri $AdminUri -Token $Token -DisableCertificateValidation | Where-Object {$_.SubscriptionId -eq $SusbcriptionID}).AccountAdminLiveEmailId" +
                Environment.NewLine;
            sScript += "$Headers = @{Authorization = \"Bearer $Token\"" + Environment.NewLine;
            sScript += "        \"x-ms-principal-id\" = $UserID}" + Environment.NewLine;
            sScript += "$FullUri = $TenantUri + \"/\" + $SusbcriptionID + \"/services/sqlservers/databases/" +
                       sDBName + "\"" + Environment.NewLine;
            sScript +=
                "$res = Invoke-RestMethod -Uri $FullUri -Headers $Headers -ContentType 'application/json; charset=utf8' -Method Delete -timeoutsec 120" +
                Environment.NewLine;
            upDcmd.AddScript(sScript);
            File.WriteAllText("c:\\temp\\dbcreatetest_WS.txt", sScript);
            ps.Commands = upDcmd;
            const string sout = "";
            try
            {
                ClsLogfile.Writelog(1, "Deleting WAP DB", true);
                ps.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to Delete WAP DB", true);
                ps.Dispose();
                throw;
            }


            if (ps.HadErrors)
            {
            }
            ps.Dispose();
            return sout;
        }
    }
}