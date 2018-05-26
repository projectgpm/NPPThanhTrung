<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PheDuyetTraHang.ascx.cs" Inherits="KobePaint.Pages.TraHang.PheDuyetTraHang" %>
<%@ Register assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<dx:ASPxGridView ID="gridTraHang" ClientInstanceName="gridTraHang" Width="100%" runat="server" AutoGenerateColumns="False" DataSourceID="dsTraHang" KeyFieldName="IDPhieuTraHang" OnCustomColumnDisplayText="gridTraHang_CustomColumnDisplayText" OnRowUpdating="gridTraHang_RowUpdating">
        <ClientSideEvents endcallback="onEndCallBackReturn" />    
        <SettingsEditing Mode="Batch">
        </SettingsEditing>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <UpdateButton>
                <Image IconID="save_save_32x32" ToolTip="Lưu tất cả thay đổi">
                </Image>
            </UpdateButton>
            <CancelButton>
                <Image IconID="actions_close_32x32">
                </Image>
            </CancelButton>
        </SettingsCommandButton>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" />
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="gridChiTietHang" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTietHang" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTietHang_BeforePerformDataSelect" OnCustomColumnDisplayText="gridChiTietHang_CustomColumnDisplayText"  Width="100%">
                    <settings showtitlepanel="True" />
                    <settingstext title="CHI TIẾT HÀNG TRẢ" />
                    <SettingsCommandButton>
                        <ShowAdaptiveDetailButton ButtonType="Image">
                        </ShowAdaptiveDetailButton>
                        <HideAdaptiveDetailButton ButtonType="Image">
                        </HideAdaptiveDetailButton>
                    </SettingsCommandButton>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0"  Caption="STT">
                            <EditFormSettings Visible="False" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TenHangHoa" VisibleIndex="2" Caption="Hàng hóa">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="MaHang" VisibleIndex="1" Caption="Mã hàng">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SoLuong" VisibleIndex="3" Caption="Số lượng">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Tiền trả" FieldName="TienTra" VisibleIndex="6">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="ThanhTien" VisibleIndex="9">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <CellStyle HorizontalAlign="Right">
                            </CellStyle>
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Giá vốn" FieldName="GiaVon" VisibleIndex="5">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <CellStyle HorizontalAlign="Right">
                            </CellStyle>
                        </dx:GridViewDataSpinEditColumn>
                    </Columns>
                    <Styles>
                        <Header HorizontalAlign="Center" forecolor="#009933">
                            <Border BorderStyle="Dashed" />
                        </Header>
                        <Cell>
                            <Border BorderStyle="Dashed" />
                        </Cell>
                        <titlepanel font-bold="True" font-size="13px" forecolor="#009933" BackColor="#F4F4F4">
                        </titlepanel>
                    </Styles>
                    <Border BorderColor="Silver" BorderStyle="Solid" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsChiTietHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT hhHangHoa.MaHang, hhHangHoa.TenHangHoa, kPhieuTraHangChiTiet.ID, kPhieuTraHangChiTiet.GiaVon, kPhieuTraHangChiTiet.SoLuong, kPhieuTraHangChiTiet.ThanhTien, kPhieuTraHangChiTiet.TonKho, kPhieuTraHangChiTiet.TienTra FROM kPhieuTraHangChiTiet INNER JOIN hhHangHoa ON kPhieuTraHangChiTiet.HangHoaID = hhHangHoa.IDHangHoa WHERE (kPhieuTraHangChiTiet.PhieuTraHangNCCID = @PhieuTraHangNCCID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="PhieuTraHangNCCID" SessionField="PhieuTraHangNCCID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="IDPhieuTraHang" ReadOnly="True" VisibleIndex="0" Caption="STT"  >
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MaPhieu" VisibleIndex="1" Caption="Mã phiếu" ReadOnly="true" >
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="DaiLyID" VisibleIndex="2" Caption="Khách hàng" ReadOnly="true">
                <PropertiesComboBox DataSourceID="dsKhachHang" TextField="HoTen" ValueField="IDKhachHang">
                </PropertiesComboBox>
                <EditFormSettings Visible="True" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn FieldName="NgayTra" VisibleIndex="3" Caption="Ngày trả" ReadOnly="true">
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                    
<CalendarProperties FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" ClearButtonText="Hủy">
                        
<FastNavProperties Enabled="False" />
                    
</CalendarProperties>
                
</PropertiesDateEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="GhiChu" VisibleIndex="6" Caption="Ghi chú" ReadOnly="true">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TongTienHang" VisibleIndex="5" Caption="Tổng tiền" ReadOnly="true" CellStyle-Font-Bold="true">
                <PropertiesTextEdit DisplayFormatString="N0">
                </PropertiesTextEdit>
                <EditFormSettings Visible="True" />

<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TongSoLuong" VisibleIndex="4" Caption="Số lượng" ReadOnly="true">
                <PropertiesTextEdit DisplayFormatString="N0">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Nhân viên" FieldName="NhanVienID" VisibleIndex="7" ReadOnly="true">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="IDNhanVien">
                </PropertiesComboBox>
                <EditFormSettings Visible="True" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="Phê duyệt" FieldName="DuyetDonHang" VisibleIndex="8" Width="150px" CellStyle-HorizontalAlign="Center" CellStyle-Font-Bold="true">
                <PropertiesComboBox EnableFocusedStyle="False">
                    <Items>
                        <dx:ListEditItem Text="Đang xử lý" Value="0" />
                        <dx:ListEditItem Text="Hoàn tất" Value="1" />
                        <dx:ListEditItem Text="Hủy phiếu" Value="2" />
                    </Items>
                </PropertiesComboBox>
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />

<CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsTraHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT IDPhieuTraHang, MaPhieu, DaiLyID, SoPhieuTra, NgayTra, NgayNhap, NhanVienID, GhiChu, CongNoCu, TongSoLuong, HinhThucTT, ThanhToan, ConLai, TongTienHang, DuyetDonHang FROM kPhieuTraHang WHERE (DuyetDonHang = 0)" 
        UpdateCommand="UPDATE gPhieuTraHang SET NgayLuuKho = @NgayLuuKho, GhiChu = @GhiChu, PheDuyet = @PheDuyet, NhanVienLapID = @NhanVienLapID WHERE IDPhieuTraHang = @IDPhieuTraHang">
        <UpdateParameters>
            <asp:Parameter Name="NgayLuuKho" />
            <asp:Parameter Name="GhiChu" />
            <asp:Parameter Name="PheDuyet" />
            <asp:Parameter Name="NhanVienLapID" />
            <asp:Parameter Name="IDPhieuTraHang" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDKhachHang], [HoTen] FROM [khKhachHang] WHERE [DaXoa] = 0"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien] WHERE [DaXoa] = 0 AND [NhomID] <> 5"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateHeightControlInPage(gridTraHang, 60);
        }" ControlsInitialized="function(s, e) {
	        UpdateHeightControlInPage(gridTraHang, 60);
        }" />
    </dx:ASPxGlobalEvents>
    