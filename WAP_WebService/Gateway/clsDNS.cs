using System.Management.Automation.Runspaces;
using System.Management;
using System.Net;
using System;
using System.Collections.ObjectModel;
using System.Management.Automation;

namespace Gateway
{
   public class clsDNS
    {
        public static void AddARecord(string hostName, string zone, string iPAddress, string dnsServerName)
        {
            var scope = new ManagementScope(string.Format(@"\\\\{0}\\root\\MicrosoftDNS", dnsServerName));
            scope.Connect();
            var cmiClass = new ManagementClass(scope, new ManagementPath("MicrosoftDNS_AType"), null);
            var inParams = cmiClass.GetMethodParameters("CreateInstanceFromPropertyData");
            inParams["DnsServerName"] = dnsServerName;
            inParams["ContainerName"] = zone;
            inParams["OwnerName"] = hostName + "." + zone;
            inParams["IPAddress"] = iPAddress;
            cmiClass.InvokeMethod("CreateInstanceFromPropertyData", inParams, null);
        }
        /// <summary>
        /// </summary>
        /// <param name="strComputer"></param>
        /// <param name="strCurpath"></param>
        /// <param name="strNewPath"></param>
        public static void CreateDNSARecord(string hostName, string zone, string iPAddress, string dnsServerName)
        {
            //ClsLogfile.Writelogparam("strComputer, strCurpath, strNewPath", strComputer, strCurpath, strNewPath);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = dnsServerName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = dnsServerName };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            //pipe.Commands.AddScript(string.Format("move {0} {1}", strCurpath, strNewPath));
            var command = new Command("Add-DnsServerResourceRecordA");
            command.Parameters.Add("ZoneName", zone);
            command.Parameters.Add("Name", hostName);
            command.Parameters.Add("IPv4Address", iPAddress);
            pipe.Commands.Add(command);
            try
            {
                ClsLogfile.Writelog(1, "Moving file", true);
                pipe.Invoke();
                pipe.Dispose();
                runspace.Close();
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, "Failed to move file");
                ClsLogfile.Writelog(3, ex.Message, true);
                runspace.Close();
                pipe.Dispose();
                throw;
            }
        }

