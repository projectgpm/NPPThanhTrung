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
    public partial class LapThanhToan : System.Web.UI.Page
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
                    int IDPhieuThanhToan = int.Parse(ccbPhieuThanhToan.Value.ToString());
                    var PhieuTT = DBDataProvider.DB.ghPhieuGiaoHangs.Where(x => x.IDPhieuGiaoHang == IDPhieuThanhToan).FirstOrDefault();
                    txtSoTienDaTT.Text = PhieuTT.ThanhToan.ToString();
                    speSoTienTT.Text = PhieuTT.ConLai.ToString();
                    ListPhieuThanhToan(Convert.ToInt32(ccbKhachHang.Value.ToString()));
                    memoNoiDungTT.Text += PhieuTT.ConLai.ToString() + " ĐỒNG";
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
              
                case "redirect": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/ThanhToan/LapThanhToan.aspx"); break;
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
            memoNoiDungTT.Text = KhachHang.HoTen.ToUpper() + " THANH TOÁN: ";
            
            var ListDonHang = DBDataProvider.ListPhieuGiaoHang(IDKhachHang);
            ccbPhieuThanhToan.DataSource = ListDonHang;
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


                    ghPhieuDaiLyThanhToan thanhtoan = new ghPhieuDaiLyThanhToan();
                    thanhtoan.STTPhieuThu = DBDataProvider.STTPhieuThanhToan_DaiLy(IDKhachHang);
                    thanhtoan.SoHoaDon = SoHoaDon;
                    thanhtoan.KhachHangID = IDKhachHang;
                    thanhtoan.SoTienThu = SoTienThu;
                    thanhtoan.NoiDung = NoiDung;
                    thanhtoan.NgayThu = NgayThu;
                    thanhtoan.NgayLap = DateTime.Now;
                    thanhtoan.NhanVienThuID = Formats.IDUser();
                    thanhtoan.HinhThucTTID = HinhThucThu;
                    thanhtoan.CongNoCu = CongNoCu;

                    DBDataProvider.DB.ghPhieuDaiLyThanhToans.InsertOnSubmit(thanhtoan);
                    DBDataProvider.DB.SubmitChanges();
                    int IDPhieuThu = thanhtoan.IDPhieuThu;
                    khKhachHang KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
                    KH.LanCuoiMuaHang = DateTime.Now;
                    if (rdlHinhThuc.SelectedIndex == 0)
                    {
                        //Cap nhat thanh toan phieu giao hang
                        List<ghPhieuGiaoHang> ListPhieuGiaoHang = DBDataProvider.ListPhieuGiaoHang_ASC(IDKhachHang);// phiếu đã được duyệt & chưa thanh toán
                        int i = 0;
                        if (SoTienThu > 0 && ListPhieuGiaoHang.Count > 0)
                        {
                            while (SoTienThu > 0 && i < ListPhieuGiaoHang.Count)
                            {
                                double? TienNoDonHang = ListPhieuGiaoHang[i].ConLai;
                                if (SoTienThu >= TienNoDonHang) //Thanh toán hết đơn hàng
                                {
                                    ListPhieuGiaoHang[i].ThanhToan = ListPhieuGiaoHang[i].TongTien; //cập nhật lại thanh toán = tổng tiền
                                    ListPhieuGiaoHang[i].ConLai = 0;// cập nhật còn lại  = 0;
                                    ListPhieuGiaoHang[i].TTThanhToan = 1;// đã thanh toán
                                    if (KH != null)
                                    {
                                        #region ghi nhật ký nhập kho để xem báo cáo
                                        khNhatKyCongNo nhatky = new khNhatKyCongNo();
                                        nhatky.NgayNhap = DateTime.Now;
                                        nhatky.DienGiai = "Thanh toán";
                                        nhatky.NoDau = KH.CongNo;
                                        nhatky.NhapHang = 0;
                                        nhatky.GiamGia = 0;
                                        nhatky.TraHang = 0;
                                        nhatky.MaPhieu = DBDataProvider.STTPhieuThanhToan_DaiLy(IDKhachHang);
                                        nhatky.ThanhToan = TienNoDonHang;
                                        nhatky.NoCuoi = KH.CongNo - TienNoDonHang;
                                        nhatky.NhanVienID = Formats.IDUser();
                                        nhatky.SoPhieu = ListPhieuGiaoHang[i].MaPhieu;
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
                                    ListPhieuGiaoHang[i].ThanhToan += SoTienThu; // cộng phần còn lại vào thanh toán.
                                    ListPhieuGiaoHang[i].ConLai = ListPhieuGiaoHang[i].TongTien - ListPhieuGiaoHang[i].ThanhToan; // cập nhật phần còn lại
                                    //ListPhieuGiaoHang[i].TTThanhToan = 1;// đã thanh toán

                                    if (KH != null)
                                    {
                                        #region ghi nhật ký nhập kho để xem báo cáo
                                        khNhatKyCongNo nhatky = new khNhatKyCongNo();
                                        nhatky.NgayNhap = DateTime.Now;
                                        nhatky.DienGiai = "Thanh toán";
                                        nhatky.NoDau = KH.CongNo;
                                        nhatky.NhapHang = 0;
                                        nhatky.TraHang = 0;
                                        nhatky.ThanhToan = SoTienThu;
                                        nhatky.GiamGia = 0;
                                        nhatky.NoCuoi = KH.CongNo - SoTienThu;
                                        nhatky.NhanVienID = Formats.IDUser();
                                        nhatky.MaPhieu = DBDataProvider.STTPhieuThanhToan_DaiLy(IDKhachHang);
                                        nhatky.SoPhieu = ListPhieuGiaoHang[i].MaPhieu;
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

                            if (KH != null)
                            {
                                #region ghi nhật ký nhập kho để xem báo cáo
                                khNhatKyCongNo nhatky = new khNhatKyCongNo();
                                nhatky.NgayNhap = DateTime.Now;
                                nhatky.DienGiai = "Thanh toán";
                                nhatky.NoDau = KH.CongNo;
                                nhatky.NhapHang = 0;
                                nhatky.TraHang = 0;
                                nhatky.GiamGia = 0;
                                nhatky.ThanhToan = SoTienThu;
                                nhatky.NoCuoi = KH.CongNo - SoTienThu;
                                nhatky.NhanVienID = Formats.IDUser();
                                nhatky.SoPhieu = "";
                                nhatky.MaPhieu = DBDataProvider.STTPhieuThanhToan_DaiLy(IDKhachHang);
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
                        int IDPhieuGiaoHang = int.Parse(ccbPhieuThanhToan.Value.ToString());
                        ghPhieuGiaoHang PhieuGH = DBDataProvider.DB.ghPhieuGiaoHangs.Single(x => x.IDPhieuGiaoHang == IDPhieuGiaoHang);

                        if (KH != null)
                        {
                            #region ghi nhật ký nhập kho để xem báo cáo
                            khNhatKyCongNo nhatky = new khNhatKyCongNo();
                            nhatky.NgayNhap = DateTime.Now;
                            nhatky.DienGiai = "Thanh toán";
                            nhatky.NoDau = KH.CongNo;
                            nhatky.NhapHang = 0;
                            nhatky.TraHang = 0;
                            nhatky.GiamGia = 0;
                            nhatky.MaPhieu = DBDataProvider.STTPhieuThanhToan_DaiLy(IDKhachHang);
                            nhatky.ThanhToan = PhieuGH.ConLai;
                            nhatky.NoCuoi = KH.CongNo - PhieuGH.ConLai;
                            nhatky.NhanVienID = Formats.IDUser();
                            nhatky.SoPhieu = PhieuGH.MaPhieu;
                            nhatky.IDKhachHang = IDKhachHang;
                            DBDataProvider.DB.khNhatKyCongNos.InsertOnSubmit(nhatky);
                            DBDataProvider.DB.SubmitChanges();
                            #endregion
                            KH.CongNo -= PhieuGH.ConLai;// - công nợ
                            KH.ThanhToan += PhieuGH.TongTien;
                        }
                        PhieuGH.ThanhToan = PhieuGH.TongTien;
                        PhieuGH.ConLai = 0;
                        PhieuGH.TTThanhToan = 1;
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

        
    }
    
}