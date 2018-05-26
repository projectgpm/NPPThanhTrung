using DevExpress.Web;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.Kho
{
    public partial class ThemKiemKho : System.Web.UI.Page
    {
        public List<oImportProduct_ChiTietKiemKe> listReceiptProducts
        {
            get
            {
                if (Session["sslistKiemKe"] == null)
                    Session["sslistKiemKe"] = new List<oImportProduct_ChiTietKiemKe>();
                return (List<oImportProduct_ChiTietKiemKe>)Session["sslistKiemKe"];
            }
            set
            {
                Session["sslistKiemKe"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
            {
                if (!IsPostBack)
                {
                    ccbBarcode.Focus();
                    string[] infoUser = Context.User.Identity.Name.Split('-');
                    txtNguoiNhap.Text = infoUser[1];
                    listReceiptProducts = new List<oImportProduct_ChiTietKiemKe>();
                }
            }
            else
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
        }

        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "Save": Save(); Reset(); break;
                case "importexcel": BindGrid(); break;
                case "redirect": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/Kho/DanhSachKiemKho.aspx"); break;
                default: InsertIntoGrid(); BindGrid(); break;
            }
        }
        protected void Save()
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    if (listReceiptProducts.Count > 0)
                    {
                        int ChenhLech = 0;
                        foreach (var prod in listReceiptProducts)
                        {
                            ChenhLech += prod.ChenhLech;
                        }

                        string MaPhieu = null, strMaPhieu = "KK";
                        string MAX = (DBDataProvider.DB.kKiemKes.Count() + 1).ToString();
                        for (int i = 1; i < (7 - MAX.Length); i++)
                        {
                            strMaPhieu += "0";
                        }
                        MaPhieu = strMaPhieu + MAX;


                        //Insert vào bảng kiểm kê
                        kKiemKe kk = new kKiemKe();
                        kk.MaPhieu = MaPhieu;
                        kk.IDNhanVien = Formats.IDUser();
                        kk.NgayLap = Formats.ConvertToDateTime(dateNgayNhap.Text);
                        kk.GhiChu = memoGhiChu.Text;
                        kk.DaXoa = 0;
                        kk.NgayTao = DateTime.Now;
                        kk.ChenhLech = ChenhLech;
                        //kk.TrangThai = 0;
                        DBDataProvider.DB.kKiemKes.InsertOnSubmit(kk);
                        DBDataProvider.DB.SubmitChanges();

                        int IDPhieuKiemKe = kk.IDPhieuKiemKe;

                        foreach (var prod in listReceiptProducts)
                        {
                            //Insert vào chi tiết kiểm kê
                            kKiemKeChiTiet chitiet = new kKiemKeChiTiet();
                            chitiet.PhieuKiemKeID = IDPhieuKiemKe;
                            chitiet.HangHoaID = prod.IDHangHoa;
                            chitiet.TonKhoHeThong = prod.TonKhoHeThong;
                            chitiet.TonKhoThucTe = prod.TonKhoThucTe;
                            chitiet.ChenhLech = prod.ChenhLech;
                            chitiet.DienGiai = prod.DienGiai;
                            DBDataProvider.DB.kKiemKeChiTiets.InsertOnSubmit(chitiet);

                            //Ghi thẻ kho || Cập nhật tồn kho = thực tế
                            var TonKhoBanDau = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == prod.IDHangHoa).FirstOrDefault();
                            if (TonKhoBanDau != null)
                            {
                                TonKhoBanDau.TonKho = prod.TonKhoThucTe;
                                #region ghi thẻ kho
                                kTheKho thekho = new kTheKho();
                                thekho.NgayNhap = DateTime.Now;
                                thekho.DienGiai = "Kiểm kho #" + MaPhieu;
                                if (prod.ChenhLech > 0)
                                {
                                    thekho.Nhap = prod.ChenhLech;
                                    thekho.Xuat = 0;
                                }
                                else
                                {
                                    thekho.Nhap = 0;
                                    thekho.Xuat = (-1)*prod.ChenhLech;
                                }
                                thekho.Ton = prod.TonKhoThucTe;
                                thekho.GiaThoiDiem = 0;
                                thekho.HangHoaID = TonKhoBanDau.IDHangHoa;
                                thekho.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                #endregion
                            }
                        }
                        DBDataProvider.DB.SubmitChanges();
                        scope.Complete();
                        Reset();
                        cbpInfo.JSProperties["cp_Reset"] = true;
                    }
                    else
                    {
                        throw new Exception("Danh sách kiểm kê trống !!");
                        ccbBarcode.Text = "";
                        ccbBarcode.Value = "";
                        ccbBarcode.Focus();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        protected void Reset()
        {
            listReceiptProducts = new List<oImportProduct_ChiTietKiemKe>();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
            memoGhiChu.Text = "";
            dateNgayNhap.Date = DateTime.Now;
            ccbBarcode.Text = "";
            ccbBarcode.Value = "";
            ccbBarcode.Focus();
        }
        #region InsertHang
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
                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.IDHangHoa == ID);
                if (exitProdInList == null)
                {
                    oImportProduct_ChiTietKiemKe newKiemKe = new oImportProduct_ChiTietKiemKe(
                            tblHangHoa.IDHangHoa,
                            tblHangHoa.MaHang,
                            tblHangHoa.TenHangHoa,
                             Convert.ToInt32(tblHangHoa.TonKho),
                            0,
                            - Convert.ToInt32(tblHangHoa.TonKho),
                            0,
                            ""
                        );
                    listReceiptProducts.Add(newKiemKe);
                }
                else
                {
                    exitProdInList.TonKhoThucTe += 1;
                    exitProdInList.ChenhLech = exitProdInList.TonKhoThucTe - exitProdInList.TonKhoHeThong;
                }
                UpdateSTT();
            }
            else
            {
                ccbBarcode.Value = "";
                ccbBarcode.Text = "";
                ccbBarcode.Focus();
                throw new Exception("Mã hàng không tồn tại!!");
            }
        }
        #endregion

        #region bind data hàng hóa
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

        protected void gridImportPro_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int stt = int.Parse(e.Keys["STT"].ToString());
            var itemToRemove = listReceiptProducts.SingleOrDefault(r => r.STT == stt);
            if (itemToRemove != null)
            {
                listReceiptProducts.Remove(itemToRemove);
                UpdateSTT();
            }
            e.Cancel = true;
            BindGrid();
        }
        private void BindGrid()
        {
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }
        protected void UpdateSTT()
        {
            ccbBarcode.Value = "";
            ccbBarcode.Text = "";
            ccbBarcode.Focus();
            for (int i = 1; i <= listReceiptProducts.Count; i++)
            {
                listReceiptProducts[i - 1].STT = i;
            }
        }

        #region  Cập nhật
        protected void spUnitReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        protected void memoDienGiai_Init(object sender, EventArgs e)
        {
            ASPxMemo memoEdit = sender as ASPxMemo;
            GridViewDataRowTemplateContainer container = memoEdit.NamingContainer as GridViewDataRowTemplateContainer;
            memoEdit.ClientSideEvents.TextChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }

        private void Unitchange(string para)
        {
            int IDProduct = Convert.ToInt32(para);
            //sL
            ASPxSpinEdit SpinEdit = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Số lượng"], "spUnitReturn") as ASPxSpinEdit;
            int TonKhoThucTeNew = Convert.ToInt32(SpinEdit.Number);

            // nguyên nhân kiểm kho
            ASPxMemo DienGiai = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Diễn giải"], "memoDienGiai") as ASPxMemo;
            string memoDienGiai = DienGiai.Text;

            // cập nhật
            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();
            sourceRow.TonKhoThucTe = TonKhoThucTeNew;
            sourceRow.ChenhLech = sourceRow.TonKhoThucTe - sourceRow.TonKhoHeThong;
            sourceRow.DienGiai = memoDienGiai;
            sourceRow.TrangThai = 1;
        }

        #endregion

        #region upload file
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
            UpdateSTT();

            //string url = folder + strFileExcel;
            //File.Delete(url);
        }

        public string strFileExcel { get; set; }
        private void Import_Temp(DataTable datatable)
        {
            int intRow = datatable.Rows.Count;
            if (datatable.Columns.Contains("Mã hàng hóa") && datatable.Columns.Contains("Tồn thực tế") && datatable.Columns.Contains("Lý do kiểm kê"))
            {
                if (intRow != 0)
                {
                    for (int i = 0; i <= intRow - 1; i++)
                    {
                        DataRow dr = datatable.Rows[i];
                        string MaHang = dr["Mã hàng hóa"].ToString().Trim();
                        if (MaHang != "")
                        {
                            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0).Count();
                            if (tblHangHoa_Count > 0)
                            {
                                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0 && x.LoaiHHID == 1).FirstOrDefault();
                                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.MaHang == MaHang);
                                if (exitProdInList == null)
                                {
                                    int TonKhoThucTe = Convert.ToInt32(dr["Tồn thực tế"] == "" ? "0" : dr["Tồn thực tế"].ToString().Trim());

                                    string DienGiai = dr["Lý do kiểm kê"] == "" ? "" : dr["Lý do kiểm kê"].ToString();
                                    oImportProduct_ChiTietKiemKe newKiemKe = new oImportProduct_ChiTietKiemKe(
                                           tblHangHoa.IDHangHoa,
                                           tblHangHoa.MaHang,
                                           tblHangHoa.TenHangHoa,
                                            Convert.ToInt32(tblHangHoa.TonKho),
                                           TonKhoThucTe,
                                            TonKhoThucTe - Convert.ToInt32(tblHangHoa.TonKho),
                                           1,
                                           DienGiai
                                       );
                                    listReceiptProducts.Add(newKiemKe);
                                }

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
    }
}