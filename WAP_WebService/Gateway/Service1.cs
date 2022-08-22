// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.ServiceProcess;
using System.Threading;
using System.Timers;
using Gateway.Properties;
using Timer = System.Timers.Timer;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public partial class Service1 : ServiceBase
    {
        /// <summary>
        /// </summary>
        public static Timer ServiceTimer;

        /// <summary>
        /// </summary>
        public static Timer EnvCheckTimer;

        /// <summary>
        /// </summary>
        private static readonly string Dbconn = Settings.Default.dbconn;

        /// <summary>
        /// </summary>
        private static readonly string LogFile = Settings.Default.logfile;

        /// <summary>
        /// </summary>
        private static readonly string AuthServer = Settings.Default.authserver;

        /// <summary>
        /// </summary>
        private static readonly string AdminServer = Settings.Default.adminserver;

        /// <summary>
        /// </summary>
        private static readonly string TenantServer = Settings.Default.tenantserver;

        /// <summary>
        /// </summary>
        private static readonly string UncPathProd = Settings.Default.prodshare;

        /// <summary>
        /// </summary>
        private static readonly string UncPathNonProd = Settings.Default.nonprodshare;

        /// <summary>
        /// </summary>
        private static readonly string CheckInterval = Settings.Default.checkinterval;

        /// <summary>
        /// </summary>
        private static readonly string SecurityGrpShareAccess = Settings.Default.securitygrpshareaccess;

        /// <summary>
        /// </summary>
        private static readonly string TimerLogFile = Settings.Default.timerlogfile;

        /// <summary>
        /// </summary>
        private static readonly bool SignedCert = Settings.Default.signedcert;

        /// <summary>
        /// </summary>
        private static readonly string Gwsqlserver = Settings.Default.GWSQLSRV;

        /// <summary>
        /// </summary>
        private static readonly string Gwdbname = Settings.Default.GWDBNAME;

        /// <summary>
        /// </summary>
        private static readonly string Loglevel = Settings.Default.loglevel;

        /// <summary>
        /// </summary>
        private static readonly string DNSProd = Settings.Default.DNSProd;

        /// <summary>
        /// /// </summary>
        private static readonly string DNSNonProd = Settings.Default.DNSNonProd;

        /// <summary>
        /// </summary>
        private static readonly string DNSServer = Settings.Default.DNSServer;

        /// <summary>
        /// </summary>
        private static readonly string MDFPath = Settings.Default.MDFPath;
        
        /// <summary>
        /// </summary>
        private static readonly string LDFPath = Settings.Default.LDFPath;

        /// <summary>
        /// </summary>
        private static readonly bool PoSHKerbCheck = Settings.Default.PoSHKerbCheck;

        /// <summary>
        /// </summary>
        private static readonly string RDGSecGroup = Settings.Default.RDGSecGroup;

        /// <summary>
        /// </summary>
        public Service1()
        {
            InitializeComponent();
        }

        /// <summary>
        /// </summary>
        /// <param name="args"></param>
        protected override void OnStart(string[] args)
        {
#if DEBUG
            for (var i = 0; i < 60; i++)
            {
                Thread.Sleep(100);
            }
#endif
            var sets = new ClsWapSettings
            {
                AdminServer = AdminServer,
                TenantServer = TenantServer,
                AuthServer = AuthServer,
                CheckInterval = CheckInterval,
                DBConnString = Dbconn,
                LogFile = LogFile,
                NonProdShareUnc = UncPathNonProd,
                ProdShareUnc = UncPathProd,
                SignedCert = SignedCert,
                TimerLogFile = TimerLogFile,
                UncSharesSecGrps = SecurityGrpShareAccess,
                Gwsqlserver = Gwsqlserver,
                Gwdbname = Gwdbname,
                LogLevel = Loglevel,
                DNSNonProd = DNSNonProd,
                DNSProd = DNSProd,
                DNSServer = DNSServer,
                MDFPath = MDFPath,
                LDFPath = LDFPath,
                PoSHKebCheck = PoSHKerbCheck,
                RDGSecGroup = RDGSecGroup
            };
            ClsTimer.GetToken(sets.AuthServer);
            ClsTimer.Settings = sets;
            ClsTimer.MainInit_init();
            ServiceTimer = new Timer(Convert.ToInt32(sets.CheckInterval)*1000);
            ServiceTimer.Elapsed += ServiceTimer_Elapsed;
            ServiceTimer.Enabled = true;
            //EnvCheckTimer = new Timer(3600000);
            //EnvCheckTimer.Elapsed += EnvCheckTimer_Elapsed;
            //EnvCheckTimer.Enabled = true;
        }

        /// <summary>
        /// </summary>
        protected override void OnStop()
        {
            ServiceTimer.Enabled = false;
            ServiceTimer.Dispose();
            //EnvCheckTimer.Enabled = false;
            //EnvCheckTimer.Dispose();
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public static void ServiceTimer_Elapsed(object sender, ElapsedEventArgs e)
        {
            try
            {
                ServiceTimer.Stop();
                ClsLogfile.Writelog(1, "Timer Mark - Timer Status=" + ServiceTimer.Enabled, "Service1_Timer",
                    TimerLogFile);
                ClsTimer.GetToken(ClsTimer.Settings.AuthServer);
                ClsHpgw.ProcEvent();
                if (DateTime.Now > ClsBilling.DtNextBillingCheck)
                    ClsBilling.DoBillingRun(ClsTimer.Settings.Gwsqlserver, ClsTimer.Settings.Gwdbname);
                ServiceTimer.Start();
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelogparam("Error in main service:", ex.Message);
                ServiceTimer.Start();
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public static void EnvCheckTimer_Elapsed(object sender, ElapsedEventArgs e)
        {
            try
            {
                EnvCheckTimer.Stop();
                ClsLogfile.Writelog(1, "Timer Mark - Timer Status=" + EnvCheckTimer.Enabled, "EnvCheckTimer",
                    TimerLogFile);
                ClsEnvCheck.CheckEnv();
                EnvCheckTimer.Start();
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelogparam("Error in main service:", ex.Message);
                EnvCheckTimer.Start();
            }
        }
    }
}