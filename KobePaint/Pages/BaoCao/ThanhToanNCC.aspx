<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ThanhToanNCC.aspx.cs" Inherits="KobePaint.Pages.BaoCao.ThanhToanNCC" %>
<%@ Register Assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>

        .dxflGroupCell_Material{
            padding: 0 5px;
        }
        .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material
        {
            padding-top: 1px;
        }
    </style>
     <script type="text/javascript">
         function AdjustSize() {
             var hformThongTin = formThongTin.GetHeight();
             UpdateHeightControlInPage(gridChiTietCongNo, hformThongTin);
         }
         function onXemBaoCaoClick() {
             if (checkInput())
                 gridChiTietCongNo.Refresh();
         }
         function checkInput() {
             //if (ccbKhachHang.GetSelectedIndex() == -1) {
             //    alert('Vui lòng chọn khách hàng!!');
             //    ccbKhachHang.Focus();
             //    return false;
             //}
             if (fromDay.GetValue() == null) {
                 alert('Vui lòng chọn ngày xem báo cáo');
                 fromDay.Focus();
                 return false;
             }
             if (toDay.GetValue() == null) {
                 alert('Vui lòng chọn ngày xem báo cáo');
                 toDay.Focus();
                 return false;
             }
             return true;
         }
         function onPrintClick(idPhieu) {
             popupViewReport.Show();
             cbpViewReport.PerformCallback(idPhieu);
         }
         function onEndCallBackViewRp() {
             reportViewer.GetViewer().Refresh();
         }
    </script>
    <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
        <Items>
            <dx:LayoutGroup Caption="Báo cáo thanh toán nhà cung cấp" ColCount="5" HorizontalAlign="Center" Width="100%">
                <Items>
                    <dx:LayoutItem Caption="Khách hàng">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                <dx:ASPxComboBox ID="ccbKhachHang" ClientInstanceName="ccbKhachHang" runat="server" DataSourceID="dsKhachHang" DisplayFormatString="{0}" TextField="HoTen" ValueField="IDKhachHang" NullText="---Chọn khách hàng---" Width="100%" DropDownStyle="DropDown">
                                    <Columns>
                                        <dx:ListBoxColumn Caption="Họ tên" FieldName="HoTen" />
                                        <dx:ListBoxColumn Caption="Điện thoại" FieldName="DienThoai" />
                                    </Columns>
                                </dx:ASPxComboBox>
                                <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDKhachHang], [HoTen], [DienThoai] FROM [khKhachHang] WHERE [LoaiKhachHangID] = 2"></asp:SqlDataSource>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Từ ngày">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                <dx:ASPxDateEdit ID="fromDay" ClientInstanceName="fromDay" runat="server" OnInit="dateEditControl_Init" Width="100%">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="đến ngày">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                <dx:ASPxDateEdit ID="toDay" ClientInstanceName="toDay" runat="server" OnInit="dateEditControl_Init" Width="100%">
                                    <DateRangeSettings StartDateEditID="fromDay" />
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Xem báo cáo" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                <dx:ASPxButton ID="btnXemBaoCao" runat="server" Text="Xem báo cáo" AutoPostBack="false" Width="100%">
                                    <ClientSideEvents Click="onXemBaoCaoClick" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Xuất excel" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                <dx:ASPxButton ID="btnXuatExcel" runat="server" Text="Xuất excel" OnClick="btnXuatExcel_Click" Width="100%">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
                <SettingsItemCaptions Location="Left" />
            </dx:LayoutGroup>
        </Items>
        <Styles>
            <LayoutItem>
                <Paddings PaddingTop="0px" />
            </LayoutItem>
        </Styles>
    </dx:ASPxFormLayout>
   <dx:ASPxGridView ID="gridChiTiet" ClientInstanceName="gridChiTietCongNo" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTiet" Width="100%" OnCustomColumnDisplayText="grid_CustomColumnDisplayText" KeyFieldName="IDPhieuThu">
        <Settings VerticalScrollBarMode="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowHeaderFilterButton="true"/>
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <SettingsText HeaderFilterCancelButton="Hủy" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" PopupEditFormCaption="Cập nhật mã hóa đơn"  EmptyDataRow="Không có dữ liệu" CommandCancel="Hủy" ConfirmDelete="Bạn có chắc chắn muốn xóa?" HeaderFilterFrom="Từ" HeaderFilterLastMonth="Tháng trước" HeaderFilterLastWeek="Tuần trước" HeaderFilterLastYear="Năm trước" HeaderFilterNextMonth="Tháng sau" HeaderFilterNextWeek="Tuần sau" HeaderFilterNextYear="Năm sau" HeaderFilterOkButton="Lọc" HeaderFilterSelectAll="Chọn tất cả" HeaderFilterShowAll="Tất cả" HeaderFilterShowBlanks="Trống" HeaderFilterShowNonBlanks="Không trống" HeaderFilterThisMonth="Tháng này" HeaderFilterThisWeek="Tuần này" HeaderFilterThisYear="Năm nay" HeaderFilterTo="Đến" HeaderFilterToday="Hôm nay" HeaderFilterTomorrow="Ngày mai" HeaderFilterYesterday="Ngày hôm qua" />
        <SettingsPager PageSize="20">
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <Columns>
            <dx:GridViewDataDateColumn Caption="Ngày thu" FieldName="NgayThu" VisibleIndex="4" ReadOnly="True">
                <SettingsHeaderFilter>
                    <DateRangeCalendarSettings ClearButtonText="Bỏ" FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" TodayButtonText="Hôm nay" />
                    <DateRangePeriodsSettings ShowWeeksSection="False" />
                </SettingsHeaderFilter>
                <CellStyle HorizontalAlign="Center"></CellStyle>
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                    <CalendarProperties FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" ClearButtonText="Hủy" TodayButtonText="Hôm nay">
                        <FastNavProperties Enabled="False" />
                    </CalendarProperties>                    
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Nội dung" FieldName="NoiDung" VisibleIndex="6" ReadOnly="True" Width="200px">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mã phiếu" FieldName="STTPhieuThu" VisibleIndex="3" ReadOnly="True" Width="90px">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="STT" VisibleIndex="0" Width="50px" FieldName="IDPhieuThu">
                <Settings AllowAutoFilter="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Khách hàng" FieldName="HoTenKH" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Nhân viên thu" FieldName="HoTenNV" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn Caption="Số tiền" FieldName="SoTienThu" VisibleIndex="5" CellStyle-Font-Bold="true">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn Caption="In phiếu" VisibleIndex="9" Width="80px">
                <DataItemTemplate>
                    <dx:ASPxButton ID="btnInPhieu" runat="server" RenderMode="Link" OnInit="btnInPhieu_Init" AutoPostBack="false">
                        <Image IconID="print_print_16x16">
                        </Image>
                    </dx:ASPxButton>
                </DataItemTemplate>
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="SoTienThu" ShowInColumn="Số tiền" SummaryType="Sum" />
        </TotalSummary>
    </dx:ASPxGridView>
     <asp:SqlDataSource ID="dsChiTiet" runat="server" 
        ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT nvNhanVien.HoTen AS HoTenNV, khKhachHang.MaKhachHang, khKhachHang.HoTen AS HoTenKH, khKhachHang.DienThoai, kPhieuThanhToanNCC.STTPhieuThu, kPhieuThanhToanNCC.SoTienThu, kPhieuThanhToanNCC.NoiDung, kPhieuThanhToanNCC.NgayThu, kPhieuThanhToanNCC.IDPhieuThu FROM khKhachHang INNER JOIN kPhieuThanhToanNCC ON khKhachHang.IDKhachHang = kPhieuThanhToanNCC.KhachHangID INNER JOIN nvNhanVien ON kPhieuThanhToanNCC.NhanVienThuID = nvNhanVien.IDNhanVien WHERE (kPhieuThanhToanNCC.NgayThu &lt;= DATEADD(day, 1, @DenNgay)) AND (kPhieuThanhToanNCC.NgayThu &gt;= @TuNgay) AND (@IDKhachHang = 0) OR (kPhieuThanhToanNCC.NgayThu &lt;= DATEADD(day, 1, @DenNgay)) AND (kPhieuThanhToanNCC.NgayThu &gt;= @TuNgay) AND (khKhachHang.IDKhachHang = @IDKhachHang)" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="formThongTin$fromDay" Name="TuNgay" PropertyName="Value" ConvertEmptyStringToNull="true" DefaultValue=""  />
            <asp:ControlParameter ControlID="formThongTin$toDay" Name="DenNgay" PropertyName="Value" ConvertEmptyStringToNull="true" DefaultValue="" />
            <asp:ControlParameter ControlID="formThongTin$ccbKhachHang" Name="IDKhachHang" PropertyName="Value" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridChiTiet">
    </dx:ASPxGridViewExporter>
    <dx:ASPxPopupControl ID="popupViewReport"  ClientInstanceName="popupViewReport" runat="server" HeaderText="Phiếu thanh toán NCC" Width="850px" ShowHeader="false" PopupVerticalAlign="WindowCenter" Height="600px" PopupHorizontalAlign="WindowCenter" ScrollBars="Auto" >
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxCallbackPanel ID="cbpViewReport" ClientInstanceName="cbpViewReport" runat="server" Width="100%" OnCallback="cbpViewReport_Callback">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server" Width="100%">
                            </dx:ASPxDocumentViewer>                
                            <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
                            </dx:ASPxHiddenField>
                        </dx:PanelContent>
                    </PanelCollection>
                    <ClientSideEvents EndCallback="onEndCallBackViewRp" />
                </dx:ASPxCallbackPanel>                
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
