using DevExpress.Web;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.HeThong
{
    public partial class ThongTinCuaHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                BindData();
            }
        }
        public void BindData()
        {
            dsChiNhanh.SelectParameters["IDChiNhanh"].DefaultValue = Formats.IDChiNhanh().ToString();
            var chinhanh = DBDataProvider.DB.chChiNhanhs.Where(x => x.IDChiNhanh == Formats.IDChiNhanh()).FirstOrDefault();
            BinaryImage.EmptyImage.Url = chinhanh.Logo;
            formLayout.DataBind();
        }
        protected void btOK_Click(object sender, EventArgs e)
        {
            

            var _chinhanh = DBDataProvider.DB.chChiNhanhs.Where(n => n.IDChiNhanh == Formats.IDChiNhanh()).SingleOrDefault();
            if (_chinhanh != null)
            {
                _chinhanh.TenChiNhanh = txtTenChiNhanh.Text;
                _chinhanh.DienThoai = txtDienThoai.Text;
                _chinhanh.DiaChi = txtDiaChi.Text;
                _chinhanh.MST = txtMST.Text;
                _chinhanh.QuyThuChi = Convert.ToDouble(spQuyThuChu.Number);
                _chinhanh.TinhThanh = txtTinhThanh.Text;
               
            }
            string folder = "";
            string folder1 = "";
            if (Page.IsValid && uploadfile.HasFile)
            {
                folder1 = "~/Content/Images/" + DateTime.Now.ToString("hhmm_tt_") + uploadfile.FileName;
                folder = MapPath(folder1);
                uploadfile.SaveAs(folder);
                _chinhanh.Logo = folder1;
            }
           
            DBDataProvider.DB.SubmitChanges();
            BindData();
        }

       
    }
}