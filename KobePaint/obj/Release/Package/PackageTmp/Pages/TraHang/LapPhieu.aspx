<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="LapPhieu.aspx.cs" Inherits="KobePaint.Pages.TraHang.LapPhieu" %>
<%@ Register assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function AdjustSize() {
            var hInfoPanel = splImport.GetPaneByName('splpInfoImport').GetClientHeight();
            var hInfoLayout = flayoutInfosImport.GetHeight();
            gridImportPro.SetHeight(hInfoPanel - hInfoLayout);
        }
        function onUnitReturnChanged(key) {
            cbpInfoImport.PerformCallback('UnitChange|' + key);
            cbpInfo.PerformCallback('refresh');
        }
        function endCallBackImport(s, e) {
            if (s.cp_Reset) {
                cbpInfoImport.PerformCallback('Reset');
                delete (s.cp_Reset);
                ShowPopup(4000);
            }
            if (s.cp_rpView) {
                hdfViewReport.Set('view', '1');
                popupViewReport.Show();
                reportViewer.GetViewer().Refresh();
                delete (s.cp_rpView);
            }
        }
        function onRenewClick() {
            if (confirm('Xác nhận thao tác ?')) {
                cbpInfoImport.PerformCallback('Reset');
                cbpInfo.PerformCallback('refresh');
            }
        }
        function checkInput() {
            if (ccbNhaCungCap.GetSelectedIndex() == -1) {
                ccbBarcode.SetSelectedIndex(-1);
                ccbNhaCungCap.Focus();
                alert('Vui lòng chọn khách hàng');
                return false;
            }
            return true;
        }
        function onSaveClick() {
            if (checkInput() && confirm('Xác nhận thao tác ?')) {
                cbpInfoImport.PerformCallback('Save');
                cbpInfoImport.PerformCallback('redirect');
            }
        }
        function onReviewClick() {
            if (checkInput())
                cbpInfoImport.PerformCallback('Review');
        }
        function ImportProduct() {
            cbpInfoImport.PerformCallback("import");
            cbpInfo.PerformCallback('refresh');
        }


        function ccbNhaCungCapChanged() {
            ccbSoPhieu.SetText() == "";
            cbpInfo.PerformCallback('ccbNhaCungCapChanged');
            cbpInfoImport.PerformCallback("refresh");
        }
        function ccbSoPhieuChanged() {
            if (checkInput()) {
                cbpInfo.PerformCallback('ccbSoPhieuChanged');
                cbpInfoImport.PerformCallback("refresh");
            }
        }
        
    </script>

    <style>
        .dxflGroupCell_Material{
            padding: 0 5px;
        }
        .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material
        {
            padding-top: 1px;
        }
    </style>
      <dx:ASPxSplitter ID="splImport" runat="server" ClientInstanceName="splImport" FullscreenMode="True" Height="100%" SeparatorVisible="False" Width="100%" Orientation="Vertical">
        <Styles>
            <Pane>
                                            
                  <Paddings Padding="0px" />
            </Pane>
        </Styles>
        <Panes>
            <dx:SplitterPane Name="splpInfo">
                <Panes>
                    <dx:SplitterPane MaxSize="350px" Name="splpInfoCustomer">
                        <ContentCollection>
                            <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
                                    <%--<ClientSideEvents EndCallback="endCallbackInfoCustomer" />--%>
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent1" runat="server">
                                            <dx:ASPxFormLayout ID="flayoutInfoNCC" runat="server" Width="100%">
                                                <Items>
                                                    <dx:LayoutGroup Caption="Thông tin đơn hàng" GroupBoxDecoration="HeadingLine">
                                                        <CellStyle>
                                                            <Paddings Padding="0px" />
                                                        </CellStyle>
                                                        <ParentContainerStyle>
                                                            <Paddings Padding="0px" />
                                                        </ParentContainerStyle>
                                                        <Items>
                                                            <dx:LayoutItem Caption="Mã phiếu">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                                                        <dx:ASPxTextBox ID="txtMaPhieu" runat="server" Enabled="False" Text="Hệ thống tự tạo..." Width="100%">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionSettings Location="Left" />
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Khách hàng">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                                                        <dx:ASPxComboBox ID="ccbNhaCungCap" TextFormatString="{0};{1}" ClientInstanceName="ccbNhaCungCap" NullText="-- Chọn khách hàng --" runat="server" Width="100%" DataSourceID="dsNhaCungCap" ValueField="IDKhachHang" TextField="HoTen">
                                                                        <ClientSideEvents SelectedIndexChanged="ccbNhaCungCapChanged" />
                                                                        <Columns>
                                                                                <dx:ListBoxColumn FieldName="MaKhachHang" Width="90px" Caption="Mã khách hàng" />
                                                                                <dx:ListBoxColumn FieldName="HoTen" Width="150px" Caption="Tên khách hàng" />
                                                                            </Columns>
                                                                        </dx:ASPxComboBox>
                                                                        <asp:SqlDataSource ID="dsNhaCungCap" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
                                                                            SelectCommand="SELECT [IDKhachHang],[MaKhachHang], [HoTen] FROM [khKhachHang] WHERE (([DaXoa] = @DaXoa) AND ([LoaiKhachHangID] <> @LoaiKhachHangID)) ORDER BY [HoTen]">
                                                                            <SelectParameters>
                                                                                <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
                                                                                <asp:Parameter DefaultValue="2" Name="LoaiKhachHangID" Type="Int32" />
                                                                            </SelectParameters>
                                                                              
                                                                        </asp:SqlDataSource>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionSettings Location="Left" />
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Số phiếu">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                                                        <dx:ASPxComboBox ID="ccbSoPhieu" ClientInstanceName="ccbSoPhieu" runat="server" Width="100%" NullText="--Chọn phiếu trả hàng--" ValueField="IDPhieuGiaoHang" TextFormatString="Mã phiếu {0}">
                                                                             <Columns>
                                                                                <dx:ListBoxColumn Caption="Mã phiếu" FieldName="MaPhieu" />
                                                                            </Columns>
                                                                            <ClientSideEvents SelectedIndexChanged="ccbSoPhieuChanged" />
                                                                        </dx:ASPxComboBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionSettings Location="Left" />
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Ngày trả">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                                                        <dx:ASPxDateEdit ID="dateNgayTra" runat="server" Width="100%" OnInit="dateNgayTra_Init">
                                                                        </dx:ASPxDateEdit>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionSettings Location="Left" />
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Ngày lập">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxDateEdit ID="dateNgayLap" runat="server" Enabled="False" OnInit="dateNgayLap_Init" Width="100%">
                                                                        </dx:ASPxDateEdit>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionSettings Location="Left" />
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Nhân viên">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                                                        <dx:ASPxTextBox ID="txtTenNhanVien" runat="server" Enabled="False" Width="100%">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionSettings Location="Left" />
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Hình thức">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxCheckBox ID="ckGiamCongNo" runat="server" CheckState="Unchecked" ClientInstanceName="ckGiamCongNo" Text="Giảm công nợ" Width="100%">
                                                                            
                                                                        </dx:ASPxCheckBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionSettings Location="Left" />
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Ghi chú">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">
                                                                        <dx:ASPxMemo ID="memoGhiChu" runat="server" Rows="4" Width="100%">
                                                                        </dx:ASPxMemo>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                        </Items>
                                                    </dx:LayoutGroup>
                                                </Items>
                                                <SettingsItemCaptions Location="Top" />
                                            </dx:ASPxFormLayout>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                    <dx:SplitterPane Name="splpInfoImport">
                        <ContentCollection>
                            <dx:SplitterContentControl ID="SplitterContentControl2" runat="server">
                                <dx:ASPxCallbackPanel ID="cbpInfoImport" ClientInstanceName="cbpInfoImport" runat="server" Width="100%" OnCallback="cbpInfoImport_Callback" DefaultButton="btnImportToList">
                                    <ClientSideEvents EndCallback="endCallBackImport" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent2" runat="server">                                            
                                              <dx:ASPxFormLayout ID="flayoutInfosImport" ClientInstanceName="flayoutInfosImport" runat="server" Width="100%">
                                                <Items>
                                                    <dx:LayoutGroup Caption="Thông tin khách hàng trả hàng" ColCount="6" GroupBoxDecoration="HeadingLine">
                                                        <Items>
                                                            <dx:LayoutItem Caption="" ColSpan="4" ShowCaption="False" Width="100%">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer10" runat="server">
                                                                       <table style="width:100%">
                                                                           <tr>
                                                                               <td style="width:80%">
                                                                                   <dx:ASPxComboBox ID="ccbBarcode" runat="server" ValueType="System.String"
                                                                                        ClientInstanceName="ccbBarcode"
                                                                                        DropDownWidth="600" DropDownStyle="DropDown"
                                                                                        ValueField="IDHangHoa"
                                                                                        NullText="Nhập Barcode hoặc mã hàng" Width="100%" TextFormatString="{0} - {1}"
                                                                                        EnableCallbackMode="true" CallbackPageSize="20"
                                                                                        OnItemsRequestedByFilterCondition="ccbBarcode_ItemsRequestedByFilterCondition"
                                                                                        OnItemRequestedByValue="ccbBarcode_ItemRequestedByValue">
                                                                                        <Columns>
                                                                                            <dx:ListBoxColumn FieldName="MaHang" Width="50px" Caption="Mã Hàng" />
                                                                                            <dx:ListBoxColumn FieldName="TenHangHoa" Width="250px" Caption="Tên Hàng Hóa" />
                                                                                        </Columns>
                                                                                        <DropDownButton Visible="False">
                                                                                        </DropDownButton>
                                                                                    </dx:ASPxComboBox>
                                                                                    <asp:SqlDataSource ID="dsHangHoa" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>">
                                                                                        <SelectParameters>
                                                                                            <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
                                                                                        </SelectParameters>
                                                                                    </asp:SqlDataSource>
                                                                               </td>
                                                                               <td style="width:20%;padding-left:10px;">
                                                                                   <dx:ASPxSpinEdit ID="spSoLuong" ToolTip="Số lượng" ClientInstanceName="spSoLuong" runat="server" Number="1" MinValue="1" MaxValue="1000000"  Caption="Số lượng"   HorizontalAlign="Right" CaptionStyle-Font-Bold="true" Font-Bold="true"> 
                                                                                        <CaptionStyle Font-Bold="True"></CaptionStyle>
                                                                                   </dx:ASPxSpinEdit>
                                                                               </td>
                                                                           </tr>
                                                                       </table>
                                                                        
                                                                         
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer11" runat="server">
                                                                        <dx:ASPxButton ID="btnImportToList" runat="server" Text="Đưa vào DS" AutoPostBack="False" UseSubmitBehavior="true">
                                                                            <ClientSideEvents Click="ImportProduct" />
                                                                        </dx:ASPxButton>
                                                                        <dx:ASPxHiddenField ID="hiddenFields" runat="server"></dx:ASPxHiddenField>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            
                                                        </Items>
                                                    </dx:LayoutGroup>
                                                </Items>
                                                <SettingsItemCaptions Location="Top" />
                                            </dx:ASPxFormLayout>

                                            <dx:ASPxGridView ID="gridImportPro" ClientInstanceName="gridImportPro" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="STT" OnRowDeleting="gridImportPro_RowDeleting">
                                                            <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFooter="True" />
                                                            <SettingsPager Mode="ShowAllRecords">
                                                            </SettingsPager>
                                                            <SettingsBehavior AllowSort="False" />
                                                            <SettingsCommandButton>
                                                                <ShowAdaptiveDetailButton ButtonType="Image">
                                                                </ShowAdaptiveDetailButton>
                                                                <HideAdaptiveDetailButton ButtonType="Image">
                                                                </HideAdaptiveDetailButton>
                                                                <DeleteButton ButtonType="Image" RenderMode="Image">
                                                                    <Image IconID="actions_cancel_16x16">
                                                                    </Image>
                                                                </DeleteButton>
                                                            </SettingsCommandButton>
                                                            <SettingsText EmptyDataRow="Chưa có dữ liệu" />
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn Caption="STT" FieldName="STT" ShowInCustomizationForm="True" VisibleIndex="0" Width="50px">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn Caption="Tên hàng hóa" FieldName="TenHangHoa" ShowInCustomizationForm="True" VisibleIndex="2" Width="100%">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn Caption="Mã HH" FieldName="MaHang" ShowInCustomizationForm="True" VisibleIndex="1" Width="100px">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewCommandColumn Caption="Xóa" ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="9" Width="50px">
                                                                </dx:GridViewCommandColumn>
                                                                <dx:GridViewDataTextColumn Caption="Tồn" FieldName="TonKho" ShowInCustomizationForm="True" VisibleIndex="3" Width="50px">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="ThanhTien" ShowInCustomizationForm="True" VisibleIndex="7" Width="100px">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                                                    </PropertiesSpinEdit>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Giá vốn" FieldName="GiaVon" ShowInCustomizationForm="True" VisibleIndex="4" Width="100px" Name="giavon">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0"></PropertiesSpinEdit>
                                                                    
                                                                    <CellStyle>
                                                                        <Paddings Padding="2px" />
                                                                    </CellStyle>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Số lượng" FieldName="SoLuong" ShowInCustomizationForm="True" VisibleIndex="6" Width="100px">
                                                                    <PropertiesSpinEdit DisplayFormatString="g"></PropertiesSpinEdit>
                                                                    <DataItemTemplate>
                                                                        <dx:ASPxSpinEdit ID="spSoLuongReturn" runat="server" Number='<%# Convert.ToInt32(Eval("SoLuong")) %>' DisplayFormatString="N0" Width="100%" NumberType="Integer" OnInit="spSoLuongReturn_Init" HorizontalAlign="Center">
                                                                        </dx:ASPxSpinEdit>
                                                                    </DataItemTemplate>
                                                                    <CellStyle>
                                                                        <Paddings Padding="2px" />
                                                                    </CellStyle>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Tiền trả" FieldName="TienTra" ShowInCustomizationForm="True" VisibleIndex="5" Width="150px">
                                                                    <PropertiesSpinEdit DisplayFormatString="g"></PropertiesSpinEdit>
                                                                    <DataItemTemplate>
                                                                        <dx:ASPxSpinEdit ID="spTienTraReturn" runat="server" Number='<%# Convert.ToDouble(Eval("TienTra")) %>' DisplayFormatString="N0" Width="100%" NumberType="Integer" OnInit="spTienTraReturn_Init" Increment="5000" HorizontalAlign="Right">
                                                                        </dx:ASPxSpinEdit>
                                                                    </DataItemTemplate>
                                                                    <CellStyle>
                                                                        <Paddings Padding="2px" />
                                                                    </CellStyle>
                                                                </dx:GridViewDataSpinEditColumn>
                                                            </Columns>
                                                            <FormatConditions>
                                                                <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] < 1" Format="LightRedFillWithDarkRedText" />
                                                                <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] > 0" Format="GreenFillWithDarkGreenText" />
                                                                <dx:GridViewFormatConditionTopBottom FieldName="TonKho" Rule="TopItems" Threshold="15" Format="BoldText" CellStyle-HorizontalAlign="Center">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:GridViewFormatConditionTopBottom>
                                                            </FormatConditions>
                                                            <TotalSummary>
                                                                <dx:ASPxSummaryItem DisplayFormat="Tổng mặt hàng: {0:N0}" FieldName="MaHang" ShowInColumn="Mã HH" SummaryType="Count" />
                                                                <dx:ASPxSummaryItem DisplayFormat="Tổng tiền: {0:N0}" FieldName="ThanhTien" ShowInColumn="Thành tiền" SummaryType="Sum" />
                                                                <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="SoLuong" ShowInColumn="Số lượng" SummaryType="Sum" />
                                                            </TotalSummary>
                                                        </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                </Panes>
                <ContentCollection>
                    <dx:SplitterContentControl ID="SplitterContentControl3" runat="server">
                    </dx:SplitterContentControl>
                </ContentCollection>
            </dx:SplitterPane>
            <dx:SplitterPane Name="splpProcess" MaxSize="100px" Size="100px">
                <ContentCollection>
                    <dx:SplitterContentControl ID="SplitterContentControl4" runat="server">
                        <div style="align-items:center; text-align:center;padding-top:5px;">
                            <table style="margin: 0 auto;">
                                <tr>
                                    <td style="padding-right:10px;">
                                        <dx:ASPxButton ID="btnPreview" runat="server" Text="Xem trước" BackColor="#5cb85c" AutoPostBack="False">
                                            <ClientSideEvents Click="onReviewClick" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td>
                                        <dx:ASPxButton ID="btnSave"  ClientInstanceName="btnSave" runat="server" Text="Trả hàng" AutoPostBack="False">
                                            <ClientSideEvents Click="onSaveClick" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td style="padding-left:10px;">
                                        <dx:ASPxButton ID="btnRenew" runat="server" Text="Lập mới" BackColor="#d9534f" AutoPostBack="False">
                                            <ClientSideEvents Click="onRenewClick" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dx:SplitterContentControl>
                </ContentCollection>
            </dx:SplitterPane>
        </Panes>
    </dx:ASPxSplitter>

    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxPopupControl ID="popupViewReport" ClientInstanceName="popupViewReport" runat="server" HeaderText="Phiếu xuất hàng" Width="850px" Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowHeader="False" >
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server">
            </dx:ASPxDocumentViewer>
            <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
            </dx:ASPxHiddenField>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
</asp:Content>
