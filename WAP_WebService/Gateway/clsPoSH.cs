using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Text;
using System.Threading.Tasks;

namespace Gateway
{
    class clsPoSH
    {
        public static void ResetPoshSessions(string strSvrName)
        {
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strSvrName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strSvrName };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            pipe.Commands.AddScript(
                string.Format(
                    "foreach($s in Get-WSManInstance -ConnectionURI http://{0}:5985/wsman shell -enum){{Remove-WSManInstance -ConnectionURI http://{0}:5985/wsman shell @{{ShellID=$s.ShellID}}}}", strSvrName));
            try
            {
                ClsLogfile.Writelog(1, "Obtaining VM from VMM", true);
                pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain VM from VMM", true);
                runspace.Close();
                runspace.Dispose();
            }
        }
    }
}
