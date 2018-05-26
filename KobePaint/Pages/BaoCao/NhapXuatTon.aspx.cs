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
    public partial class NhapXuatTon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
            {
                if (!IsPostBack)
                {
                    XoaDuLieuBaoCao();
                }
            }
            else
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
        }
        private void XoaDuLieuBaoCao()
        {
            var baocao = DBDataProvider.DB.bc_NhapXuatTons.Where(x => x.NhanVienID == Formats.IDUser()).ToList();
            DBDataProvider.DB.bc_NhapXuatTons.DeleteAllOnSubmit(baocao);
            DBDataProvider.DB.SubmitChanges();
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "baocao": XemBaoCao(); break;
                default: break;
            }
        }

        private void XemBaoCao()
        {
            //insert hàng
            XoaDuLieuBaoCao();
            var HH = DBDataProvider.DB.hhHangHoas.Where(x => x.LoaiHHID == 1).ToList();
            foreach (var prod in HH)
            {
                int IDHangHoa = prod.IDHangHoa;
                DateTime TuNgay = DateTime.Parse(fromDay.Date.ToString());
                DateTime DenNgay = DateTime.Parse(toDay.Date.ToString());
                DBDataProvider.DB.pr_Insert_NhapXuatTon(IDHangHoa, Formats.IDUser(), TuNgay, DenNgay);
            }
        }
        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
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