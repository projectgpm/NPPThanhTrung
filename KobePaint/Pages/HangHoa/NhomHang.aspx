<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="NhomHang.aspx.cs" Inherits="KobePaint.Pages.HangHoa.NhomHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
        <Items>
            <dx:LayoutGroup Caption="Danh sách nhóm hàng" Width="100%">
                <Items>
                    <dx:LayoutItem HorizontalAlign="Right" ShowCaption="False" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                <dx:ASPxButton ID="btnXuatExcel" runat="server" OnClick="btnXuatExcel_Click" Text="Xuất Excel">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Nhóm khách hàng" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                <dx:ASPxGridViewExporter ID="exproter" runat="server" ExportedRowType="All" GridViewID="gridNhomHang">
                                </dx:ASPxGridViewExporter>
     <dx:ASPxGridView ID="gridNhomHang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridNhomHang" Width="100%" DataSourceID="dsNhomHang" KeyFieldName="IDNhomHH" OnCustomColumnDisplayText="gridNhomHang_CustomColumnDisplayText">
        <SettingsEditing Mode="Inline">
        </SettingsEditing>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0"/>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xóa dữ liệu ??" />
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
         <SettingsBehavior ConfirmDelete="True" />
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
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="2" Width="200px">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="IDNhomHH" ReadOnly="True" VisibleIndex="0" Caption="STT" Width="60px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TenNhom" VisibleIndex="1" Caption="Tên nhóm">
                <PropertiesTextEdit>
                    <ValidationSettings SetFocusOnError="True">
                        <RequiredField ErrorText="Nhập thông tin" IsRequired="True" />
                    </ValidationSettings>
                </PropertiesTextEdit>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsNhomHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>"
         DeleteCommand="UPDATE [hhNhomHang] SET [DaXoa] = 1 WHERE [IDNhomHH] = @IDNhomHH"
         InsertCommand="INSERT INTO [hhNhomHang] ([TenNhom]) VALUES (@TenNhom)" 
         SelectCommand="SELECT [IDNhomHH], [TenNhom] FROM [hhNhomHang] Where [DaXoa] = 0" 
         UpdateCommand="UPDATE [hhNhomHang] SET [TenNhom] = @TenNhom WHERE [IDNhomHH] = @IDNhomHH">
        <DeleteParameters>
            <asp:Parameter Name="IDNhomHH" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TenNhom" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TenNhom" Type="String" />
            <asp:Parameter Name="IDNhomHH" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridNhomHang);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridNhomHang);
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
</asp:Content>
