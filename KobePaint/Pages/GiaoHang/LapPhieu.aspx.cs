using DevExpress.Web;
using DevExpress.XtraReports.UI;
using KobePaint.App_Code;
using KobePaint.Reports;
//using KobePaint.Reports;
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

namespace KobePaint.Pages.GiaoHang
{
    public partial class LapPhieu : System.Web.UI.Page
    {
        public List<oChiTietHoaDon> listReceiptProducts
        {
            get
            {
                if (Session["sslistLapPhieuGiaoHang"] == null)
                    Session["sslistLapPhieuGiaoHang"] = new List<oChiTietHoaDon>();
                return (List<oChiTietHoaDon>)Session["sslistLapPhieuGiaoHang"];
            }
            set
            {
                Session["sslistLapPhieuGiaoHang"] = value;
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
                
                listReceiptProducts = new List<oChiTietHoaDon>();
                hdfViewReport["view"] = 0;
                int Permiss = Formats.PermissionUser();
                if (Permiss == 3)
                {
                    btnExcel.Enabled = false;
                    gridImportPro.Columns["giavon"].Visible = false;
                }
            }
            if (hdfViewReport["view"].ToString() != "0")
            {
                reportViewer.Report = CreatReport();
                hdfViewReport["view"] = 0;
            }
        }

