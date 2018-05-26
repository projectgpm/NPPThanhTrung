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
    public partial class NhapKho : System.Web.UI.Page
    {
        public List<oImportProduct_ChiTietNhapHang> listReceiptProducts
        {
            get
            {
                if (Session["sslistReceiptProducts"] == null)
                    Session["sslistReceiptProducts"] = new List<oImportProduct_ChiTietNhapHang>();
                return (List<oImportProduct_ChiTietNhapHang>)Session["sslistReceiptProducts"];
            }
            set
            {
                Session["sslistReceiptProducts"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
            {
                if (!IsPostBack)
                {
                    string[] infoUser = Context.User.Identity.Name.Split('-');
                    txtNguoiNhap.Text = infoUser[1];
                    listReceiptProducts = new List<oImportProduct_ChiTietNhapHang>();
                }
            }
            else
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
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
                case "SaveTemp": SaveTemp(); break;
                case "Save": Save(); BindGrid(); break;
                case "Review": CreateReportReview(); break;
                case "importexcel": BindGrid(); break;
                case "resetinfo_pro": BindGrid(); break;
                case "redirect": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/Kho/DanhSachNhapKho.aspx"); break;
                default: InsertIntoGrid(); BindGrid(); break;
            }
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "refresh": BindGrid(); break;
                case "resetinfo": Reset(); break;
                default: break;
            }
        }
        #region Report
        //private oReturnNode oReturnNodeReport
        //{
        //    get
        //    {
        //        return (oReturnNode)Session["oReturnNodeReport"];
        //    }
        //    set
        //    {
        //        Session["oReturnNodeReport"] = value;
        //    }
        //}
        //rpPhieuTraHang CreatReport()
        //{
        //    rpPhieuTraHang rp = new rpPhieuTraHang();
        //    rp.odsPhieuTraHang.DataSource = oReturnNodeReport;
        //    rp.CreateDocument();
        //    return rp;
        //}
        private void CreateReportReview()
        {
            //oReturnNode ReturnNode = new oReturnNode();
            //ReturnNode.NumReturns = "Xem trước";
            //ReturnNode.SerialReturn = "PHIẾU TRẢ HÀNG";
            //ReturnNode.strReturnDate = dateReturns.Text;
            //ReturnNode.strStorageDate = dateStorage.Text;

            //ReturnNode.ListHangTra = new List<oProduct>();

            //float Total = 0;
            //foreach (var item in ReturnDataSouce)
            //{
            //    Total += item.Total;
            //    oProduct product = ReturnNode.ListHangTra.Where(x => x.ProductID == item.ProductID && x.ColorID == item.ColorID).SingleOrDefault();
            //    if (product != null)
            //    {
            //        product.Unit += item.Unit;
            //        product.Total += item.Total;
            //    }
            //    else
            //    {
            //        ReturnNode.ListHangTra.Add(item);
            //    }
            //}
            //ReturnNode.ToTal = Total;
            //int IDCustomer = Convert.ToInt32(ccbCustomer.Value);
            //var KhachHang = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDCustomer).SingleOrDefault();
            //ReturnNode.CustomerCode = KhachHang.MaKhachHang;
            //ReturnNode.CustomerName = KhachHang.HoTen;
            //ReturnNode.CustomerPhone = KhachHang.DienThoai;
            //ReturnNode.CustomerAddress = KhachHang.DiaChi;
            //oReturnNodeReport = ReturnNode;
            //cbpProduct.JSProperties["cp_rpView"] = true;
        }
        #endregion

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
            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0 && x.LoaiHHID == 1).Count();
            if (tblHangHoa_Count > 0)
            {
                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0).FirstOrDefault();
                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.IDHangHoa == ID);
                if (exitProdInList == null)
                {
                   
                    oImportProduct_ChiTietNhapHang newRecpPro = new oImportProduct_ChiTietNhapHang(
                         tblHangHoa.IDHangHoa,
                         tblHangHoa.MaHang,
                         tblHangHoa.TenHangHoa,
                         Convert.ToDouble(tblHangHoa.GiaVon),
                         Convert.ToInt32(tblHangHoa.TonKho),
                         1, Convert.ToDouble(tblHangHoa.GiaVon),
                         Convert.ToDouble(tblHangHoa.GiaBan),
                         Convert.ToDouble(tblHangHoa.GiaBan));
                    listReceiptProducts.Add(newRecpPro);
                }
                else
                {
                    exitProdInList.SoLuong += 1;
                    exitProdInList.ThanhTien = exitProdInList.SoLuong * exitProdInList.GiaVon;
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



        protected void Reset()
        {
            listReceiptProducts = new List<oImportProduct_ChiTietNhapHang>();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
            ccbNhaCungCap.Value = "";
            ccbNhaCungCap.Text = "";
            dateNgayNhap.Date = DateTime.Now;
            spThanhToan.Number = 0;
            spTongTien.Number = 0;
            txtSoHoaDon.Text = "";
            memoGhiChu.Text = "";
            ccbBarcode.Text = "";
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

                        double ThanhToan = Convert.ToDouble(spThanhToan.Number);
                        double ConLai = TongTien - ThanhToan;

                        string MaPhieu = null, strMaPhieu = "PN";
                        //string MAX = (DBDataProvider.DB.kNhapKhos.Where(r => r.TrangThaiPhieu == 0).Count() + 1).ToString();
                        string MAX = (DBDataProvider.DB.kNhapKhos.Count() + 1).ToString();
                        for (int i = 1; i < (7 - MAX.Length); i++)
                        {
                            strMaPhieu += "0";
                        }
                        MaPhieu = strMaPhieu + MAX;

                        int IDNCC = Int32.Parse(ccbNhaCungCap.Value.ToString());
                        //Insert vào bảng nhập kho
                        kNhapKho nhapKho = new kNhapKho();
                        nhapKho.NCCID = IDNCC;
                        nhapKho.MaPhieu = MaPhieu;
                        nhapKho.SoHoaDon = txtSoHoaDon.Text; ;
                        nhapKho.NgayNhap = Formats.ConvertToDateTime(dateNgayNhap.Text);
                        nhapKho.NguoiNhapID = Formats.IDUser();
                        nhapKho.TongTien = TongTien;
                        nhapKho.TrangThaiPhieu = 0;// 1 phiếu tạm, 2 phiếu xóa, 0 phiếu nhập
                        nhapKho.TongSoLuong = TongSoLuong;
                        nhapKho.GhiChu = memoGhiChu.Text;
                        nhapKho.NgayTao = DateTime.Now;
                        nhapKho.DaXoa = 0;
                        nhapKho.ThanhToan = ThanhToan;
                        nhapKho.CongNo = ConLai;// nợ đơn hàng

                        if (ConLai == 0)
                            nhapKho.TTThanhToan = 1;
                        nhapKho.TTThanhToan = 0;
                        DBDataProvider.DB.kNhapKhos.InsertOnSubmit(nhapKho);
                        DBDataProvider.DB.SubmitChanges();
                        int IDNhap = nhapKho.IDNhapKho;
                        nhapKho.Url = "TraHang.aspx?id=" + IDNhap;
                        foreach (var prod in listReceiptProducts)
                        {
                            //Insert vào chi tiết nhập kho
                            kNhapKhoChiTiet detailNhapKho = new kNhapKhoChiTiet();
                            detailNhapKho.NhapKhoID = IDNhap;
                            detailNhapKho.HangHoaID = prod.IDHangHoa;
                            detailNhapKho.GiaVon = prod.GiaVon;
                            detailNhapKho.SoLuong = prod.SoLuong;
                            detailNhapKho.ThanhTien = prod.ThanhTien;
                            detailNhapKho.GiaBan = prod.GiaBanMoi;
                            detailNhapKho.TonKho = prod.TonKho;
                            DBDataProvider.DB.kNhapKhoChiTiets.InsertOnSubmit(detailNhapKho);
                            DBDataProvider.DB.SubmitChanges();

                            //Cập nhật || Thêm tồn kho
                            var TonKhoBanDau = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == prod.IDHangHoa).FirstOrDefault();
                            if (TonKhoBanDau != null)
                            {
                                TonKhoBanDau.TonKho += prod.SoLuong;
                                #region ghi thẻ kho
                                kTheKho thekho = new kTheKho();
                                thekho.NgayNhap = DateTime.Now;
                                thekho.DienGiai = "Nhập hàng #" + MaPhieu;
                                thekho.Nhap = prod.SoLuong;
                                thekho.Xuat = 0;
                                thekho.GiaThoiDiem = prod.GiaVon;
                                thekho.Ton = prod.SoLuong + prod.TonKho;
                                thekho.HangHoaID = TonKhoBanDau.IDHangHoa;
                                thekho.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                #endregion
                            }
                            hhHangHoa hang = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == prod.IDHangHoa).FirstOrDefault();

                            // cập nhật giá nhập trung bình cho hàng hóa

                            var GiaVonTB = DBDataProvider.DB.spAVG_IDHangHoa(Convert.ToInt32(hang.IDHangHoa)).FirstOrDefault();
                            hang.GiaVon = Convert.ToDouble(GiaVonTB.GiaNhapTrungBinh);
                            // thay đổi giá bán nếu khác giá bán cũ
                            if (prod.GiaBanMoi != prod.GiaBanCu)
                            {
                                hang.GiaBan = prod.GiaBanMoi;
                            }
                        }
                        //update công nợ
                        khKhachHang Supplier = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDNCC).FirstOrDefault();
                        if (Supplier != null)
                        {
                            #region ghi nhật ký nhập kho để xem báo cáo
                                khNhatKyCongNo nhatky = new khNhatKyCongNo();
                                nhatky.NgayNhap = DateTime.Now;
                                nhatky.DienGiai = "Nhập kho";
                                nhatky.NoDau = Supplier.CongNo;
                                nhatky.NhapHang = TongTien;
                                nhatky.TraHang = 0;
                                nhatky.NoCuoi = Supplier.CongNo + ConLai;
                                nhatky.ThanhToan = ThanhToan;
                                nhatky.NhanVienID = Formats.IDUser();
                                nhatky.GiamGia = 0;
                                nhatky.SoPhieu = MaPhieu;
                                nhatky.IDKhachHang = IDNCC;
                                DBDataProvider.DB.khNhatKyCongNos.InsertOnSubmit(nhatky);
                                DBDataProvider.DB.SubmitChanges();
                            #endregion

                            nhapKho.CongNoCu = Supplier.CongNo;
                            nhapKho.CongNoMoi = Supplier.CongNo + ConLai;
                            Supplier.TongTienHang += TongTien;
                            Supplier.CongNo += ConLai;
                            Supplier.LanCuoiMuaHang = DateTime.Now;
                        }

                        DBDataProvider.DB.SubmitChanges();
                        scope.Complete();
                        cbpInfoImport.JSProperties["cp_Reset"] = true;
                    }
                    else
                    {
                        throw new Exception("Danh sách nhập kho trống !!");
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
                                        WHERE (hhHangHoa.IDHangHoa = @IDHangHoa AND hhHangHoa.DaXoa = 0  AND hhHangHoa.LoaiHHID = 1)";
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

        #region cập nhật SL + DG 
        protected void spUnitReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        protected void spGiaBanReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        protected void spGiaVonReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }

        private void Unitchange(string para)
        {
            int IDProduct = Convert.ToInt32(para);

            //sL
            ASPxSpinEdit SpinEdit = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Số lượng"], "spUnitReturn") as ASPxSpinEdit;
            int UnitProductNew = Convert.ToInt32(SpinEdit.Number);

            //Giá vốn
            ASPxSpinEdit SpinEdit_GiaVon = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Giá vốn"], "spGiaVonReturn") as ASPxSpinEdit;
            double PriceProduct_GiaVon = Convert.ToDouble(SpinEdit_GiaVon.Number);

            //Giá bán 
            ASPxSpinEdit SpinEdit_GiaBan = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Giá bán"], "spGiaBanReturn") as ASPxSpinEdit;
            double PriceProduct_GiaBan = Convert.ToDouble(SpinEdit_GiaBan.Number);

            // cập nhật
            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();
            sourceRow.SoLuong = UnitProductNew;
            sourceRow.GiaBanMoi = PriceProduct_GiaBan;
            sourceRow.GiaVon = PriceProduct_GiaVon;
            sourceRow.ThanhTien = UnitProductNew * PriceProduct_GiaVon;
           
            //BindGrid();
        }
        #endregion

        private void BindGrid()
        {
            double TongTien = 0;
            foreach (var prod in listReceiptProducts)
            {
                TongTien += prod.ThanhTien;
            }
            spTongTien.Text = TongTien.ToString();
            //spThanhToan.Text = TongTien.ToString();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }

        

        protected void SaveTemp()
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    double TongTien = 0;
                    int TongSoLuong = 0;
                    foreach (var prod in listReceiptProducts)
                    {
                        TongTien += prod.ThanhTien;
                        TongSoLuong += prod.SoLuong;
                    }

                    string MaPhieu = null;

                    string strMaPhieu = "PT";
                    string MAX = (DBDataProvider.DB.kNhapKhos.Where(r => r.TrangThaiPhieu == 1).Count() + 1).ToString();
                    for (int i = 1; i < (6 - MAX.Length); i++)
                    {
                        strMaPhieu += "0";
                    }


                    double ThanhToan = Convert.ToDouble(spThanhToan.Number);
                    double ConLai = TongTien - ThanhToan;

                    MaPhieu = strMaPhieu + MAX;
                    int IDNCC = Int32.Parse(ccbNhaCungCap.Value.ToString());
                    //Insert vào bảng nhập kho
                    kNhapKho nhapKho = new kNhapKho();
                    nhapKho.NCCID = IDNCC;
                    nhapKho.MaPhieu = MaPhieu;
                    nhapKho.SoHoaDon = txtSoHoaDon.Text; ;
                    nhapKho.NgayNhap = Formats.ConvertToDateTime(dateNgayNhap.Text);
                    nhapKho.NguoiNhapID = Formats.IDUser();
                    nhapKho.TongTien = TongTien;
                    nhapKho.TongSoLuong = TongSoLuong;
                    nhapKho.GhiChu = memoGhiChu.Text;
                    nhapKho.ThanhToan = ThanhToan;
                    
                    nhapKho.TrangThaiPhieu = 1;// 1 phiếu tạm, 2 phiếu xóa, 0 phiếu nhập
                    DBDataProvider.DB.kNhapKhos.InsertOnSubmit(nhapKho);
                    DBDataProvider.DB.SubmitChanges();
                    int IDNhap = nhapKho.IDNhapKho;
                    nhapKho.Url = "CapNhat.aspx?id=" + IDNhap;
                    foreach (var prod in listReceiptProducts)
                    {
                        //Insert vào chi tiết nhập kho
                        kNhapKhoChiTiet detailNhapKho = new kNhapKhoChiTiet();
                        detailNhapKho.NhapKhoID = IDNhap;
                        detailNhapKho.HangHoaID = prod.IDHangHoa;
                        detailNhapKho.GiaVon = prod.GiaVon;
                        detailNhapKho.GiaBan = prod.GiaBanMoi;
                        detailNhapKho.SoLuong = prod.SoLuong;
                        detailNhapKho.ThanhTien = prod.ThanhTien;
                        detailNhapKho.TonKho = prod.TonKho;
                        DBDataProvider.DB.kNhapKhoChiTiets.InsertOnSubmit(detailNhapKho);
                    }
                    //update công nợ
                    //khKhachHang Supplier = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDNCC).FirstOrDefault();
                    //if (Supplier != null)
                    //{
                    //    nhapKho.CongNoCu = Supplier.CongNo;
                    //    nhapKho.CongNoMoi = Supplier.CongNo + ConLai;
                    //}
                    DBDataProvider.DB.SubmitChanges();
                    scope.Complete();
                    Reset();
                    cbpInfoImport.JSProperties["cp_Reset"] = true;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
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

            //gridImportPro.DataBind();
            UpdateSTT();
            //BindGrid();
            
        }
        private void Import_Temp(DataTable datatable)
        {
            int intRow = datatable.Rows.Count;
            if (datatable.Columns.Contains("Mã hàng hóa") && datatable.Columns.Contains("Số lượng") && datatable.Columns.Contains("Giá vốn") && datatable.Columns.Contains("Giá bán"))
            {
                if (intRow != 0)
                {
                    for (int i = 0; i <= intRow - 1; i++)
                    {
                        DataRow dr = datatable.Rows[i];
                        string MaHang = dr["Mã hàng hóa"].ToString().Trim();
                        if (MaHang != "")
                        {
                            double GiaVon = Convert.ToDouble(dr["Giá vốn"] == null ? "0" : dr["Giá vốn"].ToString().Trim());
                            double GiaBan = Convert.ToDouble(dr["Giá bán"] == null ? "0" : dr["Giá bán"].ToString().Trim());
                            int SoLuong = Convert.ToInt32(dr["Số lượng"] == null ? "0" : dr["Số lượng"].ToString().Trim());
                            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0).Count();
                            if (tblHangHoa_Count > 0)
                            {
                                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0 && x.LoaiHHID == 1).FirstOrDefault();
                                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.MaHang == MaHang);
                                if (exitProdInList == null)
                                {

                                    oImportProduct_ChiTietNhapHang newRecpPro = new oImportProduct_ChiTietNhapHang(
                                         tblHangHoa.IDHangHoa,
                                         tblHangHoa.MaHang,
                                         tblHangHoa.TenHangHoa,
                                         GiaVon,
                                         Convert.ToInt32(tblHangHoa.TonKho),
                                         SoLuong, GiaVon * SoLuong, GiaBan, GiaBan);
                                    listReceiptProducts.Add(newRecpPro);
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