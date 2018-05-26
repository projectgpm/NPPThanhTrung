<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachDaiLy.aspx.cs" Inherits="KobePaint.Pages.KhachHang.DanhSachDaiLy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <script type="text/javascript">
         function ShowPopup(elementID, paras) {
             cbpInfoStep.PerformCallback(paras);
             popupInfoStep.ShowAtElementByID(elementID);
         }
         function HidePopup() {
             popupInfoStep.Hide();
         }
    </script>
    <dx:ASPxGridView ID="gridDanhSachKH" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridDanhSachKH" DataSourceID="dsKhachHang" KeyFieldName="IDKhachHang" Width="100%" OnHtmlDataCellPrepared="gridDanhSachKH_HtmlDataCellPrepared" OnCustomColumnDisplayText="gridDanhSachKH_CustomColumnDisplayText">
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin nhà cung cấp cần tìm..." Title="DANH SÁCH ĐẠI LÝ" />
        
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
            <dx:GridViewDataTextColumn Caption="Mã đại lý" FieldName="MaKhachHang" VisibleIndex="1" Width="120px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tên đại lý" FieldName="HoTen" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DiaChi" VisibleIndex="4" Caption="Địa chỉ">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn Caption=" " ShowEditButton="True" VisibleIndex="15" Width="60px">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn Caption="Lần cuối mua hàng" FieldName="LanCuoiMuaHang" VisibleIndex="5">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yy H:mm:ss" EditFormat="Custom" EditFormatString="dd/MM/yy H:mm:ss">
                </PropertiesDateEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tổng tiền hàng" FieldName="TongTienHang" VisibleIndex="6">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tiền trả hàng" FieldName="TienTraHang" VisibleIndex="9">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Nợ" FieldName="CongNo" VisibleIndex="11">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn Caption="Ghi chú" FieldName="GhiChu" Visible="False" VisibleIndex="13">
                <EditFormSettings Visible="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Email" FieldName="Email" Visible="False" VisibleIndex="12">
                <EditFormSettings Visible="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mã số thuế" FieldName="MaSoThue" Visible="False" VisibleIndex="14">
                <EditFormSettings Visible="True" />
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT * FROM [khKhachHang] WHERE [DaXoa] = 0 AND [LoaiKhachHangID] = 3" 
        DeleteCommand="DELETE FROM [khKhachHang] WHERE [IDKhachHang] = @IDKhachHang" 
        InsertCommand="INSERT INTO [khKhachHang] ([MaKhachHang], [LoaiKhachHangID], [HoTen], [DiaChi], [DienThoai], [MaSoThue], [GhiChu], [NhanVienPhuTrachID], [TongCongNo], [DaThanhToan], [TienTamUng], [TienTTConLai], [HanMucCongNo], [ThoiHanThanhToan], [DaXoa]) VALUES (@MaKhachHang, @LoaiKhachHangID, @HoTen, @DiaChi, @DienThoai, @MaSoThue, @GhiChu, @NhanVienPhuTrachID, @TongCongNo, @DaThanhToan, @TienTamUng, @TienTTConLai, @HanMucCongNo, @ThoiHanThanhToan, @DaXoa)" 
        UpdateCommand="UPDATE [khKhachHang] SET [HoTen] = @HoTen, [DiaChi] = @DiaChi,[Email] = @Email, [DienThoai] = @DienThoai, [MaSoThue] = @MaSoThue, [GhiChu] = @GhiChu WHERE [IDKhachHang] = @IDKhachHang">
        <SelectParameters>
            <%--<asp:Parameter Name="DaXoa" Type="Int32" />--%>
        </SelectParameters>
        <DeleteParameters>
           <%-- <asp:Parameter Name="IDKhachHang" Type="Int32" />--%>
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="HoTen" Type="String" />
            <asp:Parameter Name="DiaChi" Type="String" />
            <asp:Parameter Name="DienThoai" Type="String" />
            <asp:Parameter Name="MaSoThue" Type="String" />
            <asp:Parameter Name="GhiChu" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="IDKhachHang" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridDanhSachKH);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridDanhSachKH);
        }" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxPopupControl ID="popupInfoStep" runat="server" ClientInstanceName="popupInfoStep" CloseAction="MouseOut" ShowHeader="False" Width="300px">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <div id="contentPopup">
                    <dx:ASPxCallbackPanel ID="cbpInfoStep" ClientInstanceName="cbpInfoStep" runat="server" OnCallback="cbpInfoStep_Callback" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent ID="PanelContent1" runat="server">
                                <asp:Literal ID="litNoiDung" runat="server"></asp:Literal>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
