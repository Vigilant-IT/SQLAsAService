using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Gateway.DataLayer
{
    public interface IDbRequestEntryRepository
    {
        bool DbExist(string strDbName);
        void CreateDbRequest(IDbReq db);
        IEnumerable<IDbReq> GetDbRequestEntry(string strDbName);
    }

    public class DbRequestEntryRepository : IDbRequestEntryRepository
    {
        private readonly string _connectionstring;
        private readonly ICodeRepository _codeRepository;
        private readonly ILog _log;

        public DbRequestEntryRepository(string sqlServerName, string dbName, ICodeRepository codeRepository, ILog log)
        {
            _codeRepository = codeRepository;
            _log = log;
            _connectionstring = string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                sqlServerName, dbName);

            _log.Writelog(string.Format("Building database connection string for RGRequestEntryRepository: {0}", _connectionstring), true);
        }

        public bool DbExist(string strDbName)
        {
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = "SELECT RgId From DbRequests Where DbName = @strDbName";
                cmd.Parameters.Add(new SqlParameter
                {
                    ParameterName = "strDbName",
                    DbType = DbType.String,
                    Value = strDbName
                });
                var reader = cmd.ExecuteReader();
                var result = reader.HasRows;
                connection.Close();
                return result;
            }
        }

        public void CreateDbRequest(IDbReq db)
        {
            _log.Writelog("Creating DbRequest...");
            _log.Writelogobject("Creating DbRequest...", db);
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = "insert into DBRequests (RGID,DBName,Collation,ListenerName,DBOGrp,PwrGrp,StdGrp,Size,AOGName,IP)" +
                    "values (@RGID,@DBName,@Collation,@ListenerName,@DBOGrp,@PwrGrp,@StdGrp,@Size,@AOGName,@IP);" +
                    "select Scope_identity();";
                cmd.Parameters.Add(new SqlParameter { ParameterName = "RGID", DbType = DbType.String, Value = db.RgId });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "DBName", DbType = DbType.String, Value = db.DbName });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "Collation", DbType = DbType.String, Value = db.Collation });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "ListenerName", DbType = DbType.String, Value = db.ListenerName });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "DBOGrp", DbType = DbType.String, Value = db.DboGrp });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "PwrGrp", DbType = DbType.String, Value = db.PwrGrp });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "StdGrp", DbType = DbType.String, Value = db.StdGrp });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "Size", DbType = DbType.String, Value = db.Size });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "AOGName", DbType = DbType.String, Value = db.AogName });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "IP", DbType = DbType.String, Value = db.Ip });
                cmd.ExecuteReader();
                connection.Close();
            }
        }
        
        public IEnumerable<IDbReq> GetDbRequestEntry(string strDbName)
        {
            _log.Writelog(string.Format("Looking up DbRequests Value: {0}", strDbName));

            var returndata = new List<IDbReq>();
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = strDbName == "%"
                    ? "SELECT * FROM DbRequests"
                    : "SELECT * FROM DbRequests WHERE DbName = @DbName";
                cmd.Parameters.Add(new SqlParameter
                {
                    ParameterName = "DbName",
                    DbType = DbType.String,
                    Value = strDbName
                });

                var result = cmd.ExecuteReader();

                var cols = new List<string>();

                for (int i = 0; i < result.FieldCount; i++)
                    cols.Add(result.GetName(i));


                    while (result.Read())
                    {
                        var dbreq = new DbReq
                        {
                            RgId = result["RGID"].ToString(),
                            DbName = result["DBName"].ToString(),
                            Collation = result["Collation"].ToString(),
                            ListenerName = result["ListenerName"].ToString(),
                            DboGrp = result["DBOGrp"].ToString(),
                            PwrGrp = result["PwrGrp"].ToString(),
                            StdGrp = result["StdGrp"].ToString(),
                            Size = result["Size"].ToString(),
                            AogName = result["AOGName"].ToString(),
                            Ip = result["IP"].ToString(),
                            Notes = result["Notes"].ToString(),
                            ConnectionString = result["ConnectionString"].ToString()

                        };
                        returndata.Add(dbreq);
                    }
            }
            return returndata;
        }
    }
}