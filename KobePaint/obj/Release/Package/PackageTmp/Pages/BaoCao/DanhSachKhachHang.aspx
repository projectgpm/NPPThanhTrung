<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachKhachHang.aspx.cs" Inherits="KobePaint.Pages.BaoCao.DanhSachKhachHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <dx:ASPxButton ID="btnXuatExcel" runat="server" OnClick="btnXuatExcel_Click" Text="Xuất Excel">
       </dx:ASPxButton> 
      <dx:ASPxGridViewExporter ID="exproter" runat="server" ExportedRowType="All" GridViewID="gridDanhSachKH">
      </dx:ASPxGridViewExporter>
    <dx:ASPxGridView ID="gridDanhSachKH" runat="server"  AutoGenerateColumns="False" ClientInstanceName="gridDanhSachKH" DataSourceID="dsKhachHang" KeyFieldName="IDKhachHang" Width="100%" OnCustomColumnDisplayText="gridDanhSachKH_CustomColumnDisplayText">
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True" ShowFooter="True" ShowFilterRowMenu="True"  ShowHeaderFilterButton="true"/>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin khách hàng cần tìm..." Title="DANH SÁCH KHÁCH HÀNG" />
         <TotalSummary>
             <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="TongTienHang" ShowInGroupFooterColumn="Tổng tiền hàng" SummaryType="Sum" />
             <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TienTraHang" ShowInGroupFooterColumn="Tiền trả hàng" SummaryType="Sum" />
             <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="CongNo" ShowInGroupFooterColumn="Nợ" SummaryType="Sum" />
         </TotalSummary>
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
        <SettingsBehavior AllowSelectByRowClick="True" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <UpdateButton ButtonType="Image" RenderMode="Image">
                <Image IconID="save_save_32x32">
                </Image>
            </UpdateButton>
            <CancelButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_close_32x32">
                </Image>
            </CancelButton>
            <EditButton ButtonType="Image" RenderMode="Image">
                <Image IconID="mail_editcontact_32x32">
                </Image>
            </EditButton>
        </SettingsCommandButton>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="IDKhachHang" ReadOnly="True" VisibleIndex="0" Width="40px">
                <EditFormSettings Visible="False" />
                <Settings AllowAutoFilter="False" AllowFilterBySearchPanel="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mã KH" FieldName="MaKhachHang" VisibleIndex="2" Width="120px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Họ tên" FieldName="HoTen" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DiaChi" VisibleIndex="5" Caption="Địa chỉ">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Lần cuối mua hàng" FieldName="LanCuoiMuaHang" VisibleIndex="6">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yy H:mm:ss" EditFormat="Custom" EditFormatString="dd/MM/yy H:mm:ss">
                </PropertiesDateEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tổng tiền hàng" FieldName="TongTienHang" VisibleIndex="7">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tiền trả hàng" FieldName="TienTraHang" VisibleIndex="9">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Nợ" FieldName="CongNo" VisibleIndex="11" CellStyle-Font-Bold="true">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />

<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn Caption="Ghi chú" FieldName="GhiChu" Visible="False" VisibleIndex="13">
                <EditFormSettings Visible="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Email" FieldName="Email" Visible="False" VisibleIndex="12">
                <EditFormSettings Visible="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Loại khách hàng" FieldName="LoaiKhachHangID" VisibleIndex="1" Width="150px">
                <PropertiesComboBox DataSourceID="dsLoaiKhachHang" TextField="TenLoaiKhachHang" ValueField="IDLoaiKhachHang">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>


    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsLoaiKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT [TenLoaiKhachHang], [IDLoaiKhachHang] FROM [khLoaiKhachHang] WHERE (([DaXoa] = @DaXoa) )">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
           
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT * FROM [khKhachHang] WHERE [DaXoa] = 0">
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridDanhSachKH);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridDanhSachKH);
        }" />
    </dx:ASPxGlobalEvents>
</asp:Content>
