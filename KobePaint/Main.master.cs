using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint {
    public partial class MainMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            if (Context.User.Identity.IsAuthenticated)
            {
            }
            else
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }
    }
}