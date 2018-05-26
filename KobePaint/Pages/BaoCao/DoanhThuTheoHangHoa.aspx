<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DoanhThuTheoHangHoa.aspx.cs" Inherits="KobePaint.Pages.BaoCao.DoanhThuTheoHangHoa" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function AdjustSize() {
            var hformThongTin = formThongTin.GetHeight();
            UpdateHeightControlInPage(gridDoanhThu, hformThongTin);
        }
        function onXemBaoCaoClick() {
            gridDoanhThu.Refresh();
        }
    </script>
    <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
        <Items>
            <dx:LayoutGroup Caption="Báo cáo doanh thu theo hàng hóa" ColCount="6" HorizontalAlign="Center" Width="100%">
                <Items>
                    <dx:LayoutItem Caption="Nhóm khách hàng">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                <dx:ASPxComboBox ID="ccbLoaiKH" ClientInstanceName="ccbLoaiKH" runat="server" DataSourceID="dsLoaiKH" TextField="TenLoaiKhachHang" ValueField="IDLoaiKhachHang" NullText="Chọn nhóm" SelectedIndex="0" Width="100%">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { ccbKhachHang.PerformCallback(); }" />
                                </dx:ASPxComboBox>
                                <asp:SqlDataSource ID="dsLoaiKH" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT 0 AS IDLoaiKhachHang, N'Tất cả' AS TenLoaiKhachHang UNION ALL SELECT IDLoaiKhachHang, TenLoaiKhachHang FROM khLoaiKhachHang WHERE (DaXoa = 0) AND (IDLoaiKhachHang &lt;&gt; 2)"></asp:SqlDataSource>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Khách hàng">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                <dx:ASPxComboBox ID="ccbKhachHang" ClientInstanceName="ccbKhachHang" runat="server" DataSourceID="dsKhachHangTheoLoai" DisplayFormatString="{0}" TextField="HoTen" ValueField="IDKhachHang" OnCallback="ccbKhachHang_Callback" SelectedIndex="0" Width="100%">
                                    <Columns>
                                        <dx:ListBoxColumn Caption="Họ tên" FieldName="HoTen" />
                                        <dx:ListBoxColumn Caption="Điện thoại" FieldName="DienThoai" />
                                    </Columns>                                    
                                </dx:ASPxComboBox>
                                <asp:SqlDataSource ID="dsKhachHangTheoLoai" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT 0 AS IDKhachHang, N'Tất cả' AS HoTen, '' AS DienThoai UNION ALL SELECT IDKhachHang, HoTen, DienThoai FROM khKhachHang WHERE (@LoaiKhachHangID = 0 OR LoaiKhachHangID = @LoaiKhachHangID) AND (LoaiKhachHangID &lt;&gt; 2) AND (DaXoa = 0)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="formThongTin$ccbLoaiKH" Name="LoaiKhachHangID" PropertyName="Value" Type="Int32" DefaultValue="0" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Từ ngày">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                <dx:ASPxDateEdit ID="fromDay" runat="server" OnInit="dateEditControl_Init" Width="100%">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="đến ngày">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                <dx:ASPxDateEdit ID="toDay" runat="server" OnInit="dateEditControl_Init" Width="100%">
                                    <DateRangeSettings StartDateEditID="fromDay" />
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Xem báo cáo" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                <dx:ASPxButton ID="btnXemBaoCao" runat="server" Text="Xem báo cáo" AutoPostBack="false" Width="100%">
                                    <ClientSideEvents Click="onXemBaoCaoClick" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Xuất excel" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server">
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
    <dx:ASPxGridView ID="gridDoanhThu" ClientInstanceName="gridDoanhThu" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="dsDoanhThuHangHoa" KeyFieldName="IDHangHoa" OnCustomColumnDisplayText="gridDoanhThu_CustomColumnDisplayText" OnHtmlRowPrepared="gridDoanhThu_HtmlRowPrepared">
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowHeaderFilterButton="true"/>
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsText HeaderFilterCancelButton="Hủy" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" PopupEditFormCaption="Cập nhật mã hóa đơn"  EmptyDataRow="Không có dữ liệu" CommandCancel="Hủy" ConfirmDelete="Bạn có chắc chắn muốn xóa?" HeaderFilterFrom="Từ" HeaderFilterLastMonth="Tháng trước" HeaderFilterLastWeek="Tuần trước" HeaderFilterLastYear="Năm trước" HeaderFilterNextMonth="Tháng sau" HeaderFilterNextWeek="Tuần sau" HeaderFilterNextYear="Năm sau" HeaderFilterOkButton="Lọc" HeaderFilterSelectAll="Chọn tất cả" HeaderFilterShowAll="Tất cả" HeaderFilterShowBlanks="Trống" HeaderFilterShowNonBlanks="Không trống" HeaderFilterThisMonth="Tháng này" HeaderFilterThisWeek="Tuần này" HeaderFilterThisYear="Năm nay" HeaderFilterTo="Đến" HeaderFilterToday="Hôm nay" HeaderFilterTomorrow="Ngày mai" HeaderFilterYesterday="Ngày hôm qua" />
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="IDHangHoa" ReadOnly="True" VisibleIndex="0" Width="50px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tên hàng hóa" FieldName="TenHangHoa" VisibleIndex="2" Width="100%">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Số lượng" FieldName="SOLUONG" ReadOnly="True" VisibleIndex="3" Width="150px" CellStyle-Font-Bold="true">
                <PropertiesTextEdit DisplayFormatString="N0">
                </PropertiesTextEdit>
                <Settings AllowHeaderFilter="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn Caption="Doanh thu" FieldName="DOANHTHU" ReadOnly="True" VisibleIndex="4" Width="200px" CellStyle-Font-Bold="true">
                <PropertiesSpinEdit DisplayFormatString="N0" Increment="100000" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <Settings AllowHeaderFilter="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn Caption="Mã hàng" FieldName="MaHang" VisibleIndex="1" Width="150px">
                <SettingsHeaderFilter Mode="CheckedList"></SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="DOANHTHU" ShowInGroupFooterColumn="Doanh thu" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="Tổng: {0}" FieldName="SOLUONG" ShowInGroupFooterColumn="Số lượng" SummaryType="Sum" />
        </TotalSummary>        
        <Styles>
            <Header HorizontalAlign="Center">
            </Header>
            <GroupRow Font-Bold="True" ForeColor="#009933">
            </GroupRow>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsDoanhThuHangHoa" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="spDoanhThuTheoHangHoa" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
        <SelectParameters>
            <asp:ControlParameter ControlID="formThongTin$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" ConvertEmptyStringToNull="true" DefaultValue="" />
            <asp:ControlParameter ControlID="formThongTin$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" ConvertEmptyStringToNull="true" DefaultValue="" />
            <asp:ControlParameter ControlID="formThongTin$ccbKhachHang" Name="IDKhachHang" DefaultValue="0" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridDoanhThu">
    </dx:ASPxGridViewExporter>
</asp:Content>
