using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.ThanhToan
{
    public partial class LapThanhToanNCC : System.Web.UI.Page
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
        #region Report
        private DevExpress.XtraReports.UI.XtraReport CreatReport()
        {
            rpPhieuThanhToan rp = new rpPhieuThanhToan();
            rp.odsPayNode.DataSource = oPhieuTTExport;
            rp.CreateDocument();
            return rp;
        }
        private oThanhToan oPhieuTTExport
        {
            get
            {
                return (oThanhToan)Session["oPhieuTT"];
            }
            set
            {
                Session["oPhieuTT"] = value;
            }
        }

        private void CreateReportReview()
        {

            hdfViewReport["view"] = 1;
            oPhieuTTExport = new oThanhToan();
            oPhieuTTExport.NgayThu = DBDataProvider.TinhThanhCty() + ", " + Formats.ConvertToFullStringDate(DateTime.Parse(dateNgayTT.Text.ToString()));
            var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == Convert.ToInt32(ccbKhachHang.Value.ToString())).FirstOrDefault();
            oPhieuTTExport.STTPhieuThu = 0000;
            oPhieuTTExport.TieuDe = "PHIẾU THANH TOÁN ";
            oPhieuTTExport.XemTruoc = "(Xem trước)";
            oPhieuTTExport.SoHoaDon = txtHoaDon.Text;
            oPhieuTTExport.TenKhachHang = KH.HoTen;
            oPhieuTTExport.MaKhachHang = KH.MaKhachHang;
            oPhieuTTExport.DienThoai = KH.DienThoai;
            oPhieuTTExport.NoiDung = memoNoiDungTT.Text;
            oPhieuTTExport.SoTienThu = Convert.ToDouble(speSoTienTT.Number);
            oPhieuTTExport.CongNoTruocThanhToan = Convert.ToDouble(KH.CongNo);
            oPhieuTTExport.CongNoSauThanhToan = Convert.ToDouble(KH.CongNo) - Convert.ToDouble(speSoTienTT.Number);
            cbpThanhToan.JSProperties["cp_rpView"] = true;
        }
        #endregion
        protected void cbpThanhToan_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "PhieuTT":
                    int IDNhapKho = int.Parse(ccbPhieuThanhToan.Value.ToString());
                    var PhieuTT = DBDataProvider.DB.kNhapKhos.Where(x => x.IDNhapKho == IDNhapKho).FirstOrDefault();
                    txtSoTienDaTT.Text = PhieuTT.ThanhToan.ToString();
                    speSoTienTT.Text = PhieuTT.CongNo.ToString();
                    //speSoTienTT.Enabled = false;
                    ListPhieuThanhToan(Convert.ToInt32(ccbKhachHang.Value.ToString()));
                    memoNoiDungTT.Text += " " + PhieuTT.CongNo.ToString() + " ĐỒNG";
                    break;
                case "Customer":
                    //ccbPhieuThanhToan.SelectedIndex = 0;
                    speSoTienTT.Text = "0";
                    int IDKhachHang = int.Parse(ccbKhachHang.Value.ToString());
                    var KhachHang = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
                    txtCongNoHienTai.Text = KhachHang.CongNo.ToString();
                    ccbPhieuThanhToan.Text = "";
                    ListPhieuThanhToan(IDKhachHang);
                    break;
                case "Review": CreateReportReview(); break;
                default:
                    LuuThanhToan();
                    Reset();
                    break;
            }
        }

        private void ListPhieuThanhToan(int IDKhachHang)
        {
            var KhachHang = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
            memoNoiDungTT.Text = "";
            memoNoiDungTT.Text = "THANH TOÁN: " + KhachHang.HoTen.ToUpper();

            var ListNhapHang = DBDataProvider.ListPhieuNhapHang(IDKhachHang);
            ccbPhieuThanhToan.DataSource = ListNhapHang;
            ccbPhieuThanhToan.DataBind();
        }

        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
        protected void Reset()
        {
            ccbKhachHang.DataBind();
            ccbKhachHang.SelectedIndex = -1;
            DevExpress.Web.ASPxEdit.ClearEditorsInContainer(formThanhToan);
            rdlHinhThuc.SelectedIndex = 0;
            dateNgayTT.Date = DateTime.Now;
        }
        public void LuuThanhToan()
        {
             using (var scope = new TransactionScope())
            {
                try
                {
                    double? SoTienThu = double.Parse(speSoTienTT.Number.ToString());
                    if (SoTienThu == 0)
                        throw new Exception("Chưa nhập số tiền thanh toán");
                    double? SoNoHienTai = double.Parse(txtCongNoHienTai.Text);
                    if (SoTienThu > SoNoHienTai)
                        throw new Exception("Số tiền thu không được vượt qua số nợ hiện tại");

                    int IDKhachHang = Convert.ToInt32(ccbKhachHang.Value.ToString());
                    string SoHoaDon = txtHoaDon.Text;
                    string NoiDung = memoNoiDungTT.Text;
                    DateTime NgayThu = Formats.ConvertToDateTime(dateNgayTT.Text);
                    int HinhThucThu = rdlHinhThuc.SelectedIndex == 0 ? 1 : 2;
                    double CongNoCu = double.Parse(txtCongNoHienTai.Text);

                    kPhieuThanhToanNCC thanhtoan = new kPhieuThanhToanNCC();
                    thanhtoan.STTPhieuThu = DBDataProvider.STTPhieuThanhToan_NCC(IDKhachHang);
                    thanhtoan.SoHoaDon = SoHoaDon;
                    thanhtoan.KhachHangID = IDKhachHang;
                    thanhtoan.SoTienThu = SoTienThu;
                    thanhtoan.NoiDung = NoiDung;
                    thanhtoan.NgayThu = NgayThu;
                    thanhtoan.NgayLap = DateTime.Now;
                    thanhtoan.NhanVienThuID = Formats.IDUser();
                    thanhtoan.HinhThucTTID = HinhThucThu;
                    thanhtoan.CongNoCu = CongNoCu;

                    DBDataProvider.DB.kPhieuThanhToanNCCs.InsertOnSubmit(thanhtoan);
                    DBDataProvider.DB.SubmitChanges();
                    int IDPhieuThu = thanhtoan.IDPhieuThu;

                    if (rdlHinhThuc.SelectedIndex == 0)
                    {
                        //Cap nhat thanh toan phieu đặt hàng
                        List<kNhapKho> ListPhieuNhapKho = DBDataProvider.ListPhieuNhapHang_ASC(IDKhachHang);// phiếu đã được duyệt & chưa thanh toán
                        int i = 0;
                        if (SoTienThu > 0 && ListPhieuNhapKho.Count > 0)
                        {
                            while (SoTienThu > 0 && i < ListPhieuNhapKho.Count)
                            {
                                double? TienNoDonHang = ListPhieuNhapKho[i].CongNo;
                                if (SoTienThu >= TienNoDonHang) //Thanh toán hết đơn hàng
                                {
                                    ListPhieuNhapKho[i].ThanhToan = ListPhieuNhapKho[i].TongTien; //cập nhật lại thanh toán = tổng tiền
                                    ListPhieuNhapKho[i].CongNo = 0;// cập nhật còn lại  = 0;
                                    ListPhieuNhapKho[i].TTThanhToan = 1;// đã thanh toán
                                    khKhachHang KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
                                    if (KH != null)
                                    {
                                        #region ghi nhật ký nhập kho để xem báo cáo
                                        khNhatKyCongNo nhatky = new khNhatKyCongNo();
                                        nhatky.NgayNhap = DateTime.Now;
                                        nhatky.DienGiai = "Thanh toán Nhà cung cấp";
                                        nhatky.NoDau = KH.CongNo;
                                        nhatky.NhapHang = 0;
                                        nhatky.TraHang = 0;
                                        nhatky.ThanhToan = TienNoDonHang;
                                        nhatky.NoCuoi = KH.CongNo - TienNoDonHang;
                                        nhatky.NhanVienID = Formats.IDUser();
                                        nhatky.SoPhieu = ListPhieuNhapKho[i].MaPhieu;
                                        nhatky.IDKhachHang = IDKhachHang;
                                        DBDataProvider.DB.khNhatKyCongNos.InsertOnSubmit(nhatky);
                                        DBDataProvider.DB.SubmitChanges();
                                        #endregion
                                        KH.CongNo -= TienNoDonHang; // - công nợ
                                        KH.ThanhToan += TienNoDonHang;
                                    }
                                    SoTienThu -= TienNoDonHang;

                                }
                                else // Thanh toán 1 phần đơn hàng
                                {
                                    ListPhieuNhapKho[i].ThanhToan += SoTienThu; // cộng phần còn lại vào thanh toán.
                                    ListPhieuNhapKho[i].CongNo = ListPhieuNhapKho[i].TongTien - ListPhieuNhapKho[i].ThanhToan; // cập nhật phần còn lại
                                    //ListPhieuGiaoHang[i].TTThanhToan = 1;// đã thanh toán
                                    khKhachHang KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
                                    if (KH != null)
                                    {
                                        #region ghi nhật ký nhập kho để xem báo cáo
                                        khNhatKyCongNo nhatky = new khNhatKyCongNo();
                                        nhatky.NgayNhap = DateTime.Now;
                                        nhatky.DienGiai = "Thanh toán Nhà cung cấp";
                                        nhatky.NoDau = KH.CongNo;
                                        nhatky.NhapHang = 0;
                                        nhatky.TraHang = 0;
                                        nhatky.ThanhToan = SoTienThu;
                                        nhatky.NoCuoi = KH.CongNo - SoTienThu;
                                        nhatky.NhanVienID = Formats.IDUser();
                                        nhatky.SoPhieu = ListPhieuNhapKho[i].MaPhieu;
                                        nhatky.IDKhachHang = IDKhachHang;
                                        DBDataProvider.DB.khNhatKyCongNos.InsertOnSubmit(nhatky);
                                        DBDataProvider.DB.SubmitChanges();
                                        #endregion
                                        KH.CongNo -= SoTienThu; // - công nợ
                                        KH.ThanhToan += SoTienThu;
                                    }
                                    SoTienThu -= SoTienThu;
                                }
                                i++;
                            }
                        }
                        else
                        {
                            // trừ công nợ thẳng.
                            khKhachHang KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
                            if (KH != null)
                            {
                                #region ghi nhật ký nhập kho để xem báo cáo
                                khNhatKyCongNo nhatky = new khNhatKyCongNo();
                                nhatky.NgayNhap = DateTime.Now;
                                nhatky.DienGiai = "Thanh toán Nhà cung cấp";
                                nhatky.NoDau = KH.CongNo;
                                nhatky.NhapHang = 0;
                                nhatky.TraHang = 0;
                                nhatky.ThanhToan = SoTienThu;
                                nhatky.NoCuoi = KH.CongNo - SoTienThu;
                                nhatky.NhanVienID = Formats.IDUser();
                                nhatky.SoPhieu = "";
                                nhatky.IDKhachHang = IDKhachHang;
                                DBDataProvider.DB.khNhatKyCongNos.InsertOnSubmit(nhatky);
                                DBDataProvider.DB.SubmitChanges();
                                #endregion
                                KH.CongNo -= SoTienThu; // - công nợ
                                KH.ThanhToan += SoTienThu;
                            }
                        }
                    }
                    else
                    {
                        // trừ theo phiếu
                        int IDNhapKho = int.Parse(ccbPhieuThanhToan.Value.ToString());
                        kNhapKho PhieuNK = DBDataProvider.DB.kNhapKhos.Single(x => x.IDNhapKho == IDNhapKho);
                        
                        khKhachHang KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
                        if (KH != null)
                        {
                            #region ghi nhật ký nhập kho để xem báo cáo
                            khNhatKyCongNo nhatky = new khNhatKyCongNo();
                            nhatky.NgayNhap = DateTime.Now;
                            nhatky.DienGiai = "Thanh toán Nhà cung cấp";
                            nhatky.NoDau = KH.CongNo;
                            nhatky.NhapHang = 0;
                            nhatky.TraHang = 0;
                            nhatky.ThanhToan = PhieuNK.CongNo;
                            nhatky.NoCuoi = KH.CongNo - PhieuNK.CongNo;
                            nhatky.NhanVienID = Formats.IDUser();
                            nhatky.SoPhieu = PhieuNK.MaPhieu;
                            nhatky.IDKhachHang = IDKhachHang;
                            DBDataProvider.DB.khNhatKyCongNos.InsertOnSubmit(nhatky);
                            DBDataProvider.DB.SubmitChanges();
                            #endregion
                            KH.CongNo -= PhieuNK.CongNo;// - công nợ
                            KH.ThanhToan += PhieuNK.CongNo;
                        }
                        PhieuNK.ThanhToan = PhieuNK.TongTien;
                        PhieuNK.CongNo = 0;
                        PhieuNK.TTThanhToan = 1;// đã thanh toán
                    }
                    DBDataProvider.DB.SubmitChanges();
                    scope.Complete();
                    // Reset();
                    cbpThanhToan.JSProperties["cp_Reset"] = true;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        protected void btnRenew_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/ThanhToan/LapThanhToanNCC.aspx");
        }

    }
}