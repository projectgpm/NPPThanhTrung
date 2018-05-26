<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CongNoDLTheoNgay.aspx.cs" Inherits="KobePaint.Pages.BaoCao.CongNoDLTheoNgay" %>
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
    </script>
    <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
        <Items>
            <dx:LayoutGroup Caption="Báo cáo công nợ chi tiết theo ngày" ColCount="4" HorizontalAlign="Center" Width="100%">
                <Items>
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
    <dx:ASPxGridView ID="gridChiTietCongNo" ClientInstanceName="gridChiTietCongNo" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTietCongNo" Width="100%" OnCustomColumnDisplayText="grid_CustomColumnDisplayText">
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
            <dx:GridViewDataDateColumn Caption="Ngày" FieldName="NgayNhap" VisibleIndex="3" ReadOnly="True">
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
            <dx:GridViewDataTextColumn Caption="Nội dung" FieldName="DienGiai" VisibleIndex="4" ReadOnly="True" Width="200px">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Số phiếu" FieldName="SoPhieu" VisibleIndex="5" ReadOnly="True" Width="90px">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="STT" VisibleIndex="0" Width="50px" FieldName="IDCongNo">
                <Settings AllowAutoFilter="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn Caption="Nợ cuối" FieldName="NoCuoi" ReadOnly="True" VisibleIndex="10" CellStyle-Font-Bold="true">
                <PropertiesSpinEdit DisplayFormatString="N0" Increment="100000" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <Settings AllowHeaderFilter="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Thanh toán" FieldName="ThanhToan" ReadOnly="True" VisibleIndex="9">
                <PropertiesSpinEdit DisplayFormatString="N0" Increment="100000" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <Settings AllowHeaderFilter="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Trả hàng" FieldName="TraHang" ReadOnly="True" VisibleIndex="8">
                <PropertiesSpinEdit DisplayFormatString="N0" Increment="100000" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <Settings AllowHeaderFilter="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Nhập hàng" FieldName="NhapHang" ReadOnly="True" VisibleIndex="7">
                <PropertiesSpinEdit DisplayFormatString="N0" Increment="100000" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <Settings AllowHeaderFilter="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Nợ đầu" FieldName="NoDau" ReadOnly="True" VisibleIndex="6" CellStyle-Font-Bold="true">
                <PropertiesSpinEdit DisplayFormatString="N0" Increment="100000" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <Settings AllowHeaderFilter="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn Caption="Khách hàng" FieldName="HoTen" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="NoDau" ShowInColumn="Nợ đầu" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="NhapHang" ShowInColumn="Nhập hàng" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TraHang" ShowInColumn="Trả hàng" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="ThanhToan" ShowInColumn="Thanh toán" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="NoCuoi" ShowInColumn="Nợ cuối" SummaryType="Sum" />
        </TotalSummary>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsChiTietCongNo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT khNhatKyCongNo.IDCongNo, khNhatKyCongNo.NgayNhap, khNhatKyCongNo.DienGiai, khNhatKyCongNo.NoDau, khNhatKyCongNo.NhapHang, khNhatKyCongNo.TraHang, khNhatKyCongNo.NoCuoi, khNhatKyCongNo.ThanhToan, khNhatKyCongNo.NhanVienID, khNhatKyCongNo.SoPhieu, khNhatKyCongNo.IDKhachHang, khKhachHang.HoTen, khKhachHang.DienThoai FROM khNhatKyCongNo INNER JOIN khKhachHang ON khNhatKyCongNo.IDKhachHang = khKhachHang.IDKhachHang WHERE (khNhatKyCongNo.NgayNhap &lt;= DATEADD(day, 1, @DenNgay)) AND (khNhatKyCongNo.NgayNhap &gt;= @TuNgay) AND (khKhachHang.LoaiKhachHangID &lt;&gt; 2)" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="formThongTin$fromDay" Name="TuNgay" PropertyName="Value" ConvertEmptyStringToNull="true" DefaultValue=""  />
            <asp:ControlParameter ControlID="formThongTin$toDay" Name="DenNgay" PropertyName="Value" ConvertEmptyStringToNull="true" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridChiTietCongNo">
    </dx:ASPxGridViewExporter>
</asp:Content>
