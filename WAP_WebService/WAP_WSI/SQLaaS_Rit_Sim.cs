using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WAP_WSI.SQLaaSWS;

namespace WAP_WSI
{
    public partial class SQLaaS_Rit_Sim : Form
    {
        public SQLaaS_WSSoapClient webservice;
        public SQLaaS_Rit_Sim()
        {
            InitializeComponent();
            lblRGSStatusRES.Text = lblRGSNumDbsRes.Text = lblDBSConStrRes.Text = lblDBSNotesRes.Text = lblDBSStatusRes.Text= lblRGSNotesRes.Text = "";
            if (!InitWebServices()) throw new Exception("Not able to connect to the Web Service");
            
            cbRGNZone.Items.AddRange(GetOption("Zone"));
            cbRGNAvail.Items.AddRange(GetOption("Availability"));
            cbRGNSqlVer.Items.AddRange(GetOption("SQLVersion"));
            cbRGNDc.Items.AddRange(GetOption("DataCentre"));
            cbRGNDc.Items.Remove("Default");
            cbRGNEnv.Items.AddRange(GetOption("Environment"));
            cbRGNTde.Items.AddRange(GetOption("TDE"));
            cbRGNSkuName.Items.AddRange(GetOption("Compute"));

            tabTask.Click += tabmain_click;
        }

        private void btRGNProvision_Click(object sender, EventArgs e)
        {
            var newrg = webservice.RitNewRg(tbRGNRGName.Text,
                cbRGNZone.SelectedItem.ToString(),
                cbRGNAvail.SelectedItem.ToString(),
                cbRGNSqlVer.SelectedItem.ToString(),
                cbRGNDc.SelectedItem.ToString(),
                cbRGNEnv.SelectedItem.ToString(),
                cbRGNTde.SelectedItem.ToString(),
                cbRGNSkuName.SelectedItem.ToString(),
                tbRGNEmail.Text,
                tbRGNPassPhrase.Text,
                "rgcreate"
                );
            var rgname = newrg;
            cbRGSRgName.Text = rgname;
            tbRGNRGName.Text = rgname;
            tabSubRg.SelectedTab = tabRgStatus;
        }
        public object[] GetOption(string name)
        {
            var values = webservice.RitGetValidPram(name);

            return values.Cast<object>().ToArray();
        }
        /// <summary>
        /// </summary>
        /// <returns></returns>
        public bool InitWebServices()
        {
            try
            {
                webservice = new SQLaaS_WSSoapClient();
                //webservice.ClientCredentials.Windows.ClientCredential = webservice.ClientCredentials.Windows.ClientCredential.GetCredential(new Uri("https://SQLaaSWS"), "Windows");
                //webservice.ClientCredentials.Windows.AllowedImpersonationLevel = TokenImpersonationLevel.Identification;

                return true;
            }
            catch (Exception ex)
            {

                MessageBox.Show(string.Format("Error initialising Web Service : {0} /n/r connecting to: {1}", ex.Message,
                    webservice == null ? "" : webservice.Endpoint.Address.Uri.AbsoluteUri));
                return false;
            }
        }


        private void btDBNProvision_Click(object sender, EventArgs e)
        {
            var rg = webservice.RitRgReqStatus(cbDBNRgName.SelectedItem.ToString());
            if (rg.Count != 1) return;
            var newdb = webservice.RitNewDb(rg[0].RgId,
                tbDBNDbName.Text,
                cbDBNCollation.SelectedItem.ToString(),
                tbDBNDboGrp.Text, 
                tbDBNPwrGrp.Text, 
                tbDBNStdGrp.Text, 
                tbDBNSzie.Text,
                "dbcreate");
            tbDBNDbName.Text = newdb;
            cbDBSDbName.Text = newdb;
            tabSubDb.SelectedTab = tabDbStatus;
        }
        public void tabmain_click(Object sender, EventArgs e)
        {
            cbDBNRgName.Items.Clear();
            cbDBNCollation.Items.Clear();
            var tab = (TabControl)sender;
            if (tab.SelectedTab.Text != "Database") return;
            List<RgReq> rgs = webservice.RitRgReqStatus("%");
            foreach (var rgReq in rgs)
            {
                cbDBNRgName.Items.Add(rgReq.RgName);
            }
            cbDBNCollation.Items.AddRange(GetOption("Colation"));
        }

        private void btTSNAddSvr_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            var dbstatus = webservice.RitDbReqStatus(cbDBSDbName.Text).First<DbReq>();

            lblDBSNotesRes.Text = dbstatus.Notes ?? "";
            lblDBSConStrRes.Text = dbstatus.ConnectionString ?? "";
        }
    }
}
