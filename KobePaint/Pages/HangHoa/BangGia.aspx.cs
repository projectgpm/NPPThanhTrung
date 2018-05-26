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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.HangHoa
{
    public partial class BangGia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
            {
                if (!IsPostBack)
                {
                    ccbBangGia.Focus();
                }
            }
            else
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
        }
        protected void ccbBangGia_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ccbBangGia.DataBind();
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "ccbBangGiaSelectChange": hiddenfile["IDBangGia"] = ccbBangGia.Value.ToString(); ChiTietBangGia(); ChiTietBangGia(); ccbBarcode.Focus(); break;
                case "import": InsertIntoGrid(); ChiTietBangGia(); break;
                case "importexcel": ChiTietBangGia(); break;
                default: break;
            }
        }

       
        protected void cbpInfo_left_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "ccbBangGiaSelectChange": hiddenfile["IDBangGia"] = ccbBangGia.Value.ToString();  ThongTinBangGia(); break;
                default: break;
            }
        }

        private void ThongTinBangGia()
        {
            int IDBangGia = Convert.ToInt32(ccbBangGia.Value.ToString());
            var BG = DBDataProvider.DB.bgBangGias.Where(x => x.IDBangGia == IDBangGia && x.DaXoa == 0).FirstOrDefault();
            if (BG != null)
            {
                memoGhiChu.Text = BG.GhiChu;
                memoPhamViApDung.Text = BG.PhamViApDung;
            }
        }
        private void ChiTietBangGia()
        {
            int IDBangGia = Convert.ToInt32(hiddenfile["IDBangGia"].ToString());
            if (IDBangGia != 1)
            {
                gridImportPro.Columns["chucnang"].Visible = true;
                dsChiTietBangGia.SelectCommand = "SELECT hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhDonViTinh.TenDonViTinh, bgChiTietBangGia.ID, " +
                                                               " bgChiTietBangGia.GiaVon, bgChiTietBangGia.DonGia, bgChiTietBangGia.GiaMoi " +
                                                               " FROM bgChiTietBangGia INNER JOIN hhHangHoa ON bgChiTietBangGia.HangHoaID = hhHangHoa.IDHangHoa " +
                                                                "INNER JOIN hhDonViTinh ON hhHangHoa.DonViTinhID = hhDonViTinh.IDDonViTinh " +
                                                               " WHERE (bgChiTietBangGia.BangGiaID = " + IDBangGia + ")";
                gridBangGia.DataBind();
            }
            else
            {
                gridImportPro.Columns["chucnang"].Visible = false;
                dsChiTietBangGia.SelectCommand = "SELECT hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhDonViTinh.TenDonViTinh, hhHangHoa.IDHangHoa AS ID, hhHangHoa.GiaVon,hhHangHoa.GiaBan as DonGia,hhHangHoa.GiaBan as GiaMoi FROM hhHangHoa INNER JOIN hhDonViTinh ON hhHangHoa.DonViTinhID = hhDonViTinh.IDDonViTinh WHERE hhHangHoa.DaXoa = 0";
                gridBangGia.DataBind();
            }
        }

        #region InsertHang done
        protected void InsertIntoGrid()
        {
            if (ccbBarcode.Text.Trim() != "")
            {
                if (ccbBarcode.Value == null)
                {
                    //barcode
                    int tbThongTin_Count = DBDataProvider.DB.hhBarcodes.Where(r => r.Barcode == ccbBarcode.Text.Trim()).Count();
                    if (tbThongTin_Count > 0)
                    {
                        var tbThongTin = DBDataProvider.DB.hhBarcodes.Where(r => r.Barcode == ccbBarcode.Text.Trim()).FirstOrDefault();
                        Insert_Hang(Convert.ToInt32(tbThongTin.IDHangHoa));
                    }
                    else
                    {
                        ccbBarcode.Value = "";
                        ccbBarcode.Text = "";
                        ccbBarcode.Focus();
                        throw new Exception("Mã hàng không tồn tại!!");
                    }
                }
                else
                {
                    // idhanghoa
                    int IDProduct;
                    bool isNumeric = Int32.TryParse(ccbBarcode.Value.ToString(), out IDProduct);
                    if (isNumeric)
                    {
                        Insert_Hang(IDProduct);
                    }
                    else
                    {
                        ccbBarcode.Value = "";
                        ccbBarcode.Text = "";
                        ccbBarcode.Focus();
                        throw new Exception("Mã hàng không tồn tại!!");
                    }
                }
            }
        }

        public void Insert_Hang(int ID)
        {
            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0 && x.LoaiHHID == 1).Count();
            if (tblHangHoa_Count > 0)
            {
                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0).FirstOrDefault();
                int IDBangGia = Convert.ToInt32(ccbBangGia.Value.ToString());
                var exitProdInList = DBDataProvider.DB.bgChiTietBangGias.Where(x => x.HangHoaID == ID && x.BangGiaID == IDBangGia).SingleOrDefault();
                if (exitProdInList == null)
                {
                    var GiaNhapCuoi = DBDataProvider.DB.kNhapKhoChiTiets.Where(x => x.HangHoaID == tblHangHoa.IDHangHoa).OrderByDescending(x => x.ID).FirstOrDefault();
                    // thêm trực tiếp vào chi tiết bảng giá
                    bgChiTietBangGia BG = new bgChiTietBangGia();
                    BG.HangHoaID = tblHangHoa.IDHangHoa;
                    BG.BangGiaID = IDBangGia;
                    BG.GiaVon = Convert.ToDouble(tblHangHoa.GiaVon);
                    BG.DonGia = GiaNhapCuoi == null ? tblHangHoa.GiaVon : GiaNhapCuoi.GiaVon;
                    BG.GiaMoi = tblHangHoa.GiaBan;
                    DBDataProvider.DB.bgChiTietBangGias.InsertOnSubmit(BG);
                    DBDataProvider.DB.SubmitChanges();
                }
                else
                {
                    LamMoi();
                    throw new Exception("Mã hàng đã tồn tại!!");
                }
                ChiTietBangGia();
                LamMoi();
            }
            else
            {
                LamMoi();
                throw new Exception("Mã hàng không tồn tại!!");
            }
        }
        private void LamMoi()
        {
            ccbBarcode.Value = "";
            ccbBarcode.Text = "";
            ccbBarcode.Focus();
        }
        #endregion 

        #region bind data hàng hóa done
        protected void ccbBarcode_ItemRequestedByValue(object source, DevExpress.Web.ListEditItemRequestedByValueEventArgs e)
        {
            long value = 0;
            if (e.Value == null || !Int64.TryParse(e.Value.ToString(), out value))
                return;
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsHangHoa.SelectCommand = @"SELECT hhHangHoa.IDHangHoa, hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhHangHoa.GiaBan,hhHangHoa.GiaVon
                                        FROM hhHangHoa
                                        WHERE (hhHangHoa.IDHangHoa = @IDHangHoa AND hhHangHoa.DaXoa = 0 AND hhHangHoa.LoaiHHID = 1)";
            dsHangHoa.SelectParameters.Clear();
            dsHangHoa.SelectParameters.Add("IDHangHoa", TypeCode.Int64, e.Value.ToString());
            comboBox.DataSource = dsHangHoa;
            comboBox.DataBind();
        }

        protected void ccbBarcode_ItemsRequestedByFilterCondition(object source, DevExpress.Web.ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsHangHoa.SelectCommand = @"SELECT [IDHangHoa], [MaHang], [TenHangHoa], [GiaBan] , [GiaVon]
                                        FROM (
	                                        select hhHangHoa.IDHangHoa, hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhHangHoa.GiaBan,hhHangHoa.GiaVon,
	                                        row_number()over(order by hhHangHoa.MaHang) as [rn] 
	                                        FROM hhHangHoa 
                                                    
	                                        WHERE ((hhHangHoa.MaHang LIKE @MaHang) OR hhHangHoa.TenHangHoa LIKE @TenHang) AND hhHangHoa.DaXoa = 0	 AND hhHangHoa.LoaiHHID = 1
	                                        ) as st 
                                        where st.[rn] between @startIndex and @endIndex";
            dsHangHoa.SelectParameters.Clear();
            dsHangHoa.SelectParameters.Add("MaHang", TypeCode.String, string.Format("%{0}%", e.Filter));
            dsHangHoa.SelectParameters.Add("TenHang", TypeCode.String, string.Format("%{0}%", e.Filter));
            dsHangHoa.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString());
            dsHangHoa.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString());
            comboBox.DataSource = dsHangHoa;
            comboBox.DataBind();
        }
        #endregion



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
            if (datatable.Columns.Contains("Mã hàng hóa") && datatable.Columns.Contains("Giá vốn") && datatable.Columns.Contains("Đơn giá nhập cuối") && datatable.Columns.Contains("Giá thiết lập"))
            {
                if (intRow != 0)
                {
                    for (int i = 0; i <= intRow - 1; i++)
                    {
                        DataRow dr = datatable.Rows[i];
                        string MaHang = dr["Mã hàng hóa"].ToString().Trim();
                        int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0).Count();
                        if (MaHang != "" && tblHangHoa_Count > 0)
                        {
                            double GiaVon = Convert.ToDouble(dr["Giá vốn"] == "" ? "0" : dr["Giá vốn"].ToString().Trim());
                            double DonGia = Convert.ToDouble(dr["Đơn giá nhập cuối"] == "" ? "0" : dr["Đơn giá nhập cuối"].ToString().Trim());
                            double GiaMoi = Convert.ToDouble(dr["Giá thiết lập"] == "" ? "0" : dr["Giá thiết lập"].ToString().Trim());
                            int IDBangGia = Convert.ToInt32(hiddenfile["IDBangGia"].ToString());
                            var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0 && x.LoaiHHID == 1).FirstOrDefault();
                            var exitProdInList = DBDataProvider.DB.bgChiTietBangGias.Where(x => x.HangHoaID == tblHangHoa.IDHangHoa && x.BangGiaID == IDBangGia).SingleOrDefault();
                            if (exitProdInList == null)
                            {
                                // insert
                                bgChiTietBangGia BG = new bgChiTietBangGia();
                                BG.HangHoaID = tblHangHoa.IDHangHoa;
                                BG.BangGiaID = IDBangGia;
                                BG.GiaVon = GiaVon;
                                BG.DonGia = DonGia;
                                BG.GiaMoi = GiaMoi;
                                DBDataProvider.DB.bgChiTietBangGias.InsertOnSubmit(BG);
                                DBDataProvider.DB.SubmitChanges();
                            }
                            else
                            {
                                // update
                                exitProdInList.GiaVon = GiaVon;
                                exitProdInList.DonGia = DonGia;
                                exitProdInList.GiaMoi = GiaMoi;
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
        #endregion

        protected void gridBangGia_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridImportPro_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridImportPro_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            LamMoi();
            ChiTietBangGia();
        }

        protected void gridImportPro_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int ID = Convert.ToInt32(e.Keys[0].ToString());
            double GiaMoi = Double.Parse(e.NewValues["GiaMoi"].ToString());
            int IDBangGia = Convert.ToInt32(ccbBangGia.Value.ToString());
            DBDataProvider.DB.spCapNhatBangGia(ID, GiaMoi, IDBangGia);
            gridImportPro.CancelEdit();
            e.Cancel = true;
            LamMoi();
            ChiTietBangGia();
            //cbpInfo.JSProperties["cp_Reset"] = true;
        }

        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exproter.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
        
    }
}