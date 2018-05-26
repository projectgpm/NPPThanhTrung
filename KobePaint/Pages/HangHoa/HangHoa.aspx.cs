using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.HangHoa
{
    public partial class HangHoa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                int Permiss = Formats.PermissionUser();
                if (Permiss == 3)
                {
                    btnThemHangHoa.Enabled = false;
                    btnNhapExcel.Enabled = false;
                    gridHangHoa.Columns["chucnang"].Visible = false;
                }

            }
        }

        protected void grid_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridApGia_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["IDHangHoa"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void gridApGia_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
        {
            //int IDDaiLy = Convert.ToInt32(e.NewValues["LoaiKhachHangID"]);
            //int IDHangHoa = Convert.ToInt32(Session["IDHangHoa"]);
            //var DaApGia = DBDataProvider.DB.hhApGias.Where(x => x.LoaiKhachHangID == IDDaiLy && x.HangHoaID == IDHangHoa).Any();
            //if (DaApGia)
            //{
            //    e.RowError = "Đại lý nãy đã được áp giá";
            //}
        }

        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exproter.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }

        #region nhập excel
        public string strFileExcel { get; set; }
        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string folder = null;
            string filein = null;
            string ThangNam = null;

            ThangNam = string.Concat(System.DateTime.Now.Month.ToString(), System.DateTime.Now.Year.ToString());
            if (!Directory.Exists(Server.MapPath("~/Uploads/") + ThangNam))
            {
                Directory.CreateDirectory(Server.MapPath("~/Uploads/") + ThangNam);
            }
            folder = Server.MapPath("~/Uploads/" + ThangNam + "/");

            if (UploadControl.HasFile)
            {
                strFileExcel = Guid.NewGuid().ToString();
                string theExtension = Path.GetExtension(UploadControl.FileName);
                strFileExcel += theExtension;
                filein = folder + strFileExcel;
                e.UploadedFile.SaveAs(filein);
                strFileExcel = ThangNam + "/" + strFileExcel;

            }

            string Excel = Server.MapPath("~/Uploads/") + strFileExcel;
            string excelConnectionString = string.Empty;
            excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Excel + ";Extended Properties=Excel 8.0;";
            OleDbConnection excelConnection = new OleDbConnection(excelConnectionString);
            OleDbCommand cmd = new OleDbCommand("Select * from [Sheet1$]", excelConnection);
            excelConnection.Open();
            OleDbDataReader dReader = default(OleDbDataReader);
            dReader = cmd.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(dReader);
            int r = dataTable.Rows.Count;
            Import_Temp(dataTable);
        }
        private void Import_Temp(DataTable datatable)
        {
            int intRow = datatable.Rows.Count;
            if (datatable.Columns.Contains("Mã hàng hóa")
                && datatable.Columns.Contains("Tên hàng hóa")
                && datatable.Columns.Contains("Nhóm hàng")
                && datatable.Columns.Contains("Đơn vị tính")
                && datatable.Columns.Contains("Loại hàng hóa")
                && datatable.Columns.Contains("Giá vốn")
                && datatable.Columns.Contains("Giá bán")
                && datatable.Columns.Contains("Tồn kho hiện tại")
                && datatable.Columns.Contains("Barcode"))
            {
                if (intRow != 0)
                {
                    for (int i = 0; i <= intRow - 1; i++)
                    {
                        DataRow dr = datatable.Rows[i];
                        string TenHangHoa = dr["Tên hàng hóa"].ToString().Trim();
                        string DonViTinh = dr["Đơn vị tính"].ToString().Trim();
                        string NhomHang = dr["Nhóm hàng"].ToString().Trim();
                        if (TenHangHoa != "" && DonViTinh != "" && NhomHang !="")
                        {
                            string MaHang = null;
                            if (dr["Mã hàng hóa"].ToString() == "")
                            {
                                string strMaHang = "SP";
                                string MAX = (DBDataProvider.DB.hhHangHoas.Count() + 1).ToString();
                                for (int j = 1; j < (6 - MAX.Length); j++)
                                {
                                    strMaHang += "0";
                                }
                                MaHang = strMaHang + MAX;
                            }
                            else
                            {
                                MaHang = dr["Mã hàng hóa"].ToString();
                            }
                            double GiaVon = Convert.ToDouble(dr["Giá vốn"].ToString() == "" ? "0" : dr["Giá vốn"].ToString().Trim());
                            double GiaBan = Convert.ToDouble(dr["Giá bán"].ToString() == "" ? "0" : dr["Giá bán"].ToString().Trim());
                            int TonKho = Convert.ToInt32(dr["Tồn kho hiện tại"].ToString() == "" ? "0" : dr["Tồn kho hiện tại"].ToString().Trim());
                            string LoaiHangHoa = dr["Loại hàng hóa"].ToString() == "" ? "Hàng hóa cơ bản" : dr["Loại hàng hóa"].ToString();
                            string Barcode = dr["Barcode"].ToString() == "" ? MaHang : dr["Barcode"].ToString();

                            
                            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0).Count();
                            int KT_Barcode = DBDataProvider.DB.hhBarcodes.Where(x => x.Barcode == Barcode && x.DaXoa == false).Count();
                            if (tblHangHoa_Count == 0 && KT_Barcode == 0)
                            {
                                //thêm mới hàng hóa
                                hhHangHoa hanghoa = new hhHangHoa();
                                hanghoa.TenHangHoa = TenHangHoa;
                                hanghoa.MaHang = MaHang;
                                hanghoa.TrongLuong = 0;
                                hanghoa.NgayNhap = DateTime.Now;
                                hanghoa.LoaiHHID = KT_LoaiHangHoa(LoaiHangHoa);
                                hanghoa.NhomHHID = KT_NhomHang(NhomHang);
                                hanghoa.DonViTinhID = KT_DonViTinh(DonViTinh);
                                hanghoa.GiaBan = GiaBan;
                                hanghoa.GiaVon = GiaVon;
                                hanghoa.TonKho = TonKho;
                                hanghoa.DaXoa = 0;
                                DBDataProvider.DB.hhHangHoas.InsertOnSubmit(hanghoa);
                                DBDataProvider.DB.SubmitChanges();
                                int IDHangHoa = hanghoa.IDHangHoa;
                                if (TonKho > 0)
                                {
                                    // ghi thẻ kho
                                    #region Trường hợp số lượng > 0 thì tiến hành ghi thẻ kho
                                    kTheKho thekho = new kTheKho();
                                    thekho.NgayNhap = DateTime.Now;
                                    thekho.DienGiai = "Khai báo hàng hóa";
                                    thekho.Nhap = TonKho;
                                    thekho.Xuat = 0;
                                    thekho.Ton = TonKho;
                                    thekho.GiaThoiDiem = GiaVon;
                                    thekho.NhanVienID = Formats.IDUser();
                                    thekho.HangHoaID = IDHangHoa;
                                    DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                    #endregion
                                }
                                // insert barcode
                                hhBarcode bc = new hhBarcode();
                                bc.IDHangHoa = IDHangHoa;
                                bc.Barcode = Barcode;
                                bc.DaXoa = false;
                                DBDataProvider.DB.hhBarcodes.InsertOnSubmit(bc);
                                DBDataProvider.DB.SubmitChanges();
                            }

                        }
                    }

                }
            }
            else
            {
                throw new Exception("File excel không đúng. Vui lòng kiểm tra lại!!");
            }
        }

        private int KT_DonViTinh(string TenDonViTinh)
        {

            var DVT = DBDataProvider.DB.hhDonViTinhs.Where(x => x.TenDonViTinh.ToUpper() == TenDonViTinh.ToUpper()).FirstOrDefault();
            if (DVT != null)
                return DVT.IDDonViTinh;
            else
            {
                // thêm mới
                hhDonViTinh dv = new hhDonViTinh();
                dv.TenDonViTinh = TenDonViTinh;
                dv.NgayNhap = DateTime.Now;
                dv.DaXoa = false;
                DBDataProvider.DB.hhDonViTinhs.InsertOnSubmit(dv);
                DBDataProvider.DB.SubmitChanges();
                return dv.IDDonViTinh;
            }
        }
        private int KT_LoaiHangHoa(string LoaiHangHoa)
        {
            // done chạy ok
            var LoaiHang = DBDataProvider.DB.hhLoaiHangHoas.Where(x => x.TenLoai == LoaiHangHoa).FirstOrDefault();
            if (LoaiHang != null)
                return LoaiHang.IDLoaiHangHoa;
            else
                return 1;
        }
        private int KT_NhomHang(string TenNhomHang)
        {

            var NhomHang = DBDataProvider.DB.hhNhomHangs.Where(x => x.TenNhom.ToUpper() == TenNhomHang.ToUpper()).FirstOrDefault();
            if (NhomHang != null)
                return NhomHang.IDNhomHH;
            else
            {
                // thêm nhóm hàng mới
                hhNhomHang hang = new hhNhomHang();
                hang.TenNhom = TenNhomHang;
                hang.DaXoa = false;
                DBDataProvider.DB.hhNhomHangs.InsertOnSubmit(hang);
                DBDataProvider.DB.SubmitChanges();
                return hang.IDNhomHH;
                //return 1;
            }
        }
        
        #endregion

       
       
    }
}