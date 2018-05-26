using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.KH_NCC
{
    public partial class ThemKH : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                dsLoaiKH.SelectParameters["Quyen"].DefaultValue = Formats.PermissionUser().ToString();
                txtTenKH.Focus();
                txtMaKH.Text = "KH" + (DateTime.Now).ToString("MM") + BitConverter.ToInt32(Guid.NewGuid().ToByteArray(), 10).ToString().Substring(1, 4);
            }  
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "btnLapMoiClick": Reset(); break;
                case "btnTroVeClick": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/KhachHang/DanhSachKH.aspx"); break;
                case "btnLuuClick": LuuLai(); break;
                case "btnLuuTiepTucClick": Save(); cbpInfo.JSProperties["cp_Reset"] = true; Reset(); break;
                default: break;
            }
        }
        private void Save()
        {
            var KT = DBDataProvider.DB.khKhachHangs.Where(x => x.MaKhachHang == txtMaKH.Text).Count();
            if (KT == 0)
            {
                khKhachHang kh = new khKhachHang();
                kh.MaKhachHang = txtMaKH.Text;
                kh.LoaiKhachHangID = Convert.ToInt32(ccbLoaiKH.Value.ToString());
                kh.MaSoThue = txtMaSoThue.Text;
                kh.HoTen = txtTenKH.Text;
                kh.Email = txtEmail.Text;
                kh.DiaChi = txtDiaChi.Text;
                kh.DienThoai = txtDienThoai.Text;
                kh.GhiChu = txtGhiChu.Text;
                kh.NgayTao = DateTime.Now;
                kh.LanCuoiMuaHang = DateTime.Now;
                kh.TongTienHang = 0;
                kh.TienTraHang = 0;
                kh.CongNo = 0;
                kh.DaXoa = 0;
                kh.IDBangGia = 1;// bảng giá chung
                kh.ThanhToan = 0;
                DBDataProvider.DB.khKhachHangs.InsertOnSubmit(kh);
                DBDataProvider.DB.SubmitChanges();
            }
            else
            {
            }
        }
        private void Reset()
        {
            txtMaKH.Text = "KH" + (DateTime.Now).ToString("MM") + BitConverter.ToInt32(Guid.NewGuid().ToByteArray(), 10).ToString().Substring(1, 4);
            ccbLoaiKH.SelectedIndex = 0;
            txtTenKH.Text = "";
            txtTenKH.Focus();
            txtMaSoThue.Text = "";
            txtDienThoai.Text = "";
            txtDiaChi.Text = "";
            txtEmail.Text = "";
            txtGhiChu.Text = "";
        }
        protected void LuuLai()
        {
            Save();
            if (ccbLoaiKH.Value.ToString() == "2")
                DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/KhachHang/DanhSachNCC.aspx");
            DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/KhachHang/DanhSachKH.aspx");
        }
        
    }
}