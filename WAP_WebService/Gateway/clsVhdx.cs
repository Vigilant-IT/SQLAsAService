using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Permissions;
using System.Text;
using System.Threading.Tasks;

namespace Gateway
{
    public class RGVHDX
    {
        public int DiskId { get; set; }
        public int RgId { get; set; }
        public string VhdxPath { get; set; }
        public int VhdxLunId { get; set; }
        public int VhdxBusId { get; set; }
        public int SvrId { get; set; }
        public string Purpose { get; set; }
        public int VhdxSetNum { get; set; }
        public int CurrentPrimary { get; set; }
        public string LocalPath { get; set; }
    }
    class clsVhdx
    {
        internal static string SqlInfoMessage;
        public static RGVHDX AttachNewVhdxToRg(string strVmName, string strVmmname ,string strPurpose, string strHiPer, string strSqlVer, int intSetNum, string strRgName,string strSqlServer, string strSqlDb)
        {
            string VMHost;
            string VMStatus;
            var strdiskperf = strHiPer == "HighPerformance" ? "HiPo" : "STD";
            ClsVmmDisks.GetVmmGuest(strVmmname, strVmName.Split('.')[0], out VMHost, out VMStatus);
            var disk = ClsVmmDisks.GetVmmLunDetails(strVmmname, strVmName);
            var vol = ClsGetVol.GetVolShare(VMHost,strPurpose,strHiPer);
            //TODO: Validate that we are still only using Data and Log, and not Data, Log, DataHP, and LogHP
            disk.Purpose = strPurpose;
            disk.VhdxSetNum = intSetNum;
            disk.VhdxPath = string.Format("{0}{1}\\{2}_{1}_{3}_{4}_{5}.vhdx", vol.Caption, strRgName, strVmName.Split(',')[0],intSetNum,strdiskperf ,strPurpose);
            if (string.IsNullOrEmpty(disk.VhdxPath)) throw new Exception(string.Format("No path found to create the {0} VHDX", strPurpose));
            if (!ClsFileSystem.DoesLocalFolderExist(VMHost, disk.VhdxPath))
                if (!ClsFileSystem.CreateLocalFolder(VMHost, disk.VhdxPath)) throw new Exception(string.Format("Could not create Folder:{0} on host:{1}", disk.VhdxPath, VMHost));
            disk.LocalPath = string.Format("{0}\\SQL{1}\\SQL{2}\\{3}_{4}\\{5}", ClsTimer.Settings.MDFPath, strSqlVer, strPurpose, strRgName, strdiskperf, intSetNum);
            if (VMStatus != "running") ClsVmmDisks.RepairVmmGuest(strVmmname, strVmName.Split('.')[0]);
            if (!ClsVmmDisks.NewVmDisk(strVmmname, strVmName.Split('.')[0], disk.VhdxLunId, disk.VhdxBusId, 1024, disk.VhdxPath, 0, 0)) throw new Exception(string.Format("Error attching VHDX: {0} to VM: {1} on Bus: {2} Lun: {3}", disk.VhdxPath, strVmName.Split('.')[0], disk.VhdxBusId, disk.VhdxLunId));
            if (!ClsVmmDisks.MountandFormat(strVmName, 65536, strRgName, disk.LocalPath, strPurpose)) throw new Exception(string.Format("Error Mounting and formatting VHDX: {0} to VM {1} to Path: {2}", disk.VhdxPath, strVmName, disk.LocalPath));
            ClsVmmDisks.GetVmmGuest(strVmmname, strVmName.Split('.')[0], out VMHost, out VMStatus);
            if (VMStatus != "running") ClsVmmDisks.RepairVmmGuest(strVmmname, strVmName.Split('.')[0]);
            disk.Purpose = strHiPer == "HighPerformance" ? strPurpose + "_HiPo" : strPurpose + "_STD";
            return disk;
        }

        public static bool AddNewVhdxToGwDb(RGVHDX vhdx, string strSqlServer, string strSqlDb)
        {
            SqlInfoMessage = null;
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    string.Format("INSERT INTO [dbo].[RgVhdx]([RgId],[SvrId],[VhdxPath],[VhdxLunId],[VhdxBusId],[Purpose],[VhdxSetNum],[CurrentPrimary],[LocalPath])VALUES({0},{1},'{2}',{3},{4},'{5}',{6},{7},'{8}')",
                    vhdx.RgId, vhdx.SvrId,vhdx.VhdxPath,vhdx.VhdxLunId,vhdx.VhdxBusId,vhdx.Purpose,vhdx.VhdxSetNum,vhdx.CurrentPrimary,vhdx.LocalPath);
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to Update RgJob table", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to Update RgJob table");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return SqlInfoMessage == null;
        }
        public static bool UpdateRgVhdxAllocation(int strRgId, int strSetNum, string strSqlServer, string strSqlDb)
        {
            SqlInfoMessage = null;
            using (
                var sc =
                    new SqlConnection(
                        string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                            strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText =
                    string.Format("update RgConfig set [VHDXSetNum] = '{0}' where RgId = {1}",
                    strSetNum, strRgId);
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to Update RgConfig VHDX Config table", true);
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to Update RgConfig VHDX Config table");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return SqlInfoMessage == null;
        }

        public static List<RGVHDX> GetRgVhdxDiskSet(string strSqlServer, string strSqlDb, string strRgId, string strSvrId)
        {

            var reqs = new List<RGVHDX>();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText = string.Format("SELECT DiskId, rgvhdx.RgId,SvrId,VhdxPath,VhdxLunId,VhdxBusId,Purpose,CurrentPrimary, rgvhdx.VhdxSetNum,LocalPath " +
                                                "FROM RgVhdx join RGConfig on rgvhdx.RgId = RGConfig.rgid " +
                                                "where rgvhdx.VhdxSetNum = RGConfig.VhdxSetNum and rgvhdx.RgId = {0} and rgvhdx.svrId = {1}", strRgId, strSvrId);
                try
                {
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            reqs.Add(new RGVHDX
                            {
                                RgId = int.Parse(dr["RGID"].ToString()),
                                SvrId = int.Parse(dr["SvrId"].ToString()),
                                CurrentPrimary = int.Parse(dr["CurrentPrimary"].ToString()),
                                DiskId = int.Parse(dr["DiskId"].ToString()),
                                VhdxPath= dr["VhdxPath"].ToString(),
                                Purpose = dr["Purpose"].ToString(),
                                VhdxBusId = int.Parse(dr["VhdxBusId"].ToString()),
                                VhdxLunId = int.Parse(dr["VhdxLunId"].ToString()),
                                LocalPath = dr["LocalPath"].ToString(),
                                VhdxSetNum = int.Parse(dr["VhdxSetNum"].ToString()),
                            });
                        }
                    }
                }
                catch (Exception)
                {
                    //TODO: Handle ex
                    sc.Close();
                    return null;
                }
                sc.Close();
                return reqs;
            }
        }
        static void conn_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            SqlInfoMessage = e.Message;
        }
    }
    
}
