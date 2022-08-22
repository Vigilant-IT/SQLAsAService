using System;
using System.Collections.Generic;
using Gateway.DataLayer;

namespace WAP_WebService
{
    public class RgDbManager
    {
        public const int MaxRgNames = 100;
        private readonly IRgRequestEntryRepository _rgRequestEntryRepository;
        private readonly ILog _log;
        private readonly ICodeRepository _codeRepository;

        public RgDbManager(IRgRequestEntryRepository rgRequestEntryRepository, ILog log, ICodeRepository codeRepository)
        {
            _rgRequestEntryRepository = rgRequestEntryRepository;
            _log = log;
            _codeRepository = codeRepository;
        }
        public string CreateRg(IRgReq rgReq)
        {
            if (rgReq.State.ToLower() == "rgcreate")
            {
                var rgoriginalname = rgReq.RgName;
                rgReq.RgName = GetValidRgName(rgReq.RgName);
                if (rgoriginalname != rgReq.RgName)
                {
                    rgReq.Notes += string.Format("Resource Goverenance {0} already exists renamed to: {1}",
                        rgoriginalname,
                        rgReq.RgName);
                    _log.Writelog(string.Format("Resource Goverenance {0} already exists renamed to: {1}",
                        rgoriginalname,
                        rgReq.RgName));
                }
                _rgRequestEntryRepository.CreateRgRequest(rgReq);
                return rgReq.RgName;
            }
            else if (rgReq.State.ToLower() == "rgdelete")
            {
                //TODO: Implement the delete routine.
            }
            return "";
        }
        private string GetValidRgName(string strRgName)
        {
            var postfix = "";

            for (var i = 0; i < MaxRgNames; i++)
            {
                if (i != 0)
                    postfix = i.ToString("00");

                if (_rgRequestEntryRepository.RgExist(strRgName + postfix))
                    continue;

                return strRgName + postfix;
            }

            throw new ApplicationException(string.Format("Found {0} Resource Group with the same name! Try using another Resource Group name!", MaxRgNames));
        }

        public IEnumerable<IRgReq> GetRgReqStatus(string strRgName)
        {
            return _rgRequestEntryRepository.GetRgRequestEntry(strRgName);
        }
    }
}