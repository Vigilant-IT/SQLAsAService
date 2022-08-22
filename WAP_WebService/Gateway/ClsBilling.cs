// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsBilling
    {
        /// <summary>
        /// </summary>
        public static DateTime DtNextBillingCheck = Convert.ToDateTime("01/01/1900 00:00:00");

        /// <summary>
        /// </summary>
        public static void DoBillingRun(string sSQLServer, string sGwdb)
        {
            ClsLogfile.Writelogparam("sSQLServer, sGwdb", sSQLServer, sGwdb);
            try
            {
                var sSQL = string.Format("Select * from StorUsed where Date='{0}'", DateTime.Now.ToString("yyy-MM-dd"));
                var dt = new DataTable();
                using (
                    var sc =
                        new SqlConnection(
                            string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                                sSQLServer, sGwdb)))
                using (var cmd = sc.CreateCommand())
                {
                    sc.Open();
                    cmd.CommandText = sSQL;
                    try
                    {
                        ClsLogfile.Writelog(1, "Obtaining all data from StorUsed for Today", true);
                        dt.Load(cmd.ExecuteReader());
                    }
                    catch (Exception ex)
                    {
                        ClsLogfile.Writelog(3, "Failed to obtain all data from StorUsed for Today");
                        ClsLogfile.Writelog(3, ex.Message, true);
                        throw;
                    }

                    sc.Close();
                }

                if (dt.Rows.Count != 0) return;
                ClsLogfile.Writelog(1, "No records found", true);
                var dataToInsert = new DataTable();
                dataToInsert.Columns.Add("Id", typeof (int));
                dataToInsert.Columns.Add("DBName", typeof (string));
                dataToInsert.Columns.Add("DataLog", typeof (string));
                dataToInsert.Columns.Add("Used", typeof (double));
                dataToInsert.Columns.Add("Date", typeof (DateTime));
                //Check has not been done yet, get all VMs from the VMSpec table
                const string sSQL2 = "Select DISTINCT SCVMM,VMName from VMSpec";
                var dt2 = new DataTable();
                using (
                    var sc =
                        new SqlConnection(
                            string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                                sSQLServer, sGwdb)))
                using (var cmd = sc.CreateCommand())
                {
                    sc.Open();
                    cmd.CommandText = sSQL2;
                    try
                    {
                        ClsLogfile.Writelog(1, "Obtaining VMM and Servernames from VMSpec", true);
                        dt.Load(cmd.ExecuteReader());
                    }
                    catch (Exception ex)
                    {
                        ClsLogfile.Writelog(3, "Failed to obtain VMM and Servernames from VMSpec");
                        ClsLogfile.Writelog(3, ex.Message, true);
                        throw;
                    }

                    sc.Close();
                }


                foreach (DataRow dr in dt2.Rows)
                {
                    ClsLogfile.Writelog(1, "Found VMs", true);
                    var diskList = ClsVmmDisks.GetVmDiskSizes(dr["SCVMM"].ToString(), dr["VMName"].ToString());
                    foreach (var currentDisk in diskList)
                    {
                        var splcurdisk = currentDisk.DiskName.Split('_');
                        var strDBName = "";
                        var i = 0;
                        foreach (var s in splcurdisk)
                        {
                            if ((i == 0) || (i == splcurdisk.Length - 1))
                            {
                            }
                            else
                            {
                                strDBName += s + "_";
                            }
                            i++;
                        }
                        strDBName = strDBName.Remove(strDBName.Length - 1);
                        var foundDatabaseFile = currentDisk.DiskName.ToLower().IndexOf("data", StringComparison.Ordinal);
                        var foundLogFile = currentDisk.DiskName.ToLower().IndexOf("log", StringComparison.Ordinal);
                        if (foundDatabaseFile > 0)
                            dataToInsert.Rows.Add(null, strDBName, "Database",
                                Convert.ToDouble(Convert.ToDouble(currentDisk.Size)/1024.0/1024.0),
                                DateTime.Now.ToString("yyy-MM-dd"));
                        else
                        {
                            if (foundLogFile > 0)
                                dataToInsert.Rows.Add(null, strDBName, "Log",
                                    Convert.ToDouble(Convert.ToDouble(currentDisk.Size)/1024.0/1024.0),
                                    DateTime.Now.ToString("yyy-MM-dd"));
                        }
                    }
                }
                bool bSuccess;
                using (
                    var sc =
                        new SqlConnection(
                            string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                                sSQLServer, sGwdb)))
                {
                    sc.Open();
                    var bulkCopy = new SqlBulkCopy(sc) {DestinationTableName = "StorUsed"};
                    try
                    {
                        ClsLogfile.Writelog(1, "Injecting Data into StorUsed", true);
                        bulkCopy.WriteToServer(dataToInsert);
                        bSuccess = true;
                    }
                    catch (Exception ex)
                    {
                        ClsLogfile.Writelog(3, "Failed to inject Data into StorUsed");
                        ClsLogfile.Writelog(3, ex.Message, true);
                        bSuccess = false;
                    }
                    sc.Close();
                }
                if (bSuccess)
                    DtNextBillingCheck =
                        DateTime.Now.AddDays(1).AddHours(-DateTime.Now.Hour).AddMinutes(-DateTime.Now.Minute);

                ClsLogfile.Writelogparam("dtNextBillingCheck, bSuccess",
                    DtNextBillingCheck.ToString(CultureInfo.InvariantCulture), bSuccess.ToString());
            }
            catch (Exception ex)
            {
                ClsLogfile.Writelog(3, "Error in billing");
                ClsLogfile.Writelog(3, ex.Message, true);
            }
        }
    }
}