        rpPhieuGiaoHang CreatReport()
        {
            rpPhieuGiaoHang rp = new rpPhieuGiaoHang();
            rp.odsPhieuGiaoHang.DataSource = oCusExport;
            rp.CreateDocument();
            return rp;
        }
        private oReportGiaoHang oCusExport
        {
            get
            {
                return (oReportGiaoHang)Session["ocus_PriewBanHang"];
            }
            set
            {
                Session["ocus_PriewBanHang"] = value;
            }
        }
        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
        protected void cbpInfoImport_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "price": GetPrice(); break;
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "Save": Save(); DeleteListProducts(); BindGrid(); break;
                case "Review": CreateReportReview(); break;
                case "xoahang": XoaHangChange(para[1]); break;
                case "importexcel": BindGrid(); break;
                case "UnitChange_GiamGia": Unitchange_GiamGia(para[1]); BindGrid(); break;
                default: InsertIntoGrid(); BindGrid(); break;
            }
        }

       
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "refresh": LamMoi(); break;
                case "giamgia": GiamGia(); break;
                case "renew": spTienGiamGia.Number = 0; break;
                case "khachhang": CongNo();  hiddenFields["IDKhachHang"] = ccbNhaCungCap.Value.ToString(); break;
                case "khachthanhtoan": KhachThanhToan(); break;
                case "lammoi": Reset(); break;
                default: break;
            }
        }
        #region xóa hàng
        protected void btnXoaHang_Init(object sender, EventArgs e)
        {
            ASPxButton btnButton = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btnButton.NamingContainer as GridViewDataRowTemplateContainer;
            btnButton.ClientSideEvents.Click = String.Format("function(s, e) {{ onXoaHangChanged({0}); }}", container.KeyValue);
        }
        private void XoaHangChange(string para)
        {
            int STT = Convert.ToInt32(para);
            var itemToRemove = listReceiptProducts.SingleOrDefault(r => r.STT == STT);
            if (itemToRemove != null)
            {
                listReceiptProducts.Remove(itemToRemove);
                UpdateSTT();
            }
            BindGrid();
        }
        #endregion

        private void KhachThanhToan()
        {
            double ThanhToan = Convert.ToDouble(spThanhToan.Number.ToString());
            double KhachThanhToan = Convert.ToDouble(spKhachHangThoan.Number.ToString());
            spTienTraKhach.Text = (KhachThanhToan - ThanhToan).ToString();
        }

        private void GiamGia()
        {
            LamMoi();
            spTienTraKhach.Number = 0;
            if (rdHinhThuc.SelectedIndex == 0)
            {
                // giảm VNĐ
                double TienGiamGia = Convert.ToDouble(spTienGiamGia.Number.ToString());
                spGiamGia.Text = (TienGiamGia).ToString();
                spThanhToan.Text = (Convert.ToDouble(spTongTien.Number) - TienGiamGia).ToString();
                spKhachHangThoan.Text = "0";
                spTienTraKhach.Text = ((-1)*(Convert.ToDouble(spTongTien.Number) - TienGiamGia)).ToString();
                hiddenTienGiamGia["GiamGia"] = TienGiamGia.ToString();
            }
            else
            {
                //giảm %
                double PhanTram = Convert.ToDouble(spTienGiamGia.Number.ToString());
                double TongTien = Convert.ToDouble(spTongTien.Number.ToString());
                double GiamGiaTien = (TongTien * (double)(PhanTram / 100));
                spGiamGia.Text = (GiamGiaTien).ToString();
                spThanhToan.Text = (TongTien - GiamGiaTien).ToString();
                spKhachHangThoan.Text = "0";
                spTienTraKhach.Text = ((-1) * (TongTien - GiamGiaTien)).ToString();
                hiddenTienGiamGia["GiamGia"] = PhanTram.ToString();
            }
        }

        private void CreateReportReview()
        {
            hdfViewReport["view"] = 1;
            oCusExport = new oReportGiaoHang();
            var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == Convert.ToInt32(ccbNhaCungCap.Value.ToString())).FirstOrDefault();
            oCusExport.MaKhachHang = KH.MaKhachHang;
            oCusExport.TenKhachHang = KH.HoTen;
            oCusExport.DienThoai = KH.DienThoai;
            oCusExport.DiaChiGiaoHang = KH.DiaChi;
            oCusExport.TenNhanVien = Formats.NameUser();
            oCusExport.GhiChuGiaoHang = memoGhiChu.Text;
            oCusExport.NgayGiao = Formats.ConvertToVNDateString(dateNgayNhap.Text);
            oCusExport.NgayTao = Formats.ConvertToVNDateString(DateTime.Now.ToString());
            oCusExport.GiamGia = Convert.ToDouble(spGiamGia.Number);
            oCusExport.CongNoHienTai = Convert.ToDouble(KH.CongNo);
            oCusExport.SoDonHangTrongNam = ".....";
            oCusExport.TieuDePhieu = "PHIẾU BÁN HÀNG ";
            oCusExport.TrangThaiPhieu = "(Xem trước)";
            oCusExport.listProduct = new List<oProduct>();
            oCusExport.ThanhToan = Convert.ToDouble(spKhachHangThoan.Number);// khách thanh toán
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
                prod.DonGia = Convert.ToDouble(Hang.GiaBan);
                prod.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oCusExport.listProduct.Add(prod);
            }
            oCusExport.TongTien = TongTien;
            cbpInfoImport.JSProperties["cp_rpView"] = true;
        }

        #region lưu lại
        protected void Save()
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
                        string MaPhieu = null, strMaPhieu = "PX";
                        string MAX = (DBDataProvider.DB.ghPhieuGiaoHangs.Count() + 1).ToString();
                        for (int i = 1; i < (10 - MAX.Length); i++)
                        {
                            strMaPhieu += "0";
                        }
                        MaPhieu = strMaPhieu + MAX;
                        int IDkhachHang = Int32.Parse(ccbNhaCungCap.Value.ToString());
                        var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDkhachHang).FirstOrDefault();
                        ghPhieuGiaoHang giaohang = new ghPhieuGiaoHang();
                        giaohang.NgayTao = DateTime.Now;
                        giaohang.MaPhieu = MaPhieu;
                        giaohang.NhanVienID = Formats.IDUser();
                        giaohang.GhiChuGiaoHang = memoGhiChu.Text;
                        giaohang.KhachHangID = IDkhachHang;
                        giaohang.NgayGiao = Formats.ConvertToDateTime(dateNgayNhap.Text);
                        giaohang.NguoiGiao = "";
                        giaohang.DiaChiGiaoHang = KH.DiaChi;
                        giaohang.DaXoa = 0;
                        giaohang.TTThanhToan = 0; //0 chưa thanh toán. 1 đã thanh toán
                        giaohang.TrangThai = 0;// chưa duyệt, 1 đã duyệt
                        giaohang.TongSoLuong = TongSoLuong;
                        giaohang.DienThoai = KH.DienThoai;
                        giaohang.TongTien = TongTien;
                        giaohang.ThanhToan = Convert.ToDouble(spKhachHangThoan.Number);
                        giaohang.GiamGia = Convert.ToDouble(spGiamGia.Number);
                        giaohang.ConLai = (TongTien - (Convert.ToDouble(spGiamGia.Number) + Convert.ToDouble(spKhachHangThoan.Number)));
                        giaohang.STTDonHang = DBDataProvider.STTPhieuGiaoHang_DaiLy(IDkhachHang);

                        DBDataProvider.DB.ghPhieuGiaoHangs.InsertOnSubmit(giaohang);
                        DBDataProvider.DB.SubmitChanges();

                        int IDPhieuGiaoHang = giaohang.IDPhieuGiaoHang;
                        hiddenFields["IDPhieuMoi"] = IDPhieuGiaoHang;
                        foreach (var prod in listReceiptProducts)
                        {
                            // insert phiếu giao hàng chi tiết
                            ghPhieuGiaoHangChiTiet chitiet = new ghPhieuGiaoHangChiTiet();
                            chitiet.PhieuGiaoHangID = IDPhieuGiaoHang;
                            chitiet.HangHoaID = prod.IDHangHoa;
                            chitiet.TonKho = prod.TonKho;
                            chitiet.SoLuong = prod.SoLuong;
                            chitiet.GiaBan = prod.GiaBan;
                            chitiet.GiaVon = prod.GiaVon;
                            chitiet.ThanhTien = prod.ThanhTien;
                            DBDataProvider.DB.ghPhieuGiaoHangChiTiets.InsertOnSubmit(chitiet);
                            // trừ tạm tồn kho. không ghi công nợ, khi duyệt thì ghi thẻ kho + cộng công nợ khách hàng
                            var TonKhoBanDau = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == prod.IDHangHoa).FirstOrDefault();
                            if (TonKhoBanDau != null && TonKhoBanDau.LoaiHHID == 1)
                            {
                                TonKhoBanDau.TonKho -= prod.SoLuong;
                                // ghi thẻ kho
                                #region ghi thẻ kho
                                kTheKho thekho = new kTheKho();
                                thekho.NgayNhap = DateTime.Now;
                                thekho.DienGiai = "Lập phiếu giao hàng#" + MaPhieu;
                                thekho.Nhap = 0;
                                thekho.Xuat = prod.SoLuong;
                                thekho.GiaThoiDiem = prod.GiaBan;
                                thekho.Ton = prod.TonKho - prod.SoLuong;
                                thekho.HangHoaID = TonKhoBanDau.IDHangHoa;
                                thekho.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                #endregion
                            }
                        }
                        DBDataProvider.DB.SubmitChanges();
                        scope.Complete();
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
        #endregion

        protected void ccbNhaCungCap_Callback(object sender, CallbackEventArgsBase e)
        {
            ccbNhaCungCap.DataBind();
        }

        #region bind data hàng hóa
        protected void ccbBarcode_ItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {
            long value = 0;
            if (e.Value == null || !Int64.TryParse(e.Value.ToString(), out value))
                return;
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsHangHoa.SelectCommand = @"SELECT hhHangHoa.IDHangHoa, hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhHangHoa.GiaBan,hhHangHoa.GiaVon
                                        FROM hhHangHoa
                                        WHERE (hhHangHoa.IDHangHoa = @IDHangHoa AND hhHangHoa.DaXoa = 0)";
            dsHangHoa.SelectParameters.Clear();
            dsHangHoa.SelectParameters.Add("IDHangHoa", TypeCode.Int64, e.Value.ToString());
            comboBox.DataSource = dsHangHoa;
            comboBox.DataBind();
        }

        protected void ccbBarcode_ItemsRequestedByFilterCondition(object source, ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsHangHoa.SelectCommand = @"SELECT [IDHangHoa], [MaHang], [TenHangHoa], [GiaBan] , [GiaVon]
                                        FROM (
	                                        select hhHangHoa.IDHangHoa, hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhHangHoa.GiaBan,hhHangHoa.GiaVon,
	                                        row_number()over(order by hhHangHoa.MaHang) as [rn] 
	                                        FROM hhHangHoa 
                                                    
	                                        WHERE ((hhHangHoa.MaHang LIKE @MaHang) OR hhHangHoa.TenHangHoa LIKE @TenHang) AND hhHangHoa.DaXoa = 0	
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

        private void LamMoi()
        {
            double TongTien = 0;
            foreach (var prod in listReceiptProducts)
            {
                TongTien += prod.ThanhTien;
            }
            spTongTien.Text = TongTien.ToString();
            spThanhToan.Text = (TongTien - Convert.ToDouble(spGiamGia.Number)).ToString();
            spTienTraKhach.Text = ((-1) * (TongTien - Convert.ToDouble(spGiamGia.Number))).ToString();
        }

        private void BindGrid()
        {
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }

        private void DeleteListProducts()
        {
            listReceiptProducts = new List<oChiTietHoaDon>();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }

        protected void Reset()
        {
            ccbNhaCungCap.SelectedIndex = -1;
            ccbNhaCungCap.Text = "";
            spThanhToan.Number = 0;
            spTongTien.Number = 0;
            dateNgayNhap.Date = DateTime.Now;
            spGiamGia.Number = 0;
            spKhachHangThoan.Number = 0;
            spTienGiamGia.Number = 0;
            spTienGiamGia.Text = "0";
            spTienTraKhach.Number = 0;
            memoGhiChu.Text = "";
            txtNo.Text = "0";
            ccbBarcode.Text = "";
            rdHinhThuc.SelectedIndex = 0;
            txtTenBangGia.Text = "";
        }
        
        private void CongNo()
        {
          
            var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == Convert.ToInt32(ccbNhaCungCap.Value.ToString())).FirstOrDefault();
            if (KH != null)
            {
                txtNo.Text = KH.CongNo.ToString();
                txtTenBangGia.Text = KH.bgBangGia.TenBangGia + (KH.bgBangGia.DaXoa == 1 ? "(Đã xóa)" : "");
            }
        }

        protected void GetPrice()
        {
            ccbBarcode.Text = "";
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
                        throw new Exception("Mã hàng không tồn tại !!");
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
                        throw new Exception("Mã hàng không tồn tại !!");
                    }
                }
            }
        }

        public void Insert_Hang(int ID)
        {
            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0).Count();
            if (tblHangHoa_Count > 0)
            {
                int IDKhachHang = Convert.ToInt32(ccbNhaCungCap.Value.ToString());
                var IDKhachHang_IDBangGia = DBDataProvider.DB.khKhachHangs.Where(x=>x.IDKhachHang == IDKhachHang).FirstOrDefault();
                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0).FirstOrDefault();
                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.IDHangHoa == ID);
                if (exitProdInList == null)
                {
                    var GiaBan_IDKhachHang = DBDataProvider.DB.bgChiTietBangGias.Where(x=>x.BangGiaID == IDKhachHang_IDBangGia.IDBangGia && x.HangHoaID == tblHangHoa.IDHangHoa && x.bgBangGia.DaXoa == 0 ).FirstOrDefault();
                    double GiaBan = GiaBan_IDKhachHang == null ?  Convert.ToDouble(tblHangHoa.GiaBan) :  Convert.ToDouble(GiaBan_IDKhachHang.GiaMoi);
                    oChiTietHoaDon cthd = new oChiTietHoaDon(
                        tblHangHoa.IDHangHoa,
                        tblHangHoa.MaHang,
                        tblHangHoa.TenHangHoa,
                        tblHangHoa.hhDonViTinh.TenDonViTinh,
                        Convert.ToInt32(tblHangHoa.TonKho),
                        1,
                        GiaBan,
                        Convert.ToDouble(tblHangHoa.GiaVon),
                        GiaBan, 0, GiaBan
                        );
                    listReceiptProducts.Add(cthd);
                }
                else
                {
                    exitProdInList.SoLuong += 1;
                    exitProdInList.ThanhTien = exitProdInList.SoLuong * exitProdInList.GiaBan;
                }
                UpdateSTT();
            }
            else
            {
                ccbBarcode.Value = "";
                ccbBarcode.Text = "";
                ccbBarcode.Focus();
                throw new Exception("Mã hàng không tồn tại !!");
            }
        }
        #endregion

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


        #region cập nhật SL + DG
        protected void spUnitReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        protected void spGiamGiaReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged_GiamGia({0}); }}", container.KeyValue);
        }
        protected void spGiaBanReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
            int Permiss = Formats.PermissionUser();
            if (Permiss == 3)
            {
                SpinEdit.ReadOnly = true;
            }
        }
        private void Unitchange(string para)
        {
            int IDProduct = Convert.ToInt32(para);

            //sL
            ASPxSpinEdit SpinEdit = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Số lượng"], "spUnitReturn") as ASPxSpinEdit;
            int UnitProductNew = Convert.ToInt32(SpinEdit.Number);
            //Giá bán 
            ASPxSpinEdit SpinEdit_GiaBan = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Giá bán"], "spGiaBanReturn") as ASPxSpinEdit;
            double PriceProduct_GiaBan = Convert.ToDouble(SpinEdit_GiaBan.Number);

            // cập nhật
            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();

            sourceRow.GiaBan = PriceProduct_GiaBan;
            if (sourceRow.SoLuong != UnitProductNew)
                sourceRow.GiaBan = sourceRow.GiaBanCu;

            sourceRow.SoLuong = UnitProductNew;

            if (sourceRow.GiaBan != sourceRow.GiaBanCu)
                sourceRow.GiaBanCu = sourceRow.GiaBan;

            sourceRow.ThanhTien = sourceRow.SoLuong * sourceRow.GiaBan;
            sourceRow.GiamGia = 0;
        }
        private void Unitchange_GiamGia(string para)
        {
            int IDProduct = Convert.ToInt32(para);
            ASPxSpinEdit SpinEdit_GiamGia = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Giảm giá"], "spGiamGiaReturn") as ASPxSpinEdit;
            double GiamGia = Convert.ToDouble(SpinEdit_GiamGia.Number);
            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();
            double DonGiaHienTai = sourceRow.GiaBanCu;
            if (GiamGia >= 0 && GiamGia <= 100)
            {
                //giảm %
                double GiamGiaTien = (DonGiaHienTai * (double)(GiamGia / 100));
                if (GiamGia == 0)
                    sourceRow.GiaBan = DonGiaHienTai;
                else
                    sourceRow.GiaBan -= GiamGiaTien;
            }
            else
            {
                //giảm tiền
                sourceRow.GiaBan -= GiamGia;
            }
            sourceRow.GiamGia = GiamGia;
            sourceRow.ThanhTien = sourceRow.SoLuong * sourceRow.GiaBan;
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

            //UploadingUtils.RemoveFileWithDelay(uploadedFile.FileName, resFileName, 5);

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
        }
        private void Import_Temp(DataTable datatable)
        {
            int intRow = datatable.Rows.Count;
            if (datatable.Columns.Contains("Mã hàng hóa") && datatable.Columns.Contains("Số lượng") && datatable.Columns.Contains("Giá bán"))
            {
                if (intRow != 0)
                {
                    for (int i = 0; i <= intRow - 1; i++)
                    {
                        DataRow dr = datatable.Rows[i];
                        string MaHang = dr["Mã hàng hóa"].ToString().Trim();
                        if (MaHang != "")
                        {
                            double GiaBan = Convert.ToDouble(dr["Giá bán"] == null ? "0" : dr["Giá bán"].ToString().Trim());
                            int SoLuong = Convert.ToInt32(dr["Số lượng"] == null ? "0" : dr["Số lượng"].ToString().Trim());
                            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0).Count();
                            if (tblHangHoa_Count > 0)
                            {
                                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0).FirstOrDefault();
                                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.MaHang == MaHang);
                                if (exitProdInList == null)
                                {
                                    oChiTietHoaDon cthd = new oChiTietHoaDon(
                                        tblHangHoa.IDHangHoa,
                                        tblHangHoa.MaHang,
                                        tblHangHoa.TenHangHoa,
                                        tblHangHoa.hhDonViTinh.TenDonViTinh,
                                       Convert.ToInt32(tblHangHoa.TonKho),
                                        SoLuong,
                                       GiaBan,
                                       Convert.ToDouble(tblHangHoa.GiaVon),
                                       SoLuong * GiaBan, 0, GiaBan
                                        );

                                    listReceiptProducts.Add(cthd);
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

        protected void dateNgayLapPhieu_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
    }
}