namespace KobePaint.Reports
{
    partial class rpPhieuThuChi
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(rpPhieuThuChi));
            this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
            this.DataThongTin = new DevExpress.DataAccess.Sql.SqlDataSource(this.components);
            this.FieldCaption = new DevExpress.XtraReports.UI.XRControlStyle();
            this.xrLabel12 = new DevExpress.XtraReports.UI.XRLabel();
            this.lblDiaChi = new DevExpress.XtraReports.UI.XRLabel();
            this.Title = new DevExpress.XtraReports.UI.XRControlStyle();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.imgLogo = new DevExpress.XtraReports.UI.XRPictureBox();
            this.xrLabel10 = new DevExpress.XtraReports.UI.XRLabel();
            this.reportHeaderBand1 = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.lblTenCTy = new DevExpress.XtraReports.UI.XRLabel();
            this.lblDienThoai = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
            this.DataField = new DevExpress.XtraReports.UI.XRControlStyle();
            this.xrLabel7 = new DevExpress.XtraReports.UI.XRLabel();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.xrLabel13 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel16 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel14 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel11 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel6 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel8 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel15 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel24 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel18 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel17 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel9 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
            this.lblTenPhieu = new DevExpress.XtraReports.UI.XRLabel();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.eventLog1 = new System.Diagnostics.EventLog();
            this.xrLabel19 = new DevExpress.XtraReports.UI.XRLabel();
            this.odsPayNode = new DevExpress.DataAccess.ObjectBinding.ObjectDataSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.eventLog1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.odsPayNode)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
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
            // DataThongTin
            // 
            this.DataThongTin.ConnectionName = "KobePaintConnectionString";
            this.DataThongTin.Name = "DataThongTin";
            customSqlQuery1.Name = "ThongTinCongTy";
            customSqlQuery1.Sql = "select UPPER(\"chChiNhanh\".\"TenChiNhanh\") AS TenChiNhanh ,\n       \"chChiNhanh\".\"Di" +
    "enThoai\",\n       \"chChiNhanh\".\"DiaChi\", \"chChiNhanh\".\"MST\", \"chChiNhanh\".\"Logo\"\n" +
    "  from \"dbo\".\"chChiNhanh\" \"chChiNhanh\"";
            this.DataThongTin.Queries.AddRange(new DevExpress.DataAccess.Sql.SqlQuery[] {
            customSqlQuery1});
            this.DataThongTin.ResultSchemaSerializable = resources.GetString("DataThongTin.ResultSchemaSerializable");
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
            // xrLabel12
            // 
            this.xrLabel12.Dpi = 100F;
            this.xrLabel12.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel12.LocationFloat = new DevExpress.Utils.PointFloat(73.40148F, 258.1018F);
            this.xrLabel12.Name = "xrLabel12";
            this.xrLabel12.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel12.SizeF = new System.Drawing.SizeF(102.9167F, 23.00003F);
            this.xrLabel12.StylePriority.UseFont = false;
            this.xrLabel12.Text = "Giám đốc";
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
            // BottomMargin
            // 
            this.BottomMargin.Dpi = 100F;
            this.BottomMargin.HeightF = 100F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
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
            // xrLabel10
            // 
            this.xrLabel10.Dpi = 100F;
            this.xrLabel10.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel10.LocationFloat = new DevExpress.Utils.PointFloat(5.993589F, 205.5833F);
            this.xrLabel10.Name = "xrLabel10";
            this.xrLabel10.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel10.SizeF = new System.Drawing.SizeF(67.14749F, 23.00002F);
            this.xrLabel10.StylePriority.UseFont = false;
            this.xrLabel10.Text = "Bằng chữ:";
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
            // xrLabel3
            // 
            this.xrLabel3.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Dot;
            this.xrLabel3.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel3.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "DienThoai")});
            this.xrLabel3.Dpi = 100F;
            this.xrLabel3.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel3.LocationFloat = new DevExpress.Utils.PointFloat(203.6059F, 113.5833F);
            this.xrLabel3.Name = "xrLabel3";
            this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel3.SizeF = new System.Drawing.SizeF(378.9583F, 23F);
            this.xrLabel3.StylePriority.UseBorderDashStyle = false;
            this.xrLabel3.StylePriority.UseBorders = false;
            this.xrLabel3.StylePriority.UseFont = false;
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
            // xrLabel7
            // 
            this.xrLabel7.Dpi = 100F;
            this.xrLabel7.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel7.LocationFloat = new DevExpress.Utils.PointFloat(6.253997F, 136.5833F);
            this.xrLabel7.Name = "xrLabel7";
            this.xrLabel7.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel7.SizeF = new System.Drawing.SizeF(196.887F, 23.00002F);
            this.xrLabel7.StylePriority.UseFont = false;
            this.xrLabel7.Text = "Địa chỉ:";
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel19,
            this.xrLabel13,
            this.xrLabel16,
            this.xrLabel14,
            this.xrLabel11,
            this.xrLabel6,
            this.xrLabel8,
            this.xrLabel4,
            this.xrLabel15,
            this.xrLabel24,
            this.xrLabel1,
            this.xrLabel18,
            this.xrLabel17,
            this.xrLabel3,
            this.xrLabel2,
            this.xrLabel12,
            this.xrLabel10,
            this.xrLabel9,
            this.xrLabel7,
            this.xrLabel5,
            this.lblTenPhieu});
            this.Detail.Dpi = 100F;
            this.Detail.HeightF = 332.3749F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.StyleName = "DataField";
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrLabel13
            // 
            this.xrLabel13.Dpi = 100F;
            this.xrLabel13.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Italic);
            this.xrLabel13.LocationFloat = new DevExpress.Utils.PointFloat(433.113F, 235.1018F);
            this.xrLabel13.Name = "xrLabel13";
            this.xrLabel13.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel13.SizeF = new System.Drawing.SizeF(206.887F, 23.00002F);
            this.xrLabel13.StylePriority.UseFont = false;
            this.xrLabel13.Text = "Ngày.........Tháng.........Năm.........";
            // 
            // xrLabel16
            // 
            this.xrLabel16.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "NguoiThuChi")});
            this.xrLabel16.Dpi = 100F;
            this.xrLabel16.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel16.LocationFloat = new DevExpress.Utils.PointFloat(515.4047F, 258.1019F);
            this.xrLabel16.Name = "xrLabel16";
            this.xrLabel16.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel16.SizeF = new System.Drawing.SizeF(114.5953F, 23.00003F);
            this.xrLabel16.StylePriority.UseFont = false;
            // 
            // xrLabel14
            // 
            this.xrLabel14.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "NguoiNopChi")});
            this.xrLabel14.Dpi = 100F;
            this.xrLabel14.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel14.LocationFloat = new DevExpress.Utils.PointFloat(293.0788F, 258.1018F);
            this.xrLabel14.Name = "xrLabel14";
            this.xrLabel14.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel14.SizeF = new System.Drawing.SizeF(111.3281F, 23.00003F);
            this.xrLabel14.StylePriority.UseFont = false;
            // 
            // xrLabel11
            // 
            this.xrLabel11.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "SoTien")});
            this.xrLabel11.Dpi = 100F;
            this.xrLabel11.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel11.LocationFloat = new DevExpress.Utils.PointFloat(73.40149F, 205.5833F);
            this.xrLabel11.Name = "xrLabel11";
            this.xrLabel11.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel11.SizeF = new System.Drawing.SizeF(509.1625F, 23F);
            this.xrLabel11.StylePriority.UseFont = false;
            this.xrLabel11.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.xrLabel11_BeforePrint);
            // 
            // xrLabel6
            // 
            this.xrLabel6.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "SoTien", "{0:N0} đồng")});
            this.xrLabel6.Dpi = 100F;
            this.xrLabel6.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel6.LocationFloat = new DevExpress.Utils.PointFloat(58.74999F, 182.5833F);
            this.xrLabel6.Name = "xrLabel6";
            this.xrLabel6.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel6.SizeF = new System.Drawing.SizeF(523.814F, 23F);
            this.xrLabel6.StylePriority.UseFont = false;
            // 
            // xrLabel8
            // 
            this.xrLabel8.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "LyDo", "{0}:")});
            this.xrLabel8.Dpi = 100F;
            this.xrLabel8.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel8.LocationFloat = new DevExpress.Utils.PointFloat(6.803024F, 159.5833F);
            this.xrLabel8.Name = "xrLabel8";
            this.xrLabel8.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel8.SizeF = new System.Drawing.SizeF(196.8869F, 23.00001F);
            this.xrLabel8.StylePriority.UseFont = false;
            // 
            // xrLabel4
            // 
            this.xrLabel4.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "HoTen", "{0}:")});
            this.xrLabel4.Dpi = 100F;
            this.xrLabel4.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel4.LocationFloat = new DevExpress.Utils.PointFloat(6.254097F, 90.5833F);
            this.xrLabel4.Name = "xrLabel4";
            this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel4.SizeF = new System.Drawing.SizeF(196.8869F, 23.00001F);
            this.xrLabel4.StylePriority.UseFont = false;
            // 
            // xrLabel15
            // 
            this.xrLabel15.Dpi = 100F;
            this.xrLabel15.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Italic);
            this.xrLabel15.LocationFloat = new DevExpress.Utils.PointFloat(264.9538F, 45.99997F);
            this.xrLabel15.Multiline = true;
            this.xrLabel15.Name = "xrLabel15";
            this.xrLabel15.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel15.SizeF = new System.Drawing.SizeF(44.66147F, 23F);
            this.xrLabel15.StylePriority.UseFont = false;
            this.xrLabel15.Text = "Ngày:\r\n";
            // 
            // xrLabel24
            // 
            this.xrLabel24.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "Ngay")});
            this.xrLabel24.Dpi = 100F;
            this.xrLabel24.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Italic);
            this.xrLabel24.LocationFloat = new DevExpress.Utils.PointFloat(309.6153F, 45.99994F);
            this.xrLabel24.Name = "xrLabel24";
            this.xrLabel24.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel24.SizeF = new System.Drawing.SizeF(187.3398F, 22.99999F);
            this.xrLabel24.StylePriority.UseFont = false;
            // 
            // xrLabel1
            // 
            this.xrLabel1.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "MaPhieu")});
            this.xrLabel1.Dpi = 100F;
            this.xrLabel1.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Bold);
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(232.8566F, 22.99995F);
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(292.7084F, 22.99999F);
            this.xrLabel1.StylePriority.UseFont = false;
            // 
            // xrLabel18
            // 
            this.xrLabel18.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Dot;
            this.xrLabel18.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel18.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "NoiDungLyDo")});
            this.xrLabel18.Dpi = 100F;
            this.xrLabel18.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel18.LocationFloat = new DevExpress.Utils.PointFloat(203.6899F, 159.5833F);
            this.xrLabel18.Name = "xrLabel18";
            this.xrLabel18.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel18.SizeF = new System.Drawing.SizeF(378.874F, 23F);
            this.xrLabel18.StylePriority.UseBorderDashStyle = false;
            this.xrLabel18.StylePriority.UseBorders = false;
            this.xrLabel18.StylePriority.UseFont = false;
            // 
            // xrLabel17
            // 
            this.xrLabel17.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Dot;
            this.xrLabel17.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel17.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "DiaChi")});
            this.xrLabel17.Dpi = 100F;
            this.xrLabel17.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel17.LocationFloat = new DevExpress.Utils.PointFloat(203.6898F, 136.5833F);
            this.xrLabel17.Name = "xrLabel17";
            this.xrLabel17.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel17.SizeF = new System.Drawing.SizeF(378.8743F, 23.00002F);
            this.xrLabel17.StylePriority.UseBorderDashStyle = false;
            this.xrLabel17.StylePriority.UseBorders = false;
            this.xrLabel17.StylePriority.UseFont = false;
            // 
            // xrLabel2
            // 
            this.xrLabel2.BorderDashStyle = DevExpress.XtraPrinting.BorderDashStyle.Dot;
            this.xrLabel2.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrLabel2.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "TenNguoiNopNhan")});
            this.xrLabel2.Dpi = 100F;
            this.xrLabel2.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel2.LocationFloat = new DevExpress.Utils.PointFloat(203.8663F, 90.58328F);
            this.xrLabel2.Name = "xrLabel2";
            this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel2.SizeF = new System.Drawing.SizeF(378.6976F, 22.99999F);
            this.xrLabel2.StylePriority.UseBorderDashStyle = false;
            this.xrLabel2.StylePriority.UseBorders = false;
            this.xrLabel2.StylePriority.UseFont = false;
            // 
            // xrLabel9
            // 
            this.xrLabel9.Dpi = 100F;
            this.xrLabel9.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel9.LocationFloat = new DevExpress.Utils.PointFloat(6.253997F, 182.5833F);
            this.xrLabel9.Name = "xrLabel9";
            this.xrLabel9.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel9.SizeF = new System.Drawing.SizeF(52.49599F, 23.00002F);
            this.xrLabel9.StylePriority.UseFont = false;
            this.xrLabel9.Text = "Số tiền:";
            // 
            // xrLabel5
            // 
            this.xrLabel5.Dpi = 100F;
            this.xrLabel5.Font = new System.Drawing.Font("Times New Roman", 11F);
            this.xrLabel5.LocationFloat = new DevExpress.Utils.PointFloat(5.993589F, 113.5833F);
            this.xrLabel5.Name = "xrLabel5";
            this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel5.SizeF = new System.Drawing.SizeF(197.1474F, 23F);
            this.xrLabel5.StylePriority.UseFont = false;
            this.xrLabel5.Text = "Số điện thoại:";
            // 
            // lblTenPhieu
            // 
            this.lblTenPhieu.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "TieuDe")});
            this.lblTenPhieu.Dpi = 100F;
            this.lblTenPhieu.Font = new System.Drawing.Font("Times New Roman", 14F, System.Drawing.FontStyle.Bold);
            this.lblTenPhieu.LocationFloat = new DevExpress.Utils.PointFloat(272.9167F, 0F);
            this.lblTenPhieu.Name = "lblTenPhieu";
            this.lblTenPhieu.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lblTenPhieu.SizeF = new System.Drawing.SizeF(222.9167F, 23F);
            this.lblTenPhieu.StylePriority.UseFont = false;
            // 
            // TopMargin
            // 
            this.TopMargin.Dpi = 100F;
            this.TopMargin.HeightF = 21.875F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrLabel19
            // 
            this.xrLabel19.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "XemTruoc", "{0}")});
            this.xrLabel19.Dpi = 100F;
            this.xrLabel19.Font = new System.Drawing.Font("Times New Roman", 11F, System.Drawing.FontStyle.Italic);
            this.xrLabel19.LocationFloat = new DevExpress.Utils.PointFloat(33.32138F, 0F);
            this.xrLabel19.Name = "xrLabel19";
            this.xrLabel19.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel19.SizeF = new System.Drawing.SizeF(88.55359F, 23.00001F);
            this.xrLabel19.StylePriority.UseFont = false;
            // 
            // odsPayNode
            // 
            this.odsPayNode.DataSource = typeof(KobePaint.App_Code.oThuChi);
            this.odsPayNode.Name = "odsPayNode";
            // 
            // rpPhieuThuChi
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
            ((System.ComponentModel.ISupportInitialize)(this.eventLog1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.odsPayNode)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.XRControlStyle PageInfo;
        private DevExpress.DataAccess.Sql.SqlDataSource DataThongTin;
        private DevExpress.XtraReports.UI.XRControlStyle FieldCaption;
        private DevExpress.XtraReports.UI.XRLabel xrLabel12;
        private DevExpress.XtraReports.UI.XRLabel lblDiaChi;
        private DevExpress.XtraReports.UI.XRControlStyle Title;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.XRPictureBox imgLogo;
        private DevExpress.XtraReports.UI.XRLabel xrLabel10;
        private DevExpress.XtraReports.UI.ReportHeaderBand reportHeaderBand1;
        private DevExpress.XtraReports.UI.XRLabel lblTenCTy;
        private DevExpress.XtraReports.UI.XRLabel lblDienThoai;
        private DevExpress.XtraReports.UI.XRLabel xrLabel3;
        private DevExpress.XtraReports.UI.XRControlStyle DataField;
        public DevExpress.DataAccess.ObjectBinding.ObjectDataSource odsPayNode;
        private DevExpress.XtraReports.UI.XRLabel xrLabel7;
        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.XRLabel xrLabel18;
        private DevExpress.XtraReports.UI.XRLabel xrLabel17;
        private DevExpress.XtraReports.UI.XRLabel xrLabel2;
        private DevExpress.XtraReports.UI.XRLabel xrLabel9;
        private DevExpress.XtraReports.UI.XRLabel xrLabel5;
        private DevExpress.XtraReports.UI.XRLabel lblTenPhieu;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.XRLabel xrLabel1;
        private DevExpress.XtraReports.UI.XRLabel xrLabel15;
        private DevExpress.XtraReports.UI.XRLabel xrLabel24;
        private DevExpress.XtraReports.UI.XRLabel xrLabel4;
        private DevExpress.XtraReports.UI.XRLabel xrLabel11;
        private DevExpress.XtraReports.UI.XRLabel xrLabel6;
        private DevExpress.XtraReports.UI.XRLabel xrLabel8;
        private DevExpress.XtraReports.UI.XRLabel xrLabel16;
        private DevExpress.XtraReports.UI.XRLabel xrLabel14;
        private System.Diagnostics.EventLog eventLog1;
        private DevExpress.XtraReports.UI.XRLabel xrLabel13;
        private DevExpress.XtraReports.UI.XRLabel xrLabel19;

    }
}
