using DevExpress.Web;
using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.TraHang
{
    public partial class PheDuyetTraHang : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void gridTraHang_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
        protected void gridChiTietHang_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
        protected void gridChiTietHang_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PhieuTraHangNCCID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }
      

        protected void gridTraHang_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    if (e.NewValues["DuyetDonHang"] == "0") return;
                    int IDPhieuTraHang = int.Parse(e.Keys["IDPhieuTraHang"].ToString());
                    int DaiLyID = int.Parse(gridTraHang.GetRowValuesByKeyValue(e.Keys["IDPhieuTraHang"], "DaiLyID").ToString());
                    int pheduyet = Int32.Parse(e.NewValues["DuyetDonHang"].ToString());

                    var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == DaiLyID).FirstOrDefault();
                    var PhieuTraHang = DBDataProvider.DB.kPhieuTraHangs.Where(x => x.IDPhieuTraHang == IDPhieuTraHang).FirstOrDefault();
                    if (pheduyet == 1)
                    {
                        // hoàn tất
                        if (KH != null && PhieuTraHang != null)
                        {
                            #region nhật ký công nợ
                            khNhatKyCongNo nhatky = new khNhatKyCongNo();
                            nhatky.NgayNhap = DateTime.Now;
                            nhatky.DienGiai = "Khách trả hàng ";
                            nhatky.NoDau = KH.CongNo;
                            nhatky.NhapHang = 0;
                            nhatky.TraHang = PhieuTraHang.TongTienHang;
                            nhatky.GiamGia = 0;
                            nhatky.NoCuoi = KH.CongNo - PhieuTraHang.ConLai;
                            nhatky.ThanhToan = -PhieuTraHang.ThanhToan;
                            nhatky.MaPhieu = DBDataProvider.STTPhieuTraHang_DaiLy(DaiLyID);
                            nhatky.NhanVienID = Formats.IDUser();
                            nhatky.SoPhieu = PhieuTraHang.MaPhieu;
                            nhatky.IDKhachHang = DaiLyID;
                            DBDataProvider.DB.khNhatKyCongNos.InsertOnSubmit(nhatky);
                            DBDataProvider.DB.SubmitChanges();
                            #endregion

                            if (PhieuTraHang.HinhThucTT == 1)
                            {
                                KH.CongNo -= PhieuTraHang.ConLai; // giảm công nợ
                            }
                            KH.TienTraHang += PhieuTraHang.TongTienHang;
                            KH.LanCuoiMuaHang = DateTime.Now;

                            PhieuTraHang.DuyetDonHang = 1;// duyệt thành công
                            PhieuTraHang.STTDonHang = DBDataProvider.STTPhieuTraHang_DaiLy(DaiLyID);
                            // + tồn kho
                            var PhieuTraHangChiTiet = DBDataProvider.DB.kPhieuTraHangChiTiets.Where(x => x.PhieuTraHangNCCID == IDPhieuTraHang).ToList();
                            foreach (var prod in PhieuTraHangChiTiet)
                            {
                                var HH = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == prod.HangHoaID).FirstOrDefault();
                                HH.TonKho += prod.SoLuong;
                                // ghi thẻ kho
                                #region ghi thẻ kho
                                kTheKho thekho = new kTheKho();
                                thekho.NgayNhap = DateTime.Now;
                                thekho.DienGiai = "Trả hàng #" + PhieuTraHang.MaPhieu;
                                thekho.Nhap = prod.SoLuong;
                                thekho.Xuat = 0;
                                thekho.GiaThoiDiem = prod.TienTra;
                                thekho.Ton = prod.SoLuong + prod.TonKho;
                                thekho.HangHoaID = HH.IDHangHoa;
                                thekho.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                #endregion
                            }
                        }
                    }
                    else
                    {
                        // hủy đơn hàng
                        if (KH != null && PhieuTraHang != null)
                        {
                            PhieuTraHang.DuyetDonHang = 2;// hủy đơn hàng
                            PhieuTraHang.STTDonHang = 0;
                        }
                    }
                    PhieuTraHang.NgayDuyet = DateTime.Now;
                    DBDataProvider.DB.SubmitChanges();
                    scope.Complete();
                    gridTraHang.CancelEdit();
                    e.Cancel = true;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
    }
}