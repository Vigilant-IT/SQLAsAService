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
using System.Management.Automation.Runspaces;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsVmmDisks
    {
        private string _diskname;
        private string _servername;
        private string _size;

        public string DiskName
        {
            get { return _diskname; }
            set { _diskname = Setval(value); }
        }

        public string Size
        {
            get { return _size; }
            set { _size = Setval(value); }
        }

        public string ServerName
        {
            get { return _servername; }
            set { _servername = Setval(value); }
        }

        /// <summary>
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private static string Setval(string val)
        {
            return val;
        }

        /// <summary>
        ///     Get the VM's Settings required for solution, Count of LUN's and VM Hostname
        /// </summary>
        /// <param name="strVmmHost"></param>
        /// <param name="strVm"></param>
        /// <param name="intLun"></param>
        /// <param name="intbus"></param>
        /// <param name="strHostName"></param>
        /// <param name="strStatus"></param>
        public static void GetVmmGuest(string strVmmHost, string strVm, out string strHostName,out string strStatus)
        {
            ClsLogfile.Writelogparam("strVmmHost, strVm", strVmmHost, strVm);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strVmmHost, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strVmmHost };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("Get-SCVirtualMachine");
            command.Parameters.Add("Name", strVm.Split('.')[0]);
            command.Parameters.Add("VMMServer", strVmmHost);
            pipe.Commands.Add(command);
            var commanddisk = new Command("Get-SCVirtualDiskDrive");
            pipe.Commands.Add(commanddisk);
            pipe.Commands.AddScript(
                string.Format(
                    "$vm = Get-SCVirtualMachine -Name {0} -VMMServer {1}; return $vm.hostname + \":\" + $vm.Status",
                    strVm.Split('.')[0], strVmmHost));
            Collection<PSObject> resdisk;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining VM from VMM", true);
                resdisk = pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain VM from VMM", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }

            var strHn = resdisk[0].BaseObject.ToString().Split(':')[0];
            var strState = resdisk[0].BaseObject.ToString().Split(':')[1];
            runspace.Close();
            runspace.Dispose();
            strHostName = strHn;
            strStatus = strState;
        }

        public static RGVHDX GetVmmLunDetails(string strVmm, string strVm)
        {
            var disk = new RGVHDX();
            ClsLogfile.Writelogparam("strVmm, strVm", strVmm, strVm);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strVmm, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strVmm };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("Get-SCVirtualMachine");
            command.Parameters.Add("Name", strVm.Split('.')[0]);
            command.Parameters.Add("VMMServer", strVmm);
            pipe.Commands.Add(command);
            var commanddisk = new Command("Get-SCVirtualDiskDrive");
            pipe.Commands.Add(commanddisk);
            pipe.Commands.AddScript(
                string.Format(
                    "$disk = get-SCVirtualDiskDrive -vm {0} -VMMServer {1} | where bustype -eq \"SCSI\";$Mi = 0;$Mb = 0;foreach ($l in $disk){{if($l.lun -eq $Mi -and $l.bus -eq $Mb){{if($Mi -eq 63){{if($Mb -eq 1){{break}}else{{$Mb++;$Mi = 0}}}}else{{$Mi++}}}}else{{if($mi -eq 6){{$mi++}}else{{break}}}}}}return $Mb.ToString() + \":\" + $Mi.ToString()", strVm.Split('.')[0], strVmm));
            Collection<PSObject> resdisk;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining VM from VMM", true);
                resdisk = pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain VM from VMM", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            disk.VhdxBusId = int.Parse(resdisk[0].BaseObject.ToString().Split(':')[0]);
            disk.VhdxLunId = int.Parse(resdisk[0].BaseObject.ToString().Split(':')[1]);
            return disk;
        }

        /// <summary>
        ///     Obtains the size of the VM Disks for Billing
        /// </summary>
        /// <param name="strVmmHost"></param>
        /// <param name="strVm"></param>
        /// <returns></returns>
        public static List<ClsVmmDisks> GetVmDiskSizes(string strVmmHost, string strVm)
        {
            ClsLogfile.Writelogparam("strVmmHost, strVm", strVmmHost, strVm);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strVmmHost, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strVmmHost };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("Get-SCVirtualHardDisk");
            command.Parameters.Add("Name", strVm.Split('.')[0]);
            command.Parameters.Add("VMMServer", strVmmHost);
            pipe.Commands.Add(command);
            ClsLogfile.Writelogparam("Get Disks from VMM: ",
                string.Format(
                    "Get-SCVirtualHardDisk -VMMServer {1} -vm {0} | select Name,size",
                    strVm.Split('.')[0], strVmmHost));
            pipe.Commands.AddScript(
                string.Format(
                    "Get-SCVirtualHardDisk -VMMServer {1} -vm {0} | select Name,size",
                    strVm.Split('.')[0], strVmmHost));
            Collection<PSObject> resdisk;
            try
            {
                ClsLogfile.Writelog(1, "Obtaining size of Disks on VM", true);
                resdisk = pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to obtain size of Disks on VM", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            //ClsLogfile.Writelogparam("After invoke", count.ToString());
            //ClsLogfile.Writelogparam("Disks variable defined", disks.Length.ToString());
            var disks = resdisk.Select(res => new ClsVmmDisks
            {
                DiskName = res.Members["Name"].Value.ToString(),
                Size = res.Members["size"].Value.ToString(),
                ServerName = strVm
            }).ToList();
            pipe.Stop();
            pipe.Dispose();
            runspace.Close();
            runspace.Dispose();
            return disks;
        }

        /// <summary>
        ///     Resizes the VM Disk
        /// </summary>
        /// <param name="strVmmHost"></param>
        /// <param name="strVm"></param>
        /// <param name="strVmDiskName"></param>
        /// <param name="strGbToAdd"></param>
        /// <returns></returns>
        public static int ResizeVmDisk(string strVmmHost, string strVm, string strVmDiskName, string strGbToAdd)
        {
            ClsLogfile.Writelogparam("strVmmHost, strVm", strVmmHost, strVm);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strVmmHost, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strVmmHost };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("Get-SCVirtualHardDisk");
            command.Parameters.Add("Name", strVm.Split('.')[0]);
            command.Parameters.Add("VMMServer", strVmmHost);
            pipe.Commands.Add(command);
            pipe.Commands.AddScript(
                string.Format(
                    "$d = (Get-SCVirtualMachine \"{0}\" -VMMServer \"{1}\" | Get-SCVirtualDiskDrive | ?{{$_.VirtualHardDisk -like \"{2}.vhdx\"}}).VirtualHardDisk.MaximumSize / 1gb; " +
                    "(Get-SCVirtualMachine \"{0}\" -VMMServer \"{1}\" | Get-SCVirtualDiskDrive | ?{{$_.VirtualHardDisk -like \"{2}.vhdx\"}} | Expand-SCVirtualDiskDrive -VirtualHardDiskSizeGB ($d + {3})).VirtualHardDisk.MaximumSize / 1gb",
                    strVm.Split('.')[0], strVmmHost,strVmDiskName,strGbToAdd));
            Collection<PSObject> resdisk;
            try
            {
                ClsLogfile.Writelog(1, string.Format("Resizing Disk:{0} on VM:{1}", strVmDiskName ,strVm), true);
                resdisk = pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, string.Format("Failed to resize Disk:{0} on VM:{1}", strVmDiskName, strVm), true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            //ClsLogfile.Writelogparam("After invoke", count.ToString());
            //ClsLogfile.Writelogparam("Disks variable defined", disks.Length.ToString());
            var newsize = int.Parse(resdisk[0].BaseObject.ToString());
            pipe.Stop();
            pipe.Dispose();
            runspace.Close();
            runspace.Dispose();
            return newsize;
        }

       /// <summary>
        ///     Get size of VM Disk
        /// </summary>
        /// <param name="strVmmHost"></param>
        /// <param name="strVm"></param>
        /// <param name="strVmDiskName"></param>
        /// <returns></returns>
        public static int GetVmDiskSize(string strVmmHost, string strVm, string strVmDiskName)
        {
            ClsLogfile.Writelogparam("strVmmHost, strVm", strVmmHost, strVm);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strVmmHost, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strVmmHost };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("Get-SCVirtualHardDisk");
            command.Parameters.Add("Name", strVm.Split('.')[0]);
            command.Parameters.Add("VMMServer", strVmmHost);
            pipe.Commands.Add(command);
            pipe.Commands.AddScript(
                string.Format(
                    "(Get-SCVirtualMachine \"{0}\" -VMMServer \"{1}\" | Get-SCVirtualDiskDrive | ?{{$_.VirtualHardDisk -like \"{2}\"}}).VirtualHardDisk.MaximumSize / 1gb",
                    strVm.Split('.')[0], strVmmHost, strVmDiskName));
            Collection<PSObject> resdisk;
            try
            {
                ClsLogfile.Writelog(1, string.Format("Obtaining the size of Disk:{0} on VM:{1}", strVmDiskName, strVm), true);
                resdisk = pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, string.Format("Failed to Obtaining the size of Disk:{0} on VM:{1}", strVmDiskName, strVm), true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            //ClsLogfile.Writelogparam("After invoke", count.ToString());
            //ClsLogfile.Writelogparam("Disks variable defined", disks.Length.ToString());
            var newsize = int.Parse(resdisk[0].BaseObject.ToString());
            pipe.Stop();
            pipe.Dispose();
            runspace.Close();
            runspace.Dispose();
            return newsize;
        }

        /// <summary>
        ///     Function to refresh a VM within VMM - used for billing as sizes needed to be updated
        /// </summary>
        /// <param name="strVmmHost"></param>
        /// <param name="strVm"></param>
        public static void RefreshVmmGuest(string strVmmHost, string strVm)
        {
            ClsLogfile.Writelogparam("strVmmHost, strVm", strVmmHost, strVm);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strVmmHost, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strVmmHost };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            ClsLogfile.Writelogparam("strVM", strVm);
            pipe.Commands.AddScript(string.Format("Read-SCVirtualMachine -VM {0}", strVm));
            try
            {
                ClsLogfile.Writelog(1, "Refresh VM", true);
                pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to refresh VM", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            runspace.Close();
            runspace.Dispose();
        }

        /// <summary>
        ///     Repairs the VM in VMM to ensure it is in a usable state
        /// </summary>
        /// <param name="strVmmHost"></param>
        /// <param name="strVm"></param>
        public static void RepairVmmGuest(string strVmmHost, string strVm)
        {
            ClsLogfile.Writelogparam("strVmmHost, strVm", strVmmHost, strVm);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strVmmHost, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strVmmHost };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            pipe.Commands.AddScript(
                string.Format("Get-SCVirtualMachine -Name {0} -VMMServer {1} | Repair-SCVirtualMachine -Dismiss", strVm,
                    strVmmHost));
            try
            {
                ClsLogfile.Writelog(1, "Repairing VM", true);
                pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to repair VM", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            var info = pipe.PipelineStateInfo;
            if (info.State != PipelineState.Completed)
            {
                throw new Exception(string.Format("Attempting to repair VM {0} on VMM server {1} but failed with the following error: {2}", strVm, strVmmHost, info.Reason));
            }
            runspace.Close();
            runspace.Dispose();
        }

        /// <summary>
        ///     Create a new VHDX and attached to a running VM, and set IOP's on the disk
        /// </summary>
        /// <param name="strVmmHost"></param>
        /// <param name="strVm"></param>
        /// <param name="intLun"></param>
        /// <param name="intDiskSize"></param>
        /// <param name="strFilePath"></param>
        /// <param name="strHostname"></param>
        /// <param name="intMiniops"></param>
        /// <param name="intMaxiops"></param>
        public static bool NewVmDisk(string strVmmHost, string strVm, int intLun, int intbus, int intDiskSize, string strFilePath,
            int intMiniops, int intMaxiops)
        {
            ClsLogfile.Writelogparam(
                "strVMMHost,  strVM, intLUN, intDiskSize,  strFilePath,  strHostname, intMINIOPS, intMAXIOPS",
                strVmmHost, strVm, intLun.ToString(), intDiskSize.ToString(), strFilePath,
                intMiniops.ToString(), intMaxiops.ToString());
            var strfile = strFilePath.Substring(strFilePath.LastIndexOf('\\') + 1);
            var strvhdxpath = strFilePath.Substring(0, strFilePath.LastIndexOf('\\'));
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strVmmHost, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strVmmHost };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            // get VM
            var commandvm = new Command("Get-SCVirtualMachine");
            commandvm.Parameters.Add("Name", strVm);
            commandvm.Parameters.Add("VMMServer", strVmmHost);
            pipe.Commands.Add(commandvm);
            //Create new Disk
            var commandnewdisk = new Command("New-SCVirtualDiskDrive");
            commandnewdisk.Parameters.Add("VMMServer", strVmmHost);
            commandnewdisk.Parameters.Add("SCSI");
            commandnewdisk.Parameters.Add("Bus", intbus);
            commandnewdisk.Parameters.Add("LUN", intLun);
            commandnewdisk.Parameters.Add("VirtualHardDiskSizeMB", intDiskSize);
            commandnewdisk.Parameters.Add("Dynamic");
            commandnewdisk.Parameters.Add("VolumeType", "None");
            commandnewdisk.Parameters.Add("FileName", strfile);
            pipe.Commands.Add(commandnewdisk);
            //Move Disk
            pipe.Commands.AddScript(
                string.Format(
                    "$moveVHDXGrpID = [Guid]::NewGuid().ToString();" +
                    "$vm = Get-SCVirtualMachine -Name \"{0}\";" +
                    "$VMDisk = Get-SCVirtualHardDisk -vm $vm | where Name -eq '{1}';  " +
                    "Move-SCVirtualHardDisk -Path {2} -VirtualHardDisk $VMDisk -JobGroup $moveVHDXGrpID;$vm = Get-SCVirtualMachine -Name \"{0}\";" +
                    "Set-SCVirtualMachine -VM $vm -JobGroup $moveVHDXGrpID -RunAsynchronously",
                    strVm, strfile, strvhdxpath));
            //SetIOPS if intMINIOPS & intMAXIOPS not equal to 0
            //if ((intMAXIOPS != 0) && (intMINIOPS != 0))
            //{
            //    //pipe.Commands.AddScript(string.Format("$VMDisk = Get-VMHardDiskDrive -computername {0} -VMName {1}  | where path -eq '{2}'; Set-VMHardDiskDrive -VMHardDiskDrive $VMDisk -MaximumIOPS {3} -MinimumIOPS {4}", strHostname, strVM, strFilePath, intMINIOPS, intMAXIOPS));
            //}
            try
            {
                ClsLogfile.Writelog(1, "Creating new VHDX", true);
                pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to create new VHDX", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            var info = pipe.PipelineStateInfo;
            runspace.Close();
            runspace.Dispose();
            return info.State == PipelineState.Completed;
        }

        /// <summary>
        ///     Mounts the newly presented hard drive and formats.
        /// </summary>
        /// <param name="strCompName"></param>
        /// <param name="intBlockSize"></param>
        /// <param name="strLabel"></param>
        /// <param name="strMountPath"></param>
        /// <param name="strDrivePurpose"></param>
        public static bool MountandFormat(string strCompName, int intBlockSize, string strLabel, string strMountPath,
            string strDrivePurpose)
        {
            ClsLogfile.Writelogparam("strCompName, intBlockSize,  strLabel,  strMountPath,  strDrivePurpose",
                strCompName, intBlockSize.ToString(), strLabel, strMountPath, strDrivePurpose);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strCompName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strCompName };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            var command = new Command("New-Item");
            command.Parameters.Add("ItemType", "Directory");
            command.Parameters.Add("Path", strMountPath);
            pipe.Commands.Add(command);
            var strShortName = strLabel.Substring(0, Math.Min(strLabel.Length, 25)) + strDrivePurpose;
            pipe.Commands.AddScript(
                string.Format(
                    "$DiskDetails = get-disk | Where partitionstyle -eq 'raw'; $DiskDetails | Initialize-Disk -partitionstyle GPT -PassThru; $DiskDetails | New-Partition -UseMaximumSize; Add-PartitionAccessPath -DiskNumber $DiskDetails.Number -AccessPath {0} -PartitionNumber 2; Get-Partition -DiskNumber $DiskDetails.Number -PartitionNumber 2 | Format-Volume -FileSystem NTFS -AllocationUnitSize {1} -NewFileSystemLabel {2} -Confirm:$false",
                    strMountPath, intBlockSize, strShortName));
            try
            {
                ClsLogfile.Writelog(1, "Mounting and Formatting new Disk", true);
                pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to mount and format new Disk", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            var info = pipe.PipelineStateInfo;
            runspace.Close();
            runspace.Dispose();
            return info.State == PipelineState.Completed;
        }

        /// <summary>
        ///     Removes the Mount point and directory from the VM
        /// </summary>
        /// <param name="strCompName"></param>
        /// <param name="strDBName"></param>
        /// <param name="strSQLVer"></param>
        /// <returns></returns>
        public static bool Unmount(string strCompName, string strDBName, string strSQLVer)
        {
            ClsLogfile.Writelogparam("strCompName, strDBName, strSQLVer", strCompName, strDBName, strSQLVer);
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ? new WSManConnectionInfo { ComputerName = strCompName, AuthenticationMechanism = AuthenticationMechanism.Negotiate } : new WSManConnectionInfo { ComputerName = strCompName };
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            pipe.Commands.AddScript(
                string.Format(
                "Get-Partition | where {{$_.accesspaths -like '{0}'}} | Remove-Partition -confirm:$false; cmd.exe /c rmdir {3}\\SQL{1}\\SQLLog\\{0}; cmd.exe /c rmdir {2}\\SQL{1}\\SQLdata\\{0}",
                strDBName, strSQLVer, ClsTimer.Settings.MDFPath, ClsTimer.Settings.LDFPath));

            try
            {
                ClsLogfile.Writelog(1, "Unmounting Disk", true);
                pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to unmount disk", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            runspace.Close();
            runspace.Dispose(); 
            return !pipe.HadErrors;
        }

        /// <summary>
        ///     Removes the VHDX's from the VM in VMM
        /// </summary>
        /// <param name="strVm"></param>
        /// <param name="strVmm"></param>
        /// <param name="strDBName"></param>
        /// <returns></returns>
        public static bool RemoveVhdx(string strVm, string strVmm, string strDBName)
        {
            ClsLogfile.Writelogparam("strVm, strVmm, strDBName", strVm, strVmm, strDBName);
            RepairVmmGuest(strVmm, strVm);
            char[] svrfstltr = strDBName.Substring(0, 1).ToCharArray();
            var connectionInfo = ClsTimer.Settings.PoSHKebCheck ?  new WSManConnectionInfo{ComputerName = strVmm, AuthenticationMechanism = AuthenticationMechanism.Negotiate} : new WSManConnectionInfo{ComputerName = strVmm};
            var runspace = RunspaceFactory.CreateRunspace(connectionInfo);
            runspace.Open();
            var pipe = runspace.CreatePipeline();
            pipe.Commands.AddScript(
                string.Format(
                    "(Get-SCVirtualMachine -Name '{0}' -VMMServer {2}).VirtualDiskDrives | where {{$_.VirtualHardDisk -like '*{1}*'}} | Remove-SCVirtualDiskDrive",
                    strVm, strDBName.TrimStart(svrfstltr), strVmm));
            try
            {
                ClsLogfile.Writelog(1, "Removing VHDX", true);
                pipe.Invoke();
            }
            catch (Exception)
            {
                ClsLogfile.Writelog(3, "Failed to remove VHDX", true);
                runspace.Close();
                runspace.Dispose();
                throw;
            }
            runspace.Close();
            runspace.Dispose();
            return !pipe.HadErrors;
        }
    }
}