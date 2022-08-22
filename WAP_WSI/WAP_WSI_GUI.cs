// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the WAP_WSI Project

using System;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Security.Principal;
using System.Windows.Forms;
using WAP_WSI.SQLaaSWS;

// Download 20151103_1700 ABP

namespace WAP_WSI
{
    /// <summary>
    ///     This is a test form to simulate RIT and enable use of the HP GW
    ///     It is also for use as a sample for assisting in the development of the RIT interface
    ///     Outine processes:
    ///     - stand up the form
    ///     - connect to the web service
    ///     - populate all the create DB combo boxes with defaults
    ///     - create single DB from user selections
    ///     - create multiple DB's from an input file
    ///     - - populates the form for each line read in and calls create single DB
    ///     - Query the GW to get all the DB's
    ///     - For any DB in the GW, get the know activities
    ///     - For any Activity display the audit information
    ///     - For Modify a DB use the form to send a modify existing request.
    /// </summary>
    public partial class HpWapWsiGui : Form
    {
        /// <summary>
        /// </summary>
        //public SQLaaS_WSSoapClient webservice;

        /// <summary>
        /// </summary>
        public HpWapWsiGui()
        {
            InitializeComponent();
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdLoadDBBatch_Click(object sender, EventArgs e)
        {
            cmdLoadDBBatch.Enabled = false;
            var sLines = File.ReadAllText(txtBatchFileName.Text).Split('\n');
            for (var i = 1; i <= sLines.Length - 1; i++)
            {
                var sElem = sLines[i].Split(',');
                if (sElem.Length >= 24)
                {
                    tbEmail.Text = sElem[2];
                    txtDBNameNew.Text = sElem[3];
                    txtInitialDBSize.Text = sElem[4];
                    cmbColation.Text = sElem[5];
                    cmbDBVersion.Text = sElem[6];
                    cmbDataCentre.Text = sElem[7];
                    cmbEnvironment.Text = sElem[8];
                    cmbAvailability.Text = sElem[9];
                    cmbZone.Text = sElem[10];
                    cmbCompute.Text = sElem[11];
                    cmbStorageData.Text = sElem[12];
                    cmbStorageLogs.Text = sElem[13];
                    cmbRetention.Text = sElem[14];
                    txtBudi.Text = sElem[15];
                    cmbRecovery.Text = sElem[16];
                    cmbTDE.Text = sElem[17];
                    tbAdminUsr.Text = sElem[18];
                    tbPWRUsr.Text = sElem[19];
                    tbSTDUsr.Text = sElem[20];

                    cmdCreateDB_Click(null, null);
                }
            }
            cmdLoadDBBatch.Enabled = true;
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdLoadBatchFileName_Click(object sender, EventArgs e)
        {
            var ofd = new OpenFileDialog {Filter = @"CSV | *.csv"};
            if (ofd.ShowDialog() == DialogResult.OK)
            {
                txtBatchFileName.Text = ofd.FileName;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdCreateDB_Click(object sender, EventArgs e)
        {
            SetCmdText((Button) sender, "Running");
            txtConnection.Text = "";
            var sAction = "DBCreate";
            if (cmbRITActnType.SelectedIndex == 1) sAction = "DBModify";
            
            //txtQueueNo.Text = webservice.RitLogEvent(sAction,
            //    cmbDataCentre.Text,
            //    tbEmail.Text,
            //    txtDBNameNew.Text,
            //    cmbDBVersion.Text,
            //    txtInitialDBSize.Text,
            //    cmbColation.Text,
            //    cmbEnvironment.Text,
            //    cmbAvailability.Text,
            //    cmbZone.Text,
            //    cmbCompute.Text,
            //    cmbStorageData.Text,
            //    cmbStorageLogs.Text,
            //    cmbRetention.Text,
            //    txtBudi.Text,
            //    tbAdminUsr.Text,
            //    tbPWRUsr.Text,
            //    tbSTDUsr.Text,
            //    cmbRecovery.Text,
            //    cmbTDE.Text, "").ToString(CultureInfo.InvariantCulture);


            //SetCmdText((Button) sender);
            //foreach (var db in webservice.RitEventStatus("%").Where(db => db.Id == txtQueueNo.Text))
            //{
            //    cmbDBNameStat.Text = db.DBName;
            //    CheckStatus(db);
            //}
        }

        /// <summary>
        /// </summary>
        /// <param name="cmd"></param>
        /// <param name="sText"></param>
        public void SetCmdText(Button cmd, string sText = "")
        {
            if (cmd == null)
                return;
            if (cmd.Tag == null)
                cmd.Tag = cmd.Text;
            if (!string.IsNullOrEmpty(sText))
            {
                cmd.Text = sText;
                Application.DoEvents();
            }
            else
            {
                cmd.Text = (string) cmd.Tag;
            }
            Application.DoEvents();
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmbDBName_SelectedIndexChanged(object sender, EventArgs e)
        {
            // *********************************************************************
            // Load the Audit table
            // *********************************************************************
            //CheckStatus(webservice.RitEventStatus(cmbDBNameStat.SelectedItem.ToString())[0]);
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmbDBName_DropDown(object sender, EventArgs e)
        {
            // *********************************************************************
            // 
            // *********************************************************************
            //cmbDBNameStat.Items.Clear();
            //var sDbList = webservice.RitEventStatus("%");
            //foreach (var sDb in sDbList)
            //{
            //    cmbDBNameStat.Items.Add(sDb.DBName);
            //}
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void WAP_WSI_GUI_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmdInitForm_Click(object sender, EventArgs e)
        {
            if (InitWebServices())
            {
                if (PopulateForm())
                {
                    gbDBPrams.Enabled = true;
                    gbDBStat.Enabled = true;
                    cmbRITActnType.SelectedIndex = 0;
                }
            }
        }

        /// <summary>
        /// </summary>
        /// <returns></returns>
        public bool InitWebServices()
        {
            //try
            //{
            //    webservice = new SQLaaS_WSSoapClient();
            //    webservice.ClientCredentials.Windows.ClientCredential = webservice.ClientCredentials.Windows.ClientCredential.GetCredential(new Uri("https://SQLaaSWS"), "Windows");
            //    webservice.ClientCredentials.Windows.AllowedImpersonationLevel = TokenImpersonationLevel.Identification;

            //    txtGWVersion.Text = webservice.GetVersion();
            //    return true;
            //}
            //catch (Exception ex)
            //{
                
            //    MessageBox.Show(string.Format("Error initialising Web Service : {0} /n/r connecting to: {1}", ex.Message,
            //        webservice == null ? "" : webservice.Endpoint.Address.Uri.AbsoluteUri));
            //    txtGWVersion.Text = @"Connect Failed";
                return false;
            //}
        }

        /// <summary>
        /// </summary>
        /// <returns></returns>
        public bool PopulateForm()
        {
            try
            {
                cmbDBVersion.Items.Clear();
                cmbAvailability.Items.Clear();
                cmbColation.Items.Clear();
                cmbZone.Items.Clear();
                cmbCompute.Items.Clear();
                cmbEnvironment.Items.Clear();
                cmbRecovery.Items.Clear();
                cmbRetention.Items.Clear();
                cmbStorageData.Items.Clear();
                cmbStorageLogs.Items.Clear();
                cmbTDE.Items.Clear();

                cmbDBVersion.Items.AddRange(GetOption("SQLVersion"));
                cmbAvailability.Items.AddRange(GetOption("Availability"));
                cmbColation.Items.AddRange(GetOption("Colation"));
                cmbZone.Items.AddRange(GetOption("Zone"));
                cmbCompute.Items.AddRange(GetOption("Compute"));
                cmbEnvironment.Items.AddRange(GetOption("Environment"));
                cmbRecovery.Items.AddRange(GetOption("Recovery"));
                cmbRetention.Items.AddRange(GetOption("Retention"));
                cmbStorageData.Items.AddRange(GetOption("Storage"));
                cmbStorageLogs.Items.AddRange(GetOption("Storage"));
                cmbTDE.Items.AddRange(GetOption("TDE"));

                //cmbZone.SelectedIndex = 3;
                //cmbEnvironment.SelectedIndex = 2;

                txtInitialDBSize.Text = @"150";
                return true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(@"Error in initialisation : " + ex.Message);
                return false;
            }
        }

        public object[] GetOption(string name)
        {
            //var values = webservice.RitGetValidPram(name);

            //return values.Cast<object>().ToArray();
            return null;
        }

        /// <summary>
        /// </summary>
        /// <param name="cmb"></param>
        /// <param name="sOptions"></param>
        /// <param name="iDefault"></param>
        public void OptionAdd(ComboBox cmb, string sOptions, int iDefault)
        {
            cmb.Items.Clear();
            foreach (var sO in sOptions.Split(','))
            {
                cmb.Items.Add(sO.Trim());
            }
            cmb.SelectedIndex = iDefault - 1;
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmbRITActnType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbRITActnType.SelectedIndex == 0) // its a new
            {
                txtDBNameNew.Width = cmbCompute.Width;
                txtDBNameNew.Visible = true;
                cmbDBNameMod.Visible = false;
            }
            else
            {
                cmbDBNameMod.Left = cmbCompute.Left;
                cmbDBNameMod.Width = cmbCompute.Width;
                cmbDBNameMod.Visible = true;
                txtDBNameNew.Visible = false;
            }
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmbDBNameMod_DropDown(object sender, EventArgs e)
        {
            // *********************************************************************
            // 
            // *********************************************************************
            cmbDBNameMod.Items.Clear();
            //var sDbList = webservice.RitEventStatus("%");
            //foreach (var sDb in sDbList)
            //{
            //    cmbDBNameMod.Items.Add(sDb.DBName);
            //}
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cmbDBNameMod_SelectedIndexChanged(object sender, EventArgs e)
        {
            // *********************************************************************
            // 
            // *********************************************************************
            //var sDbList = ws.RitEventStatus(cmbDBNameMod.Text);
            //var sActv = sDbList[0].State.Split(',')[sDbList[0].Split(',').Count() - 1];
            //var sDbActivityDetailList = webservice.RitEventStatus((string) cmbDBNameMod.SelectedItem);
            //var sElem = sDbActivityDetailList[0].State.Split(';');
            //cmbDataCentre.Text = sElem[1].Split('=')[1];
            //tbEmail.Text = sElem[2].Split('=')[1];
            //txtDBNameNew.Text = sElem[3].Split('=')[1];
            //cmbDBVersion.Text = sElem[4].Split('=')[1];
            //txtInitialDBSize.Text = sElem[5].Split('=')[1];
            //cmbColation.Text = sElem[6].Split('=')[1];
            //cmbEnvironment.Text = sElem[7].Split('=')[1];
            //cmbAvailability.Text = sElem[8].Split('=')[1];
            //cmbZone.Text = sElem[9].Split('=')[1];
            //cmbCompute.Text = sElem[10].Split('=')[1];
            //cmbStorageData.Text = sElem[11].Split('=')[1];
            //cmbStorageLogs.Text = sElem[12].Split('=')[1];
            //cmbRetention.Text = sElem[13].Split('=')[1];
            //txtBudi.Text = sElem[14].Split('=')[1];
            //tbAdminUsr.Text = sElem[15].Split('=')[1];
            //cmbRecovery.Text = sElem[16].Split('=')[1];
            //cmbTDE.Text = sElem[17].Split('=')[1];
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btChkProg_Click(object sender, EventArgs e)
        {
            //progressBar1.Value = 0;
            //if (string.IsNullOrEmpty(cmbDBNameStat.Text))
            //    return;
            //var sDbActivityDetailList = webservice.RitEventStatus(cmbDBNameStat.Text);
            //CheckStatus(sDbActivityDetailList[0]);
        }

        /// <summary>
        /// </summary>
        /// <param name="sDbActivityDetailList"></param>
        private void CheckStatus(AuditEntry sDbActivityDetailList)
        {
            progressBar1.Value = 0;
            txtStatus.Text = "";
            txtConnection.Text = "";
            progressBar1.ResetForeColor();
            if (sDbActivityDetailList.Availability.ToLower() == "standard")
            {
                switch (sDbActivityDetailList.State.ToLower())
                {
                    case "new":
                        txtStatus.Text = @"Pending";
                        break;
                    case "1":
                        progressBar1.Value = 10;
                        timer1.Enabled = true;

                        break;
                    case "2":
                        progressBar1.Value = 20;
                        timer1.Enabled = true;

                        break;
                    case "3":
                        progressBar1.Value = 30;
                        timer1.Enabled = true;

                        break;
                    case "4":
                        progressBar1.Value = 40;
                        timer1.Enabled = true;

                        break;
                    case "5":
                        progressBar1.Value = 50;
                        timer1.Enabled = true;

                        break;
                    case "6":
                        progressBar1.Value = 60;
                        timer1.Enabled = true;

                        break;
                    case "7":
                        progressBar1.Value = 70;
                        timer1.Enabled = true;

                        break;
                    case "8":
                        progressBar1.Value = 80;
                        timer1.Enabled = true;

                        break;
                    case "9":
                        progressBar1.Value = 90;
                        timer1.Enabled = true;

                        break;
                    case "completed":
                        progressBar1.Value = 100;
                        txtStatus.Text = sDbActivityDetailList.State;
                        txtConnection.Text = sDbActivityDetailList.Connection;
                        break;
                    case "failed":
                        progressBar1.Value = 0;
                        //txtStatus.Text = sDbActivityDetailList.State;
                        txtStatus.Text = @"Failed Please Raise a ticket";
                        break;
                    case "delete":
                        txtStatus.Text = "";
                        progressBar1.Value = 0;
                        txtStatus.Text = sDbActivityDetailList.State;
                        tbNotes.Text = sDbActivityDetailList.Notes;

                        break;
                    default:
                        progressBar1.Value = 100;
                        progressBar1.ForeColor = Color.Red;
                        txtStatus.Text = sDbActivityDetailList.State;
                        tbNotes.Text = sDbActivityDetailList.Notes;
                        txtConnection.Text = @"Failed Please Raise a ticket";
                        break;
                }
            }
            else
            {
                switch (sDbActivityDetailList.State.ToLower())
                {
                    case "new":
                        txtStatus.Text = @"Pending";
                        break;
                    case "1":
                        progressBar1.Value = 7;
                        timer1.Enabled = true;

                        break;
                    case "2":
                        progressBar1.Value = 14;
                        timer1.Enabled = true;

                        break;
                    case "3":
                        progressBar1.Value = 21;
                        timer1.Enabled = true;

                        break;
                    case "4":
                        progressBar1.Value = 28;
                        timer1.Enabled = true;

                        break;
                    case "5":
                        progressBar1.Value = 35;
                        timer1.Enabled = true;

                        break;
                    case "6":
                        progressBar1.Value = 42;
                        timer1.Enabled = true;

                        break;
                    case "7":
                        progressBar1.Value = 49;
                        timer1.Enabled = true;

                        break;
                    case "8":
                        progressBar1.Value = 56;
                        timer1.Enabled = true;

                        break;
                    case "9":
                        progressBar1.Value = 63;
                        timer1.Enabled = true;

                        break;
                    case "10":
                        progressBar1.Value = 70;
                        timer1.Enabled = true;

                        break;
                    case "11":
                        progressBar1.Value = 77;
                        timer1.Enabled = true;

                        break;
                    case "12":
                        progressBar1.Value = 85;
                        timer1.Enabled = true;

                        break;
                    case "13":
                        progressBar1.Value = 92;
                        timer1.Enabled = true;

                        break;
                    case "completed":
                        progressBar1.Value = 100;
                        txtStatus.Text = sDbActivityDetailList.State;
                        txtConnection.Text = sDbActivityDetailList.Connection;
                        break;
                    case "failed":
                        progressBar1.Value = 0;
                        txtStatus.Text = sDbActivityDetailList.State;
                        txtStatus.Text = @"Failed Please Raise a ticket";
                        break;
                    default:
                        progressBar1.Value = 100;
                        progressBar1.ForeColor = Color.Red;
                        txtStatus.Text = sDbActivityDetailList.State;
                        tbNotes.Text = sDbActivityDetailList.Notes;
                        txtConnection.Text = @"Failed Please Raise a ticket";
                        break;
                }
            }
            //do
            ////{
            //var db = Ws.RitEventStatus(sDBName)[0];
            //var state = db.State;

            ////} while (state == sCurState);
            //switch (state)
            //{
            //    case "new":
            //        txtNotes.Text = @"Pending";
            //        timer1.Enabled = true;
            //        break;
            //    case "1":
            //        progressBar1.Value = 10;
            //        //CheckStatus(sDBName, state);
            //        timer1.Enabled = true;
            //        break;
            //    case "2":
            //        progressBar1.Value = 20;
            //        //CheckStatus(sDBName, state);
            //        break;
            //    case "3":
            //        progressBar1.Value = 30;
            //        //CheckStatus(sDBName, state);
            //        break;
            //    case "4":
            //        progressBar1.Value = 40;
            //        //CheckStatus(sDBName, state);
            //        break;
            //    case "5":
            //        progressBar1.Value = 50;
            //        //CheckStatus(sDBName, state);
            //        break;
            //    case "6":
            //        progressBar1.Value = 60;
            //        //CheckStatus(sDBName, state);
            //        break;
            //    case "7":
            //        progressBar1.Value = 70;
            //        //CheckStatus(sDBName, state);
            //        break;
            //    case "8":
            //        progressBar1.Value = 80;
            //        //CheckStatus(sDBName, state);
            //        break;
            //    case "9":
            //        progressBar1.Value = 90;
            //        //CheckStatus(sDBName, state);
            //        break;
            //    case "completed":
            //        progressBar1.Value = 100;
            //        txtStatus.Text = db.State;
            //        txtConnection.Text = db.Connection;
            //        txtNotes.Text = db.Notes;
            //        timer1.Enabled = false;
            //        break;
            //    case "failed":
            //        progressBar1.Value = 0;
            //        txtNotes.Text = @"Failed Please Raise a ticket";
            //        timer1.Enabled = false;
            //        break;
            //}

            //return db ;
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void timer1_Tick(object sender, EventArgs e)
        {
            //timer1.Stop();
            //CheckStatus(webservice.RitEventStatus(cmbDBNameStat.Text)[0]);
            //timer1.Start();
        }

        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btdel_Click(object sender, EventArgs e)
        {
            //if (
            //    MessageBox.Show(string.Format("Are you sure you want to Delete Database: {0}?", cmbDBNameStat.Text),
            //        @"Delete Database", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == DialogResult.Yes)
            //{
            //    webservice.QueueDBDelete(cmbDBNameStat.Text);
            //    MessageBox.Show(string.Format("Database: {0} has been queued to be deleted", cmbDBNameStat.Text));
            //}
        }
    }
}