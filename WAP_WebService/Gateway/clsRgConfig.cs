using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gateway
{
    class clsRgConfig
    {
        internal static string SqlInfoMessage;
        static void conn_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            SqlInfoMessage = e.Message;
        }
        public class RgConfig
        {
            public int RgId { get; set; }
            public string RgName { get; set; }
            public int SvrId { get; set; }
            public int SkuId { get; set; }
            public string PassPhrase { get; set; }
            public string SubId { get; set; }
            public string PlanId { get; set; }
            public int StartCore { get; set; }
            public int EndCore { get; set; }
            public int VhdxSetNum { get; set; }
        }

        public static RgConfig GetRgConfig(string strSqlServer, string strSqlDb, string strRgName)
        {
            var config = new RgConfig();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText = string.Format("select * from RgConfig where RgName = '{0}'", strRgName);
                try
                {
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            config.RgId = int.Parse(dr["RgId"].ToString());
                            config.RgName = dr["RgName"].ToString();
                            config.SvrId = int.Parse(dr["ServerID"].ToString());
                            config.SkuId = int.Parse(dr["SKUID"].ToString());
                            config.PassPhrase = dr["Passphrase"].ToString();
                            config.SubId = dr["SubId"].ToString();
                            config.PlanId = dr["PlanId"].ToString();
                            config.StartCore = int.Parse(dr["StartCore"].ToString());
                            config.EndCore = int.Parse(dr["EndCore"].ToString());
                            config.VhdxSetNum = int.Parse(dr["VHDXSetNum"].ToString());
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
                return config;
            }
        }
        public static bool NewRgConfig(string strSqlServer, string strSqlDb, RgConfig objRgConfig)
        {
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        strSqlServer, strSqlDb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                sc.InfoMessage += conn_InfoMessage;
                cmd.CommandText = string.Format("insert into RgConfig ([RGID],[RGName],[ServerID],[SKUID],[Passphrase],[SubID],[PlanID],[StartCore],[EndCore],[VHDXSetNum]) " +
                                                "values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}',{9})",
                                                objRgConfig.RgId,
                                                objRgConfig.RgName,
                                                objRgConfig.SvrId,
                                                objRgConfig.SkuId,
                                                objRgConfig.PassPhrase,
                                                objRgConfig.SubId,
                                                objRgConfig.PlanId,
                                                objRgConfig.StartCore,
                                                objRgConfig.EndCore,
                                                objRgConfig.VhdxSetNum);
                try
                {
                    cmd.ExecuteReader();
                }
                catch (Exception)
                {
                    //TODO: Handle ex
                    sc.Close();
                    return true;
                }
                sc.Close();
                return SqlInfoMessage == null;
            }
        }
        public static bool UpdateRgConfig(string strSqlServer, string strSqlDb, string strRgName, int intSvrId, string strRgJobetting, string strValue)
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
                    string.Format("update RgConfig set [{0}] = '{1}' where RgName = '{2}' and ServerID = {3}", strRgJobetting, strValue, strRgName, intSvrId);
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
    }
}
