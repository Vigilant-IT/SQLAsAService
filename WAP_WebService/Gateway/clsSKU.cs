using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gateway
{
    class clsSKU
    {
        public string SKUID { get; set; }
        public string NAME { get; set; }
        public string MEMORY { get; set; }
        public string CORES { get; set; }
        public string CHECKSUM { get; set; }
        public string VISIBLE { get; set; }
        public string MICRODB { get; set; }
        public string ELASTICDB { get; set; }

        public static List<clsSKU> GetALLSKUs(string sSqlServer, string sGwdb)
        {
            ClsLogfile.Writelogparam("sSqlServer,  sGwdb", sSqlServer, sGwdb);
            var lSKU = new List<clsSKU>();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        sSqlServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = "select * from SKUConfig";
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining SKUs", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            var sku = new clsSKU
                            {
                                SKUID = dr["SKUID"].ToString(),
                                NAME = dr["Name"].ToString(),
                                MEMORY = dr["Memory"].ToString(),
                                CORES = dr["Cores"].ToString(),
                                CHECKSUM = dr["Checksum"].ToString(),
                                VISIBLE = dr["Visible"].ToString(),
                                MICRODB = dr["MicroDB"].ToString(),
                                ELASTICDB = dr["Elasticdb"].ToString()
                            };
                            lSKU.Add(sku);
                        }
                    }
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain SKUs", true);
                    throw;
                }
                sc.Close();
                return lSKU;
            }
        }
        public static clsSKU GetSKU(string sSqlServer, string sGwdb, string sSKUName)
        {
            ClsLogfile.Writelogparam("sSqlServer,  sGwdb", sSqlServer, sGwdb);
            var SKU = new clsSKU();
            using (
                var sc =
                    new SqlConnection(string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                        sSqlServer, sGwdb)))
            using (var cmd = sc.CreateCommand())
            {
                sc.Open();
                cmd.CommandText = string.Format("select top 1 * from SKUConfig where name = '{0}'", sSKUName);
                try
                {
                    ClsLogfile.Writelog(1, "Obtaining SKUs", true);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            SKU.SKUID = dr["SKUID"].ToString();
                            SKU.NAME = dr["Name"].ToString();
                            SKU.MEMORY = dr["Memory"].ToString();
                            SKU.CORES = dr["Cores"].ToString();
                            SKU.CHECKSUM = dr["Checksum"].ToString();
                            SKU.VISIBLE = dr["Visible"].ToString();
                            SKU.MICRODB = dr["MicroDB"].ToString();
                            SKU.ELASTICDB = dr["Elasticdb"].ToString();
                        }
                    }
                }
                catch (Exception)
                {
                    ClsLogfile.Writelog(3, "Failed to obtain SKUs", true);
                    sc.Close();
                    throw;
                }
                sc.Close();
                return SKU;
            }
        }
    }
}
