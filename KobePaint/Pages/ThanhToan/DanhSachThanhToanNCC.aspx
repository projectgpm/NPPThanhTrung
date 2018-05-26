<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachThanhToanNCC.aspx.cs" Inherits="KobePaint.Pages.ThanhToan.DanhSachThanhToanNCC" %>
<%@ Register Assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function onPrintClick(idPhieu) {
            popupViewReport.Show();
            cbpViewReport.PerformCallback(idPhieu);
        }
        function onEndCallBackViewRp() {
            reportViewer.GetViewer().Refresh();
        }
        function ccbHienThiSelectChange() {
            if (ccbHienThi.GetValue() == 0) {
                gridThanhToan.CollapseAll();
            }
            else {
                gridThanhToan.ExpandAll()
            }
        }
    </script>
    <dx:ASPxFormLayout ID="flThongTin" runat="server" ClientInstanceName="flThongTin" ColCount="2">
        <Items>
            <dx:LayoutItem ShowCaption="False">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                        <dx:ASPxButton ID="btnXuatExcel" runat="server" ClientInstanceName="btnXuatExcel" Text="Xuất Excel" OnClick="btnXuatExcel_Click">
                        </dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem Caption="Hiển thị">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                        <dx:ASPxComboBox ID="ccbHienThi" runat="server" ClientInstanceName="ccbHienThi" SelectedIndex="0">
                            <Items>
                                <dx:ListEditItem Text="Thu gọn các hàng" Value="0" />
                                <dx:ListEditItem Text="Mở rộng các hàng" Value="1" />
                            </Items>
                            <ClientSideEvents SelectedIndexChanged="ccbHienThiSelectChange" />
                        </dx:ASPxComboBox>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
        </Items>
    </dx:ASPxFormLayout>
     <dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridThanhToan">
    </dx:ASPxGridViewExporter>
    <dx:ASPxGridView ID="gridThanhToan" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridThanhToan" DataSourceID="dsPhieuThu" KeyFieldName="IDPhieuThu" Width="100%">
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowTitlePanel="false" />
        <SettingsBehavior AutoExpandAllGroups="True" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <UpdateButton RenderMode="Image">
                <Image IconID="save_save_32x32" ToolTip="Lưu tất cả thay đổi">
                </Image>
            </UpdateButton>
            <CancelButton RenderMode="Image">
                <Image IconID="actions_close_32x32">
                </Image>
            </CancelButton>
            <EditButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_edit_16x16devav">
                </Image>
            </EditButton>
        </SettingsCommandButton>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" PopupEditFormCaption="Cập nhật mã hóa đơn" Title="DANH SÁCH THANH TOÁN NHÀ CUNG CẤP" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="IDPhieuThu" ReadOnly="True" Visible="False" VisibleIndex="0">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="STTPhieuThu" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" Width="50px">
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Hóa đơn" FieldName="SoHoaDon" VisibleIndex="2" Width="120px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Nội dung" FieldName="NoiDung" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày thu" FieldName="NgayThu" VisibleIndex="3" Width="100px">
                <EditFormSettings Visible="False" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                    <CalendarProperties FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" ClearButtonText="Hủy">
                        <FastNavProperties Enabled="False" />
                    </CalendarProperties>
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Khách hàng" FieldName="KhachHangID" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="4" Width="150px">
                <PropertiesComboBox DataSourceID="dsKhachHang" TextField="HoTen" ValueField="IDKhachHang">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="Nhân viên thu" FieldName="NhanVienThuID" VisibleIndex="7" Width="150px">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="IDNhanVien">
                </PropertiesComboBox>
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataComboBoxColumn>
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
            
            <dx:GridViewDataSpinEditColumn Caption="Số tiền thu" FieldName="SoTienThu" VisibleIndex="6" Width="120px" CellStyle-Font-Bold="true">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Hình thức thanh toán" FieldName="HinhThucTTID" VisibleIndex="8" Width="200px">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Công nợ giảm dần" Value="1" />
                        <dx:ListEditItem Text="Theo phiếu giao hàng" Value="2" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            
        </Columns>
         <GroupSummary>
            <dx:ASPxSummaryItem DisplayFormat="Tổng = {0:N0}" FieldName="SoTienThu"   SummaryType="Sum" />
        </GroupSummary>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsPhieuThu" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT IDPhieuThu, STTPhieuThu, SoHoaDon, KhachHangID, SoTienThu, NoiDung, NgayThu, NhanVienThuID, HinhThucTTID, CongNoCu, NgayLap FROM kPhieuThanhToanNCC ORDER BY IDPhieuThu DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDKhachHang], [HoTen] FROM [khKhachHang] WHERE LoaiKhachHangID =2"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien]  WHERE IDNhanVien > 1"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridThanhToan);                          
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridThanhToan);                      
        }" />
    </dx:ASPxGlobalEvents>
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
