using DevExpress.Web;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.Kho
{
    public partial class CapNhat : System.Web.UI.Page
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
                case "price":
                    GetPrice();
                    break;
                case "UnitChange":
                    Unitchange(para[1]);
                    break;
                case "SaveTemp":
                    SaveTemp();
                    break;
                case "Save":
                    Save();
                    break;
                case "Review":
                    CreateReportReview();
                    break;
                default:
                    InsertIntoGrid();
                    break;
            }
        }
        #region Report

        private void CreateReportReview()
        {
           
        }
        #endregion

        protected void GetPrice()
        {
            ccbBarcode.Text = "";
            ccbBarcode.Focus();
        }
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
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mã hàng không tồn tại!!');", true);
                    }
                }
                else
                {
                    // value idhanghoa
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
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mã hàng không tồn tại!!');", true);
                    }
                }
            }
            BindGrid();
        }
        public void Insert_Hang(int ID)
        {
            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0).Count();
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
                         Convert.ToDouble(tblHangHoa.GiaBan), Convert.ToDouble(tblHangHoa.GiaBan));
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
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mã hàng không tồn tại!!');", true);
            }
        }
        protected void Reset()
        {
            listReceiptProducts = new List<oImportProduct_ChiTietNhapHang>();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();

            ccbNhaCungCap.Text = "";
            txtSoHoaDon.Text = "";
            memoGhiChu.Text = "";
            dateNgayNhap.Date = DateTime.Now;
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

        #region value datasource
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

        #region cập nhật SL + DG
        protected void spUnitReturn_Init(object sender, EventArgs e)
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
            //GV
            ASPxSpinEdit SpinEdit_GiaVon = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Giá vốn"], "spGiaVonReturn") as ASPxSpinEdit;
            double PriceProductNew = Convert.ToDouble(SpinEdit_GiaVon.Number);

            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();
            //int UnitProductOld = sourceRow.SoLuong;

            sourceRow.SoLuong = UnitProductNew;
            sourceRow.GiaVon = PriceProductNew;
            sourceRow.ThanhTien = UnitProductNew * PriceProductNew;
            BindGrid();
        }
        #endregion
        private void BindGrid()
        {
            double TongTien = 0;
            foreach (var prod in listReceiptProducts)
            {
                TongTien += prod.ThanhTien;
            }

            string[] infoUser = Context.User.Identity.Name.Split('-');
            int ID = Convert.ToInt32(infoUser[0]);
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }


        protected void SaveTemp()
        {
           
        }
    }
}