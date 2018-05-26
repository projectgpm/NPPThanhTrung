using DevExpress.Export;
using DevExpress.XtraPrinting;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.BaoCao
{
    public partial class CongNoDLTheoNgay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }
        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControlNoValue(sender, e);
        }
        protected void grid_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exporterGrid.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
    }
}