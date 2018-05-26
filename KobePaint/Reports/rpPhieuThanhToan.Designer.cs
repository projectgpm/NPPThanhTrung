namespace KobePaint.Reports
{
    partial class rpPhieuThanhToan
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            DevExpress.DataAccess.Sql.CustomSqlQuery customSqlQuery1 = new DevExpress.DataAccess.Sql.CustomSqlQuery();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(rpPhieuThanhToan));
            this.xrLabel14 = new DevExpress.XtraReports.UI.XRLabel();
            this.DataThongTin = new DevExpress.DataAccess.Sql.SqlDataSource(this.components);
            this.xrLabel18 = new DevExpress.XtraReports.UI.XRLabel();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.xrLabel23 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel22 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel21 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel20 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel19 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel17 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel16 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel13 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel12 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel11 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel10 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel9 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel8 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel7 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel6 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
            this.lblTenPhieu = new DevExpress.XtraReports.UI.XRLabel();
            this.lblMaKh = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.reportHeaderBand1 = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.imgLogo = new DevExpress.XtraReports.UI.XRPictureBox();
            this.lblTenCTy = new DevExpress.XtraReports.UI.XRLabel();
            this.lblDiaChi = new DevExpress.XtraReports.UI.XRLabel();
            this.lblDienThoai = new DevExpress.XtraReports.UI.XRLabel();
            this.DataField = new DevExpress.XtraReports.UI.XRControlStyle();
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
            this.FieldCaption = new DevExpress.XtraReports.UI.XRControlStyle();
            this.Title = new DevExpress.XtraReports.UI.XRControlStyle();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.odsPayNode = new DevExpress.DataAccess.ObjectBinding.ObjectDataSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.odsPayNode)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // xrLabel14
            // 
            this.xrLabel14.Dpi = 100F;
            this.xrLabel14.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel14.LocationFloat = new DevExpress.Utils.PointFloat(395.8333F, 279.1667F);
            this.xrLabel14.Name = "xrLabel14";
            this.xrLabel14.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel14.SizeF = new System.Drawing.SizeF(141.6667F, 23F);
            this.xrLabel14.StylePriority.UseFont = false;
            this.xrLabel14.Text = "Người thu tiền";
            // 
            // DataThongTin
            // 
            this.DataThongTin.ConnectionName = "KobePaintConnectionString";
            this.DataThongTin.Name = "DataThongTin";
            customSqlQuery1.Name = "ThongTinCongTy";
            customSqlQuery1.Sql = resources.GetString("customSqlQuery1.Sql");
            this.DataThongTin.Queries.AddRange(new DevExpress.DataAccess.Sql.SqlQuery[] {
            customSqlQuery1});
            this.DataThongTin.ResultSchemaSerializable = resources.GetString("DataThongTin.ResultSchemaSerializable");
            // 
            // xrLabel18
            // 
            this.xrLabel18.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "SoTienThu")});
            this.xrLabel18.Dpi = 100F;
            this.xrLabel18.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel18.LocationFloat = new DevExpress.Utils.PointFloat(140.1602F, 115.8333F);
            this.xrLabel18.Name = "xrLabel18";
            this.xrLabel18.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel18.SizeF = new System.Drawing.SizeF(446.5705F, 23F);
            this.xrLabel18.StylePriority.UseFont = false;
            this.xrLabel18.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.xrLabel18_BeforePrint);
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel23,
            this.xrLabel22,
            this.xrLabel21,
            this.xrLabel20,
            this.xrLabel19,
            this.xrLabel18,
            this.xrLabel17,
            this.xrLabel16,
            this.xrLabel3,
            this.xrLabel2,
            this.xrLabel14,
            this.xrLabel13,
            this.xrLabel12,
            this.xrLabel11,
            this.xrLabel10,
            this.xrLabel9,
            this.xrLabel8,
            this.xrLabel7,
            this.xrLabel6,
            this.xrLabel5,
            this.xrLabel4,
            this.lblTenPhieu,
            this.lblMaKh,
            this.xrLabel1});
            this.Detail.Dpi = 100F;
            this.Detail.HeightF = 384.4583F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.StyleName = "DataField";
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrLabel23
            // 
            this.xrLabel23.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "DienThoai")});
            this.xrLabel23.Dpi = 100F;
            this.xrLabel23.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel23.LocationFloat = new DevExpress.Utils.PointFloat(445.2725F, 46.83329F);
            this.xrLabel23.Name = "xrLabel23";
            this.xrLabel23.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel23.SizeF = new System.Drawing.SizeF(141.4583F, 23F);
            this.xrLabel23.StylePriority.UseFont = false;
            // 
            // xrLabel22
            // 
            this.xrLabel22.Dpi = 100F;
            this.xrLabel22.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel22.LocationFloat = new DevExpress.Utils.PointFloat(370.9936F, 46.83333F);
            this.xrLabel22.Name = "xrLabel22";
            this.xrLabel22.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel22.SizeF = new System.Drawing.SizeF(74.2789F, 23F);
            this.xrLabel22.StylePriority.UseFont = false;
            this.xrLabel22.Text = "Điện thoại:";
            // 
            // xrLabel21
            // 
            this.xrLabel21.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "CongNoSauThanhToan", "{0:n0}")});
            this.xrLabel21.Dpi = 100F;
            this.xrLabel21.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel21.LocationFloat = new DevExpress.Utils.PointFloat(167.404F, 138.8333F);
            this.xrLabel21.Name = "xrLabel21";
            this.xrLabel21.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel21.SizeF = new System.Drawing.SizeF(419.3268F, 23F);
            this.xrLabel21.StylePriority.UseFont = false;
            // 
            // xrLabel20
            // 
            this.xrLabel20.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "STTPhieuThu")});
            this.xrLabel20.Dpi = 100F;
            this.xrLabel20.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel20.LocationFloat = new DevExpress.Utils.PointFloat(77.46803F, 184.8333F);
            this.xrLabel20.Name = "xrLabel20";
            this.xrLabel20.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel20.SizeF = new System.Drawing.SizeF(509.2628F, 22.99998F);
            this.xrLabel20.StylePriority.UseFont = false;
            // 
            // xrLabel19
            // 
            this.xrLabel19.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "SoHoaDon")});
            this.xrLabel19.Dpi = 100F;
            this.xrLabel19.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel19.LocationFloat = new DevExpress.Utils.PointFloat(95.52887F, 161.8333F);
            this.xrLabel19.Name = "xrLabel19";
            this.xrLabel19.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel19.SizeF = new System.Drawing.SizeF(491.2019F, 23F);
            this.xrLabel19.StylePriority.UseFont = false;
            // 
            // xrLabel17
            // 
            this.xrLabel17.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "SoTienThu", "{0:n0}")});
            this.xrLabel17.Dpi = 100F;
            this.xrLabel17.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel17.LocationFloat = new DevExpress.Utils.PointFloat(140.1602F, 92.83332F);
            this.xrLabel17.Name = "xrLabel17";
            this.xrLabel17.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel17.SizeF = new System.Drawing.SizeF(446.5706F, 23.00001F);
            this.xrLabel17.StylePriority.UseFont = false;
            // 
            // xrLabel16
            // 
            this.xrLabel16.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "NoiDung")});
            this.xrLabel16.Dpi = 100F;
            this.xrLabel16.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel16.LocationFloat = new DevExpress.Utils.PointFloat(77.46803F, 207.8333F);
            this.xrLabel16.Name = "xrLabel16";
            this.xrLabel16.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel16.SizeF = new System.Drawing.SizeF(509.2628F, 22.99998F);
            this.xrLabel16.StylePriority.UseFont = false;
            // 
            // xrLabel3
            // 
            this.xrLabel3.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "CongNoTruocThanhToan", "{0:n0}")});
            this.xrLabel3.Dpi = 100F;
            this.xrLabel3.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel3.LocationFloat = new DevExpress.Utils.PointFloat(207.7725F, 69.83331F);
            this.xrLabel3.Name = "xrLabel3";
            this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel3.SizeF = new System.Drawing.SizeF(378.9583F, 23F);
            this.xrLabel3.StylePriority.UseFont = false;
            // 
            // xrLabel2
            // 
            this.xrLabel2.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "TenKhachHang")});
            this.xrLabel2.Dpi = 100F;
            this.xrLabel2.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel2.LocationFloat = new DevExpress.Utils.PointFloat(120.7373F, 46.83328F);
            this.xrLabel2.Name = "xrLabel2";
            this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel2.SizeF = new System.Drawing.SizeF(187.3398F, 22.99999F);
            this.xrLabel2.StylePriority.UseFont = false;
            // 
            // xrLabel13
            // 
            this.xrLabel13.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "NgayThu")});
            this.xrLabel13.Dpi = 100F;
            this.xrLabel13.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Italic);
            this.xrLabel13.LocationFloat = new DevExpress.Utils.PointFloat(341.907F, 245.8333F);
            this.xrLabel13.Name = "xrLabel13";
            this.xrLabel13.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel13.SizeF = new System.Drawing.SizeF(298.093F, 23.00002F);
            this.xrLabel13.StylePriority.UseFont = false;
            // 
            // xrLabel12
            // 
            this.xrLabel12.Dpi = 100F;
            this.xrLabel12.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel12.LocationFloat = new DevExpress.Utils.PointFloat(98.33336F, 279.1667F);
            this.xrLabel12.Name = "xrLabel12";
            this.xrLabel12.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel12.SizeF = new System.Drawing.SizeF(141.6667F, 23F);
            this.xrLabel12.StylePriority.UseFont = false;
            this.xrLabel12.Text = "Người thanh toán";
            // 
            // xrLabel11
            // 
            this.xrLabel11.Dpi = 100F;
            this.xrLabel11.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel11.LocationFloat = new DevExpress.Utils.PointFloat(10.16035F, 138.8333F);
            this.xrLabel11.Name = "xrLabel11";
            this.xrLabel11.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel11.SizeF = new System.Drawing.SizeF(157.0833F, 23F);
            this.xrLabel11.StylePriority.UseFont = false;
            this.xrLabel11.Text = "Công nợ sau thanh toán:";
            // 
            // xrLabel10
            // 
            this.xrLabel10.Dpi = 100F;
            this.xrLabel10.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel10.LocationFloat = new DevExpress.Utils.PointFloat(10.16027F, 184.8333F);
            this.xrLabel10.Name = "xrLabel10";
            this.xrLabel10.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel10.SizeF = new System.Drawing.SizeF(67.14749F, 23.00002F);
            this.xrLabel10.StylePriority.UseFont = false;
            this.xrLabel10.Text = "Số phiếu:";
            // 
            // xrLabel9
            // 
            this.xrLabel9.Dpi = 100F;
            this.xrLabel9.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel9.LocationFloat = new DevExpress.Utils.PointFloat(10.16027F, 161.8333F);
            this.xrLabel9.Name = "xrLabel9";
            this.xrLabel9.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel9.SizeF = new System.Drawing.SizeF(85.04807F, 23F);
            this.xrLabel9.StylePriority.UseFont = false;
            this.xrLabel9.Text = "Số hóa đơn:";
            // 
            // xrLabel8
            // 
            this.xrLabel8.Dpi = 100F;
            this.xrLabel8.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel8.LocationFloat = new DevExpress.Utils.PointFloat(10.16027F, 115.8333F);
            this.xrLabel8.Name = "xrLabel8";
            this.xrLabel8.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel8.SizeF = new System.Drawing.SizeF(129.8397F, 23F);
            this.xrLabel8.StylePriority.UseFont = false;
            this.xrLabel8.Text = "Số tiền bằng chữ:";
            // 
            // xrLabel7
            // 
            this.xrLabel7.Dpi = 100F;
            this.xrLabel7.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel7.LocationFloat = new DevExpress.Utils.PointFloat(10.16027F, 92.83332F);
            this.xrLabel7.Name = "xrLabel7";
            this.xrLabel7.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel7.SizeF = new System.Drawing.SizeF(129.8397F, 23.00001F);
            this.xrLabel7.StylePriority.UseFont = false;
            this.xrLabel7.Text = "Số tiền thanh toán:";
            // 
            // xrLabel6
            // 
            this.xrLabel6.Dpi = 100F;
            this.xrLabel6.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel6.LocationFloat = new DevExpress.Utils.PointFloat(10.16035F, 207.8333F);
            this.xrLabel6.Name = "xrLabel6";
            this.xrLabel6.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel6.SizeF = new System.Drawing.SizeF(67.14742F, 22.99998F);
            this.xrLabel6.StylePriority.UseFont = false;
            this.xrLabel6.Text = "Nội dung:";
            // 
            // xrLabel5
            // 
            this.xrLabel5.Dpi = 100F;
            this.xrLabel5.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel5.LocationFloat = new DevExpress.Utils.PointFloat(10.16027F, 69.83331F);
            this.xrLabel5.Name = "xrLabel5";
            this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel5.SizeF = new System.Drawing.SizeF(197.1474F, 23F);
            this.xrLabel5.StylePriority.UseFont = false;
            this.xrLabel5.Text = "Công nợ trước khi thanh toán:";
            // 
            // xrLabel4
            // 
            this.xrLabel4.Dpi = 100F;
            this.xrLabel4.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel4.LocationFloat = new DevExpress.Utils.PointFloat(10.16027F, 46.83333F);
            this.xrLabel4.Name = "xrLabel4";
            this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel4.SizeF = new System.Drawing.SizeF(110.4167F, 23F);
            this.xrLabel4.StylePriority.UseFont = false;
            this.xrLabel4.Text = "Tên khách hàng:";
            // 
            // lblTenPhieu
            // 
            this.lblTenPhieu.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "TieuDe")});
            this.lblTenPhieu.Dpi = 100F;
            this.lblTenPhieu.Font = new System.Drawing.Font("Times New Roman", 14F, System.Drawing.FontStyle.Bold);
            this.lblTenPhieu.LocationFloat = new DevExpress.Utils.PointFloat(301.0417F, 0F);
            this.lblTenPhieu.Name = "lblTenPhieu";
            this.lblTenPhieu.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblTenPhieu.SizeF = new System.Drawing.SizeF(222.9167F, 23F);
            this.lblTenPhieu.StylePriority.UseFont = false;
            // 
            // lblMaKh
            // 
            this.lblMaKh.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "MaKhachHang")});
            this.lblMaKh.Dpi = 100F;
            this.lblMaKh.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Italic);
            this.lblMaKh.LocationFloat = new DevExpress.Utils.PointFloat(95.20836F, 0F);
            this.lblMaKh.Name = "lblMaKh";
            this.lblMaKh.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblMaKh.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.lblMaKh.StylePriority.UseFont = false;
            // 
            // xrLabel1
            // 
            this.xrLabel1.Dpi = 100F;
            this.xrLabel1.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Italic);
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(39.99999F, 0F);
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(55.20835F, 23F);
            this.xrLabel1.StylePriority.UseFont = false;
            this.xrLabel1.Text = "Mã KH:";
            // 
            // reportHeaderBand1
            // 
            this.reportHeaderBand1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.imgLogo,
            this.lblTenCTy,
            this.lblDiaChi,
            this.lblDienThoai});
            this.reportHeaderBand1.Dpi = 100F;
            this.reportHeaderBand1.HeightF = 77.82636F;
            this.reportHeaderBand1.Name = "reportHeaderBand1";
            // 
            // imgLogo
            // 
            this.imgLogo.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("ImageUrl", this.DataThongTin, "ThongTinCongTy.Logo")});
            this.imgLogo.Dpi = 100F;
            this.imgLogo.LocationFloat = new DevExpress.Utils.PointFloat(19.99998F, 12.0833F);
            this.imgLogo.Name = "imgLogo";
            this.imgLogo.SizeF = new System.Drawing.SizeF(120F, 60F);
            this.imgLogo.Sizing = DevExpress.XtraPrinting.ImageSizeMode.StretchImage;
            // 
            // lblTenCTy
            // 
            this.lblTenCTy.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.lblTenCTy.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", this.DataThongTin, "ThongTinCongTy.TenChiNhanh")});
            this.lblTenCTy.Dpi = 100F;
            this.lblTenCTy.Font = new System.Drawing.Font("Times New Roman", 13F, System.Drawing.FontStyle.Bold);
            this.lblTenCTy.LocationFloat = new DevExpress.Utils.PointFloat(150F, 0F);
            this.lblTenCTy.Name = "lblTenCTy";
            this.lblTenCTy.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblTenCTy.SizeF = new System.Drawing.SizeF(480F, 25F);
            this.lblTenCTy.StylePriority.UseBorders = false;
            this.lblTenCTy.StylePriority.UseFont = false;
            this.lblTenCTy.StylePriority.UsePadding = false;
            this.lblTenCTy.StylePriority.UseTextAlignment = false;
            this.lblTenCTy.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // lblDiaChi
            // 
            this.lblDiaChi.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.lblDiaChi.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", this.DataThongTin, "ThongTinCongTy.DiaChi")});
            this.lblDiaChi.Dpi = 100F;
            this.lblDiaChi.Font = new System.Drawing.Font("Times New Roman", 10F);
            this.lblDiaChi.LocationFloat = new DevExpress.Utils.PointFloat(150F, 24.99999F);
            this.lblDiaChi.Name = "lblDiaChi";
            this.lblDiaChi.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblDiaChi.SizeF = new System.Drawing.SizeF(480F, 25F);
            this.lblDiaChi.StylePriority.UseBorders = false;
            this.lblDiaChi.StylePriority.UseFont = false;
            this.lblDiaChi.StylePriority.UsePadding = false;
            this.lblDiaChi.StylePriority.UseTextAlignment = false;
            this.lblDiaChi.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // lblDienThoai
            // 
            this.lblDienThoai.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.lblDienThoai.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", this.DataThongTin, "ThongTinCongTy.DienThoai")});
            this.lblDienThoai.Dpi = 100F;
            this.lblDienThoai.Font = new System.Drawing.Font("Times New Roman", 10F);
            this.lblDienThoai.LocationFloat = new DevExpress.Utils.PointFloat(150F, 49.99999F);
            this.lblDienThoai.Name = "lblDienThoai";
            this.lblDienThoai.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblDienThoai.SizeF = new System.Drawing.SizeF(480F, 25F);
            this.lblDienThoai.StylePriority.UseBorders = false;
            this.lblDienThoai.StylePriority.UseFont = false;
            this.lblDienThoai.StylePriority.UsePadding = false;
            this.lblDienThoai.StylePriority.UseTextAlignment = false;
            this.lblDienThoai.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // DataField
            // 
            this.DataField.BackColor = System.Drawing.Color.Transparent;
            this.DataField.BorderColor = System.Drawing.Color.Black;
            this.DataField.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.DataField.BorderWidth = 1F;
            this.DataField.Font = new System.Drawing.Font("Arial", 9F);
            this.DataField.ForeColor = System.Drawing.Color.Black;
            this.DataField.Name = "DataField";
            this.DataField.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            // 
            // PageInfo
            // 
            this.PageInfo.BackColor = System.Drawing.Color.Transparent;
            this.PageInfo.BorderColor = System.Drawing.Color.Black;
            this.PageInfo.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.PageInfo.BorderWidth = 1F;
            this.PageInfo.Font = new System.Drawing.Font("Arial", 8F);
            this.PageInfo.ForeColor = System.Drawing.Color.Black;
            this.PageInfo.Name = "PageInfo";
            // 
            // FieldCaption
            // 
            this.FieldCaption.BackColor = System.Drawing.Color.Transparent;
            this.FieldCaption.BorderColor = System.Drawing.Color.Black;
            this.FieldCaption.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.FieldCaption.BorderWidth = 1F;
            this.FieldCaption.Font = new System.Drawing.Font("Times New Roman", 10F);
            this.FieldCaption.ForeColor = System.Drawing.Color.Black;
            this.FieldCaption.Name = "FieldCaption";
            // 
            // Title
            // 
            this.Title.BackColor = System.Drawing.Color.Transparent;
            this.Title.BorderColor = System.Drawing.Color.Black;
            this.Title.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.Title.BorderWidth = 1F;
            this.Title.Font = new System.Drawing.Font("Times New Roman", 21F);
            this.Title.ForeColor = System.Drawing.Color.Black;
            this.Title.Name = "Title";
            // 
            // TopMargin
            // 
            this.TopMargin.Dpi = 100F;
            this.TopMargin.HeightF = 21.875F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.Dpi = 100F;
            this.BottomMargin.HeightF = 100F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // odsPayNode
            // 
            this.odsPayNode.DataSource = typeof(KobePaint.App_Code.oThanhToan);
            this.odsPayNode.Name = "odsPayNode";
            // 
            // rpPhieuThanhToan
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.reportHeaderBand1});
            this.Bookmark = "rpPhieuThanhToan";
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.odsPayNode,
            this.DataThongTin});
            this.DataSource = this.odsPayNode;
            this.DisplayName = "rpPhieuThanhToan";
            this.Margins = new System.Drawing.Printing.Margins(100, 100, 22, 100);
            this.StyleSheet.AddRange(new DevExpress.XtraReports.UI.XRControlStyle[] {
            this.Title,
            this.FieldCaption,
            this.PageInfo,
            this.DataField});
            this.Version = "16.1";
            ((System.ComponentModel.ISupportInitialize)(this.odsPayNode)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.XRLabel xrLabel14;
        private DevExpress.DataAccess.Sql.SqlDataSource DataThongTin;
        private DevExpress.XtraReports.UI.XRLabel xrLabel18;
        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.XRLabel xrLabel23;
        private DevExpress.XtraReports.UI.XRLabel xrLabel22;
        private DevExpress.XtraReports.UI.XRLabel xrLabel21;
        private DevExpress.XtraReports.UI.XRLabel xrLabel20;
        private DevExpress.XtraReports.UI.XRLabel xrLabel19;
        private DevExpress.XtraReports.UI.XRLabel xrLabel17;
        private DevExpress.XtraReports.UI.XRLabel xrLabel16;
        private DevExpress.XtraReports.UI.XRLabel xrLabel3;
        private DevExpress.XtraReports.UI.XRLabel xrLabel2;
        private DevExpress.XtraReports.UI.XRLabel xrLabel13;
        private DevExpress.XtraReports.UI.XRLabel xrLabel12;
        private DevExpress.XtraReports.UI.XRLabel xrLabel11;
        private DevExpress.XtraReports.UI.XRLabel xrLabel10;
        private DevExpress.XtraReports.UI.XRLabel xrLabel9;
        private DevExpress.XtraReports.UI.XRLabel xrLabel8;
        private DevExpress.XtraReports.UI.XRLabel xrLabel7;
        private DevExpress.XtraReports.UI.XRLabel xrLabel6;
        private DevExpress.XtraReports.UI.XRLabel xrLabel5;
        private DevExpress.XtraReports.UI.XRLabel xrLabel4;
        private DevExpress.XtraReports.UI.XRLabel lblTenPhieu;
        private DevExpress.XtraReports.UI.XRLabel lblMaKh;
        private DevExpress.XtraReports.UI.XRLabel xrLabel1;
        private DevExpress.XtraReports.UI.ReportHeaderBand reportHeaderBand1;
        public DevExpress.DataAccess.ObjectBinding.ObjectDataSource odsPayNode;
        private DevExpress.XtraReports.UI.XRControlStyle DataField;
        private DevExpress.XtraReports.UI.XRControlStyle PageInfo;
        private DevExpress.XtraReports.UI.XRControlStyle FieldCaption;
        private DevExpress.XtraReports.UI.XRControlStyle Title;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.XRPictureBox imgLogo;
        private DevExpress.XtraReports.UI.XRLabel lblTenCTy;
        private DevExpress.XtraReports.UI.XRLabel lblDiaChi;
        private DevExpress.XtraReports.UI.XRLabel lblDienThoai;

    }
}
