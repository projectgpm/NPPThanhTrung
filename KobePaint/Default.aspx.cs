using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint {
    public partial class _Default : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            // phân quyền
            int Permiss = Formats.PermissionUser();
            if (Permiss == 3) Response.Redirect("~/Pages/BanHang/LapPhieu.aspx");

            if (CountPhieuGiaoHang() > 0)
                pageControl.TabPages[0].Text = string.Format("PHIẾU GIAO HÀNG ĐẠI LÝ CHỜ DUYỆT <span class=\"countGH\">{0}</span>", CountPhieuGiaoHang());
            if (CountPhieuTraHang() > 0)
                pageControl.TabPages[1].Text = string.Format("PHIẾU ĐẠI LÝ TRẢ HÀNG CHỜ DUYỆT <span class=\"countTH\">{0}</span>", CountPhieuTraHang());
          
        }

        private int CountPhieuTraHang()
        {
            return DBDataProvider.DB.kPhieuTraHangs.Where(x => x.DuyetDonHang == 0).Count();
        }

        private int CountPhieuGiaoHang()
        {
            return DBDataProvider.DB.ghPhieuGiaoHangs.Where(x => x.TrangThai == 0).Count();
        }
    }
}