<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachGiaoHang.aspx.cs" Inherits="KobePaint.Pages.GiaoHang.DanhSachGiaoHang" %>

<%@ Register Assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function onPrintClick(idPhieu) {
            popupViewReport.Show();
            //reportViewer.GetViewer().Refresh();
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
    <dx:ASPxGridView ID="gridGiaoHang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridGiaoHang" Width="100%" DataSourceID="dsGiaohang" KeyFieldName="IDPhieuGiaoHang" OnCustomColumnDisplayText="gridGiaoHang_CustomColumnDisplayText" OnRowDeleting="gridGiaoHang_RowDeleting">
        <SettingsEditing EditFormColumnCount="3">
        </SettingsEditing>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True" ShowFooter="True"/>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <Templates>
            <DetailRow>
                <div style="padding-top:0px; padding-bottom: 14px;">
                    <dx:ASPxLabel ID="lblChiTietHang" runat="server" Text="Chi tiết đơn hàng" Font-Bold="True" ForeColor="#009933" Font-Italic="True" Font-Size="16px" Font-Underline="True">
                </dx:ASPxLabel>
                </div>
                <dx:ASPxGridView ID="gridChiTietDonHang" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTietDonHang" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTietDonHang_BeforePerformDataSelect" Width="100%" OnCustomColumnDisplayText="gridChiTietDonHang_CustomColumnDisplayText">
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
                        <dx:GridViewDataSpinEditColumn Caption="Giá bán" FieldName="GiaBan" VisibleIndex="5" Width="100px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                    </Columns>

                    <FormatConditions>
                        <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] < 1" Format="LightRedFillWithDarkRedText" />
                        <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] > 0" Format="GreenFillWithDarkGreenText" />
                        <dx:GridViewFormatConditionHighlight FieldName="TenHangHoa" Expression="[GiaVon] > [GiaBan]" Format="LightRedFillWithDarkRedText" CellStyle-Font-Italic="true" />
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
                <asp:SqlDataSource ID="dsChiTietDonHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
                    SelectCommand="SELECT hhHangHoa.MaHang, hhHangHoa.TenHangHoa, ghPhieuGiaoHangChiTiet.HangHoaID, ghPhieuGiaoHangChiTiet.ID, ghPhieuGiaoHangChiTiet.TonKho, ghPhieuGiaoHangChiTiet.SoLuong, ghPhieuGiaoHangChiTiet.GiaBan, ghPhieuGiaoHangChiTiet.ThanhTien, ghPhieuGiaoHangChiTiet.GiaVon FROM ghPhieuGiaoHangChiTiet INNER JOIN hhHangHoa ON ghPhieuGiaoHangChiTiet.HangHoaID = hhHangHoa.IDHangHoa WHERE (ghPhieuGiaoHangChiTiet.PhieuGiaoHangID = @PhieuGiaoHangID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="PhieuGiaoHangID" SessionField="PhieuGiaoHangID" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xác nhận xóa !!" Title="DANH SÁCH GIAO HÀNG" />
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
                <Image IconID="actions_edit_16x16devav" ToolTip="Cập nhật địa chỉ giao hàng">
                </Image>
            </EditButton>
            <DeleteButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_cancel_16x16" ToolTip="Xóa phiếu nhập hàng">
                </Image>
            </DeleteButton>
        </SettingsCommandButton>
        <EditFormLayoutProperties ColCount="2">
            <Items>
                <dx:GridViewColumnLayoutItem ColumnName="Điện thoại">
                </dx:GridViewColumnLayoutItem>
                <dx:GridViewColumnLayoutItem ColumnName="Ngày giao">
                </dx:GridViewColumnLayoutItem>
                <dx:GridViewColumnLayoutItem ColumnName="Ghi chú đơn hàng">
                </dx:GridViewColumnLayoutItem>
                <dx:GridViewColumnLayoutItem ColumnName="Số hóa đơn">
                </dx:GridViewColumnLayoutItem>
                <dx:GridViewColumnLayoutItem ColSpan="2" ColumnName="Địa chỉ giao hàng">
                </dx:GridViewColumnLayoutItem>
                <dx:EditModeCommandLayoutItem ColSpan="2" HorizontalAlign="Right">
                </dx:EditModeCommandLayoutItem>
            </Items>
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" ReadOnly="True" VisibleIndex="0" FieldName="IDPhieuGiaoHang" Width="50px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn Caption="Cập nhật" ShowEditButton="True" VisibleIndex="12" Width="100px">
                 
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Mã phiếu" FieldName="MaPhieu" VisibleIndex="1" Width="110px" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Center">
<CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày tạo" FieldName="NgayTao" VisibleIndex="4" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" DisplayFormatInEditMode="True">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Người bán" FieldName="NhanVienID" VisibleIndex="5" Width="150px">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="IDNhanVien">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="TongSoLuong" VisibleIndex="6" Width="50px" CellStyle-HorizontalAlign="Center">
                <PropertiesSpinEdit DisplayFormatString="N0">
                </PropertiesSpinEdit>

<CellStyle HorizontalAlign="Center"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tổng tiền" FieldName="TongTien" VisibleIndex="7" CellStyle-Font-Bold="true" Width="100px"> 
                <PropertiesSpinEdit DisplayFormatString="N0" >
                </PropertiesSpinEdit>

