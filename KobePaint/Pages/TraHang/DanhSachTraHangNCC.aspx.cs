using DevExpress.Web;
using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.TraHang
{
    public partial class DanhSachTraHangNCC : System.Web.UI.Page
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
                if (hdfViewReport["view"].ToString() == "1")
                    reportViewer.Report = CreatReport();
                else
                    reportViewer.Report = CreatReportNoPrice();
                hdfViewReport["view"] = 0;
            }
        }
        rpPhieuTraHang CreatReport()
        {
            rpPhieuTraHang rp = new rpPhieuTraHang();
            rp.odsPhieuGiaoHang.DataSource = oReturnReport;
            rp.CreateDocument();
            return rp;
        }
        rpPhieuTraHangNoPrice CreatReportNoPrice()
        {
            rpPhieuTraHangNoPrice rp = new rpPhieuTraHangNoPrice();
            rp.odsPhieuGiaoHang.DataSource = oReturnReport;
            rp.CreateDocument();
            return rp;
        }
        private oReportGiaoHang oReturnReport
        {
            get
            {
                return (oReportGiaoHang)Session["oReturnReport"];
            }
            set
            {
                Session["oReturnReport"] = value;
            }
        }
        protected void gridTraHang_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridChiTiet_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PhieuTraHangNCCID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void gridChiTiet_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
        protected void cbpViewReport_Callback(object sender, CallbackEventArgsBase e)
        {
            int IDPhieuTraHang = int.Parse(e.Parameter);
            var PhieuTraHang = DBDataProvider.GetPhieuTraHang_NCC(IDPhieuTraHang);
            oReturnReport = new oReportGiaoHang();
            oReturnReport.MaKhachHang = PhieuTraHang.khKhachHang.MaKhachHang;
            oReturnReport.TenKhachHang = PhieuTraHang.khKhachHang.HoTen;
            oReturnReport.DienThoai = PhieuTraHang.khKhachHang.DienThoai;
            oReturnReport.DiaChiGiaoHang = PhieuTraHang.khKhachHang.DiaChi;
            oReturnReport.TenNhanVien = PhieuTraHang.nvNhanVien.HoTen;
            oReturnReport.GhiChuGiaoHang = PhieuTraHang.GhiChu;
            oReturnReport.NgayGiao = Formats.ConvertToVNDateString(PhieuTraHang.NgayTra.ToString());
            oReturnReport.NgayTao = Formats.ConvertToVNDateString(PhieuTraHang.NgayNhap.ToString());
            oReturnReport.TongTien = Convert.ToDouble(PhieuTraHang.TongTienHang);
            oReturnReport.TieuDePhieu = "PHIẾU TRẢ HÀNG " + PhieuTraHang.STTDonHang;
            oReturnReport.listProduct = new List<oProduct>();
            List<kPhieuTraHangNCCChiTiet> ListHang = DBDataProvider.ListChiTietTraHang_NCC(IDPhieuTraHang);
            int i = 1;
            foreach (var Hang in ListHang)
            {
                oProduct prod = new oProduct();
                prod.STT = i++;
                prod.MaHang = Hang.hhHangHoa.MaHang;
                prod.TenHang = Hang.hhHangHoa.TenHangHoa;
                prod.TenDonViTinh = Hang.hhHangHoa.hhDonViTinh.TenDonViTinh;
                prod.SoLuong = Convert.ToInt32(Hang.SoLuong);
                prod.DonGia = Convert.ToDouble(Hang.TienTra);
                prod.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oReturnReport.listProduct.Add(prod);
            }
        }
        protected void btnInPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            btn.ClientSideEvents.Click = String.Format("function(s, e) {{ onPrintClick({0}); }}", container.KeyValue);
        }
    }
}