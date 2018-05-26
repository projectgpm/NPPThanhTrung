using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.Kho
{
    public partial class TonKho : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }
        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exproter.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }

        protected void gridTonKho_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridTheKho_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["IDHangHoa"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

       
    }
}