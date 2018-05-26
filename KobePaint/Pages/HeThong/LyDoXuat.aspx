<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="LyDoXuat.aspx.cs" Inherits="KobePaint.Pages.HeThong.LyDoXuat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <dx:ASPxGridView ID="gridDanhSach" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridDanhSach" DataSourceID="dsLyDoXuat" KeyFieldName="IDPhieuXuatKhac" Width="100%" OnHtmlDataCellPrepared="gridDanhSachKH_HtmlDataCellPrepared" OnCustomColumnDisplayText="gridDanhSachKH_CustomColumnDisplayText">
         <SettingsEditing Mode="Inline">
         </SettingsEditing>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin khách hàng cần tìm..." Title="DANH SÁCH LÝ DO XUẤT KHÁC" ConfirmDelete="Xác nhận xóa !!" />
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight Expression="[TienTTConLai] &gt;= [HanMucCongNo] And [HanMucCongNo] &lt;&gt; 0" FieldName="TienTTConLai" Format="Custom">
                <CellStyle BackColor="LightPink" ForeColor="DarkRed">
                </CellStyle>
            </dx:GridViewFormatConditionHighlight>
        </FormatConditions>
        <Styles>
            <Header HorizontalAlign="Center">
                <Paddings Padding="3px" />
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
        <SettingsBehavior AllowSelectByRowClick="True" ConfirmDelete="True" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <NewButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_add_16x16" ToolTip="Thêm">
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
                <Image IconID="mail_editcontact_16x16office2013" ToolTip="Cập nhật">
                </Image>
            </EditButton>
            <DeleteButton ButtonType="Image" RenderMode="Image">
                <Image IconID="edit_delete_16x16" ToolTip="Xóa">
                </Image>
            </DeleteButton>
        </SettingsCommandButton>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="IDPhieuXuatKhac" ReadOnly="True" VisibleIndex="0" Width="40px">
                <EditFormSettings Visible="False" />
                <Settings AllowAutoFilter="False" AllowFilterBySearchPanel="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Lý do xuất" FieldName="LyDoXuat" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn Caption=" " ShowEditButton="True" VisibleIndex="15" Width="80px" ShowDeleteButton="True" ShowNewButtonInHeader="True">
            </dx:GridViewCommandColumn>
        </Columns>
    </dx:ASPxGridView>
     <asp:SqlDataSource ID="dsLyDoXuat" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
         DeleteCommand="UPDATE kLyDoXuatKhac SET DaXoa = 1 WHERE (IDPhieuXuatKhac = @IDPhieuXuatKhac)"
          UpdateCommand="UPDATE kLyDoXuatKhac SET  LyDoXuat = @LyDoXuat WHERE (IDPhieuXuatKhac = @IDPhieuXuatKhac)"
         SelectCommand="SELECT [IDPhieuXuatKhac], [LyDoXuat] FROM [kLyDoXuatKhac] WHERE ([DaXoa] = @DaXoa)"
          InsertCommand="INSERT INTO kLyDoXuatKhac(LyDoXuat, DaXoa) VALUES (@LyDoXuat, 0)">
         <UpdateParameters>
             <asp:Parameter Name="IDPhieuXuatKhac" Type="Int32" />
              <asp:Parameter Name="LyDoXuat"  Type="String"/>
         </UpdateParameters>
         <DeleteParameters>
             <asp:Parameter  Name="IDPhieuXuatKhac" Type="Int32" />
         </DeleteParameters>
         <InsertParameters>
             <asp:Parameter Name="LyDoXuat"  Type="String"/>
         </InsertParameters>
         <SelectParameters>
             <asp:Parameter DefaultValue="0" Name="DaXoa"  />
         </SelectParameters>
     </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridDanhSach);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridDanhSach);
        }" />
    </dx:ASPxGlobalEvents>
</asp:Content>
