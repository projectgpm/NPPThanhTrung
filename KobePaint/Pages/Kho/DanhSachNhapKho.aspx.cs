using DevExpress.Web;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.Kho
{
    public partial class DanhSachNhapKho : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }

        protected void gridChiTietNhapKho_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["IDNhapKho"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void gridChiTietNhapKho_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridNhaphang_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexGroupColumn(sender, e);
        }

        protected void gridNhaphang_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int IDNhapKho = Convert.ToInt32(e.Keys[0].ToString());

            using (var scope = new TransactionScope())
            {
                try
                {
                    var NhapKho = DBDataProvider.DB.kNhapKhos.Where(x => x.IDNhapKho == IDNhapKho).FirstOrDefault();
                    if (NhapKho != null)
                    {
                        if (NhapKho.TrangThaiPhieu == 0)
                        {
                            NhapKho.TrangThaiPhieu = 2;
                            khKhachHang kh = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == NhapKho.NCCID).FirstOrDefault();
                            if (NhapKho.CongNo > 0) // cập nhật công nợ + ghi nhật ký
                            {
                                #region ghi nhật ký nhập kho để xem báo cáo
                                    khNhatKyCongNo nhatky = new khNhatKyCongNo();
                                    nhatky.NgayNhap = DateTime.Now;
                                    nhatky.DienGiai = "Xóa phiếu nhập kho";
                                    nhatky.NoDau = kh.CongNo;
                                    nhatky.NhapHang = 0;
                                    nhatky.TraHang = NhapKho.CongNo;
                                    nhatky.NoCuoi = kh.CongNo - NhapKho.CongNo;
                                    nhatky.ThanhToan = 0;
                                    nhatky.NhanVienID = Formats.IDUser();
                                    nhatky.SoPhieu = NhapKho.MaPhieu;
                                    nhatky.IDKhachHang = NhapKho.NCCID;
                                    DBDataProvider.DB.khNhatKyCongNos.InsertOnSubmit(nhatky);
                                    DBDataProvider.DB.SubmitChanges();
                                #endregion

                                kh.TongTienHang -= NhapKho.TongTien;
                                kh.CongNo -= NhapKho.CongNo;
                                kh.LanCuoiMuaHang = DateTime.Now;
                            }
                            else
                            {
                                kh.TongTienHang -= NhapKho.TongTien;
                                kh.CongNo -= NhapKho.CongNo;
                                kh.LanCuoiMuaHang = DateTime.Now;
                            }

                            List<kNhapKhoChiTiet> nhapkho = DBDataProvider.NhapKhoChiTiet(IDNhapKho);
                            foreach (var nk in nhapkho)
                            {
                                int IDHangHoa = Convert.ToInt32(nk.HangHoaID);
                                int SoLuong = Convert.ToInt32(nk.SoLuong);

                                var HangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == IDHangHoa).FirstOrDefault();
                                if (HangHoa != null)
                                {
                                    //// trừ tồn kho, 
                                    //HangHoa.TonKho -= SoLuong;
                                    //ghi thẻ kho
                                    #region ghi thẻ kho
                                        kTheKho thekho = new kTheKho();
                                        thekho.NgayNhap = DateTime.Now;
                                        thekho.DienGiai = "Xóa phiếu nhập hàng #" + NhapKho.MaPhieu;
                                        thekho.Nhap = 0;
                                        thekho.GiaThoiDiem = 0;// kiê
                                        thekho.Xuat = SoLuong;
                                        thekho.Ton = HangHoa.TonKho -= SoLuong; // trừ tồn kho luôn
                                        thekho.HangHoaID = IDHangHoa;
                                        thekho.NhanVienID = Formats.IDUser();
                                        DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                    #endregion
                                }
                            }
                            DBDataProvider.DB.SubmitChanges();
                            scope.Complete();
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            gridNhaphang.CancelEdit();
            e.Cancel = true;
            gridNhaphang.DataBind();
        }
        
    }
}