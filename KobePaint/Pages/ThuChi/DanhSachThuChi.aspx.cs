using DevExpress.Web;
using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.ThuChi
{
    public partial class DanhSachThuChi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                hdfViewReport["view"] = 0;
            }
            if (hdfViewReport["view"].ToString() != "0")
            {
                reportViewer.Report = CreatReport();
                hdfViewReport["view"] = 0;
            }
        }
        private DevExpress.XtraReports.UI.XtraReport CreatReport()
        {

            rpPhieuThuChi rp = new rpPhieuThuChi();
            rp.odsPayNode.DataSource = oPhieuTC;
            rp.CreateDocument();
            return rp;
        }
        protected void gridThuChi_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
        protected void btnInPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            btn.ClientSideEvents.Click = String.Format("function(s, e) {{ onPrintClick({0}); }}", container.KeyValue);
        }
        protected void cbpViewReport_Callback(object sender, CallbackEventArgsBase e)
        {
            int IDPhieu = int.Parse(e.Parameter);
            var PhieuTC = DBDataProvider.DB.pPhieuThuChis.Where(x => x.IDPhieu == IDPhieu).SingleOrDefault();
            hdfViewReport["view"] = 1;
            int LoaiPhieuThuChi = Convert.ToInt32(PhieuTC.LoaiPhieu);
            if (LoaiPhieuThuChi == 0)
            {
                //phiếu thu
                oPhieuTC = new oThuChi();
                oPhieuTC.TieuDe = "PHIẾU THU";
                
                oPhieuTC.MaPhieu = "Mã phiếu thu: " + PhieuTC.MaPhieu;
                oPhieuTC.Ngay =Formats.ConvertToVNDateString(PhieuTC.NgayLap.ToString());
                oPhieuTC.HoTen = "Họ tên người nộp tiền";
                oPhieuTC.TenNguoiNopNhan = PhieuTC.NguoiNop;
                oPhieuTC.DienThoai = PhieuTC.DienThoai;
                oPhieuTC.DiaChi = PhieuTC.DiaChi;
                oPhieuTC.LyDo = "Lý do nộp";
                oPhieuTC.NoiDungLyDo = PhieuTC.NoiDung;
                oPhieuTC.SoTien = Convert.ToDouble(PhieuTC.SoTien);
                oPhieuTC.NguoiNopChi = "Người nộp";
                oPhieuTC.NguoiThuChi = "Người thu";
                oPhieuTC.NgayThangNam = Formats.ConvertToFullStringDate_ToUp(DateTime.Parse(PhieuTC.NgayLap.ToString()));
            }
            else
            {
                // Phiếu chi
                oPhieuTC = new oThuChi();
                oPhieuTC.TieuDe = "PHIẾU CHI";
                oPhieuTC.MaPhieu = "Mã phiếu chi: " + PhieuTC.MaPhieu;
                oPhieuTC.Ngay = Formats.ConvertToVNDateString(PhieuTC.NgayLap.ToString());
                oPhieuTC.HoTen = "Họ tên người nhận tiền";
                oPhieuTC.TenNguoiNopNhan = PhieuTC.NguoiNop;
                oPhieuTC.DienThoai = PhieuTC.DienThoai;
                oPhieuTC.DiaChi = PhieuTC.DiaChi;
                oPhieuTC.LyDo = "Lý do nhận";
                oPhieuTC.NoiDungLyDo = PhieuTC.NoiDung;
                oPhieuTC.SoTien = Convert.ToDouble(PhieuTC.SoTien);
                oPhieuTC.NguoiNopChi = "Người nhận";
                oPhieuTC.NguoiThuChi = "Người chi";
                oPhieuTC.NgayThangNam = Formats.ConvertToFullStringDate_ToUp(DateTime.Parse(PhieuTC.NgayLap.ToString()));
            }
        }
        private oThuChi oPhieuTC
        {
            get
            {
                return (oThuChi)Session["oPhieuTC"];
            }
            set
            {
                Session["oPhieuTC"] = value;
            }
        }
    }
}