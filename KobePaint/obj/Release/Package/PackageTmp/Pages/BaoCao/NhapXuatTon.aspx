<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="NhapXuatTon.aspx.cs" Inherits="KobePaint.Pages.BaoCao.NhapXuatTon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>


        .dxflGroupCell_Material{
            padding: 0 5px;
        }
        .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material
        {
            padding-top: 1px;
        }
    </style>
     <script type="text/javascript">
         function AdjustSize() {
             var hformThongTin = formThongTin.GetHeight();
             UpdateHeightControlInPage(gridNhapXuatTon, hformThongTin);
         }
         function onXemBaoCaoClick() {
             if (checkInput())
                 cbpInfo.PerformCallback('baocao');
                 //gridNhapXuatTon.Refresh();
         }
         function checkInput() {
             if (fromDay.GetValue() == null) {
                 alert('Vui lòng chọn ngày xem báo cáo');
                 fromDay.Focus();
                 return false;
             }
             if (toDay.GetValue() == null) {
                 alert('Vui lòng chọn ngày xem báo cáo');
                 toDay.Focus();
                 return false;
             }
             return true;
         }
         function endCallBackProduct(s, e) {
             gridNhapXuatTon.Refresh();
         }
    </script>
     <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent2" runat="server">
                <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
                    <Items>
                        <dx:LayoutGroup Caption="Báo cáo Nhập - Xuất - Tồn" ColCount="4" HorizontalAlign="Center">
                            <Items>
                                <dx:LayoutItem Caption="Từ ngày">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                            <dx:ASPxDateEdit ID="fromDay" ClientInstanceName="fromDay" runat="server" OnInit="dateEditControl_Init">
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="đến ngày">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                            <dx:ASPxDateEdit ID="toDay" ClientInstanceName="toDay" runat="server" OnInit="dateEditControl_Init">
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Xem báo cáo" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                            <dx:ASPxButton ID="btnXemBaoCao" runat="server" Text="Xem báo cáo" AutoPostBack="false">
                                                <ClientSideEvents Click="onXemBaoCaoClick" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Xuất excel" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                            <dx:ASPxButton ID="btnXuatExcel" runat="server" Text="Xuất excel" OnClick="btnXuatExcel_Click">
                                            </dx:ASPxButton>
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

                <dx:ASPxGridView ID="gridNhapXuatTon" ClientInstanceName="gridNhapXuatTon" runat="server" AutoGenerateColumns="False" DataSourceID="dsNhapXuatTon" KeyFieldName="ID" Width="100%" OnCustomColumnDisplayText="grid_CustomColumnDisplayText">
                    <Settings VerticalScrollBarMode="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowHeaderFilterButton="True" HorizontalScrollBarMode="Visible"/>
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
                        <dx:GridViewDataTextColumn Caption="Tên hàng hóa" VisibleIndex="1" FieldName="TenHangHoa" Width="200px" FixedStyle="Left">
                            <SettingsHeaderFilter Mode="CheckedList">
                            </SettingsHeaderFilter>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Mã HH" VisibleIndex="2" FieldName="MaHang" Width="100px" FixedStyle="Left">
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                            <SettingsHeaderFilter Mode="CheckedList">
                            </SettingsHeaderFilter>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tồn trước" ReadOnly="True" VisibleIndex="4" FieldName="TonDauKy" Width="100px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn VisibleIndex="6" Caption="SL Nhập" ReadOnly="True" FieldName="SLNhap" Width="90px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Thành tiền nhập" ReadOnly="True" VisibleIndex="7" FieldName="TienNhap" Width="150px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="SL Xuất" ReadOnly="True" VisibleIndex="8" FieldName="SLXuat" Width="100px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Thành tiền xuất" ReadOnly="True" VisibleIndex="9" FieldName="TienXuat" Width="150px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="SL Tồn" ReadOnly="True" VisibleIndex="10" FieldName="SLTon" Width="100px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="STT" VisibleIndex="0" Width="40px" FieldName="ID" FixedStyle="Left">
                            <Settings AllowAutoFilter="False" ShowFilterRowMenu="False" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tồn HT" VisibleIndex="14" FieldName="TonHienTai" CellStyle-Font-Bold="true" Width="100px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
            <CellStyle Font-Bold="True"></CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn VisibleIndex="15" Width="150px" Caption="Thành tiền HT" FieldName="TienHienTai" CellStyle-Font-Bold="true" CellStyle-Font-Italic="true">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>

            <CellStyle Font-Bold="True" Font-Italic="True"></CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Thành tiền TT" VisibleIndex="5" FieldName="TienDauKy" Width="120px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Thành tiền tồn" FieldName="TienTon" VisibleIndex="11" Width="150px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tồn sau" FieldName="TonCuoiKy" VisibleIndex="12" Width="100px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Thành tiền sau" FieldName="TienCuoiKy" VisibleIndex="13" Width="150px">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="ĐVT" FieldName="TenDonViTinh" VisibleIndex="3" Width="80px" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <Styles>
                        <FixedColumn BackColor="LightYellow" />
                    </Styles>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TonDauKy" ShowInColumn="Tồn trước" SummaryType="Sum" ShowInGroupFooterColumn="Tồn trước" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TienDauKy" SummaryType="Sum" ShowInGroupFooterColumn="Thành tiền HT" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="SLNhap" SummaryType="Sum" ShowInGroupFooterColumn="SL Nhập" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TienNhap" SummaryType="Sum" ShowInGroupFooterColumn="Thành tiền nhập" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="SLXuat" SummaryType="Sum" ShowInGroupFooterColumn="SL Xuất" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TienXuat" SummaryType="Sum" ShowInGroupFooterColumn="Thành tiền xuất" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="SLTon" ShowInGroupFooterColumn="SL Tồn" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TienTon" ShowInGroupFooterColumn="Thành tiền tồn" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TonCuoiKy" ShowInGroupFooterColumn="Tồn sau" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TienCuoiKy" ShowInGroupFooterColumn="Thành tiền sau" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TonHienTai" ShowInGroupFooterColumn="Tồn HT" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="TienHienTai" ShowInGroupFooterColumn="Thành tiền HT" SummaryType="Sum" />
                    </TotalSummary>
                </dx:ASPxGridView>
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="endCallBackProduct" />
    </dx:ASPxCallbackPanel>
    <asp:SqlDataSource ID="dsNhapXuatTon" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT bc_NhapXuatTon.* FROM bc_NhapXuatTon">
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridNhapXuatTon">
    </dx:ASPxGridViewExporter>
</asp:Content>