        public static bool CreateDnsCname(string strDnsServerName,string strZone, string strHostName, string strNewDnsHostName)
        {
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strDnsServerName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strDnsServerName };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            //pipe.Commands.AddScript(string.Format("move {0} {1}", strCurpath, strNewPath));
            var command = new Command("Add-DnsServerResourceRecord");
            command.Parameters.Add("ZoneName", strZone);
            command.Parameters.Add("HostNameAlias", strHostName);
            command.Parameters.Add("Name", strNewDnsHostName);
            command.Parameters.Add("cname",true);
            pipe.Commands.Add(command);
            try
            {
                ClsLogfile.Writelog(1, string.Format("Creating Cname Record for Address:{0}",strNewDnsHostName), true);
                pipe.Invoke();
                pipe.Dispose();
                runspace.Close();
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, string.Format("Failed to create Cname Record for Address:{0}", strNewDnsHostName));
                ClsLogfile.Writelog(3, ex.Message, true);
                runspace.Close();
                pipe.Dispose();
                throw;
            }
            return true;
        }

        public static bool ValidateDnsCname(string strDnsServerName, string strSqlServerName, string strDnsHostname)
        {
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strDnsServerName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strDnsServerName };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            //pipe.Commands.AddScript(string.Format("move {0} {1}", strCurpath, strNewPath));
            var command = new Command("Resolve-DnsName");
            command.Parameters.Add("type", "CNAME");
            command.Parameters.Add("Name", strDnsHostname);
            pipe.Commands.Add(command);
            Collection<PSObject> res;
            try
            {
                ClsLogfile.Writelog(1, string.Format("Checking Cname Record for Address:{0}", strDnsHostname), true);
                res = pipe.Invoke();
                pipe.Dispose();
                runspace.Close();
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, string.Format("Failed to check Cname Record for Address:{0}", strDnsHostname));
                ClsLogfile.Writelog(3, ex.Message, true);
                runspace.Close();
                pipe.Dispose();
                throw;
            }
            if (res.Count != 1) return false;
            foreach (var re in res)
            {
                if (re.Members["NameHost"].Value.ToString() == strSqlServerName)
                {
                    return true;
                }
            }
            return false;
        }

        public static bool DeleteDnsCnameRecord(string strDnsServerName, string strZone, string strSqlServerName, string strDnsRecordName)
        {
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strDnsServerName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strDnsServerName };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            //pipe.Commands.AddScript(string.Format("move {0} {1}", strCurpath, strNewPath));
            var command = new Command("Remove-DnsServerResourceRecord");
            command.Parameters.Add("ZoneName", strZone);
            command.Parameters.Add("RRType", "CName");
            command.Parameters.Add("Name", strDnsRecordName);
            command.Parameters.Add("Confirm", false);
            command.Parameters.Add("force",true);
            pipe.Commands.Add(command);
            try
            {
                ClsLogfile.Writelog(1, string.Format("Deleting Cname Record for Address:{0}", strDnsRecordName), true);
                pipe.Invoke();
                pipe.Dispose();
                runspace.Close();
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, string.Format("Failed to delete Cname Record for Address:{0}", strDnsRecordName));
                ClsLogfile.Writelog(3, ex.Message, true);
                runspace.Close();
                pipe.Dispose();
                throw;
            }
            return true;
        }

        public static void DeleteDNSARecord(string hostName, string zone, string dnsServerName)
        {
            //ClsLogfile.Writelogparam("strComputer, strCurpath, strNewPath", strComputer, strCurpath, strNewPath);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = dnsServerName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = dnsServerName };
            var subzone = "";
            if (zone.Split('.')[0] == "nonprod")
            {
               subzone = ".nonprod";
               zone = zone.Replace("nonprod.", "");
            }
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            //pipe.Commands.AddScript(string.Format("move {0} {1}", strCurpath, strNewPath));
            var command = new Command("Remove-DnsServerResourceRecord");
            command.Parameters.Add("ZoneName", zone);
            command.Parameters.Add("Name", hostName + subzone);
            command.Parameters.Add("RRType", "A");
            command.Parameters.Add("Force", true);
            pipe.Commands.Add(command);
            try
            {
                ClsLogfile.Writelog(1, "Moving file", true);
                pipe.Invoke();
                pipe.Dispose();
                runspace.Close();
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, "Failed to move file");
                ClsLogfile.Writelog(3, ex.Message, true);
                pipe.Dispose();
                runspace.Close();
                //throw;
            }
        }

        public static string GetDNSRecord(string strHostname, string dnsServerName, string strZone)
        {
            var hostinfo = "";
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = dnsServerName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = dnsServerName };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            pipe.Commands.AddScript(string.Format("(Get-DnsServerResourceRecord -ZoneName '{0}' -RRType A -Name '{1}').recorddata.ipv4address.ipaddresstostring", strZone, strHostname));
            try
            {
                hostinfo = pipe.Invoke()[0].ToString();
                pipe.Dispose();
                runspace.Close();
            }
            catch (Exception)
            {
                hostinfo = "";
                pipe.Dispose();
                runspace.Close();
            }
            return hostinfo;
        }

        public static string GetSvrDNSRecord(string strHostname)
        {
            var hostinfo = "";
            try
            {
                hostinfo = Dns.GetHostAddresses(strHostname)[0].ToString();
            }
            catch
            {
                hostinfo = "";
            }
            return hostinfo;
        }

        public static string updateDns(string strNewName, string strZone, string strServerName, string strDnsServer)
        {
            var DNSname = strNewName.Substring(0, Math.Min(strNewName.Length, 63));
            var strInZone = strZone;
            var subzone = "";
            if (strZone.Split('.')[0] == "nonprod")
            {
                subzone = ".nonprod";
                strZone = strZone.Replace("nonprod.", "");
            }
            if(GetDNSRecord(DNSname + subzone, strDnsServer, strZone) == "")
            {
                CreateDnsCname(strDnsServer, strZone, strServerName, DNSname + subzone);
            }
            else
            {
                var i = 0;
                while (i < 100)
                {
                    DNSname = strNewName.Substring(0, Math.Min(strNewName.Length, 61)) + i.ToString("00");
                    if (ValidateDnsCname(DNSname + subzone, strDnsServer, strZone))
                    {
                        CreateDnsCname(strDnsServer, strZone, strServerName, DNSname + subzone);
                        break;
                    }
                    else
                    {
                        i += 1;
                    }
                }
            }
            return DNSname + "." + strInZone;
        }
    }
} 