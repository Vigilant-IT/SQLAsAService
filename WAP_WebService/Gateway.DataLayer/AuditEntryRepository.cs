using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Gateway.DataLayer
{
    /// <summary>
    /// IAuditEntryRepository - to enable unit testing.
    /// </summary>
    public interface IAuditEntryRepository
    {
        IEnumerable<IAuditEntry> GetAuditEntry(string dbName);
        void CreateAuditEntry(IAuditEntry entry);
        void ScheduleDelete(IAuditEntry entry);
        void ScheduleDelete(string dbname);
        bool DBExist(string dbname);
    }

    /// <summary>
    /// This class contains all logic to store and retrive AuditEntry objects from the database.
    /// Keep all audit entry sql here.
    /// </summary>
    public class AuditEntryRepository : IAuditEntryRepository
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
        public AuditEntryRepository(string sqlServerName, string dbName, ICodeRepository codeRepository, ILog log)
        {
            _codeRepository = codeRepository;
            _log = log;
            _connectionstring = string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                sqlServerName, dbName);

            _log.Writelog(string.Format("Building database connection string for AuditEndtryRepository: {0}", _connectionstring), true);
        }

        /// <summary>
        /// Retrieves an auditentry.
        /// Note: Eventually will break this out into 2 methods. One to retrive a single DB object and another to return a list of DBnames.
        /// </summary>
        /// <param name="dbName">Name of database to retrive or % to retrieve all.</param>
        /// <returns>List of auditenterires requested.</returns>
        public IEnumerable<IAuditEntry> GetAuditEntry(string dbName)
        {
            _log.Writelog(string.Format("Looking up Audit Value: {0}", dbName));

            var returndata = new List<IAuditEntry>();
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = dbName == "%"
                    ? "SELECT * FROM Audit"
                    : "SELECT * FROM Audit WHERE DBName = @dbname";
                cmd.Parameters.Add(new SqlParameter {ParameterName = "dbname", DbType = DbType.String, Value = dbName});

                var result = cmd.ExecuteReader();

                while (result.Read())
                {
                    var entry = new AuditEntry
                    {
                        Id = result["ID"].ToString(),
                        State = result["State"].ToString(),
                        DC = result["DC"].ToString(),
                        Username = result["Username"].ToString(),
                        DBName = result["DBName"].ToString(),
                        SQLVer = result["SQLVer"].ToString(),
                        InitialSizeMB = result["InitialSizeMB"].ToString(),
                        Colation = result["Colation"].ToString(),
                        Network = result["Network"].ToString(),
                        Availability = result["Availability"].ToString(),
                        Zone = result["Zone"].ToString(),
                        Sku = result["SKU"].ToString(),
                        StorPerfData = result["StorPerfData"].ToString(),
                        StorPerfLogs = result["StorPerfLogs"].ToString(),
                        Retention = result["Retention"].ToString(),
                        BUDI = result["BUDI"].ToString(),
                        DBoGroup = result["DBoGroup"].ToString(),
                        Recovery = result["Recovery"].ToString(),
                        TDE = result["TDE"].ToString(),
                        Connection = result["Connection"].ToString(),
                        Notes = result["Notes"].ToString(),
                        Logged = result["Logged"].ToString(),
                        Expire = result["Expire"].ToString(),
                        PwrUGroup = result["PwrUGroup"].ToString(),
                        StdUGroup = result["StdUGroup"].ToString()
                    };

                    _log.Writelogobject("Audit entry looked up", entry);

                    returndata.Add(entry);
                }

                connection.Close();
            }

            return returndata;
        }

        /// <summary>
        /// Creates an audit entry in the database.
        /// Note: Make sure auditentry object has no null members or this will throw. 
        /// ReplaceNullWithEmtpyString extension method makes this easy.
        /// </summary>
        /// <param name="entry">Entry to store in database.</param>
        public void CreateAuditEntry(IAuditEntry entry)
        {
            _log.Writelog("Creating Audit entry...");
            _log.Writelogobject("Creating audit entry", entry);
            
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText =
                    "Insert into Audit (State,DC,Username,DBName,SQLVer,InitialSizeMB,Colation,Network,Availability," +
                    "Zone,SKU,StorPerfData,StorPerfLogs,Retention,BUDI,DBoGroup,PwrUGroup,StdUGroup,Recovery,TDE," +
                    "Notes,Logged,Expire,RequestITID) values (@State,@dc,@username,@dbname,@sqlver,@initialsizemb,@colation,@network,@availability," +
                    "@zone,@sku,@storperfdata,@storperflogs,@retention,@budi,@dbogroup,@pwrugroup,@stdugroup,@recovery,@tde," +
                    "@notes,@logged,@expire,@requestitid);Select Scope_identity();"; 

                cmd.Parameters.Add(new SqlParameter { ParameterName = "State", DbType = DbType.String, Value = entry.State });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "dc", DbType = DbType.String, Value = entry.DC });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "username", DbType = DbType.String, Value = entry.Username });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "dbname", DbType = DbType.String, Value = entry.DBName });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "sqlver", DbType = DbType.String, Value = entry.SQLVer });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "initialsizemb", DbType = DbType.String, Value = entry.InitialSizeMB });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "colation", DbType = DbType.String, Value = entry.Colation });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "network", DbType = DbType.String, Value = entry.Network });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "availability", DbType = DbType.String, Value = entry.Availability });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "zone", DbType = DbType.String, Value = entry.Zone });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "sku", DbType = DbType.String, Value = entry.Sku });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "storperfdata", DbType = DbType.String, Value = entry.StorPerfData });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "storperflogs", DbType = DbType.String, Value = entry.StorPerfLogs });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "retention", DbType = DbType.String, Value = entry.Retention });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "budi", DbType = DbType.String, Value = entry.BUDI });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "dbogroup", DbType = DbType.String, Value = entry.DBoGroup });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "pwrugroup", DbType = DbType.String, Value = entry.PwrUGroup });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "stdugroup", DbType = DbType.String, Value = entry.StdUGroup });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "recovery", DbType = DbType.String, Value = entry.Recovery });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "tde", DbType = DbType.String, Value = entry.TDE });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "notes", DbType = DbType.String, Value = entry.Notes });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "logged", DbType = DbType.String, Value = entry.Logged });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "expire", DbType = DbType.String, Value = entry.Expire });
                cmd.Parameters.Add(new SqlParameter { ParameterName = "requestitid", DbType = DbType.String, Value = entry.RequestITID });

                cmd.ExecuteScalar();

                connection.Close();
            }
        }

        public void ScheduleDelete(IAuditEntry entry)
        {
            ScheduleDelete(entry.DBName);
        }

        public void ScheduleDelete(string dbname)
        {
            _log.Writelog(string.Format("Updating audit table to delete database {0}", dbname));

            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = "UPDATE Audit SET State = 'delete' WHERE DBName = @dbname";
                cmd.Parameters.Add(new SqlParameter { ParameterName = "dbname", DbType = DbType.String, Value = dbname });
                cmd.ExecuteNonQuery();
                connection.Close();

                _log.Writelog("Database delete scheduled...");
            }
        }

        public bool DBExist(string dbname)
        {

            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = "SELECT DBName From Audit Where DBName = @dbname";
                
                cmd.Parameters.Add(new SqlParameter
                {
                    ParameterName = "dbname",
                    DbType = DbType.String,
                    Value = dbname
                });

                var reader = cmd.ExecuteReader();
                var result = reader.HasRows;

                connection.Close();

                return result;
            }
        }
       
    }
}
