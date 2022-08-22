using System;
using System.Collections.Generic;
using Gateway.DataLayer;

namespace WAP_WebService
{
    public class DbDatabaseManager
    {
        public const int MaxDbNames = 100;
        private readonly IDbRequestEntryRepository _dbRequestEntryRepository;
        private readonly ILog _log;
        private readonly ICodeRepository _codeRepository;

        public DbDatabaseManager(IDbRequestEntryRepository dbRequestEntryRepository, ILog log, ICodeRepository codeRepository)
        {
            _dbRequestEntryRepository = dbRequestEntryRepository;
            _log = log;
            _codeRepository = codeRepository;
        }

        public string CreateDb(IDbReq dbReq)
        {
            if (dbReq.State.ToLower() == "dbcreate")
            {
                var dboriginalname = dbReq.DbName;
                dbReq.DbName = GetValidDbName(dbReq.DbName);
                if (dboriginalname != dbReq.DbName)
                {
                    dbReq.Notes += string.Format("Database {0} already exists renamed to: {1}", dboriginalname, dbReq.DbName);
                    _log.Writelog(string.Format("Database {0} already exists renamed to: {1}", dboriginalname, dbReq.DbName));
                }
                _dbRequestEntryRepository.CreateDbRequest(dbReq);
                return dbReq.DbName;
            }
            else if (dbReq.State.ToLower() == "dbdelete")
            {
                //TODO: Implement the delete routine.
                return null;
            }
            return null;
        }
        private string GetValidDbName(string strDbName)
        {
            var postfix = "";

            for (var i = 0; i < MaxDbNames; i++)
            {
                if (i != 0)
                    postfix = i.ToString("00");

                if (_dbRequestEntryRepository.DbExist(strDbName + postfix))
                    continue;

                return strDbName + postfix;
            }
            throw new ApplicationException(string.Format("Found {0} Database with the same name! Try using another Database name!", MaxDbNames));
        }

        public IEnumerable<IDbReq> GetDbRequestEntry(string strDbName)
        {
            return _dbRequestEntryRepository.GetDbRequestEntry(strDbName);
        }
    }
}