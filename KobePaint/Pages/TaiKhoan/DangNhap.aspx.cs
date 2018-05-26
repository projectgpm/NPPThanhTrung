using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.TaiKhoan
{
    public partial class DangNhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Default.aspx");
            }
        }
        protected void btOK_Click(object sender, EventArgs e)
        {
            var user = from p in DBDataProvider.DB.nvNhanViens
                       where p.TenDangNhap == tbLogin.Text.Trim() && p.MatKhau == tbPassword.Text.Trim() && p.DaXoa == false
                       select new
                       {
                           userID = p.IDNhanVien,
                           TenNguoiDung = p.HoTen,
                           Quyen = p.NhomID,
                           IDChiNhanh= p.IDChiNhanh
                       };
            if(user.Any())
            {
                FormsAuthentication.RedirectFromLoginPage(user.First().userID + "-" + user.First().TenNguoiDung + "-" + user.First().Quyen + "-" + user.First().IDChiNhanh, chbRemember.Checked);
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                lblError.Text = "Tài khoản không chính xác ?";
            }
        }
    }
}