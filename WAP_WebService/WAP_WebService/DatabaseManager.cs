using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Gateway.DataLayer;

namespace WAP_WebService
{
    /// <summary>
    /// DatabaseManager - Contains all business logic of the web service and interacts with the datalayer.
    /// </summary>
    public class DatabaseManager
    {
        public const int MaxDBNames = 100;

        private readonly IAuditEntryRepository _auditEntryRepository;
        private readonly ILog _log;
        private readonly ICodeRepository _codeRepository;

        public DatabaseManager(IAuditEntryRepository auditEntryRepository, ILog log, ICodeRepository codeRepository)
        {
            _auditEntryRepository = auditEntryRepository;
            _log = log;
            _codeRepository = codeRepository;
        }
        
        /// <summary>
        /// CreateDB - uses data layer to create an audit entry in the audit table.
        /// Keep business logic in this class to make it easy to unit test.
        /// </summary>
        /// <param name="audit">Audit object holding data passed by web service for storing in db.</param>
        public void CreateDB(IAuditEntry audit)
        {
            _log.Writelogobject("User requested Audit entry queued via web service.", audit);

            if (audit.State.ToLower() == "dbmodify")
            {
                _log.Writelog("User requested dbmodify which is not currently supported!");
                audit.State = "Rejected";
                audit.Notes += "DB modify not currently supported!";
            }
            else if (audit.State.ToLower() == "dbcreate")
            {
                _log.Writelog("User requested dbcreate!");
                audit.State = ValidAuditEntry(audit) ? "New" : "Rejected";
            }
            else
            {
                _log.Writelog(string.Format("User requested unknown action {0}!", audit.State));

                audit.Notes += string.Format("Unsupported action {0}!", audit.State);
                audit.State = "Rejected";
            }

            var originalname = audit.DBName;
            audit.DBName = GetValidDBName(audit.DBName);

            if (originalname != audit.DBName)
            {
                audit.Notes += string.Format("Database {0} already exists renamed to: {1}", originalname, audit.DBName);
                _log.Writelog(string.Format("Database {0} already exists renamed to: {1}", originalname, audit.DBName));
            }

            _auditEntryRepository.CreateAuditEntry(audit);

            return;
        }
        
        /// <summary>
        /// Captures requests for database status and retrives from Data layer.
        /// </summary>
        /// <param name="dbname">Database name to retrieve object for. Can be % to return all databases.</param>
        /// <returns>Enumerable of AuditEnterires</returns>
        public IEnumerable<IAuditEntry> GetAuditStatus(string dbname)
        {
            return _auditEntryRepository.GetAuditEntry(dbname);
        }

        /// <summary>
        /// Looks up codes from the code table.
        /// This is used to retrive valid fields from the code table.
        /// </summary>
        /// <param name="field">field to look up.</param>
        /// <returns>Enumerable of string of the values or an empty enumeration if invalid code.</returns>
        public IEnumerable<string> GetCodeValues(string field)
        {
            return field == "Compute" ? _codeRepository.GetSkuCode() : _codeRepository.GetCode(field);
        }

        /// <summary>
        /// Queues a delete job in the database.
        /// </summary>
        /// <param name="mydb">Name of DB to schedule delete for.</param>
        public void DeleteDB(string mydb)
        {
            _auditEntryRepository.ScheduleDelete(mydb);
        }

        private bool HasInvalidChars(string text, bool allowbackslash = false)
        {
            var invalidchars = new List<char> {'\0', '\'', '\"', '\b', '\n', '\r', '\t', (char)26, '%'};

            if(!allowbackslash)
                invalidchars.Add('\\');

            return invalidchars.Any(i => text.Contains(i));
        }

        private bool ValidAuditEntry(IAuditEntry entry)
        {
            _log.Writelog("Checking if Audit entry is valid!");
            _log.Writelogobject("Checking if audit entry is valid", entry);

            var notes = new StringBuilder(entry.Notes);
            var result = true;

            int storesize;
            if (!int.TryParse(entry.InitialSizeMB, out storesize))
            {
                notes.Append(string.Format("Invalid option for InitialSizeMB with {0} must be numeric.",
                    entry.InitialSizeMB));

                result = false;
            }
            else if (storesize < 150)
            {
                notes.Append(string.Format("Invalid option for InitialSizeMB with {0} must be >= 150.",
                entry.InitialSizeMB));

                result = false;
            }

            if (HasInvalidChars(entry.BUDI))
            {
                notes.Append("Invalid charecters in BUDI!");
                result = false;
            }

            if (HasInvalidChars(entry.DBName))
            {
                notes.Append("Invalid charecters in DBName!");
                result = false;
            }

            if (HasInvalidChars(entry.DBoGroup))
            {
                notes.Append("Invalid charecters in DBoGroup!");
                result = false;
            }

            if (HasInvalidChars(entry.StdUGroup))
            {
                notes.Append("Invalid charecters in StdUGroup!");
                result = false;
            }

            if (HasInvalidChars(entry.PwrUGroup))
            {
                notes.Append("Invalid charecters in PwrUGroup!");
                result = false;
            }

            if (HasInvalidChars(entry.Username))
            {
                notes.Append("Invalid charecters in Username!");
                result = false;
            }

            //Checking properties against the code table.
            //Note: Original code also checked BUDI, DBoGroup, StdUGroup and PwrUGroup
            //but it was stubbed out to do nothing.
            if (!_codeRepository.CheckCode("DataCentre", entry.DC)) { notes.Append("Invalid DataCentre."); result = false; }
            if (!_codeRepository.CheckCode("SQLVersion", entry.SQLVer)) { notes.Append("Invalid SQLVersion."); result = false; }
            if (!_codeRepository.CheckCode("Zone", entry.Zone)) { notes.Append("Invalid Zone."); result = false; }
            if (!_codeRepository.CheckCode("Compute", entry.Sku)) { notes.Append("Invalid Compute."); result = false; }
            if (!_codeRepository.CheckCode("Colation", entry.Colation)) { notes.Append("Invalid Colation."); result = false; }
            if (!_codeRepository.CheckCode("TDE", entry.TDE)) { notes.Append("Invalid TDE."); result = false; }
            if (!_codeRepository.CheckCode("Environment", entry.Network)) { notes.Append("Invalid Environment."); result = false; }
            if (!_codeRepository.CheckCode("Storage", entry.StorPerfData)) { notes.Append("Invalid StorPerfData Storage."); result = false; }
            if (!_codeRepository.CheckCode("Storage", entry.StorPerfLogs)) { notes.Append("Invalid StorPerfLogs Storage."); result = false; }
            if (!_codeRepository.CheckCode("Retention", entry.Retention)) { notes.Append("Invalid Retention."); result = false; }
            if (!_codeRepository.CheckCode("Recovery", entry.Recovery)) { notes.Append("Invalid Recovery."); result = false; }

            entry.Notes = notes.ToString();

            return result;
        }

        private string GetValidDBName(string dbname)
        {
            var postfix = "";
            
            for (var i = 0; i < MaxDBNames; i++)
            {
                if (i != 0)
                    postfix = i.ToString("00");

                if (_auditEntryRepository.DBExist(dbname + postfix))
                    continue;

                return dbname + postfix;
            }

            throw new ApplicationException(string.Format("Found {0} Databases with the same name! Try using another database name!", MaxDBNames));
        }
        
    }
}