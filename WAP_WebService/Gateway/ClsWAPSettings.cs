// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsWapSettings
    {
        /// <summary>
        /// </summary>
        private static string _adminServer;

        /// <summary>
        /// </summary>
        private static string _tenantServer;

        /// <summary>
        /// </summary>
        private static string _authServer;

        /// <summary>
        /// </summary>
        private static string _dbconn;

        /// <summary>
        /// </summary>
        private static string _uncProdPath;

        /// <summary>
        /// </summary>
        private static string _uncNonProdPath;

        /// <summary>
        /// </summary>
        private static string _checkInterval;

        /// <summary>
        /// </summary>
        private static string _secGrpsForShares;

        /// <summary>
        /// </summary>
        private static string _timerLogFile;

        /// <summary>
        /// </summary>
        private static string _logFile;

        /// <summary>
        /// </summary>
        private static bool _signedcert;

        /// <summary>
        /// </summary>
        private static string _token;

        /// <summary>
        /// </summary>
        private static string _gwsqlserver;

        /// <summary>
        /// </summary>
        private static string _gwdbname;

        /// <summary>
        /// </summary>
        private static string _loglevel;

        /// <summary>
        /// </summary>
        private static string _dnsprod;

        /// <summary>
        /// </summary>
        private static string _dnsnonprod;

        /// <summary>
        /// </summary>
        private static string _dnsserver;

        /// <summary>
        /// </summary>
        private static string _mdfpath;
        
        /// <summary>
        /// </summary>
        private static string _ldfpath;

        /// <summary>
        /// </summary>
        private static bool _poshkerb;

        /// <summary>
        /// </summary>
        private static string _rdgsecgrp;

        /// <summary>
        /// </summary>
        public string AdminServer
        {
            get { return _adminServer; }
            set { _adminServer = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string TenantServer
        {
            get { return _tenantServer; }
            set { _tenantServer = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string AuthServer
        {
            get { return _authServer; }
            set { _authServer = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string DBConnString
        {
            get { return _dbconn; }
            set { _dbconn = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string ProdShareUnc
        {
            get { return _uncProdPath; }
            set { _uncProdPath = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string NonProdShareUnc
        {
            get { return _uncNonProdPath; }
            set { _uncNonProdPath = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string CheckInterval
        {
            get { return _checkInterval; }
            set { _checkInterval = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string UncSharesSecGrps
        {
            get { return _secGrpsForShares; }
            set { _secGrpsForShares = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string TimerLogFile
        {
            get { return _timerLogFile; }
            set { _timerLogFile = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string LogFile
        {
            get { return _logFile; }
            set { _logFile = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public bool SignedCert
        {
            get { return _signedcert; }
            set { _signedcert = Setbool(value); }
        }

        /// <summary>
        /// </summary>
        public string Token
        {
            get { return _token; }
            set { _token = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Gwsqlserver
        {
            get { return _gwsqlserver; }
            set { _gwsqlserver = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string Gwdbname
        {
            get { return _gwdbname; }
            set { _gwdbname = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string LogLevel
        {
            get { return _loglevel; }
            set { _loglevel = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string DNSProd
        {
            get { return _dnsprod; }
            set { _dnsprod = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string DNSNonProd
        {
            get { return _dnsnonprod; }
            set { _dnsnonprod = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string DNSServer
        {
            get { return _dnsserver; }
            set { _dnsserver = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string MDFPath
        {
            get { return _mdfpath; }
            set { _mdfpath = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public string LDFPath
        {
            get { return _ldfpath; }
            set { _ldfpath = Setval(value); }
        }

        /// <summary>
        /// </summary>
        public bool PoSHKebCheck
        {
            get { return _poshkerb; }
            set { _poshkerb = Setbool(value); }
        }

        /// <summary>
        /// </summary>
        public string RDGSecGroup
        {
            get { return _rdgsecgrp; }
            set { _rdgsecgrp = Setval(value); }
        }

        /// <summary>
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private static string Setval(string val)
        {
            return val;
        }

        /// <summary>
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private static bool Setbool(bool val)
        {
            return val;
        }
    }
}