using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gateway
{
    class clsRgJob
    {
        internal static string SqlInfoMessage;
        public class RgJob
        {
            public int JobId { get; set; }
            public int RgId { get; set; }
            public int SvrId { get; set; }
            public string MdfPath { get; set; }
            public int MdfLun { get; set; }
            public int MdfBus { get; set; }
            public string LdfPath { get; set; }
            public int LdfLun { get; set; }
            public int LdfBus { get; set; }
            public int StartCore { get; set; }
            public int EndCore { get; set; }
            public string PlanShortName { get; set; }
            public string VhdxAllocated { get; set; }
            public string RgAllocated { get; set; }
            public string WapUserAllocated { get; set; }
            public string WapPlanAllocated { get; set; }
            public string WapSubAllocated { get; set; }
            public string Notes { get; set; }
        }
        public static List<RgJob> GetAllRgJob(string strSqlServer, string strSqlDb)
        {
            var reqs = new List<RgJob>();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText = "select * from RgJob where not Notes like 'Completed%'";
                try
                {
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            reqs.Add(new RgJob
                            {
                                JobId = int.Parse(dr["JobId"].ToString()),
                                RgId = int.Parse(dr["RGID"].ToString()),
                                SvrId = int.Parse(dr["SvrId"].ToString()),
                                MdfPath = dr["MdfPath"].ToString(),
                                MdfBus = int.Parse(dr["MdfBus"].ToString()),
                                MdfLun = int.Parse(dr["MdfLun"].ToString()),
                                LdfPath = dr["LdfPath"].ToString(),
                                LdfBus = int.Parse(dr["LdfBus"].ToString()),
                                LdfLun = int.Parse(dr["LdfLun"].ToString()),
                                StartCore = int.Parse(dr["StartCore"].ToString()),
                                EndCore = int.Parse(dr["EndCore"].ToString()),
                                PlanShortName = dr["PlaShortName"].ToString(),
                                VhdxAllocated = dr["VhdxAllocated"].ToString(),
                                RgAllocated = dr["RgAllocated"].ToString(),
                                WapUserAllocated = dr["WapUserAllocated"].ToString(),
                                WapPlanAllocated = dr["WapPlanAllocated"].ToString(),
                                WapSubAllocated = dr["WapSubAllocated"].ToString(),
                                Notes = dr["Notes"].ToString(),
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
        /// <summary>
        /// 
        /// </summary>
        /// <param name="strSqlServer"></param>
        /// <param name="strSqlDb"></param>
        /// <param name="intRgId"></param>
        /// <param name="strRgJobetting"></param>
        /// <param name="strValue"></param>
        /// <returns></returns>
        public static bool UpdateRgJob(string strSqlServer, string strSqlDb, int intJobId, string strRgJobetting, string strValue)
        {

            SqlInfoMessage = null;
            ClsLogfile.Writelogparam("strSqlServer", strSqlServer);
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
                    string.Format("update RgJob set [{0}] = '{1}' where JobId = {2}", strRgJobetting, strValue,intJobId);
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
        public static bool AddRgJob(string strSqlServer, string strSqlDb,int intRgId,int intSvrId)
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
                    string.Format("insert into RgJob ([RgId],[SvrId]) values ({0},{1})",intRgId,intSvrId);
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
        public static int GetRgJodId(string strSqlServer, string strSqlDb, int intRgId, int intSvrId)
        {
            var resout = 0;
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
                    string.Format("select JobId from RgJob where RgId = {0} and SvrId = {1}", intRgId, intSvrId);
                try
                {
                    ClsLogfile.Writelog(1, "Attempting to obtain JobId from RgJob table", true);
                    var res = cmd.ExecuteReader();
                    while (res.Read())
                    {
                        resout = int.Parse(res["JobId"].ToString());
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
