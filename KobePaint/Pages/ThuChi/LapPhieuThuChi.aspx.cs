using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.ThuChi
{
    public partial class LapPhieuThuChi : System.Web.UI.Page
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

        protected void btnRenew_Click(object sender, EventArgs e)
        {
            DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/ThuChi/LapPhieuThuChi.aspx");
        }
        protected void cbpThem_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "ccbLoaiPhieuSelectedIndex":
                    memoNoiDung.Text = "";
                    spSoTien.Number = 0;
                    break;
                case "spSoTienOnNumberChanged":
                    memoNoiDung.Text = "";
                    memoNoiDung.Text = ccbLoaiPhieu.Text.ToUpper() + " " + ccbLoaiThuChi.Text.ToUpper() + " SỐ TIỀN: " + spSoTien.Text + " ĐỒNG";
                    break;
                case "Save": Save(); Rest(); break;
                case "redirect": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/ThuChi/DanhSachThuChi.aspx"); break;
                case "Review": CreateReportReview();  break;
                default: break;
            }
        }
        #region Report
        private DevExpress.XtraReports.UI.XtraReport CreatReport()
        {

            rpPhieuThuChi rp = new rpPhieuThuChi();
            rp.odsPayNode.DataSource = oPhieuTC;
            rp.CreateDocument();
            return rp;
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
       
        private void CreateReportReview()
        {

            int LoaiPhieu = Convert.ToInt32(ccbLoaiPhieu.Value.ToString());
            string MAX = (DBDataProvider.DB.pPhieuThuChis.Where(x => x.LoaiPhieu == LoaiPhieu).Count() + 1).ToString();
            if (LoaiPhieu == 0)
            {
                //phiếu thu
                string MaPhieu = "PT";
                for (int i = 1; i < (9 - MAX.Length); i++)
                {
                    MaPhieu += "0";
                }
                MaPhieu += MAX;
                oPhieuTC = new oThuChi();
                oPhieuTC.TieuDe = "PHIẾU THU";
                oPhieuTC.XemTruoc = "(Xem trước)";
                oPhieuTC.MaPhieu = "Mã phiếu thu: " + MaPhieu;
                oPhieuTC.Ngay = Formats.ConvertToVNDateString(dateNgayLap.Text);
                oPhieuTC.HoTen = "Họ tên người nộp tiền";
                oPhieuTC.TenNguoiNopNhan = txtKhachHang.Text;
                oPhieuTC.DienThoai =  txtDienThoai.Text;
                oPhieuTC.DiaChi = txtDiaChi.Text;
                oPhieuTC.LyDo = "Lý do nộp";
                oPhieuTC.NoiDungLyDo = memoNoiDung.Text;
                oPhieuTC.SoTien = Convert.ToDouble(spSoTien.Number);
                oPhieuTC.NguoiNopChi = "Người nộp";
                oPhieuTC.NguoiThuChi = "Người thu";
                oPhieuTC.NgayThangNam = Formats.ConvertToFullStringDate_ToUp(DateTime.Parse(dateNgayLap.Text.ToString()));
            }
            else
            {
                // Phiếu chi
                string MaPhieu = "PC";
                for (int i = 1; i < (9 - MAX.Length); i++)
                {
                    MaPhieu += "0";
                }
                MaPhieu += MAX;
                oPhieuTC = new oThuChi();
                oPhieuTC.TieuDe = "PHIẾU CHI";
                oPhieuTC.XemTruoc = "(Xem trước)";
                oPhieuTC.MaPhieu = "Mã phiếu chi: " + MaPhieu;
                oPhieuTC.Ngay = Formats.ConvertToVNDateString(dateNgayLap.Text);
                oPhieuTC.HoTen = "Họ tên người nhận tiền";
                oPhieuTC.TenNguoiNopNhan = txtKhachHang.Text;
                oPhieuTC.DienThoai = txtDienThoai.Text;
                oPhieuTC.DiaChi = txtDiaChi.Text;
                oPhieuTC.LyDo = "Lý do nhận";
                oPhieuTC.NoiDungLyDo = memoNoiDung.Text;
                oPhieuTC.SoTien = Convert.ToDouble(spSoTien.Number);
                oPhieuTC.NguoiNopChi = "Người nhận";
                oPhieuTC.NguoiThuChi = "Người chi";
                oPhieuTC.NgayThangNam = Formats.ConvertToFullStringDate_ToUp(DateTime.Parse(dateNgayLap.Text.ToString()));
            }
            cbpThem.JSProperties["cp_rpView"] = true;
        }
        #endregion
        private void Save()
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    int LoaiPhieu = Convert.ToInt32(ccbLoaiPhieu.Value.ToString());
                    pPhieuThuChi item = new pPhieuThuChi();
                    item.NgayLap = Convert.ToDateTime(dateNgayLap.Date);
                    item.NhanVienID = Formats.IDUser();
                    item.NguoiNop = txtKhachHang.Text;
                    item.NoiDung = memoNoiDung.Text;
                    item.DienThoai = txtDienThoai.Text;
                    item.DiaChi = txtDiaChi.Text;
                    item.SoTien = Convert.ToDouble(spSoTien.Number);
                    item.LoaiThuChiID = Convert.ToInt32(ccbLoaiThuChi.Value.ToString());
                    item.LoaiPhieu = LoaiPhieu;
                    item.NgayLuu = DateTime.Now;
                    string MaPhieu = "";
                    string MAX = (DBDataProvider.DB.pPhieuThuChis.Where(x => x.LoaiPhieu == LoaiPhieu).Count() + 1).ToString();

                    var ChiNhanh = DBDataProvider.DB.chChiNhanhs.Where(x => x.IDChiNhanh == Formats.IDChiNhanh()).FirstOrDefault();
                    item.DuDau = ChiNhanh.QuyThuChi;
                   
                    if (LoaiPhieu == 0)
                    {
                        //phiếu thu
                        MaPhieu = "PT";
                        for (int i = 1; i < (9 - MAX.Length); i++)
                        {
                            MaPhieu += "0";
                        }
                        MaPhieu += MAX;
                        item.DuCuoi = ChiNhanh.QuyThuChi += Convert.ToDouble(spSoTien.Number);
                    }
                    else
                    {
                        //phiếu chi
                        MaPhieu = "PC";
                        for (int i = 1; i < (9 - MAX.Length); i++)
                        {
                            MaPhieu += "0";
                        }
                        MaPhieu += MAX;
                        item.DuCuoi = ChiNhanh.QuyThuChi -= Convert.ToDouble(spSoTien.Number);
                    }

                    item.MaPhieu = MaPhieu;
                    DBDataProvider.DB.pPhieuThuChis.InsertOnSubmit(item);
                    DBDataProvider.DB.SubmitChanges();
                    scope.Complete();
                    cbpThem.JSProperties["cp_Reset"] = true;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }    
        }
        private void Rest()
        {
            ccbLoaiPhieu.Text = "";
            ccbLoaiThuChi.Text = "";
            spSoTien.Number = 0;
            txtKhachHang.Text = "";
            memoNoiDung.Text = "";
        }
        protected void gridLoaiThuChi_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void ccbLoaiThuChi_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ccbLoaiThuChi.DataBind();
        }

        protected void dateNgayLap_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
    }
}