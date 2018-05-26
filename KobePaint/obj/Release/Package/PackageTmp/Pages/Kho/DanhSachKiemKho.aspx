<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachKiemKho.aspx.cs" Inherits="KobePaint.Pages.Kho.DanhSachKiemKho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxGridView ID="gridKiemKe" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridKiemKe" Width="100%" DataSourceID="dsKiemKe" KeyFieldName="IDPhieuKiemKe" OnCustomColumnDisplayText="gridKiemKe_CustomColumnDisplayText" OnRowDeleting="gridKiemKe_RowDeleting">
        <SettingsEditing EditFormColumnCount="3">
        </SettingsEditing>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <Templates>
            <DetailRow>
                <div style="padding-top:0px; padding-bottom: 14px;">
                    <dx:ASPxLabel ID="lblChiTietHang" runat="server" Text="Chi tiết kiểm kê" Font-Bold="True" ForeColor="#009933" Font-Italic="True" Font-Size="16px" Font-Underline="True">
                </dx:ASPxLabel>
                </div>
                <dx:ASPxGridView ID="gridChiTietKiemKe" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTietKiemKe" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTietKiemKe_BeforePerformDataSelect" Width="100%" OnCustomColumnDisplayText="gridChiTietKiemKe_CustomColumnDisplayText">
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
                        <dx:GridViewDataSpinEditColumn Caption="Chênh lệch" FieldName="ChenhLech" VisibleIndex="5" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Tồn thực tế" FieldName="TonKhoThucTe" VisibleIndex="4" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Tồn hệ thống" FieldName="TonKhoHeThong" VisibleIndex="3" Width="80px">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataTextColumn Caption="Diễn giải" FieldName="DienGiai" VisibleIndex="6" Width="150px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
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
                <asp:SqlDataSource ID="dsChiTietKiemKe" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT kKiemKeChiTiet.ID, kKiemKeChiTiet.TonKhoHeThong, kKiemKeChiTiet.TonKhoThucTe, kKiemKeChiTiet.ChenhLech, kKiemKeChiTiet.DienGiai, hhHangHoa.MaHang, hhHangHoa.TenHangHoa FROM kKiemKeChiTiet INNER JOIN hhHangHoa ON kKiemKeChiTiet.HangHoaID = hhHangHoa.IDHangHoa WHERE (kKiemKeChiTiet.PhieuKiemKeID = @PhieuKiemKeID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="PhieuKiemKeID" SessionField="PhieuKiemKeID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xác nhận xóa !!" Title="DANH SÁCH KIỂM KÊ" />
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
                <Image IconID="actions_cancel_16x16" ToolTip="Xóa phiếu nhập hàng">
                </Image>
            </DeleteButton>
        </SettingsCommandButton>
        <EditFormLayoutProperties ColCount="2">
            <Items>
                <dx:GridViewColumnLayoutItem ColumnName="Ghi chú" ColSpan="2">
                </dx:GridViewColumnLayoutItem>
                <dx:EditModeCommandLayoutItem ColSpan="2" HorizontalAlign="Right">
                </dx:EditModeCommandLayoutItem>
            </Items>
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" ReadOnly="True" VisibleIndex="0" FieldName="IDPhieuKiemKe" Width="50px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn Caption="Cập nhật" ShowEditButton="True" VisibleIndex="10" Width="100px" ShowDeleteButton="True">
                 
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Mã phiếu" FieldName="MaPhieu" VisibleIndex="1" Width="90px" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Center">
              
<CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày cân bằng" FieldName="NgayLap" VisibleIndex="6" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" DisplayFormatInEditMode="True">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Người cân bằng" FieldName="IDNhanVien" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="IDNhanVien">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="Số lượng" FieldName="SoLuong" VisibleIndex="2" Width="150px" CellStyle-HorizontalAlign="Center">
                <PropertiesSpinEdit DisplayFormatString="N0">
                </PropertiesSpinEdit>

<CellStyle HorizontalAlign="Center"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Tình trạng" FieldName="DaXoa" VisibleIndex="4" Width="100px" CellStyle-HorizontalAlign="Center">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Hoàn thành" Value="0" />
                        <dx:ListEditItem Text="Đã xóa" Value="1" />
                    </Items>
                </PropertiesComboBox>

<CellStyle HorizontalAlign="Center"></CellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataMemoColumn Caption="Ghi chú" FieldName="GhiChu" VisibleIndex="8">
            </dx:GridViewDataMemoColumn>
            <dx:GridViewDataSpinEditColumn Caption="Chênh lệch" FieldName="ChenhLech" Width="150px" VisibleIndex="3" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Center"> 
                <PropertiesSpinEdit DisplayFormatString="N0" >
                </PropertiesSpinEdit>

<CellStyle Font-Bold="True"></CellStyle>

            </dx:GridViewDataSpinEditColumn>
        </Columns>

        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 0" Format="GreenFillWithDarkGreenText" />
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 1" Format="LightRedFillWithDarkRedText" />
        </FormatConditions>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsKiemKe" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT * FROM [kKiemKe] ORDER BY [IDPhieuKiemKe] DESC" 
        UpdateCommand="UPDATE kKiemKe SET GhiChu = @GhiChu WHERE (IDPhieuKiemKe = @IDPhieuKiemKe)"
        >
        <UpdateParameters>
            <asp:Parameter Name="GhiChu" Type="String" />
            <asp:Parameter Name="IDPhieuKiemKe" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien]  WHERE IDNhanVien > 1"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridKiemKe);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridKiemKe);
        }" />
    </dx:ASPxGlobalEvents>
</asp:Content>
