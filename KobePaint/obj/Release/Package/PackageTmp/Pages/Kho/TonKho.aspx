<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TonKho.aspx.cs" Inherits="KobePaint.Pages.Kho.TonKho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function LoadTonKho() {
            gridTonKho.Refresh();
        }
    </script>
     <dx:ASPxCallbackPanel ID="cbpTonKho" ClientInstanceName="cbpTonKho" runat="server" Width="100%" >
          <PanelCollection>
            <dx:PanelContent ID="PanelContent1" runat="server">
                 <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
                <Items>
                    <dx:LayoutGroup Caption="Tồn kho" Width="100%" ColCount="2">
                        <Items>
                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                      <dx:ASPxButton ID="btnXuatExcel" runat="server" OnClick="btnXuatExcel_Click" Text="Xuất Excel"> </dx:ASPxButton>

                                                </td>
                                                <td style="padding-left:10px">
                                                    <dx:ASPxComboBox Caption="Loại tồn kho"  ID="ccbLoaiTonKho" runat="server" AutoPostBack="false" ClientInstanceName="ccbLoaiTonKho" SelectedIndex="2" >
                                                        <Items>
                                                            <dx:ListEditItem  Text="Chỉ lấy hàng tồn" Value="0" />
                                                            <dx:ListEditItem Text="Hết hàng" Value="1" />
                                                            <dx:ListEditItem  Text="Tất cả" Value="2" />
                                                        </Items>
                                                        <ClientSideEvents SelectedIndexChanged="function(s,e){ LoadTonKho(); }" />
                                                    </dx:ASPxComboBox>    
                                                </td>
                                            </tr>
                                        </table>
                                      
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            
                            <dx:LayoutItem Caption="Nhóm khách hàng" ColSpan="2" ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                        <dx:ASPxGridViewExporter ID="exproter" runat="server" ExportedRowType="All" GridViewID="gridTonKho">
                                        </dx:ASPxGridViewExporter>
                                        <dx:ASPxGridView ID="gridTonKho" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridTonKho" DataSourceID="dsTonKho" KeyFieldName="IDHangHoa" OnCustomColumnDisplayText="gridTonKho_CustomColumnDisplayText" Width="100%">
                                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
                                            <Templates>
                                                <DetailRow>
                                                    <div style="width: 100%; text-align:center;">
                                                        <div style="display:inline-block;">
                                                            <dx:ASPxGridView ID="gridTheKho" runat="server" AutoGenerateColumns="False" DataSourceID="dsTheKho" KeyFieldName="IDTheKho" Width="800px" OnBeforePerformDataSelect="gridTheKho_BeforePerformDataSelect">
                                                                <SettingsPager Mode="EndlessPaging">
                                                                </SettingsPager>
                                                                <Settings ShowTitlePanel="True" ShowFooter="True" />
                                                                <SettingsCommandButton>
                                                                    <ShowAdaptiveDetailButton ButtonType="Image">
                                                                    </ShowAdaptiveDetailButton>
                                                                    <HideAdaptiveDetailButton ButtonType="Image">
                                                                    </HideAdaptiveDetailButton>
                                                                    <NewButton ButtonType="Image" RenderMode="Image">
                                                                        <Image IconID="numberformats_accounting_16x16">
                                                                        </Image>
                                                                    </NewButton>
                                                                    <EditButton ButtonType="Image" RenderMode="Image">
                                                                        <Image IconID="tasks_edittask_16x16office2013">
                                                                        </Image>
                                                                    </EditButton>
                                                                    <DeleteButton ButtonType="Image" RenderMode="Image">
                                                                        <Image IconID="actions_close_16x16devav">
                                                                        </Image>
                                                                    </DeleteButton>
                                                                </SettingsCommandButton>
                                                                <SettingsText Title="THẺ KHO" EmptyDataRow="không có dữ liệu" />
                                                                <Columns>
                              
                                                                    <dx:GridViewDataTextColumn Caption="Diễn giải" FieldName="DienGiai" VisibleIndex="2" Width="100%">
                                                                        <CellStyle HorizontalAlign="Left">
                                                                        </CellStyle>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataSpinEditColumn Caption="Tồn" FieldName="Ton" VisibleIndex="5" Width="80px">
                                                                        <PropertiesSpinEdit DisplayFormatString="g">
                                                                        </PropertiesSpinEdit>
                                                                    </dx:GridViewDataSpinEditColumn>
                                                                    <dx:GridViewDataSpinEditColumn Caption="Xuất" FieldName="Xuat" VisibleIndex="4" Width="80px">
                                                                        <PropertiesSpinEdit DisplayFormatString="g">
                                                                        </PropertiesSpinEdit>
                                                                    </dx:GridViewDataSpinEditColumn>
                                                                    <dx:GridViewDataSpinEditColumn Caption="Nhập" FieldName="Nhap" VisibleIndex="3" Width="80px">
                                                                        <PropertiesSpinEdit DisplayFormatString="g">
                                                                        </PropertiesSpinEdit>
                                                                    </dx:GridViewDataSpinEditColumn>
                                                                    <dx:GridViewDataDateColumn Caption="Ngày" FieldName="NgayNhap" VisibleIndex="1" Width="150px">
                                                                        <PropertiesDateEdit DisplayFormatString="dd/MM/yy H:mm">
                                                                        </PropertiesDateEdit>
                                                                        <CellStyle HorizontalAlign="Left">
                                                                        </CellStyle>
                                                                    </dx:GridViewDataDateColumn>
                              
                                                                </Columns>
                                                                <TotalSummary>
                                                                    <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="Nhap" ShowInColumn="Nhập" ShowInGroupFooterColumn="Nhập" SummaryType="Sum" />
                                                                    <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="Xuat" ShowInColumn="Xuất" ShowInGroupFooterColumn="Xuất" SummaryType="Sum" />
                                                                </TotalSummary>
                                                                <Styles>
                                                                    <Header HorizontalAlign="Center">
                                                                    </Header>
                                                                    <TitlePanel ForeColor="#00CC00" Font-Bold="True" Font-Size="14px">
                                                                    </TitlePanel>
                                                                </Styles>
                                                            </dx:ASPxGridView>
                                                            <asp:SqlDataSource ID="dsTheKho" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT NgayNhap, DienGiai, Nhap, Xuat, Ton, IDTheKho FROM kTheKho WHERE (HangHoaID = @HangHoaID) ORDER BY IDTheKho DESC">
                                                                  <SelectParameters>
                                                                    <asp:SessionParameter Name="HangHoaID" SessionField="IDHangHoa" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </div>
                                                    </div>
                                                </DetailRow>
                                            </Templates>
                                            <SettingsPager AlwaysShowPager="True" PageSize="30">
                                                <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
                                            </SettingsPager>
                                            <SettingsEditing Mode="Inline">
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
                                                <dx:GridViewDataTextColumn Caption="STT" FieldName="IDHangHoa" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1" Width="60px">
                                                    <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                                                    <EditFormSettings Visible="False" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <CellStyle HorizontalAlign="Center">
                                                    </CellStyle>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="Mã hàng hóa" FieldName="MaHang" ShowInCustomizationForm="True" VisibleIndex="2"  Width="100px">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="Tên hàng hóa" FieldName="TenHangHoa" ShowInCustomizationForm="True" VisibleIndex="3">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataSpinEditColumn Caption="Đơn giá" FieldName="GiaVon" ShowInCustomizationForm="True" VisibleIndex="6" Width="200px">
                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                                    </PropertiesSpinEdit>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataSpinEditColumn Settings-FilterMode="Value" Caption="SL" CellStyle-HorizontalAlign="Center" FieldName="TonKho" ShowInCustomizationForm="True" VisibleIndex="5" Width="100px">
                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                                    </PropertiesSpinEdit>
                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataSpinEditColumn Caption="Giá trị tồn kho" FieldName="GiaTriTonKho" ShowInCustomizationForm="True" VisibleIndex="7" Width="200px">
                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                                    </PropertiesSpinEdit>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataComboBoxColumn Caption="Nhóm hàng" FieldName="NhomHHID" ShowInCustomizationForm="True" VisibleIndex="4" Width="250px">
                                                    <PropertiesComboBox DataSourceID="dsNhomHang" TextField="TenNhom" ValueField="IDNhomHH">
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
                                        <asp:SqlDataSource ID="dsNhomHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT * FROM [hhNhomHang]"></asp:SqlDataSource>
                                        <asp:SqlDataSource ID="dsTonKho" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="spTonKho" SelectCommandType="StoredProcedure"
                                            >
                                            <SelectParameters>
                                                 <asp:ControlParameter ControlID="formThongTin$ccbLoaiTonKho" Name="LoaiTonKho" DefaultValue="0"  PropertyName="Value" />

                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
                                            <ClientSideEvents BrowserWindowResized="function(s, e) {
	                                                UpdateControlHeight(gridTonKho);
                                                }" ControlsInitialized="function(s, e) {
	                                                UpdateControlHeight(gridTonKho);
                                                }" />
                                        </dx:ASPxGlobalEvents>
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
            </dx:PanelContent>
           </PanelCollection>
     </dx:ASPxCallbackPanel>
   
</asp:Content>
