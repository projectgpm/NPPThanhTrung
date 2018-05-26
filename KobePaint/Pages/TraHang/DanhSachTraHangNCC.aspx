<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachTraHangNCC.aspx.cs" Inherits="KobePaint.Pages.TraHang.DanhSachTraHangNCC" %>
<%@ Register Assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <script>
            function onPrintClick(idPhieu) {
                popupViewReport.Show();
                cbpViewReport.PerformCallback(idPhieu);
            }
            function onEndCallBackViewRp() {
                hdfViewReport.Set('view', '1');
                reportViewer.GetViewer().Refresh();
            }
            function onTabChanged(s, e) {
                if (e.tab.name == 'CoGia') {
                    hdfViewReport.Set('view', '1');
                    reportViewer.GetViewer().Refresh();
                }
                else {
                    hdfViewReport.Set('view', '2');
                    reportViewer.GetViewer().Refresh();
                }
            }
    </script>
    <dx:ASPxGridView ID="gridTraHang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridTraHang" Width="100%" DataSourceID="dsTraHang" KeyFieldName="IDPhieuTraHang" OnCustomColumnDisplayText="gridTraHang_CustomColumnDisplayText">
        <SettingsEditing EditFormColumnCount="3">
        </SettingsEditing>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <Templates>
            <DetailRow>
                <div style="padding-top:0px; padding-bottom: 14px;">
                    <dx:ASPxLabel ID="lblChiTietHang" runat="server" Text="Chi tiết trả hàng" Font-Bold="True" ForeColor="#009933" Font-Italic="True" Font-Size="16px" Font-Underline="True">
                </dx:ASPxLabel>
                </div>
                <dx:ASPxGridView ID="gridChiTiet" runat="server" AutoGenerateColumns="False" DataSourceID="dsTraHangChiTiet" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTiet_BeforePerformDataSelect" Width="100%" OnCustomColumnDisplayText="gridChiTiet_CustomColumnDisplayText">
                    <SettingsPager Mode="ShowAllRecords">
                    </SettingsPager>
                    <SettingsCommandButton>
                        <ShowAdaptiveDetailButton ButtonType="Image">
                        </ShowAdaptiveDetailButton>
                        <HideAdaptiveDetailButton ButtonType="Image">
                        </HideAdaptiveDetailButton>
                    </SettingsCommandButton>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Caption="STT" Width="50px" ShowInCustomizationForm="True">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TenHangHoa" VisibleIndex="2" Caption="Hàng hóa" ShowInCustomizationForm="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MaHang" VisibleIndex="1" Caption="Mã HH" Width="80px" ShowInCustomizationForm="True">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="ThanhTien" VisibleIndex="7" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Số lượng" FieldName="SoLuong" VisibleIndex="6" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Giá vốn" FieldName="GiaVon" VisibleIndex="4" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Tồn kho" FieldName="TonKho" VisibleIndex="3" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Tiền trả" FieldName="TienTra" VisibleIndex="5" Width="100px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        
                    </Columns>

                    <FormatConditions>
                        <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] < 1" Format="LightRedFillWithDarkRedText" />
                            <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] > 0" Format="GreenFillWithDarkGreenText" />
                        <dx:GridViewFormatConditionTopBottom FieldName="TonKho" Rule="TopItems" Threshold="15" Format="BoldText"  CellStyle-HorizontalAlign="Center">
    <CellStyle HorizontalAlign="Center"></CellStyle>
                            </dx:GridViewFormatConditionTopBottom>
                    </FormatConditions>
                    <Styles>
                        <AlternatingRow Enabled="True">
                        </AlternatingRow>                    
                        <Header BackColor="White" Font-Bold="False" HorizontalAlign="Center">
                            <Border BorderStyle="Dashed" />
                        </Header>
                        <Cell>
                            <Border BorderStyle="Dashed" />
                        </Cell>
                    </Styles>
                    <Border BorderColor="Silver" BorderStyle="Solid" />
                    <Border BorderStyle="Solid" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsTraHangChiTiet" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT hhHangHoa.MaHang, hhHangHoa.TenHangHoa, kPhieuTraHangNCCChiTiet.GiaVon, kPhieuTraHangNCCChiTiet.SoLuong, kPhieuTraHangNCCChiTiet.ThanhTien, kPhieuTraHangNCCChiTiet.TonKho, kPhieuTraHangNCCChiTiet.TienTra, kPhieuTraHangNCCChiTiet.ID FROM kPhieuTraHangNCCChiTiet INNER JOIN hhHangHoa ON kPhieuTraHangNCCChiTiet.HangHoaID = hhHangHoa.IDHangHoa WHERE (kPhieuTraHangNCCChiTiet.PhieuTraHangNCCID = @PhieuTraHangNCCID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="PhieuTraHangNCCID" SessionField="PhieuTraHangNCCID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xác nhận xóa !!" Title="DANH SÁCH TRẢ HÀNG NHÀ CUNG CẤP" />
        <Styles>
            <Header HorizontalAlign="Center">
            </Header>
            <GroupRow ForeColor="#428BCA">
            </GroupRow>
            <Cell>
                <Paddings PaddingBottom="3px" PaddingTop="3px" />
            </Cell>
            <GroupPanel>
                <Paddings Padding="0px" />
            </GroupPanel>
            <FilterCell>
                <Paddings Padding="0px" />
            </FilterCell>
            <SearchPanel>
                <Paddings PaddingBottom="5px" PaddingTop="5px" />
            </SearchPanel>
        </Styles>
        <Paddings Padding="0px" />
        <SettingsBehavior AutoExpandAllGroups="True" ConfirmDelete="True" AllowSelectByRowClick="True" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <NewButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_add_16x16">
                </Image>
            </NewButton>
            <UpdateButton ButtonType="Image" RenderMode="Image">
                <Image IconID="save_save_32x32" ToolTip="Lưu">
                </Image>
            </UpdateButton>
            <CancelButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_close_32x32" ToolTip="Hủy">
                </Image>
            </CancelButton>
            <EditButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_edit_16x16devav" ToolTip="Cập nhật số hóa đơn">
                </Image>
            </EditButton>
            <DeleteButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_cancel_16x16" ToolTip="Xóa phiếu nhập hàng">
                </Image>
            </DeleteButton>
        </SettingsCommandButton>
        <EditFormLayoutProperties ColCount="2">
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" ReadOnly="True" VisibleIndex="0" FieldName="IDPhieuTraHang" Width="50px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mã phiếu" FieldName="MaPhieu" VisibleIndex="1" Width="90px" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Center">
                <%--<DataItemTemplate>
                     <a target="_blank" href="<%# Eval("Url") %>" > <%# Eval("MaPhieu") %></a>
                </DataItemTemplate>--%>
<CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Nhà cung cấp" FieldName="NhaCungCapID" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="dsNhaCC" TextField="HoTen" ValueField="IDKhachHang">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn Caption="Ngày trả" FieldName="NgayTra" VisibleIndex="4" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" DisplayFormatInEditMode="True">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Người nhập" FieldName="NhanVienID" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="IDNhanVien">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="TongSoLuong" VisibleIndex="6" Width="50px" CellStyle-HorizontalAlign="Center">
                <PropertiesSpinEdit DisplayFormatString="N0">
                </PropertiesSpinEdit>

<CellStyle HorizontalAlign="Center"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tổng tiền" FieldName="TongTienHang" VisibleIndex="7" CellStyle-Font-Bold="true" Width="100px"> 
                <PropertiesSpinEdit DisplayFormatString="N0" >
                </PropertiesSpinEdit>

<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Nợ" FieldName="ConLai" VisibleIndex="8" Width="100px">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataMemoColumn Caption="Ghi chú" FieldName="GhiChu" VisibleIndex="9">
            </dx:GridViewDataMemoColumn>
             <dx:GridViewDataTextColumn Caption="In phiếu" VisibleIndex="12" Width="80px">
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

        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="TrangThaiPhieu" Expression="[TrangThaiPhieu] = 0" Format="GreenFillWithDarkGreenText" />
            <dx:GridViewFormatConditionHighlight FieldName="TrangThaiPhieu" Expression="[TrangThaiPhieu] = 1" Format="YellowFillWithDarkYellowText" />
            <dx:GridViewFormatConditionHighlight FieldName="TrangThaiPhieu" Expression="[TrangThaiPhieu] = 2" Format="LightRedFillWithDarkRedText" />
            <dx:GridViewFormatConditionHighlight FieldName="CongNo" Expression="[CongNo] > 0" Format="RedText" />

            <dx:GridViewFormatConditionTopBottom FieldName="TonKho" Rule="TopItems" Threshold="15" Format="BoldText"  CellStyle-HorizontalAlign="Center">
                <CellStyle HorizontalAlign="Center"></CellStyle>
                </dx:GridViewFormatConditionTopBottom>
        </FormatConditions>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsTraHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT * FROM [kPhieuTraHangNCC] ORDER BY [IDPhieuTraHang] DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhaCC" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDKhachHang], [HoTen] FROM [khKhachHang] WHERE [LoaiKhachHangID] = 2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien]  WHERE IDNhanVien > 1"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridTraHang);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridTraHang);
        }" />
    </dx:ASPxGlobalEvents>
     <dx:ASPxPopupControl ID="popupViewReport" ClientInstanceName="popupViewReport" runat="server" HeaderText="Phiếu đại lý trả hàng" Width="800px" Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter" >
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxCallbackPanel ID="cbpViewReport" ClientInstanceName="cbpViewReport" runat="server" Width="100%" OnCallback="cbpViewReport_Callback">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxTabControl ID="ASPxTabControl1" runat="server" ActiveTabIndex="0">
                                <tabs>
                                    <dx:Tab Text="Phiếu trả hàng" Name="CoGia">
                                    </dx:Tab>
                                    <dx:Tab Text="Phiếu trả hàng (không có giá bán)" Name="KhongGia">
                                    </dx:Tab>
                                </tabs>
                                <clientsideevents activetabchanged="onTabChanged" />
                                <tabstyle>
                                    <paddings padding="5px" />
                                </tabstyle>
                                <ActiveTabStyle Font-Bold="True" ForeColor="#1F77C0">
                                </ActiveTabStyle>
                            </dx:ASPxTabControl>
                            <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server">
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
