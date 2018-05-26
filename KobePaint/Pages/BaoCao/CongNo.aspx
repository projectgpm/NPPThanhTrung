<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CongNo.aspx.cs" Inherits="KobePaint.Pages.BaoCao.CongNo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
        <Items>
            <dx:LayoutGroup Caption="Công nợ đại lý" Width="100%">
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
                                <dx:ASPxGridViewExporter ID="exproter" runat="server" ExportedRowType="All" GridViewID="gridKhachHang">
                                </dx:ASPxGridViewExporter>
                                <dx:ASPxGridView ID="gridKhachHang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridKhachHang" DataSourceID="dsKhachHang" KeyFieldName="IDKhachHang" Width="100%" OnCustomColumnDisplayText="gridKhachHang_CustomColumnDisplayText">
                                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowHeaderFilterButton="true"/>
                                    <SettingsBehavior ColumnResizeMode="Control" />
                                    <SettingsCommandButton>
                                        <ShowAdaptiveDetailButton ButtonType="Image">
                                        </ShowAdaptiveDetailButton>
                                        <HideAdaptiveDetailButton ButtonType="Image">
                                        </HideAdaptiveDetailButton>
                                    </SettingsCommandButton>
                                    <SettingsText HeaderFilterCancelButton="Hủy" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" PopupEditFormCaption="Cập nhật mã hóa đơn"  EmptyDataRow="Không có dữ liệu" CommandCancel="Hủy" ConfirmDelete="Bạn có chắc chắn muốn xóa?" HeaderFilterFrom="Từ" HeaderFilterLastMonth="Tháng trước" HeaderFilterLastWeek="Tuần trước" HeaderFilterLastYear="Năm trước" HeaderFilterNextMonth="Tháng sau" HeaderFilterNextWeek="Tuần sau" HeaderFilterNextYear="Năm sau" HeaderFilterOkButton="Lọc" HeaderFilterSelectAll="Chọn tất cả" HeaderFilterShowAll="Tất cả" HeaderFilterShowBlanks="Trống" HeaderFilterShowNonBlanks="Không trống" HeaderFilterThisMonth="Tháng này" HeaderFilterThisWeek="Tuần này" HeaderFilterThisYear="Năm nay" HeaderFilterTo="Đến" HeaderFilterToday="Hôm nay" HeaderFilterTomorrow="Ngày mai" HeaderFilterYesterday="Ngày hôm qua" />
                                    <SettingsPager PageSize="20">
                                        <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
                                    </SettingsPager>
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="IDKhachHang" Caption="STT" ReadOnly="True" VisibleIndex="0" Width="50px">
                                            <Settings AllowAutoFilter="False" ShowFilterRowMenu="False" />
                                            <CellStyle HorizontalAlign="Center">
                                            </CellStyle>
                                            <Settings AllowHeaderFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="HoTen" Caption="Họ tên" VisibleIndex="2">
                                            <SettingsHeaderFilter Mode="CheckedList">
                                            </SettingsHeaderFilter>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DiaChi" Caption="Địa chỉ" VisibleIndex="5">
                                            <Settings AllowHeaderFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="MaKhachHang" Caption="Mã đại lý" VisibleIndex="1">
                                            <CellStyle HorizontalAlign="Center">
                                            </CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DienThoai" Caption="Điện thoại" VisibleIndex="4">
                                            <Settings AllowHeaderFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="MaSoThue" Caption="Mã số thuế" VisibleIndex="3">
                                            <Settings AllowHeaderFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="GhiChu" Caption="Ghi chú" VisibleIndex="11">
                                            <Settings AllowHeaderFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TongTienHang" Caption="Tổng tiền hàng" VisibleIndex="7">
                                            <PropertiesTextEdit DisplayFormatString="N0">
                                            </PropertiesTextEdit>
                                            <Settings AllowHeaderFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ThanhToan" Caption="Đã thanh toán" VisibleIndex="8">
                                            <PropertiesTextEdit DisplayFormatString="N0">
                                            </PropertiesTextEdit>
                                            <Settings AllowHeaderFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CongNo" Caption="Công nợ" VisibleIndex="9" CellStyle-Font-Bold="true">
                                            <PropertiesTextEdit DisplayFormatString="N0">
                                            </PropertiesTextEdit>
                                            <Settings AllowHeaderFilter="False" />

                                            <CellStyle Font-Bold="True"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                    </Columns>
                                    <TotalSummary>
                                        <dx:ASPxSummaryItem DisplayFormat="N0" FieldName="TongTienHang" ShowInColumn="Tổng tiền hàng" SummaryType="Sum" />
                                        <dx:ASPxSummaryItem DisplayFormat="N0" FieldName="ThanhToan" ShowInColumn="Đã thanh toán" SummaryType="Sum" />
                                        <dx:ASPxSummaryItem DisplayFormat="N0" FieldName="CongNo" ShowInColumn="Công nợ" SummaryType="Sum" />
                                    </TotalSummary>
                                    <Styles>
                                        <Header Wrap="True">
                                        </Header>
                                    </Styles>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="dsKhachHang" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
                                    SelectCommand="SELECT IDKhachHang, LoaiKhachHangID, MaKhachHang, HoTen, DienThoai, DiaChi, GhiChu, Email, LanCuoiMuaHang, TongTienHang, MaSoThue, TienTraHang, CongNo, DaXoa, NgayTao, ThanhToan, IDBangGia FROM khKhachHang WHERE (DaXoa = @DaXoa) AND (LoaiKhachHangID &lt;&gt; 2) ORDER BY HoTen">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
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
