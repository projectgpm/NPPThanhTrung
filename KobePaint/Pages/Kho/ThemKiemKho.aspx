<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ThemKiemKho.aspx.cs" Inherits="KobePaint.Pages.Kho.ThemKiemKho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <script>
         function AdjustSize() {
             var hInfoPanel = splImport.GetPaneByName('splpInfoImport').GetClientHeight();
             var hInfoLayout = flayoutInfosImport.GetHeight();
             gridImportPro.SetHeight(hInfoPanel - hInfoLayout);
         }

         function ImportProduct() {
             cbpInfo.PerformCallback("import");
         }
         function onSaveClick() {
             if (checkInput() && confirm('Xác nhận thao tác ?')) {
                 cbpInfo.PerformCallback('Save');
                 cbpInfo.PerformCallback('redirect');
             }
         }
         function onExcelClick() {
             popupViewExcel.Show();
         }

         function checkInput() {
             return true;
         }

         function onFileUploadComplete() {
             cbpInfo.PerformCallback('importexcel');
             popupViewExcel.Hide();
         }

         ///////////////////////////////////
         function onUnitReturnChanged(key) {
             cbpInfo.PerformCallback('UnitChange|' + key);
         }
         function endCallBackProduct(s, e) {
             if (s.cp_Reset) {
                 cbpInfo.PerformCallback('Reset');
                 delete (s.cp_Reset);
                 ShowPopup(4000);
             }
         }
    </script>

    <style>
        .dxflGroupCell_Material {
            padding: 0 5px;
        }

        .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material {
            padding-top: 1px;
        }
    </style>
  
