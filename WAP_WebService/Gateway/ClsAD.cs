using System;
using System.DirectoryServices.AccountManagement;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsAd
    {
        /// <summary>
        /// </summary>
        /// <param name="sCompName"></param>
        public static void EnableCompObj(string sCompName)
        {
            var strCompName = sCompName.Split('.')[0];
            var strDomName = sCompName.Split('.')[1];
            ClsLogfile.Writelogparam("sCompName", strCompName);
            if (string.IsNullOrEmpty(strCompName)) return;
            using (var targetDomain = new PrincipalContext(ContextType.Domain, strDomName, null, null))
            {
                var targetComputer = ComputerPrincipal.FindByIdentity(targetDomain, strCompName);
                if (targetComputer == null) return;
                if (targetComputer.Enabled != null && (bool)targetComputer.Enabled) return;
                targetComputer.Enabled = true;
                try
                {
                    ClsLogfile.Writelog(1, string.Format("Enabling {0} computer object in Active Directory", strCompName),
                    true);
                    targetComputer.Save();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3,
                    string.Format("Failed to enable {0} computer object in Active Directory", strCompName));
                    ClsLogfile.Writelog(3, ex.Message, true);
                }
            }
        }

        public static bool GrantRdgAccess(string strGrp)
        {
            var strGrpName = strGrp.Split('\\')[1];
            var strDomName = strGrp.Split('\\')[0];
            using (var targetDomain = new PrincipalContext(ContextType.Domain, strDomName, null, null))
            {
                var rdGgroup = GroupPrincipal.FindByIdentity(targetDomain, ClsTimer.Settings.RDGSecGroup);
                var secgroup = GroupPrincipal.FindByIdentity(targetDomain, strGrpName);
                if (secgroup != null && rdGgroup != null)
                {
                    
                    try
                    {
                        rdGgroup.Members.Add(secgroup);
                        rdGgroup.Save();
                    }
                    catch (Exception)
                    {
                        // ignored
                    }
                }
            }
            return true;
        }
    }
}