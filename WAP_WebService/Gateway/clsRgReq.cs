using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gateway
{
    class clsRgReq
    {
        internal static string SqlInfoMessage;

        public class RgReq
        {
            public string RgName { get; set; }
            public string Zone { get; set; }
            public string Avail { get; set; }
            public string SqlVer { get; set; }
            public string Dc { get; set; }
            public string Env { get; set; }
            public string Tde { get; set; }
            public string SkuName { get; set; }
            public string MdfPerf { get; set; }
            public string LdfPerf { get; set; }
            public string Email { get; set; }
            public string RgPassPhrase { get; set; }
            public string Notes { get; set; }
            public int ReqId { get; set; }
        }

        public static List<RgReq> GetAllRgRequests(string strSqlServer, string strSqlDb)
        {
            var reqs = new List<RgReq>();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText = "select req.*, job.Notes as note from RGRequests as req inner join RGJob as job on req.ReqId = job.RGID";
                try
                {
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            reqs.Add(new RgReq
                            {
                                SkuName = dr["SkuName"].ToString(),
                                Avail = dr["Avail"].ToString(),
                                ReqId = int.Parse(dr["ReqId"].ToString()),
                                RgName = dr["RgName"].ToString(),
                                Zone = dr["Zone"].ToString(),
                                SqlVer = dr["SqlVer"].ToString(),
                                Dc = dr["DC"].ToString(),
                                Env = dr["ENV"].ToString(),
                                Tde = dr["TDE"].ToString(),
                                Email = dr["Email"].ToString(),
                                RgPassPhrase = dr["RgPassPhrase"].ToString(),
                                Notes = dr["Note"].ToString()
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
                return reqs.Where<RgReq>(r => r.Notes != "Completed").ToList<RgReq>();
            }
        }

        public static RgReq GetRgRequestById(string strSqlServer, string strSqlDb, int intRgId)
        {
            var req = new RgReq();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText = string.Format("select req.*, job.Notes from RGRequests as req join RGJob as job on req.ReqId = job.RGID where job.rgid = {0}", intRgId);
                try
                {
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            req = new RgReq
                            {
                                SkuName = dr["SkuName"].ToString(),
                                Avail = dr["Avail"].ToString(),
                                ReqId = int.Parse(dr["ReqId"].ToString()),
                                RgName = dr["RgName"].ToString(),
                                Zone = dr["Zone"].ToString(),
                                SqlVer = dr["SqlVer"].ToString(),
                                Dc = dr["DC"].ToString(),
                                Env = dr["ENV"].ToString(),
                                Tde = dr["TDE"].ToString(),
                                Email = dr["Email"].ToString(),
                                RgPassPhrase = dr["RgPassPhrase"].ToString(),
                                Notes = dr["Notes"].ToString()
                            };

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
                return req;
            }
        }
        static void conn_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            SqlInfoMessage = e.Message;
        }
    }
}
