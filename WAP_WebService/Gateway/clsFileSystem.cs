// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Management.Automation.Runspaces;
using System.Security.AccessControl;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsFileSystem
    {
        /// <summary>
        /// </summary>
        /// <param name="strUnCpath"></param>
        public static void CreateUNCFolder(string strUnCpath)
        {
            ClsLogfile.Writelogparam("strUnCpath", strUnCpath);
            if (!Directory.Exists(strUnCpath)) Directory.CreateDirectory(strUnCpath);
        }

        public static bool CreateLocalFolder(string strSvr, string strPath)
        {
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strSvr, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strSvr };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("New-Item");
            command.Parameters.Add("ItemType", "Directory");
            command.Parameters.Add("path", strPath);
            pipe.Commands.Add(command);
            pipe.Invoke();
            var info = pipe.PipelineStateInfo;
            return info.State == PipelineState.Completed;
        }

        public static bool DoesLocalFolderExist(string strSvr, string strPath)
        {
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strSvr, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strSvr };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("Test-Path");
            command.Parameters.Add("path", strPath);
            pipe.Commands.Add(command);
            var res = pipe.Invoke();
            return res[0].BaseObject.ToString() == "true";
        }

        public static bool RemoveLocalFolderExist(string strSvr, string strPath)
        {
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strSvr, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strSvr };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("Test-Path");
            command.Parameters.Add("path", strPath);
            pipe.Commands.Add(command);
            var res = pipe.Invoke();
            return res[0].BaseObject.ToString() == "true";
        }
       /// <summary>
       /// 
       /// </summary>
       /// <param name="strUncPath"></param>
       /// <param name="strUserName"></param>
       /// <param name="bolAdmin"></param>
       /// <param name="bolReports"></param>
       /// <param name="bolBasic"></param>
        public static void AssignFolderPerms(string strUncPath,
            string strUserName,
            bool bolAdmin,
            bool bolReports,
            bool bolBasic)
        {
           var adminpermissions = new FileSystemRights();
            adminpermissions |= FileSystemRights.AppendData |
                                 FileSystemRights.CreateDirectories |
                                 FileSystemRights.CreateFiles |
                                 FileSystemRights.DeleteSubdirectoriesAndFiles |
                                 FileSystemRights.ListDirectory |
                                 FileSystemRights.Read |
                                 FileSystemRights.ReadAttributes |
                                 FileSystemRights.ReadData |
                                 FileSystemRights.ReadExtendedAttributes |
                                 FileSystemRights.ReadPermissions |
                                 FileSystemRights.Synchronize |
                                 FileSystemRights.Write |
                                 FileSystemRights.WriteAttributes |
                                 FileSystemRights.WriteData |
                                 FileSystemRights.WriteExtendedAttributes;
            
            var reportspermissions = new FileSystemRights();
            reportspermissions |= FileSystemRights.AppendData |
                                 FileSystemRights.CreateDirectories |
                                 FileSystemRights.CreateFiles |
                                 FileSystemRights.ListDirectory |
                                 FileSystemRights.Read |
                                 FileSystemRights.ReadAttributes |
                                 FileSystemRights.ReadData |
                                 FileSystemRights.ReadExtendedAttributes |
                                 FileSystemRights.ReadPermissions |
                                 FileSystemRights.Synchronize |
                                 FileSystemRights.Write |
                                 FileSystemRights.WriteAttributes |
                                 FileSystemRights.WriteData |
                                 FileSystemRights.WriteExtendedAttributes;

            var basicpermissions = new FileSystemRights();
            basicpermissions |= FileSystemRights.AppendData |
                                 FileSystemRights.CreateDirectories |
                                 FileSystemRights.CreateFiles |
                                 FileSystemRights.DeleteSubdirectoriesAndFiles |
                                 FileSystemRights.ListDirectory |
                                 FileSystemRights.Modify |
                                 FileSystemRights.Read |
                                 FileSystemRights.ReadAttributes |
                                 FileSystemRights.ReadData |
                                 FileSystemRights.ReadExtendedAttributes |
                                 FileSystemRights.ReadPermissions |
                                 FileSystemRights.Synchronize |
                                 FileSystemRights.Write |
                                 FileSystemRights.WriteAttributes |
                                 FileSystemRights.WriteData |
                                 FileSystemRights.WriteExtendedAttributes;

            var permissions = new FileSystemRights();
            if (bolAdmin) permissions = adminpermissions;
            if (bolReports) permissions = reportspermissions;
            if (bolBasic) permissions = basicpermissions;
            var dInfo = new DirectoryInfo(strUncPath);
            var dSecurity = dInfo.GetAccessControl();
            var inheritanceflag = InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit;
            var propflag = PropagationFlags.None;
            try
            {
                ClsLogfile.Writelog(1, "Setting file Permissions", true);
                dSecurity.AddAccessRule(new FileSystemAccessRule(strUserName, permissions, inheritanceflag, propflag,
                    AccessControlType.Allow));
                dInfo.SetAccessControl(dSecurity);
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to set file Permissions", true);
                throw;
            }
        }


        public static void AgeOutFolders(string sPath, int iAge, List<Audit> dbList, string sGwSqlServer,
            string sGwDbName)
        {
            if (Directory.Exists(sPath))
            {
                foreach (var sdir in new DirectoryInfo(sPath).GetDirectories())
                {
                    if (!dbList.Contains(new Audit {DBName = sdir.Name, State = "completed delete"}) &&
                        (DateTime.Now - sdir.LastWriteTime).TotalDays >= iAge)
                    {
                        sdir.Delete();
                    }
                    else
                    {
                        AgeOutFiles(sdir, iAge);
                        AgeOutSubFolders(sdir, iAge);
                    }
                }
            }
        }

        public static void AgeOutSubFolders(DirectoryInfo subFolder, int iAge)
        {
            try
            {
                foreach (var dirs in subFolder.GetDirectories())
                {
                    if ((DateTime.Now - dirs.LastWriteTime).TotalDays >= iAge)
                    {
                        dirs.Delete(true);
                    }
                    else
                    {
                        AgeOutFiles(subFolder, iAge);
                        AgeOutSubFolders(dirs, iAge);
                    }
                }
            }
            catch (Exception e)
            {
                ClsLogfile.Writelog(string.Format("Failed to run AgeOutSubFolders. Error: {0}", e));
            }
        }

        public static void AgeOutFiles(DirectoryInfo dir, int iAge)
        {
            foreach (var file in dir.GetFiles())
            {
                if ((DateTime.Now - file.CreationTime).TotalDays >= iAge) file.Delete();
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="sVmName"></param>
        /// <param name="sVmmName"></param>
        /// <returns></returns>
        public static List<Vhdx> GetVhdxFilesForVm(string sVmName, string sVmmName)
        {
            string sHostName;
            int lun;
            string state;
            var vhdxs = new List<Vhdx>();
            //ClsVmmDisks.GetVmmGuest(sVmmName, sVmName, out lun, out sHostName, out state);
            //var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = sVmmName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = sVmmName };
            //
            //var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            //runspace.Open();
            //
            //var disks = ClsGetVol.GetVolShare(sHostName);
            //foreach (var disk in disks)
            //{
            //    if (disk.Purpose.ToLower() == "data" || disk.Purpose.ToLower() == "log")
            //    {
            //        var pipe = runspace.CreatePipeline();
            //        pipe.Commands.AddScript(
            //            string.Format("Get-ChildItem -File -Path '{0}\\{1}' | select name, directory, length",
            //                disk.Caption, sVmName.Split('.')[0]));
            //        var res = pipe.Invoke();
            //        vhdxs.AddRange(res.Select(o => new Vhdx
            //        {
            //            Name = o.Members["name"].ToString(),
            //            Host = sHostName,
            //            Vm = sVmName,
            //            Size = o.Members["length"].ToString(),
            //            Path = o.Members["directory"].ToString()
            //        }));
            //        pipe.Dispose();
            //    }
            //}
            //runspace.Close();
            return vhdxs;
        }

        /// <summary>
        /// </summary>
        /// <param name="sVmName"></param>
        /// <param name="sSqlVer"></param>
        /// <returns></returns>
        public static List<MountPoint> GetMountPointForVm(string sVmName, string sSqlVer)
        {
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = sVmName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = sVmName };

            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var mps = new List<MountPoint>();
            pipe.Commands.AddScript(
                string.Format("Get-ChildItem -File -Path '{0}\\SQL{1}\\SQLData' | select name, fullname", ClsTimer.Settings.MDFPath, sSqlVer));
            var resdata = pipe.Invoke();
            mps.AddRange(resdata.Select(o => new MountPoint
            {
                Name = o.Members["name"].ToString(),
                Vm = sVmName,
                Path = o.Members["fullname"].ToString()
            }));
            var pipe2 = runspace.CreatePipeline();
            pipe2.Commands.AddScript(
                string.Format("Get-ChildItem -File -Path '{0}\\SQL{1}\\SQLLog' | select name, fullname", ClsTimer.Settings.LDFPath, sSqlVer));
            var reslog = pipe2.Invoke();
            mps.AddRange(reslog.Select(o => new MountPoint
            {
                Name = o.Members["name"].ToString(),
                Vm = sVmName,
                Path = o.Members["fullname"].ToString()
            }));
            runspace.Close();
            return mps;
        }
    }

    /// <summary>
    /// </summary>
    public class MountPoint
    {
        /// <summary>
        /// </summary>
        private string _name;

        /// <summary>
        /// </summary>
        private string _path;

        /// <summary>
        /// </summary>
        private string _vm;

        /// <summary>
        /// </summary>
        public string Vm
        {
            get { return _vm; }
            set { _vm = Setval(value); }
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
        public string Path
        {
            get { return _path; }
            set { _path = Setval(value); }
        }

        /// <summary>
        ///     Sets Values for strings
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private string Setval(string val)
        {
            return val;
        }
    }

    /// <summary>
    /// </summary>
    public class Vhdx
    {
        /// <summary>
        /// </summary>
        private static string _name;

        /// <summary>
        /// </summary>
        private static string _vm;

        /// <summary>
        /// </summary>
        private static string _size;

        /// <summary>
        /// </summary>
        private static string _host;

        /// <summary>
        /// </summary>
        private static string _path;

        /// <summary>
        /// </summary>
        public string Name
        {
            get { return _name; }
            set { _name = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Vm
        {
            get { return _vm; }
            set { _vm = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Size
        {
            get { return _size; }
            set { _size = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Host
        {
            get { return _host; }
            set { _host = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Path
        {
            get { return _path; }
            set { _path = Setval(value); }
        }

        /// <summary>
        ///     Sets Values for strings
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private string Setval(string val)
        {
            return val;
        }
    }
}