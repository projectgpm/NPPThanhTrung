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

namespace KobePaint.Pages.BaoCao
{
    public partial class DoanhThuTheoHangHoa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exporterGrid.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
        protected void ccbKhachHang_Callback(object sender, CallbackEventArgsBase e)
        {
            ccbKhachHang.DataBind();
            ccbKhachHang.SelectedIndex = 0;
        }
        protected void gridDoanhThu_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridDoanhThu_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != GridViewRowType.Data) return;
            int TRANGTHAI = Convert.ToInt32(e.GetValue("TRANGTHAI"));
            if (TRANGTHAI == 2)
                e.Row.BackColor = System.Drawing.Color.AliceBlue;
        }
    }
}