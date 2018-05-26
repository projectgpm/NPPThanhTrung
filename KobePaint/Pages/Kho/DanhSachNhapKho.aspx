<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachNhapKho.aspx.cs" Inherits="KobePaint.Pages.Kho.DanhSachNhapKho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxGridView ID="gridNhaphang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridNhaphang" Width="100%" DataSourceID="dsNhapKho" KeyFieldName="IDNhapKho" OnCustomColumnDisplayText="gridNhaphang_CustomColumnDisplayText" OnRowDeleting="gridNhaphang_RowDeleting">
        <SettingsEditing EditFormColumnCount="3">
        </SettingsEditing>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <Templates>
            <DetailRow>
                <div style="padding-top:0px; padding-bottom: 14px;">
                    <dx:ASPxLabel ID="lblChiTietHang" runat="server" Text="Chi tiết nhập hàng" Font-Bold="True" ForeColor="#009933" Font-Italic="True" Font-Size="16px" Font-Underline="True">
                </dx:ASPxLabel>
                </div>
                <dx:ASPxGridView ID="gridChiTietNhapKho" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTietNhapKho" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTietNhapKho_BeforePerformDataSelect" Width="100%" OnCustomColumnDisplayText="gridChiTietNhapKho_CustomColumnDisplayText">
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
                        <dx:GridViewDataSpinEditColumn Caption="Tổng tiền" FieldName="ThanhTien" VisibleIndex="7" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Số lượng" FieldName="SoLuong" VisibleIndex="6" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Giá nhập" FieldName="GiaVon" VisibleIndex="5" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Tồn kho" FieldName="TonKho" VisibleIndex="4" Width="80px">
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
                <asp:SqlDataSource ID="dsChiTietNhapKho" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
                    SelectCommand="SELECT kNhapKhoChiTiet.ID, kNhapKhoChiTiet.HangHoaID, kNhapKhoChiTiet.GiaVon,kNhapKhoChiTiet.TonKho, kNhapKhoChiTiet.SoLuong, kNhapKhoChiTiet.ThanhTien,hhHangHoa.TenHangHoa, hhHangHoa.MaHang
FROM kNhapKhoChiTiet INNER JOIN hhHangHoa ON kNhapKhoChiTiet.HangHoaID = hhHangHoa.IDHangHoa WHERE (kNhapKhoChiTiet.NhapKhoID =@NhapKhoID) ">
                    <SelectParameters>
                        <asp:SessionParameter Name="NhapKhoID" SessionField="IDNhapKho" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xác nhận xóa !!" Title="DANH SÁCH NHẬP KHO" />
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
            <Items>
                <dx:GridViewColumnLayoutItem ColumnName="Số hóa đơn">
                </dx:GridViewColumnLayoutItem>
                <dx:GridViewColumnLayoutItem ColumnName="Ghi chú">
                </dx:GridViewColumnLayoutItem>
                <dx:EditModeCommandLayoutItem ColSpan="2" HorizontalAlign="Right">
                </dx:EditModeCommandLayoutItem>
            </Items>
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" ReadOnly="True" VisibleIndex="0" FieldName="IDNhapKho" Width="50px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn Caption="Cập nhật" ShowEditButton="True" VisibleIndex="9" Width="100px" ShowDeleteButton="True">
                 
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Mã phiếu" FieldName="MaPhieu" VisibleIndex="1" Width="90px" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Center">
                <%--<DataItemTemplate>
                     <a target="_blank" href="<%# Eval("Url") %>" > <%# Eval("MaPhieu") %></a>
                </DataItemTemplate>--%>
<CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Nhà cung cấp" FieldName="NCCID" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="dsNhaCC" TextField="HoTen" ValueField="IDKhachHang">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn Caption="Ngày nhập" FieldName="NgayNhap" VisibleIndex="3" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" DisplayFormatInEditMode="True">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Người nhập" FieldName="NguoiNhapID" VisibleIndex="4">
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
            <dx:GridViewDataSpinEditColumn Caption="Nợ" FieldName="CongNo" VisibleIndex="8" Width="100px">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="TrangThaiPhieu" VisibleIndex="2" Width="100px" CellStyle-HorizontalAlign="Center">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Hoàn thành" Value="0" />
                        <dx:ListEditItem Text="Phiếu tạm" Value="1" />
                        <dx:ListEditItem Text="Đã xóa" Value="2" />
                    </Items>
                </PropertiesComboBox>

<CellStyle HorizontalAlign="Center"></CellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Số hóa đơn" FieldName="SoHoaDon" Visible="False" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataMemoColumn Caption="Ghi chú" FieldName="GhiChu" Visible="False" VisibleIndex="11">
            </dx:GridViewDataMemoColumn>
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
    <asp:SqlDataSource ID="dsNhapKho" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT * FROM [kNhapKho] ORDER BY IDNhapKho DESC" 
        UpdateCommand="UPDATE [kNhapKho] SET [GhiChu] = @GhiChu, [SoHoaDon] = @SoHoaDon WHERE [IDNhapKho] = @IDNhapKho">
        <UpdateParameters>
            <asp:Parameter Name="SoHoaDon" Type="String" />
            <asp:Parameter Name="GhiChu" Type="String" />
            <asp:Parameter Name="IDNhapKho" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhaCC" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDKhachHang], [HoTen] FROM [khKhachHang] WHERE [LoaiKhachHangID] = 2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien] WHERE IDNhanVien > 1"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridNhaphang);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridNhaphang);
        }" />
    </dx:ASPxGlobalEvents>
</asp:Content>
