using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.HangHoa
{
    public partial class CapNhat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ResetAddProductPanel();
                int Permiss = Formats.PermissionUser();
                if (Permiss == 3)
                {
                    btnSave.Enabled = false;
                    btnRenew.Enabled = false;
                    txtTenHH.Enabled = false;
                    ccbTinhTrang.Enabled = false;
                    ccbNhomHH.Enabled = false;
                    btn_ThemNhomHH.Enabled = false;
                    ccbDVT.Enabled = false;
                    btnPreview.Enabled = false;
                    spGiaVon.Visible = false;
                    spGiaBan.Enabled = false;
                    ccbLoaiHangHoa.Enabled = false;
                    tkBarcode.Enabled = false;
                }
                
            }
        }

        protected void ccbNhomHH_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ccbNhomHH.DataBind();
        }

        protected void ccbDVT_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            ccbDVT.DataBind();
        }
        protected void cbpThemHH_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "Save":
                    Save();
                    ResetAddProductPanel();
                    break;
                case "Renew": ResetAddProductPanel(); break;
            }
        }
        private void Save()
        {
            int KT = DBDataProvider.DB.hhHangHoas.Where(x => x.TenHangHoa == txtTenHH.Text).Count();
            int HangHoaID = Convert.ToInt32(Request.QueryString["id"]);
            if (HangHoaID != 0)
            {
                var hanghoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == HangHoaID).FirstOrDefault();
                hanghoa.TenHangHoa = txtTenHH.Text;
                hanghoa.NgayNhap = DateTime.Now;
                hanghoa.GiaBan = Convert.ToDouble(spGiaBan.Number);
                hanghoa.GiaVon = Convert.ToDouble(spGiaVon.Number);
                hanghoa.NhomHHID = Convert.ToInt32(ccbNhomHH.Value);
                hanghoa.DonViTinhID = Convert.ToInt32(ccbDVT.Value);
                hanghoa.DaXoa = Convert.ToInt32(ccbLoaiHangHoa.Value);
                hanghoa.LoaiHHID = Convert.ToInt32(ccbTinhTrang.Value.ToString());

                var remove_barcode = (from bc in DBDataProvider.DB.hhBarcodes
                                      where bc.IDHangHoa == HangHoaID
                                      select bc);
                DBDataProvider.DB.hhBarcodes.DeleteAllOnSubmit(remove_barcode);
                DBDataProvider.DB.SubmitChanges();


                List<string> ListBarCode = GetListBarCode();
                if (ListBarCode.Count > 0)
                {
                    foreach (string barCode in ListBarCode)
                    {
                        int KT_barcode = DBDataProvider.DB.hhBarcodes.Where(x => x.Barcode == barCode).Count();
                        if (KT_barcode == 0)
                        {
                            hhBarcode bc = new hhBarcode();
                            bc.IDHangHoa = HangHoaID;
                            bc.Barcode = barCode;
                            bc.DaXoa = false;
                            DBDataProvider.DB.hhBarcodes.InsertOnSubmit(bc);
                        }
                        //else
                        //{
                        //    throw new Exception("Barcode tồn tại đã bỏ qua!!");
                        //}
                    }
                }
                else
                {

                }
                DBDataProvider.DB.SubmitChanges();
                cbpThemHH.JSProperties["cp_Reset"] = true;
            }
            else
            {
                Response.Redirect("~/Pages/HangHoa/HangHoa.aspx");
            }
           
        }
        protected List<string> GetListBarCode()
        {
            ASPxTokenBox tkbListBarCode = tkBarcode;
            List<string> ListBarCode = new List<string>();
            foreach (string barCode in tkbListBarCode.Tokens)
            {
                ListBarCode.Add(barCode);
            }
            return ListBarCode;
        }
        private void ResetAddProductPanel()
        {
            int HangHoaID = Convert.ToInt32(Request.QueryString["id"]);
            if (HangHoaID != 0)
            {
                var hanghoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == HangHoaID).FirstOrDefault();
                txtTenHH.Text = hanghoa.TenHangHoa;
                ccbNhomHH.Value = hanghoa.NhomHHID.ToString();
                ccbDVT.Value = hanghoa.DonViTinhID.ToString();
                spGiaBan.Text = hanghoa.GiaBan.ToString();
                spGiaVon.Text = hanghoa.GiaVon.ToString();
                tkBarcode.Tokens = LoadListBarCode(HangHoaID);
                ccbLoaiHangHoa.Value = hanghoa.DaXoa.ToString();
                ccbTinhTrang.Value = hanghoa.LoaiHHID.ToString();
            }
            else
                Response.Redirect("~/Pages/HangHoa/HangHoa.aspx");
        }
        protected void gridDVT_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
        protected void btnXuatExcel_NhomHang_Click(object sender, EventArgs e)
        {
            exproter_NhomHang.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
        protected void btnXuatExcel_DVT_Click(object sender, EventArgs e)
        {
            exproter_DVT.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }

        protected void gridNhomHang_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
        protected TokenCollection LoadListBarCode(int ID)
        {
            TokenCollection listBarCode = new TokenCollection();
            if (ID != null)
            {
                List<hhBarcode> barcode = DBDataProvider.GetDanhSach(ID);
                foreach(var bc in barcode)
                {
                    listBarCode.Add(bc.Barcode);
                }
            }
            return listBarCode;
        }
    }
}