using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.BaoCao
{
    public partial class CongNoDLChiTiet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                hdfViewReport["View"] = 0;
            }
            if(hdfViewReport["View"].ToString() != "0")
            {
                reportViewer.Report = CreatReport();
                hdfViewReport["View"] = 0;
            }
        }
        private DevExpress.XtraReports.UI.XtraReport CreatReport()
        {
            rpGiaoDich rp = new rpGiaoDich();
            rp.odsGiaoDich.DataSource = oInGiaoDich;
            rp.CreateDocument();
            return rp;

        }
        private oReportGiaoDich oInGiaoDich
        {
            get
            {
                return (oReportGiaoDich)Session["oInGiaoDich"];
            }
            set
            {
                Session["oInGiaoDich"] = value;
            }
        }
        protected void cbpViewReport_Callback(object sender, CallbackEventArgsBase e)
        {
            hdfViewReport["View"] = 1;
            if (ccbKhachHang.Value != null)
            {
                int IDKhachHang = Convert.ToInt32(ccbKhachHang.Value.ToString());
                oInGiaoDich = new oReportGiaoDich();
                oInGiaoDich.TieuDe = "CHI TIẾT PHÁT SINH";
                var kh = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
                oInGiaoDich.MaKhachHang = kh == null ? "" : kh.MaKhachHang;
                oInGiaoDich.TenKhachHang = kh == null ? "" : kh.HoTen;
                oInGiaoDich.DienThoai = kh == null ? "" : kh.DienThoai;
                oInGiaoDich.DiaChi = kh == null ? "" : kh.DiaChi;
                oInGiaoDich.listProduct = new List<oChiTietGiaoDich>();
                oInGiaoDich.NgayThangNam = DBDataProvider.TinhThanhCty() + ", " + Formats.ConvertToFullStringDate(DateTime.Now);
                string NgayBD = fromDay.Date.ToString("yyyy-MM-dd");
                string NgayKT = toDay.Date.AddDays(1).ToString("yyyy-MM-dd");
                List<khNhatKyCongNo> nhatky = DBDataProvider.DB.khNhatKyCongNos.Where(x => x.NgayNhap <= DateTime.Parse(NgayKT) && x.NgayNhap >= DateTime.Parse(NgayBD) && x.IDKhachHang == IDKhachHang).ToList();
                int stt = 1;
                double TongHangTra = 0, TongPhatSinh = 0, TongThanhToan = 0, TongGiamGia = 0;
                foreach (var a in nhatky)
                {
                    TongHangTra += Convert.ToDouble(a.TraHang);
                    TongPhatSinh += Convert.ToDouble(a.NhapHang);
                    TongThanhToan += Convert.ToDouble(a.ThanhToan);
                    TongGiamGia += Convert.ToDouble(a.GiamGia);
                    oChiTietGiaoDich chitiet = new oChiTietGiaoDich();
                    chitiet.STT = stt++;
                    chitiet.Ngay = Formats.ConvertToVNDateString(a.NgayNhap.ToString());
                    chitiet.NoiDung = a.DienGiai;
                    chitiet.SoPhieu = a.MaPhieu.ToString();
                    chitiet.NoDau = Convert.ToDouble(a.NoDau);
                    chitiet.NhapHang = Convert.ToDouble(a.NhapHang);
                    chitiet.HangTra = Convert.ToDouble(a.TraHang);
                    chitiet.ThanhToan = Convert.ToDouble(a.ThanhToan);
                    chitiet.NoCuoi = Convert.ToDouble(a.NoCuoi);
                    chitiet.GiamGia = Convert.ToDouble(a.GiamGia);
                    oInGiaoDich.listProduct.Add(chitiet);
                }
                oInGiaoDich.TongHangTra = TongHangTra;
                oInGiaoDich.TongPhatSinh = TongPhatSinh;
                oInGiaoDich.TongThanhToan = TongThanhToan;
                oInGiaoDich.TongGiamGia = TongGiamGia;
            }

        }
        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
        protected void grid_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exporterGrid.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
    }
}