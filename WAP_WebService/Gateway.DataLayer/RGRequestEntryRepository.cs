using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Gateway.DataLayer
{
    public interface IRgRequestEntryRepository
    {
        bool RgExist(string strRgName);
        void CreateRgRequest(IRgReq strRgName);
        IEnumerable<IRgReq> GetRgRequestEntry(string strRgName);
    }

    public class RgRequestEntryRepository : IRgRequestEntryRepository
    {
        private readonly string _connectionstring;
        private readonly ICodeRepository _codeRepository;
        private readonly ILog _log;

                /// <summary>
        /// Constructor will generate connection string to connect to the database.
        /// Assumption: Database will always be on default instance.
        /// </summary>
        /// <param name="sqlServerName">SQL server netbios or dns name.</param>
        /// <param name="dbName">Database name</param>
        /// <param name="codeRepository">An instance of a code repository.</param>
        /// <param name="log">Instance of a log class (not using static log methods because it breaks unit tests).</param>
        public RgRequestEntryRepository(string sqlServerName, string dbName, ICodeRepository codeRepository, ILog log)
        {
            _codeRepository = codeRepository;
            _log = log;
            _connectionstring = string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                sqlServerName, dbName);

            _log.Writelog(string.Format("Building database connection string for RGRequestEntryRepository: {0}", _connectionstring), true);
        }

        public bool RgExist(string strRgName)
        {
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = "SELECT RgName From RGRequests Where RgName = @strRgName";

                cmd.Parameters.Add(new SqlParameter
                {
                    ParameterName = "strRgName",
                    DbType = DbType.String,
                    Value = strRgName
                });

                var reader = cmd.ExecuteReader();
                var result = reader.HasRows;

                connection.Close();

                return result;
            }
        }

        public void CreateRgRequest(IRgReq rg)
        {
            _log.Writelog("Creating RGRequest...");
            _log.Writelogobject("Creating RGRequest...", rg);
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText =
                    "insert into RgRequests (RgName, Zone, Avail, SqlVer, Dc, Env, Tde, SkuName, Email, RgPassPhrase, ReqTime, Notes)" +
                    "values (@rgname, @zone, @avail, @sqlver, @dc, @env, @tde, @skuname, @email, @passphrase, @reqtime, @notes);" +
                    "select Scope_identity();";
                cmd.Parameters.Add(new SqlParameter {ParameterName = "rgname", DbType = DbType.String, Value = rg.RgName});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "zone", DbType = DbType.String, Value = rg.Zone});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "avail", DbType = DbType.String, Value = rg.Avail});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "sqlver", DbType = DbType.String, Value = rg.SqlVer});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "dc", DbType = DbType.String, Value = rg.Dc});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "env", DbType = DbType.String, Value = rg.Env});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "tde", DbType = DbType.String, Value = rg.Tde});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "skuname", DbType = DbType.String, Value = rg.SkuName});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "email", DbType = DbType.String, Value = rg.Email});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "passphrase", DbType = DbType.String, Value = rg.PassPhrase});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "reqtime", DbType = DbType.DateTime, Value = DateTime.Now});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "notes", DbType = DbType.String, Value = rg.Notes});
                cmd.ExecuteReader();
                connection.Close();
            }
        }

        public IEnumerable<IRgReq> GetRgRequestEntry(string strRgName)
        {
            _log.Writelog(string.Format("Looking up RgRequests Value: {0}", strRgName));

            var returndata = new List<IRgReq>();
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = strRgName == "%"
                    ? "SELECT * FROM RgRequests"
                    : "SELECT * FROM RgRequests WHERE RgName = @RgName";
                cmd.Parameters.Add(new SqlParameter
                {
                    ParameterName = "RgName",
                    DbType = DbType.String,
                    Value = strRgName
                });

                var result = cmd.ExecuteReader();

                while (result.Read())
                {
                    var rgreq = new RgReq
                    {
                        RgId = result["ReqId"].ToString(),
                        RgName = result["RgName"].ToString(),
                        Zone = result["Zone"].ToString(),
                        Avail = result["Avail"].ToString(),
                        SqlVer = result["SqlVer"].ToString(),
                        Dc = result["Dc"].ToString(),
                        Env = result["Env"].ToString(),
                        Tde = result["TDE"].ToString(),
                        SkuName = result["SkuName"].ToString(),
                        Email = result["Email"].ToString(),
                        PassPhrase = result["RgPassPhrase"].ToString(),
                        ReqTime = result["ReqTime"].ToString(),
                        Notes = result["Notes"].ToString()
                    };
                    returndata.Add(rgreq);
                }
            }
            return returndata;
        }
    }
}