<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="TrangThai" VisibleIndex="11" Width="100px" CellStyle-HorizontalAlign="Center">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Đã đặt" Value="0" />
                        <dx:ListEditItem Text="Giao hàng" Value="1" />
                        <dx:ListEditItem Text="Đã hủy" Value="2" />
                        <dx:ListEditItem Text="Bán hàng" Value="3" />
                    </Items>
                </PropertiesComboBox>

<CellStyle HorizontalAlign="Center"></CellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="Khách hàng" FieldName="KhachHangID" VisibleIndex="2" Width="150px">
                <PropertiesComboBox DataSourceID="dsKhachHang" TextField="HoTen" ValueField="IDKhachHang">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Ghi chú đơn hàng" FieldName="GhiChuGiaoHang" VisibleIndex="14" Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày giao" FieldName="NgayGiao" VisibleIndex="10" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataMemoColumn Caption="Địa chỉ giao hàng" FieldName="DiaChiGiaoHang" VisibleIndex="9" Width="100%">
            </dx:GridViewDataMemoColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" VisibleIndex="3" Width="100px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Số hóa đơn" FieldName="SoHoaDon" Visible="False" VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="In phiếu" VisibleIndex="13" Width="80px">
                <DataItemTemplate>
                    <dx:ASPxButton ID="btnInPhieu" runat="server" RenderMode="Link" OnInit="btnInPhieu_Init" AutoPostBack="false">
                        <Image IconID="print_print_16x16">
                        </Image>
                    </dx:ASPxButton>
                </DataItemTemplate>
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn Caption="Giảm giá" FieldName="GiamGia" VisibleIndex="8" Width="100px">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
        </Columns>

        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="TongTien" ShowInColumn="Tổng tiền" SummaryType="Sum" />
        </TotalSummary>

        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="TrangThai" Expression="[TrangThai] = 0" Format="YellowFillWithDarkYellowText" />
            <dx:GridViewFormatConditionHighlight FieldName="TrangThai" Expression="[TrangThai] = 1" Format="GreenFillWithDarkGreenText" />
            <dx:GridViewFormatConditionHighlight FieldName="TrangThai" Expression="[TrangThai] = 2" Format="LightRedFillWithDarkRedText" />
        </FormatConditions>
    </dx:ASPxGridView>
     <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
         SelectCommand="SELECT [IDKhachHang], [HoTen] FROM [khKhachHang] WHERE LoaiKhachHangID <> 2 ORDER BY [IDKhachHang] DESC ">

     </asp:SqlDataSource>
     <asp:SqlDataSource ID="dsGiaohang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
         SelectCommand="SELECT IDPhieuGiaoHang, NgayTao, MaPhieu, NhanVienID, GhiChuGiaoHang, KhachHangID, NgayGiao, NguoiGiao, DiaChiGiaoHang, DaXoa, TrangThai, TongSoLuong, TongTien, DienThoai, SoHoaDon, TTThanhToan, ThanhToan, ConLai, STTDonHang, SoDonHangTrongNam, CongNoHienTai, NgayDuyet, GiamGia FROM ghPhieuGiaoHang WHERE (@Quyen &lt;&gt; 3) OR (NhanVienID = @NhanVienID) ORDER BY IDPhieuGiaoHang DESC" 
         UpdateCommand="UPDATE ghPhieuGiaoHang SET   SoHoaDon = @SoHoaDon,DienThoai = @DienThoai,NgayGiao = @NgayGiao, DiaChiGiaoHang = @DiaChiGiaoHang, GhiChuGiaoHang = @GhiChuGiaoHang WHERE (IDPhieuGiaoHang = @IDPhieuGiaoHang)">
         <SelectParameters>
             <asp:Parameter DefaultValue="3" Name="Quyen" />
             <asp:Parameter DefaultValue="1" Name="NhanVienID" />
         </SelectParameters>
         <UpdateParameters>
             <asp:Parameter Name="DienThoai" />
             <asp:Parameter Name="SoHoaDon" />
             <asp:Parameter Name="NgayGiao" />
             <asp:Parameter Name="DiaChiGiaoHang" />
             <asp:Parameter Name="GhiChuGiaoHang" />
             <asp:Parameter Name="IDPhieuGiaoHang" />
         </UpdateParameters>
     </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien]  WHERE IDNhanVien > 1"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridGiaoHang);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridGiaoHang);
        }" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxPopupControl ID="popupViewReport" ClientInstanceName="popupViewReport" runat="server" HeaderText="Phiếu giao hàng đại lý" Width="850px" Height="600px" ScrollBars="Auto" PopupVerticalAlign="WindowCenter" ShowHeader="false" PopupHorizontalAlign="WindowCenter" >
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxCallbackPanel ID="cbpViewReport" ClientInstanceName="cbpViewReport" runat="server" Width="100%" OnCallback="cbpViewReport_Callback">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxTabControl ID="ASPxTabControl1" runat="server" ActiveTabIndex="0">
                                <tabs>
                                    <dx:Tab Text="Phiếu giao hàng" Name="CoGia">
                                    </dx:Tab>
                                    <dx:Tab Text="Phiếu giao hàng (không có giá bán)" Name="KhongGia">
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