<dx:ASPxPanel ID="panelImport" runat="server" Width="100%" DefaultButton="btnImportToList">
<PanelCollection>
        <dx:PanelContent ID="PanelContent1" runat="server">
            <dx:ASPxSplitter ID="splImport" runat="server" ClientInstanceName="splImport" FullscreenMode="True" Height="100%" SeparatorVisible="False" Width="100%" Orientation="Vertical">
                <Styles>
                    <Pane>
                        <Paddings Padding="0px" />
                    </Pane>
                </Styles>
                <Panes>
                    <dx:SplitterPane Name="splpInfo">
                        <Panes>
                            <dx:SplitterPane MaxSize="300px" Name="splpInfoNCC">
                                <ContentCollection>
                                    <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                            <dx:ASPxFormLayout ID="flayoutInfoNCC" runat="server" Width="100%">
                                        <Items>
                                            <dx:LayoutGroup Caption="Thông tin phiếu kiểm kê" GroupBoxDecoration="HeadingLine">
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
                                                                <dx:ASPxTextBox ID="txtMaPhieu" runat="server" Enabled="False" Text="Hệ thống tự tạo" Width="100%">
                                                                </dx:ASPxTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="Ngày kiểm kê">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                                                <dx:ASPxDateEdit ID="dateNgayNhap" runat="server" OnInit="dateEditControl_Init" Width="100%">
                                                                    <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom">
                                                                        <RequiredField ErrorText="Không được để trống" IsRequired="True" />
                                                                    </ValidationSettings>
                                                                </dx:ASPxDateEdit>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="Người kiểm kê">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                                                <dx:ASPxTextBox ID="txtNguoiNhap" runat="server" Enabled="False" Width="100%">
                                                                </dx:ASPxTextBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="Thông tin khác">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">
                                                                <dx:ASPxMemo ID="memoGhiChu" runat="server" Rows="3" Width="100%">
                                                                </dx:ASPxMemo>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                                        
                                                </Items>
                                            </dx:LayoutGroup>
                                        </Items>
                                        <SettingsItemCaptions Location="Top" />
                                    </dx:ASPxFormLayout>
                                    </dx:SplitterContentControl>
                                    </ContentCollection>
                                </dx:SplitterPane>

                            <dx:SplitterPane Name="splpInfoImport"  >
                                <ContentCollection>
                                    <dx:SplitterContentControl ID="SplitterContentControl2" runat="server">
                                            <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
                                            <PanelCollection>
                                                <dx:PanelContent ID="PanelContent3" runat="server">
                                        <dx:ASPxFormLayout ID="flayoutInfosImport" ClientInstanceName="flayoutInfosImport" runat="server" Width="100%">
                                            <Items>
                                                <dx:LayoutGroup Caption="Thông tin kiểm kê" ColCount="6" GroupBoxDecoration="HeadingLine">
                                                    <Items>
                                                        <dx:LayoutItem Caption="" ColSpan="4" ShowCaption="False" Width="100%">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer8" runat="server">
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
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="" ShowCaption="False">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server">
                                                                    <dx:ASPxButton ID="btnImportToList" runat="server" Text="Đưa vào DS" AutoPostBack="False">
                                                                        <ClientSideEvents Click="ImportProduct" />
                                                                    </dx:ASPxButton>
                                                                    <dx:ASPxHiddenField ID="hiddenFields" runat="server"></dx:ASPxHiddenField>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="Excel" ShowCaption="False">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer10" runat="server">
                                                                    <dx:ASPxButton ID="btnExcel" runat="server" AutoPostBack="False" ClientInstanceName="btnExcel" Text="Nhập Excel">
                                                                        <ClientSideEvents Click="onExcelClick" />
                                                                    </dx:ASPxButton>
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
                                                <dx:GridViewDataTextColumn Caption="Tên hàng hóa" FieldName="TenHangHoa" ShowInCustomizationForm="True" VisibleIndex="2" Width="60%">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="Mã HH" FieldName="MaHang" ShowInCustomizationForm="True" VisibleIndex="1" Width="80px">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewCommandColumn Caption="Xóa" ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="9" Width="50px">
                                                </dx:GridViewCommandColumn>
                                                <dx:GridViewDataSpinEditColumn Caption="Chênh lệch" FieldName="ChenhLech" ShowInCustomizationForm="True" VisibleIndex="6" Width="100px" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Center">
                                                    <PropertiesSpinEdit DisplayFormatString="N0"></PropertiesSpinEdit>
                                                    <CellStyle HorizontalAlign="Center" Font-Bold="True"></CellStyle>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataSpinEditColumn Caption="Tồn thực tế" FieldName="TonKhoThucTe" ShowInCustomizationForm="True" VisibleIndex="4" Width="100px">
                                                    <PropertiesSpinEdit DisplayFormatString="N0"></PropertiesSpinEdit>
                                                    <DataItemTemplate>
                                                        <dx:ASPxSpinEdit ID="spUnitReturn" runat="server" Number='<%# Convert.ToInt32(Eval("TonKhoThucTe")) %>' DisplayFormatString="N0" Width="100%" NumberType="Integer" OnInit="spUnitReturn_Init" HorizontalAlign="Center">
                                                        </dx:ASPxSpinEdit>
                                                    </DataItemTemplate>
                                                    <CellStyle>
                                                        <Paddings Padding="2px" />
                                                    </CellStyle>
                                                </dx:GridViewDataSpinEditColumn>              
                                                <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="TrangThai" ShowInCustomizationForm="True" CellStyle-HorizontalAlign="Center" VisibleIndex="5" Width="100px">
                                                    <PropertiesComboBox>
                                                        <Items>
                                                            <dx:ListEditItem Text="Đã kiểm kê" Value="1" />
                                                            <dx:ListEditItem Text="Đang kiểm kê" Value="0" />
                                                        </Items>
                                                    </PropertiesComboBox>
                                                    <CellStyle>
                                                        <Paddings Padding="2px" />
                                                    </CellStyle>
                                                </dx:GridViewDataComboBoxColumn>                      
                                                <dx:GridViewDataSpinEditColumn Caption="Tồn hệ thống" FieldName="TonKhoHeThong" ShowInCustomizationForm="True" CellStyle-Font-Bold="true" CellStyle-Font-Italic="true" CellStyle-HorizontalAlign="Center" VisibleIndex="3" Width="100px">
                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                                    </PropertiesSpinEdit>
                                                    <PropertiesSpinEdit DisplayFormatString="g">
                                                    </PropertiesSpinEdit>
                                                    <CellStyle HorizontalAlign="Center" Font-Bold="True" Font-Italic="True"></CellStyle>
                                                </dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataMemoColumn Caption="Diễn giải" FieldName="DienGiai" ShowInCustomizationForm="True" VisibleIndex="8" Width="150px">
                                                    <PropertiesMemoEdit >
                                                    </PropertiesMemoEdit>
                                                    <DataItemTemplate>
                                                        <dx:ASPxMemo ID="memoDienGiai" NullText="Nhập nguyên nhân" runat="server" Height="20px" Text='<%# Eval("DienGiai") %>' Width="100%" OnInit="memoDienGiai_Init">

                                                        </dx:ASPxMemo>
                                                    </DataItemTemplate>
                                                    <CellStyle>
                                                        <Paddings Padding="2px" />
                                                    </CellStyle>
                                                </dx:GridViewDataMemoColumn>                
                                            </Columns>
                                            <FormatConditions>
                                                <dx:GridViewFormatConditionHighlight FieldName="TrangThai" Expression="[TrangThai] = 0" Format="YellowFillWithDarkYellowText" />
                                                <dx:GridViewFormatConditionHighlight FieldName="TrangThai" Expression="[TrangThai] = 1" Format="GreenFillWithDarkGreenText"  CellStyle-Font-Italic="true" >
                                                <CellStyle Font-Italic="True"></CellStyle>
                                                </dx:GridViewFormatConditionHighlight>
                                                <dx:GridViewFormatConditionHighlight FieldName="ChenhLech" Expression="[ChenhLech] = 0" Format="GreenFillWithDarkGreenText" />
                                                <dx:GridViewFormatConditionHighlight FieldName="ChenhLech" Expression="[ChenhLech] < 0" Format="LightRedFillWithDarkRedText" />
                                                <dx:GridViewFormatConditionHighlight FieldName="ChenhLech" Expression="[ChenhLech] > 0" Format="YellowFillWithDarkYellowText" />
                                            </FormatConditions>
                                            <TotalSummary>
                                                <dx:ASPxSummaryItem DisplayFormat="Tổng mặt hàng: {0:N0}" FieldName="MaHang" ShowInColumn="Mã HH" SummaryType="Count" />
                                                <dx:ASPxSummaryItem DisplayFormat="Tổng = {0:N0}" FieldName="TonKhoThucTe" ShowInColumn="Tồn kho tế" SummaryType="Sum" />
                                                <dx:ASPxSummaryItem DisplayFormat="Tổng = {0:N0}" FieldName="TonKhoHeThong" ShowInColumn="Tồn hệ thống" SummaryType="Sum" />
                                                <dx:ASPxSummaryItem DisplayFormat="Tổng = {0:N0}" FieldName="ChenhLech" ShowInColumn="Chênh lệch" SummaryType="Sum" />
                                            </TotalSummary>
                                        </dx:ASPxGridView>
                                                            </dx:PanelContent>
                                            </PanelCollection>
                                        <ClientSideEvents EndCallback="endCallBackProduct" />
                                        </dx:ASPxCallbackPanel>
                                    </dx:SplitterContentControl>
                                </ContentCollection>
                            </dx:SplitterPane>
                        </Panes>
                    <ContentCollection>
                    <dx:SplitterContentControl ID="SplitterContentControl3" runat="server"></dx:SplitterContentControl>
                    </ContentCollection>
                    </dx:SplitterPane>
                        <dx:SplitterPane Name="splpProcess" MaxSize="100px" Size="100px">
                        <ContentCollection>
                            <dx:SplitterContentControl ID="SplitterContentControl4" runat="server">
                                <div style="align-items: center; text-align: center; padding-top: 5px;">
                                    <table style="margin: 0 auto;">
                                        <tr>
                                            <td style="padding-left: 10px">
                                                <dx:ASPxButton ID="btnCanBang" runat="server" Text="Cân Bằng" AutoPostBack="false" UseSubmitBehavior="false">
                                                    <ClientSideEvents Click="onSaveClick" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-left: 10px">
                                                &nbsp;</td>
                                            <td style="padding-left: 10px;">
                                                <dx:ASPxButton ID="btnTroVe" ClientInstanceName="btnTroVe" runat="server" Text="Trở về" BackColor="#d9534f" AutoPostBack="false" UseSubmitBehavior="false">
                                                <ClientSideEvents Click="function(){ if(confirm('Xác nhận thao tác ?')) { cbpInfo.PerformCallback('redirect'); } }" />
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
        </dx:PanelContent>
    </PanelCollection>
    </dx:ASPxPanel>
      
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>


    <dx:ASPxPopupControl ID="popupViewExcel" runat="server" ClientInstanceName="popupViewExcel" HeaderText="Nhập hàng hóa từ Excel" Width="800px" Height="200px" PopupHorizontalAlign="WindowCenter">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
                </dx:ASPxHiddenField>
                <table>
                    <tr>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Tải file mẫu:"></dx:ASPxLabel>
                        </td>
                        <td style="float: left; padding-left: 3px;">
                            <dx:ASPxHyperLink ID="linkNhapKho" runat="server" Text="kiemke.xls" NavigateUrl="~/BieuMau/kiemke.xls">
                            </dx:ASPxHyperLink>
                        </td>
                    </tr>

                </table>
                <table>
                    <tr style="padding-top: 20px">
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Font-Italic="true" Text="Lưu ý: Hệ thống chỉ hỗ trợ tối đa 500 hàng hóa cho mỗi lần nhập dữ liệu từ file."></dx:ASPxLabel>
                        </td>

                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="500px"
                                NullText="Chọn file excel nhập hàng..." UploadMode="Advanced" ShowUploadButton="True" ShowProgressPanel="True"
                                OnFileUploadComplete="UploadControl_FileUploadComplete">
                                <BrowseButton Text="Chọn file excel">
                                    <Image IconID="actions_open_32x32office2013">
                                    </Image>
                                </BrowseButton>
                                <RemoveButton Text="Xóa">
                                    <Image IconID="actions_cancel_32x32office2013">
                                    </Image>
                                </RemoveButton>
                                <UploadButton Text="Tải lên">
                                    <Image IconID="miscellaneous_publish_32x32office2013">
                                    </Image>
                                </UploadButton>
                                <CancelButton Text="Hủy">
                                    <Image IconID="actions_cancel_32x32office2013">
                                    </Image>
                                </CancelButton>
                                <AdvancedModeSettings EnableMultiSelect="True" EnableDragAndDrop="True" />
                                <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xlt, .xls" NotAllowedFileExtensionErrorText="Vui lòng chọn đúng định dạng .xlt .xls">
                                </ValidationSettings>
                                <ClearFileSelectionImage IconID="actions_cancel_32x32office2013" ToolTip="Xóa file">
                                </ClearFileSelectionImage>
                                <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                            </dx:ASPxUploadControl>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
