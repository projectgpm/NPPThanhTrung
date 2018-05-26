<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachThuChi.aspx.cs" Inherits="KobePaint.Pages.ThuChi.DanhSachThuChi" %>
<%@ Register Assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function onPrintClick(idPhieu) {
            popupViewReport.Show();
            cbpViewReport.PerformCallback(idPhieu);
        }
        function onEndCallBackViewRp() {
            reportViewer.GetViewer().Refresh();
        }
    </script>
    <dx:ASPxGridView ID="gridThuChi" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridThuChi" Width="100%" DataSourceID="dsThuChi" KeyFieldName="IDPhieu" OnCustomColumnDisplayText="gridThuChi_CustomColumnDisplayText">
        <SettingsEditing EditFormColumnCount="3">
        </SettingsEditing>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xác nhận xóa !!" Title="DANH SÁCH THU - CHI" />
        <Styles>
            <Header HorizontalAlign="Center">
            </Header>
            <GroupRow ForeColor="#428BCA">
            </GroupRow>
            <AlternatingRow Enabled="True">
            </AlternatingRow>
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
            <dx:GridViewDataTextColumn Caption="STT" ReadOnly="True" VisibleIndex="0" FieldName="IDPhieu" Width="50px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mã phiếu" FieldName="MaPhieu" VisibleIndex="2" Width="120px" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Center">
                <%--<DataItemTemplate>
                     <a target="_blank" href="<%# Eval("Url") %>" > <%# Eval("MaPhieu") %></a>
                </DataItemTemplate>--%>
<CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày lập" FieldName="NgayLap" VisibleIndex="3" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" DisplayFormatInEditMode="True">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Người lập" FieldName="NhanVienID" VisibleIndex="4" Width="120px">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="IDNhanVien">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Người nộp" FieldName="NguoiNop" VisibleIndex="5" Width="120px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Nội dung" FieldName="NoiDung" VisibleIndex="9" Width="90%">
            </dx:GridViewDataTextColumn>
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
            <dx:GridViewDataSpinEditColumn Caption="Số tiền" CellStyle-Font-Bold="true" FieldName="SoTien" VisibleIndex="7" CellStyle-HorizontalAlign="Center" Width="120px">
                <PropertiesSpinEdit DisplayFormatString="N0">
                </PropertiesSpinEdit>

<CellStyle HorizontalAlign="Center"></CellStyle>

            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Loại phiếu" FieldName="LoaiPhieu" VisibleIndex="1" CellStyle-HorizontalAlign="Center" Width="100px">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Phiếu thu" Value="0" />
                        <dx:ListEditItem Text="Phiếu chi" Value="1" />
                    </Items>
                </PropertiesComboBox>

<CellStyle HorizontalAlign="Center"></CellStyle>

            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="Loại thu chi" FieldName="LoaiThuChiID" VisibleIndex="8" Width="100px">
                <PropertiesComboBox DataSourceID="dsLoaiThuChi" TextField="TenPhieu" ValueField="ID">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" VisibleIndex="6" Width="100px">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsLoaiThuChi" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [ID], [TenPhieu] FROM [pLoaiThuChi] WHERE ([DaXoa] = @DaXoa) ORDER BY [TenPhieu]">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsThuChi" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT * FROM [pPhieuThuChi] ORDER BY [IDPhieu] DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien]"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridThuChi);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridThuChi);
        }" />
    </dx:ASPxGlobalEvents>
     <dx:ASPxPopupControl ID="popupViewReport" ClientInstanceName="popupViewReport" runat="server" HeaderText="In phiếu thu chi" ShowHeader="false" PopupVerticalAlign="WindowCenter" Width="850px" Height="600px" PopupHorizontalAlign="WindowCenter" ScrollBars="Auto" >
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxCallbackPanel ID="cbpViewReport" ClientInstanceName="cbpViewReport" runat="server" Width="100%" OnCallback="cbpViewReport_Callback">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server" Width="100%">
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
