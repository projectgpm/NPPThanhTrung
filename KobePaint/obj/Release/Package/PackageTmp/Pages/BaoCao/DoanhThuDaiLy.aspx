<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DoanhThuDaiLy.aspx.cs" Inherits="KobePaint.Pages.BaoCao.DoanhThuDaiLy" %>
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
             //if (checkInput())
                 gridChiTietCongNo.Refresh();
         }
         function checkInput() {
             if (ccbKhachHang.GetSelectedIndex() == -1) {
                 alert('Vui lòng chọn khách hàng!!');
                 ccbKhachHang.Focus();
                 return false;
             }
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
            <dx:LayoutGroup Caption="Báo cáo doanh thu" ColCount="5" HorizontalAlign="Center" Width="100%">
                <Items>
                    <dx:LayoutItem Caption="Khách hàng">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                <dx:ASPxComboBox ID="ccbKhachHang" ClientInstanceName="ccbKhachHang" runat="server" DataSourceID="dsKhachHang" DisplayFormatString="{0};{1}" TextField="HoTen" ValueField="IDKhachHang" NullText="---Chọn khách hàng---" Width="100%" DropDownStyle="DropDown">
                                    <Columns>
                                        <dx:ListBoxColumn Caption="Mã khách hàng" FieldName="MaKhachHang" />
                                        <dx:ListBoxColumn Caption="Họ tên" FieldName="HoTen" />
                                    </Columns>
                                </dx:ASPxComboBox>
                                <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDKhachHang], [HoTen], [MaKhachHang] FROM [khKhachHang] WHERE [LoaiKhachHangID] <> 2"></asp:SqlDataSource>
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
   <dx:ASPxGridView ID="gridChiTiet" ClientInstanceName="gridChiTietCongNo" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTiet" Width="100%" OnCustomColumnDisplayText="grid_CustomColumnDisplayText" KeyFieldName="IDKhachHang">
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
            <dx:GridViewDataDateColumn Caption="Ngày duyệt" FieldName="NGAYDUYET" VisibleIndex="6" ReadOnly="True">
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
            <dx:GridViewDataTextColumn Caption="Mã phiếu" FieldName="MAPHIEU" VisibleIndex="4" ReadOnly="True" Width="110px">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="STT" VisibleIndex="0" Width="50px" FieldName="IDKhachHang">
                <Settings AllowAutoFilter="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Khách hàng" FieldName="HoTen" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn Caption="Số tiền" FieldName="TONGTIEN" VisibleIndex="7" CellStyle-Font-Bold="true">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>

<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn Caption="Mã khách hàng" FieldName="MaKhachHang" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="STT phiếu" FieldName="STT" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="N0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn Caption="Giảm giá" FieldName="GIAMGIA" VisibleIndex="8">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="TONGTIEN" Expression="[TONGTIEN] < 1" Format="LightRedFillWithDarkRedText" />
            <dx:GridViewFormatConditionHighlight FieldName="TONGTIEN" Expression="[TONGTIEN] > 0" Format="GreenFillWithDarkGreenText" />
            <dx:GridViewFormatConditionTopBottom FieldName="TONGTIEN" Rule="TopItems" Threshold="15" Format="BoldText" CellStyle-HorizontalAlign="Center">
                <CellStyle HorizontalAlign="Center"></CellStyle>
            </dx:GridViewFormatConditionTopBottom>
        </FormatConditions>
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="TONGTIEN" ShowInColumn="Số tiền" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="GIAMGIA" ShowInGroupFooterColumn="Giảm giá" SummaryType="Sum" />
        </TotalSummary>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="dsChiTiet" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="spDoanhThuDaiLy" SelectCommandType="StoredProcedure">
        <SelectParameters>
             <asp:ControlParameter ControlID="formThongTin$ccbKhachHang" Name="IDKhachHang" DefaultValue="-1"  PropertyName="Value" />
            <asp:ControlParameter ControlID="formThongTin$fromDay" Name="TuNgay" DefaultValue="2018-01-01" PropertyName="Value" />
            <asp:ControlParameter ControlID="formThongTin$toDay" Name="DenNgay" DefaultValue="2018-01-01"   PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
   
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridChiTiet">
    </dx:ASPxGridViewExporter>
</asp:Content>
