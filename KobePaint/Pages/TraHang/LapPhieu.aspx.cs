using DevExpress.Web;
using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.TraHang
{
    public partial class LapPhieu : System.Web.UI.Page
    {
        public List<oImportProduct_TraHangNCC> listReceiptProducts
        {
            get
            {
                if (Session["sslistReceiptProducts"] == null)
                    Session["sslistReceiptProducts"] = new List<oImportProduct_TraHangNCC>();
                return (List<oImportProduct_TraHangNCC>)Session["sslistReceiptProducts"];
            }
            set
            {
                Session["sslistReceiptProducts"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                txtTenNhanVien.Text = Formats.NameUser();
                listReceiptProducts = new List<oImportProduct_TraHangNCC>();
                hdfViewReport["view"] = 0;

                if (Formats.PermissionUser() == 3)
                    gridImportPro.Columns["giavon"].Visible = false;
            }
            if (hdfViewReport["view"].ToString() != "0")
            {
                reportViewer.Report = CreatReport();
                hdfViewReport["view"] = 0;
            }
        }
        rpPhieuTraHang CreatReport()
        {
            rpPhieuTraHang rp = new rpPhieuTraHang();
            rp.odsPhieuGiaoHang.DataSource = oReturnNodeReport;
            rp.CreateDocument();
            return rp;
        }
        private oReportGiaoHang oReturnNodeReport
        {
            get
            {
                return (oReportGiaoHang)Session["oReturnNodeReportReview"];
            }
            set
            {
                Session["oReturnNodeReportReview"] = value;
            }
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "refresh": BindGrid(); break;
                case "ccbNhaCungCapChanged":
                    listReceiptProducts = new List<oImportProduct_TraHangNCC>();
                    BindGrid();
                    ListSoPhieu();
                    break;
                case "ccbSoPhieuChanged":
                    listReceiptProducts = new List<oImportProduct_TraHangNCC>();
                    ListSoPhieu();
                    int PhieuGiaoHangID = int.Parse(ccbSoPhieu.Value.ToString());
                    var ListGiaoHangChiTiet = DBDataProvider.ListChiTietGiaoHang(PhieuGiaoHangID);
                    foreach (var prod in ListGiaoHangChiTiet)
                    {
                        Insert_Hang(Convert.ToInt32(prod.HangHoaID));
                    }
                    BindGrid();
                    break;

                default: break;
            }
        }

        private void ListSoPhieu()
        {
            int IDDaiLy = int.Parse(ccbNhaCungCap.Value.ToString());
            var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDDaiLy).FirstOrDefault();
            if (KH.LoaiKhachHangID == 3)
                ckGiamCongNo.Checked = true;
            ckGiamCongNo.Checked = false;
            var ListGiaoHang = DBDataProvider.ListPhieuGiaoHang_TraHang(IDDaiLy);
            ccbSoPhieu.DataSource = ListGiaoHang;
            ccbSoPhieu.DataBind();
        }

        protected void cbpInfoImport_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "refresh": BindGrid(); break;
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "Reset": Reset(); break;
                case "Save": Save(); break;
                case "Review": CreateReportReview(); break;
                case "redirect": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/TraHang/DanhSachTraHang.aspx"); break;
                default: InsertIntoGrid(); BindGrid(); break;
            }
        }

        private void CreateReportReview()
        {
            hdfViewReport["view"] = 1;
            oReturnNodeReport = new oReportGiaoHang();
            var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == Convert.ToInt32(ccbNhaCungCap.Value.ToString())).FirstOrDefault();
            oReturnNodeReport.MaKhachHang = KH.MaKhachHang;
            oReturnNodeReport.TenKhachHang = KH.HoTen;
            oReturnNodeReport.DienThoai = KH.DienThoai;
            oReturnNodeReport.DiaChiGiaoHang = KH.DiaChi;
            oReturnNodeReport.TenNhanVien = Formats.NameUser();
            oReturnNodeReport.GhiChuGiaoHang = memoGhiChu.Text;
            oReturnNodeReport.NgayGiao = Formats.ConvertToVNDateString(dateNgayTra.Text);
            oReturnNodeReport.NgayTao = Formats.ConvertToVNDateString(DateTime.Now.ToString());
          
            oReturnNodeReport.TieuDePhieu = "PHIẾU TRẢ HÀNG (Xem trước)" ;
            oReturnNodeReport.listProduct = new List<oProduct>();
            int i = 1;
            double TongTien = 0;
            foreach (var Hang in listReceiptProducts)
            {
                TongTien += Hang.ThanhTien;
                oProduct prod = new oProduct();
                prod.STT = i++;
                prod.MaHang = Hang.MaHang;
                prod.TenHang = Hang.TenHangHoa;
                prod.TenDonViTinh = Hang.TenDonViTinh;
                prod.SoLuong = Convert.ToInt32(Hang.SoLuong);
                prod.DonGia = Convert.ToDouble(Hang.TienTra);
                prod.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oReturnNodeReport.listProduct.Add(prod);
            }
            oReturnNodeReport.TongTien = TongTien;
            cbpInfoImport.JSProperties["cp_rpView"] = true;
        }

        private void Save()
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    if (listReceiptProducts.Count > 0)
                    {
                        double TongTien = 0;
                        int TongSoLuong = 0;
                        foreach (var prod in listReceiptProducts)
                        {
                            TongTien += prod.ThanhTien;
                            TongSoLuong += prod.SoLuong;
                        }

                        string MaPhieu = null, strMaPhieu = "PN";
                        string MAX = (DBDataProvider.DB.kPhieuTraHangs.Count() + 1).ToString();
                        for (int i = 1; i < (7 - MAX.Length); i++)
                        {
                            strMaPhieu += "0";
                        }
                        MaPhieu = strMaPhieu + MAX;
                        int IDDaiLy = Int32.Parse(ccbNhaCungCap.Value.ToString());
                        int IDSoPhieu = 0;
                        if (ccbSoPhieu.Text != "")
                            IDSoPhieu = Int32.Parse(ccbSoPhieu.Value.ToString());

                        // insert kPhieuTraHang
                        kPhieuTraHang phieutra = new kPhieuTraHang();
                        phieutra.MaPhieu = MaPhieu;
                        phieutra.DaiLyID = IDDaiLy;
                        phieutra.SoPhieuTra = IDSoPhieu;
                        phieutra.NgayTra = Convert.ToDateTime(dateNgayTra.Date);
                        phieutra.NgayNhap = DateTime.Now;
                        phieutra.NhanVienID = Formats.IDUser();
                        phieutra.GhiChu = memoGhiChu.Text;
                        phieutra.TongSoLuong = TongSoLuong;
                        phieutra.TongTienHang = TongTien;
                        phieutra.ThanhToan = ckGiamCongNo.Checked == true ? 0 : TongTien;
                        phieutra.DuyetDonHang = 0; // 0 chưa duyệt , 1 đã duyệt
                        phieutra.ConLai = ckGiamCongNo.Checked == true ? TongTien : 0;
                        phieutra.HinhThucTT = ckGiamCongNo.Checked == true ? 1 : 0;
                        DBDataProvider.DB.kPhieuTraHangs.InsertOnSubmit(phieutra);
                        DBDataProvider.DB.SubmitChanges();
                        int IDPhieuTraHang = phieutra.IDPhieuTraHang;
                        foreach (var prod in listReceiptProducts)
                        {
                            // insert Chi tiet
                            kPhieuTraHangChiTiet chitiet = new kPhieuTraHangChiTiet();
                            chitiet.PhieuTraHangNCCID = IDPhieuTraHang;
                            chitiet.HangHoaID = prod.IDHangHoa;
                            chitiet.GiaVon = prod.GiaVon;
                            chitiet.SoLuong = prod.SoLuong;
                            chitiet.ThanhTien = prod.ThanhTien;
                            chitiet.TonKho = prod.TonKho;
                            chitiet.TienTra = prod.TienTra;
                            DBDataProvider.DB.kPhieuTraHangChiTiets.InsertOnSubmit(chitiet);
                        }
                        //update công nợ
                        khKhachHang Supplier = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDDaiLy).FirstOrDefault();
                        if (Supplier != null)
                        {
                            phieutra.CongNoCu = Supplier.CongNo;
                        }

                        DBDataProvider.DB.SubmitChanges();
                        scope.Complete();
                        Reset();
                        cbpInfoImport.JSProperties["cp_Reset"] = true;
                    }
                    else
                    {
                        throw new Exception("Danh sách hàng hóa trống !!");
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
                        throw new Exception("Mã hàng khồn tồn tại!!");
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
                        throw new Exception("Mã hàng khồn tồn tại!!");
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
                int SoLuong = Convert.ToInt32(spSoLuong.Number);
                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.IDHangHoa == ID);
                if (exitProdInList == null)
                {
                    // kiểm tra lấy bảng giá chưa

                    oImportProduct_TraHangNCC newRecpPro = new oImportProduct_TraHangNCC(
                         tblHangHoa.IDHangHoa,
                         tblHangHoa.MaHang,
                         tblHangHoa.TenHangHoa,
                         Convert.ToDouble(tblHangHoa.GiaVon),
                         Convert.ToInt32(tblHangHoa.TonKho),
                         SoLuong, SoLuong * Convert.ToDouble(tblHangHoa.GiaBan), Convert.ToDouble(tblHangHoa.GiaBan),
                         tblHangHoa.hhDonViTinh.TenDonViTinh
                         );
                    listReceiptProducts.Add(newRecpPro);
                }
                else
                {
                    exitProdInList.SoLuong += SoLuong;
                    exitProdInList.ThanhTien = exitProdInList.SoLuong * exitProdInList.TienTra;
                }
                UpdateSTT();
            }
            else
            {
                ccbBarcode.Value = "";
                ccbBarcode.Text = "";
                ccbBarcode.Focus();
                spSoLuong.Number = 1;
                throw new Exception("Mã hàng không tồn tại !!");
            }
        }
        #endregion
        protected void UpdateSTT()
        {
            ccbBarcode.Value = "";
            ccbBarcode.Text = "";
            ccbBarcode.Focus();
            spSoLuong.Number = 1;
            for (int i = 1; i <= listReceiptProducts.Count; i++)
            {
                listReceiptProducts[i - 1].STT = i;
            }

        }
        private void BindGrid()
        {
            gridImportPro.DataSource = null;
            gridImportPro.DataBind();
            gridImportPro.DataSource = listReceiptProducts;
         
            gridImportPro.DataBind();
        }


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

        #region bind hàng hóa
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
                                                    
	                                        WHERE ((hhHangHoa.MaHang LIKE @MaHang) OR hhHangHoa.TenHangHoa LIKE @TenHang) AND hhHangHoa.DaXoa = 0 AND hhHangHoa.LoaiHHID = 1
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

        protected void Reset()
        {
            listReceiptProducts = new List<oImportProduct_TraHangNCC>();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
            ccbNhaCungCap.SelectedIndex = -1;
            ccbNhaCungCap.Text = "";
            ckGiamCongNo.Checked = false;
            memoGhiChu.Text = "";

            dateNgayTra.Date = DateTime.Now;
            ccbBarcode.Text = "";
        }

        protected void dateNgayTra_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }

        #region Cập nhật SL + Tiền trả
        protected void spSoLuongReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        protected void spTienTraReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        private void Unitchange(string para)
        {
            int IDProduct = Convert.ToInt32(para);

            //sL
            ASPxSpinEdit SpinEdit = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Số lượng"], "spSoLuongReturn") as ASPxSpinEdit;
            int SLMoi = Convert.ToInt32(SpinEdit.Number);

            //Giá vốn
            ASPxSpinEdit SpinEdit_TienTra = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Tiền trả"], "spTienTraReturn") as ASPxSpinEdit;
            double TienTraMoi = Convert.ToDouble(SpinEdit_TienTra.Number);

            // cập nhật
            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();
            sourceRow.SoLuong = SLMoi;
            sourceRow.TienTra = TienTraMoi;
            sourceRow.ThanhTien = SLMoi * TienTraMoi;
        }
        #endregion

        protected void dateNgayLap_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
    }
}