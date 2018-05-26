<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="LienKetBangGia.aspx.cs" Inherits="KobePaint.Pages.HangHoa.LienKetBangGia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <script>
          function LoadKhachHang() {
              gridKhachHang.Refresh();
          }
    </script>
      <style>
        .dxflGroupCell_Material {
            padding: 0 5px;
        }

        .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material {
            padding-top: 1px;
        }
    </style>
      <dx:ASPxGridView ID="gridKhachHang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridKhachHang" DataSourceID="dsKhachHang" KeyFieldName="IDKhachHang" OnCustomColumnDisplayText="gridTonKho_CustomColumnDisplayText" Width="100%">
                                            <SettingsDetail ShowDetailRow="false" AllowOnlyOneMasterRowExpanded="True" />
                                           
                                            <SettingsPager AlwaysShowPager="True" PageSize="30">
                                                <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
                                            </SettingsPager>
                                            <SettingsEditing Mode="Batch">
                                            </SettingsEditing>
                                            <Settings ShowFilterRow="True" VerticalScrollableHeight="50" VerticalScrollBarMode="Visible" />
                                            <SettingsBehavior ConfirmDelete="True" AllowSelectByRowClick="True" />
                                            <SettingsCommandButton>
                                                <ShowAdaptiveDetailButton ButtonType="Image">
                                                </ShowAdaptiveDetailButton>
                                                <HideAdaptiveDetailButton ButtonType="Image">
                                                </HideAdaptiveDetailButton>
                                                <NewButton Text="Thêm mới">
                                                    <Image IconID="actions_add_16x16">
                                                    </Image>
                                                </NewButton>
                                                <UpdateButton Text="Lưu">
                                                    <Image IconID="save_save_32x32">
                                                    </Image>
                                                </UpdateButton>
                                                <CancelButton Text="Hủy">
                                                    <Image IconID="actions_close_32x32">
                                                    </Image>
                                                </CancelButton>
                                                <EditButton Text="Sửa">
                                                    <Image IconID="actions_edit_16x16devav">
                                                    </Image>
                                                </EditButton>
                                                <DeleteButton Text="Xóa">
                                                    <Image IconID="actions_cancel_16x16">
                                                    </Image>
                                                </DeleteButton>
                                            </SettingsCommandButton>
                                            <SettingsSearchPanel Visible="True" />
                                            <SettingsText ConfirmDelete="Xóa dữ liệu ??" EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." />
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                </dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn Caption="STT" FieldName="IDKhachHang" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1" Width="60px">
                                                    <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                                                    <EditFormSettings Visible="False" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <CellStyle HorizontalAlign="Center">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn ReadOnly="true" Caption="Mã khách hàng" FieldName="MaKhachHang" ShowInCustomizationForm="True" VisibleIndex="3"  Width="120px">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn ReadOnly="true" Caption="Tên khách hàng" FieldName="HoTen" ShowInCustomizationForm="True" VisibleIndex="4">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn ReadOnly="true" Caption="Điện thoại" FieldName="DienThoai" ShowInCustomizationForm="True" VisibleIndex="5">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn ReadOnly="true" Caption="Địa chỉ" FieldName="DiaChi" ShowInCustomizationForm="True" VisibleIndex="6">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataSpinEditColumn ReadOnly="true" Caption="Tổng tiền hàng" FieldName="TongTienHang" ShowInCustomizationForm="True" VisibleIndex="7">
                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                                    </PropertiesSpinEdit>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataComboBoxColumn Caption="Bảng giá" FieldName="IDBangGia" ShowInCustomizationForm="True" VisibleIndex="8">
                                                    <PropertiesComboBox DataSourceID="dsBangGia" TextField="TenBangGia" ValueField="IDBangGia">
                                                    </PropertiesComboBox>
                                                </dx:GridViewDataComboBoxColumn>
                                                <dx:GridViewDataComboBoxColumn ReadOnly="true" Caption="Loại khách hàng" FieldName="LoaiKhachHangID" ShowInCustomizationForm="True" VisibleIndex="2">
                                                    <PropertiesComboBox DataSourceID="dsLoaiKhachHang" TextField="TenLoaiKhachHang" ValueField="IDLoaiKhachHang">
                                                    </PropertiesComboBox>
                                                </dx:GridViewDataComboBoxColumn>
                                            </Columns>
                                            <FormatConditions>
                                                <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] < 1" Format="LightRedFillWithDarkRedText" />
                                                <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] > 0" Format="GreenFillWithDarkGreenText" />
                                                <dx:GridViewFormatConditionTopBottom FieldName="TonKho" Rule="TopItems" Threshold="15" Format="BoldText" />
                                            </FormatConditions>
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
                                            <Border BorderWidth="0px" />
                                            <BorderBottom BorderWidth="1px" />
                                        </dx:ASPxGridView>
                                        <asp:SqlDataSource ID="dsLoaiKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDLoaiKhachHang], [TenLoaiKhachHang] FROM [khLoaiKhachHang] WHERE (([DaXoa] = @DaXoa) AND ([IDLoaiKhachHang] &lt;&gt; @IDLoaiKhachHang))">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
                                                <asp:Parameter DefaultValue="2" Name="IDLoaiKhachHang" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT MaKhachHang, LoaiKhachHangID,HoTen, DienThoai, DiaChi, IDBangGia, TongTienHang, IDKhachHang FROM khKhachHang WHERE (DaXoa = @DaXoa) AND (LoaiKhachHangID &lt;&gt; @LoaiKhachHangID)" UpdateCommand="UPDATE khKhachHang SET IDBangGia = @IDBangGia WHERE (IDKhachHang = @IDKhachHang)">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
                                                <asp:Parameter DefaultValue="2" Name="LoaiKhachHangID" Type="Int32" />
                                            </SelectParameters>
                                            <UpdateParameters>
                                                <asp:Parameter DefaultValue="IDBangGia" Name="IDBangGia" />
                                                <asp:Parameter DefaultValue="IDKhachHang" Name="IDKhachHang" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="dsBangGia" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDBangGia], [MaBangGia], [TenBangGia] FROM [bgBangGia] WHERE ([DaXoa] = @DaXoa)">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
                                            <ClientSideEvents BrowserWindowResized="function(s, e) {
	                                                UpdateControlHeight(gridKhachHang);
                                                }" ControlsInitialized="function(s, e) {
	                                                UpdateControlHeight(gridKhachHang);
                                                }" />
                                        </dx:ASPxGlobalEvents>
</asp:Content>
