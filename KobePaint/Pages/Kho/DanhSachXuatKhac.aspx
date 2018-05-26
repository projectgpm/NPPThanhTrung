<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachXuatKhac.aspx.cs" Inherits="KobePaint.Pages.Kho.DanhSachXuatKhac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <dx:ASPxGridView ID="gridXuathang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridXuathang" Width="100%" DataSourceID="dsXuatKho" KeyFieldName="IDPhieuXuat" OnCustomColumnDisplayText="gridXuathang_CustomColumnDisplayText" OnRowDeleting="gridXuathang_RowDeleting">
        <SettingsEditing EditFormColumnCount="3">
        </SettingsEditing>
        <Settings VerticalScrollableHeight="600" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <Templates>
            <DetailRow>
                <div style="padding-top:0px; padding-bottom: 14px;">
                    <dx:ASPxLabel ID="lblChiTietHang" runat="server" Text="Chi tiết xuất hàng" Font-Bold="True" ForeColor="#009933" Font-Italic="True" Font-Size="16px" Font-Underline="True">
                </dx:ASPxLabel>
                </div>
                <dx:ASPxGridView ID="gridChiTietXuatKho" runat="server" AutoGenerateColumns="False" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTietXuatKho_BeforePerformDataSelect" Width="100%" OnCustomColumnDisplayText="gridChiTietXuatKho_CustomColumnDisplayText" DataSourceID="dsChiTietXuatKho">
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
                        <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="ThanhTien" VisibleIndex="6" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Số lượng" FieldName="SoLuong" VisibleIndex="5" Width="80px">
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
                        <dx:GridViewDataTextColumn Caption="Lý do xuất" FieldName="LyDoXuat" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
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
                <asp:SqlDataSource ID="dsChiTietXuatKho" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT kPhieuXuatKhacChiTiet.TonKho, kPhieuXuatKhacChiTiet.SoLuong, kPhieuXuatKhacChiTiet.GiaVon, kPhieuXuatKhacChiTiet.ThanhTien, hhHangHoa.MaHang, hhHangHoa.TenHangHoa, kLyDoXuatKhac.LyDoXuat, kPhieuXuatKhacChiTiet.ID FROM kPhieuXuatKhacChiTiet INNER JOIN kLyDoXuatKhac ON kPhieuXuatKhacChiTiet.LyDoXuatID = kLyDoXuatKhac.IDPhieuXuatKhac INNER JOIN hhHangHoa ON kPhieuXuatKhacChiTiet.HangHoaID = hhHangHoa.IDHangHoa WHERE (kPhieuXuatKhacChiTiet.PhieuXuatID = @PhieuXuatID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="PhieuXuatID" SessionField="PhieuXuatID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xác nhận xóa !!" Title="DANH SÁCH XUẤT KHÁC" />
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
                <Image IconID="actions_edit_16x16devav" ToolTip="Cập nhật ghi chú">
                </Image>
            </EditButton>
            <DeleteButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_cancel_16x16" ToolTip="Xóa phiếu xuất hàng">
                </Image>
            </DeleteButton>
        </SettingsCommandButton>
        <EditFormLayoutProperties ColCount="2">
            <Items>
                <dx:GridViewColumnLayoutItem ColumnName="Ghi chú" ColSpan="2" RowSpan="3">
                </dx:GridViewColumnLayoutItem>
                <dx:EditModeCommandLayoutItem ColSpan="2" HorizontalAlign="Right">
                </dx:EditModeCommandLayoutItem>
            </Items>
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" ReadOnly="True" VisibleIndex="0" FieldName="IDPhieuXuat" Width="50px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn Caption="Cập nhật" ShowEditButton="True" VisibleIndex="10" Width="100px" ShowDeleteButton="True">
                 
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Mã phiếu" FieldName="MaPhieuXuat" VisibleIndex="1" Width="90px" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Center">
<CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày lập" FieldName="NgayLap" VisibleIndex="2" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" DisplayFormatInEditMode="True">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Người lập" FieldName="IDNhanVien" VisibleIndex="3" Width="200px">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="IDNhanVien">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="SoLuong" VisibleIndex="4" Width="50px" CellStyle-HorizontalAlign="Center">
                <PropertiesSpinEdit DisplayFormatString="N0">
                </PropertiesSpinEdit>

<CellStyle HorizontalAlign="Center"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tổng tiền" FieldName="TongTien" VisibleIndex="5" CellStyle-Font-Bold="true" Width="100px"> 
                <PropertiesSpinEdit DisplayFormatString="N0" >
                </PropertiesSpinEdit>

<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataMemoColumn Caption="Ghi chú" FieldName="GhiChu" VisibleIndex="9" Width="200px">
            </dx:GridViewDataMemoColumn>
            <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="DaXoa" VisibleIndex="8" Width="100px" CellStyle-HorizontalAlign="Center" CellStyle-Font-Bold="true">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Hoàn thành" Value="0" />
                        <dx:ListEditItem Text="Đã xóa" Value="1" />
                    </Items>
                </PropertiesComboBox>

<CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn Caption="Ngày tạo" FieldName="NgayTao" VisibleIndex="7" Width="100px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 0" Format="GreenFillWithDarkGreenText" />
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 1" Format="LightRedFillWithDarkRedText" />
        </FormatConditions>
    </dx:ASPxGridView>
     <asp:SqlDataSource ID="dsXuatKho" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>"
          SelectCommand="SELECT * FROM [kPhieuXuatKhac] ORDER BY [IDPhieuXuat] DESC"
          UpdateCommand="UPDATE kPhieuXuatKhac SET GhiChu = @GhiChu WHERE (IDPhieuXuat = @IDPhieuXuat)">
         <UpdateParameters>
             <asp:Parameter Name="GhiChu" Type="String" />
             <asp:Parameter Name="IDPhieuXuat" Type="Int32"  />
         </UpdateParameters>


     </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien]  WHERE IDNhanVien > 1"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridXuathang);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridXuathang);
        }" />
        </dx:ASPxGlobalEvents>
</asp:Content>
