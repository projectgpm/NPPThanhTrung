using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.KhachHang
{
    public partial class DanhSachNCC : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }
        protected void gridDanhSachKH_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e)
        {
            //if (e.DataColumn.FieldName == "TienTTConLai" && e.GetValue("HanMucCongNo").ToString() != "0")
            //{
            //    e.Cell.Attributes.Add("onclick", "ShowPopup('" + e.Cell.ClientID + "','1-" + e.KeyValue + "')");
            //}
            //if (e.DataColumn.FieldName == "ThoiHanThanhToan" && e.GetValue("ThoiHanThanhToan").ToString() != "0")
            //{                
            //    int IDKhachHang = int.Parse(e.KeyValue.ToString());
            //    int ThoiHanTT = int.Parse(e.GetValue("ThoiHanThanhToan").ToString());
            //    var PhieuGH = DBDataProvider.DB.gPhieuGiaoHangs.Where(x => x.KhachHangID == IDKhachHang && x.PheDuyet == true && SqlMethods.DateDiffDay(x.NgayXuatHang, DateTime.Now) > ThoiHanTT).ToList();
            //    if (PhieuGH.Count > 0)
            //    {                   
            //        e.Cell.BackColor = System.Drawing.Color.LightPink;
            //        e.Cell.ForeColor = System.Drawing.Color.DarkRed;
            //        e.Cell.Text = PhieuGH.Count + " phiếu trễ";
            //        e.Cell.Attributes.Add("onclick", "ShowPopup('" + e.Cell.ClientID + "','2-" + e.KeyValue + "')");
            //    }
            //}
        }
        protected void cbpInfoStep_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] Para = e.Parameter.Split('-');
            switch (Para[0])
            {
                case "1": HanMucCongNo(Para[1]); break;
                case "2": PhieuDenHang(Para[1]); break;
            }
        }

        private void PhieuDenHang(string ID)
        {
            //int IDKhachHang = int.Parse(ID);
            //int ThoiHanTT = int.Parse(gridDanhSachKH.GetRowValuesByKeyValue(ID, "ThoiHanThanhToan").ToString());
            //List<gPhieuGiaoHang> listPhieuGH = DBDataProvider.DB.gPhieuGiaoHangs.Where(x => x.KhachHangID == IDKhachHang && x.PheDuyet == true && SqlMethods.DateDiffDay(x.NgayXuatHang, DateTime.Now) > ThoiHanTT).ToList();
            //string ThongBao = "<table>";
            //foreach(var p in listPhieuGH)
            //{
            //    ThongBao += "<tr>";
            //    ThongBao += string.Format("<td>Phiếu {0}&nbsp;&nbsp;</td><td>&nbsp;&nbsp;Ngày {1}</td>", p.STTDonHang, Formats.ConvertToVNDateString(p.NgayXuatHang.ToString()));
            //    ThongBao += "</tr>";
            //}
            //ThongBao += "</tbale>";
            //litNoiDung.Text = ThongBao;
        }

        private void HanMucCongNo(string ID)
        {
            object[] values = gridDanhSachKH.GetRowValuesByKeyValue(ID, new string[] { "HanMucCongNo", "TienTTConLai" }) as object[];
            float SoTienVuot = float.Parse(values[1].ToString()) - float.Parse(values[0].ToString());
            string bang = @"<table>
                <tr><td>Hạn mức công nợ:</td><td>&nbsp;&nbsp;{0}</td></tr>
                <tr><td>Đã vượt: </td><td>&nbsp;&nbsp;{1}</td></tr></table>";
            string thongbao = string.Format(bang, values[0].ToString(), SoTienVuot.ToString());
            litNoiDung.Text = thongbao;
        }

        protected void gridDanhSachKH_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
    }
}