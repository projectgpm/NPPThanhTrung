using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Data.Linq.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.KH_NCC
{
    public partial class DanhSachKH : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                if (Formats.PermissionUser() == 3)
                    gridDanhSachKH.Columns["chucnang"].Visible = false;
            }
        }

        protected void gridDanhSachKH_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e)
        {
        }
        protected void cbpInfoStep_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
           
        }

        protected void gridDanhSachKH_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        
    }
}