// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the WAP_WSI Project

using System;
using System.Windows.Forms;

namespace WAP_WSI
{
    /// <summary>
    /// </summary>
    internal static class Program
    {
        /// <summary>
        ///     The main entry point for the application.
        /// </summary>
        [STAThread]
        private static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new HpWapWsiGui());
            Application.Run(new SQLaaS_Rit_Sim());
        }
    }
}