using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gateway
{
    class clsSvrConfig
    {
        internal static string SqlInfoMessage;
        public class SvrConfig
        {
            public int SvrId { get; set; }
            public string VmmName { get; set; }
            public string VmName { get; set; }
            public string PtrVmName { get; set; }
            public string Dc { get; set; }
            public string Env { get; set; }
            public string Zone { get; set; }
            public string Avail { get; set; }
            public string SqlVer { get; set; }
            public string Cores { get; set; }
            public string Tde { get; set; }
            public string Ram { get; set; }
        }
        public static SvrConfig GetSvrDetailsById(string strSqlServer, string strSqlDb, int intSvrId)
        {
            var resout = new SvrConfig();
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
                    string.Format("select * from VmSpec where ID = {0}", intSvrId);
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to obtain JobId from RgJob table", true);
                    var res = cmd.ExecuteReader();
                    while (res.Read())
                    {
                        resout.SvrId = int.Parse(res["Id"].ToString());
                        resout.VmmName = res["SCVMM"].ToString();
                        resout.VmName = res["VMName"].ToString();
                        resout.PtrVmName = res["VMNameClusterPartner"].ToString();
                        resout.Dc = res["Dc"].ToString();
                        resout.Env = res["Env"].ToString();
                        resout.Zone = res["Zone"].ToString();
                        resout.Avail = res["Avail"].ToString();
                        resout.SqlVer = res["MSSQL"].ToString();
                        resout.Cores = res["VCore"].ToString();
                        resout.Ram = res["RAM"].ToString();
                        resout.Tde = res["TDE"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain JobId from Update RgJob table");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return resout;
        }
        public static SvrConfig GetSvrDetailsByName(string strSqlServer, string strSqlDb, string strSvrName)
        {
            var resout = new SvrConfig();
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
                    string.Format("select * from VmSpec where VMName = {0}", strSvrName);
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to obtain JobId from RgJob table", true);
                    var res = cmd.ExecuteReader();
                    while (res.Read())
                    {
                        resout.SvrId = int.Parse(res["Id"].ToString());
                        resout.VmmName = res["SCVMM"].ToString();
                        resout.VmName = res["VMName"].ToString();
                        resout.PtrVmName = res["VMNameClusterPartner"].ToString();
                        resout.Dc = res["Dc"].ToString();
                        resout.Env = res["Env"].ToString();
                        resout.Zone = res["Zone"].ToString();
                        resout.Avail = res["Avail"].ToString();
                        resout.SqlVer = res["MSSQL"].ToString();
                        resout.Cores = res["VCore"].ToString();
                        resout.Ram = res["RAM"].ToString();
                        resout.Tde = res["TDE"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain JobId from Update RgJob table");
                    ClsLogfile.Writelog(3, ex.Message, true);
                    sc.Close();
                    throw;
                }
                sc.Close();
            }
            return resout;
        }
        static void conn_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            SqlInfoMessage = e.Message;
        }
    }
}
