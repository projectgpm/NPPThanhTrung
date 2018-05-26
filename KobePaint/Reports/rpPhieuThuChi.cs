using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using KobePaint.App_Code;

namespace KobePaint.Reports
{
    public partial class rpPhieuThuChi : DevExpress.XtraReports.UI.XtraReport
    {
        public rpPhieuThuChi()
        {
            InitializeComponent();
        }

        private void xrLabel11_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            ConvertNumToText num2Text = new ConvertNumToText();
            string str =  num2Text.replace_special_word(((XRLabel)sender).Text).Trim() + "./.";
            ((XRLabel)sender).Text = char.ToUpper(str[0]).ToString() + str.Substring(1);
            
        }

    }
}
