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
    public partial class DanhSachXuatKhac : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }
      
        protected void gridXuathang_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridXuathang_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int IDPhieuXuat = Convert.ToInt32(e.Keys[0].ToString());
            using (var scope = new TransactionScope())
            {
                try
                {
                    var XuatKho = DBDataProvider.DB.kPhieuXuatKhacs.Where(x => x.IDPhieuXuat == IDPhieuXuat).FirstOrDefault();
                    if (XuatKho != null)
                    {
                        if (XuatKho.DaXoa == 0)
                        {
                            XuatKho.DaXoa = 1; // đã xóa
                            List<kPhieuXuatKhacChiTiet> ctXuatKho = DBDataProvider.XuatKhacKhoChiTiet(IDPhieuXuat);
                            foreach (var xk in ctXuatKho)
                            {
                                int IDHangHoa = Convert.ToInt32(xk.HangHoaID);
                                int SoLuong = Convert.ToInt32(xk.SoLuong);
                                var HangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == IDHangHoa).FirstOrDefault();
                                if (HangHoa != null)
                                {
                                    #region ghi thẻ kho
                                    kTheKho thekho = new kTheKho();
                                        thekho.NgayNhap = DateTime.Now;
                                        thekho.DienGiai = "Xóa phiếu xuất khác #" + XuatKho.MaPhieuXuat;
                                        thekho.Nhap = SoLuong;
                                        thekho.Xuat = 0;
                                        thekho.Ton = HangHoa.TonKho += SoLuong; // cộng tồn kho luôn
                                        thekho.HangHoaID = IDHangHoa;
                                        thekho.GiaThoiDiem = 0;
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
            gridXuathang.CancelEdit();
            e.Cancel = true;
            gridXuathang.DataBind();
        }

        protected void gridChiTietXuatKho_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PhieuXuatID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void gridChiTietXuatKho_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
    }
}