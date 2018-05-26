<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="BangGia.aspx.cs" Inherits="KobePaint.Pages.HangHoa.BangGia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function AdjustSize() {
            var hInfoPanel = splImport.GetPaneByName('splpInfoImport').GetClientHeight();
            var hInfoLayout = flayoutInfosImport.GetHeight();
            gridImportPro.SetHeight(hInfoPanel - hInfoLayout);
        }

        function ImportProduct() {
            if (ccbBangGia.GetSelectedIndex() == -1) {
                alert('Vui lòng chọn bảng giá');
                ccbBarcode.SetSelectedIndex(-1);
                ccbBangGia.Focus();
            }
            else {
                if (ccbBarcode.GetSelectedIndex() != -1) {
                    cbpInfo.PerformCallback("import");
                }
            }
        }
    
        function onExcelClick() {
            if (ccbBangGia.GetSelectedIndex() == -1) {
                alert('Vui lòng chọn bảng giá');
                ccbBarcode.SetSelectedIndex(-1);
                ccbBangGia.Focus();
            }
            else {
                popupViewExcel.Show();
            }
        }

        function checkInput() {
            return true;
        }

        function onFileUploadComplete() {
            cbpInfo.PerformCallback('importexcel');
            popupViewExcel.Hide();
        }
        function LoadBangGia() {
            ccbBangGia.PerformCallback();
           
        }
        function ccbBangGiaSelectChange() {
            cbpInfo_left.PerformCallback('ccbBangGiaSelectChange');
            cbpInfo.PerformCallback('ccbBangGiaSelectChange');
        }
        ///////////////////////////////////
        function onUnitReturnChanged(key) {
            cbpInfo.PerformCallback('UnitChange|' + key);
        }
        function endCallBackProduct(s, e) {
            if (s.cp_Reset) {
                //cbpInfo.PerformCallback('Reset');
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
  
    <dx:ASPxPanel ID="panelImport" ClientInstanceName="panelImport" runat="server" Width="100%" DefaultButton="btnImportToList">
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
                                <dx:SplitterPane MaxSize="300px" Name="splpInfoNCC"  >
                                    <ContentCollection>
                                        <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                             <dx:ASPxCallbackPanel ID="cbpInfo_left" ClientInstanceName="cbpInfo_left" runat="server" Width="100%" OnCallback="cbpInfo_left_Callback">
                                                <PanelCollection>
                                                    <dx:PanelContent ID="PanelContent2" runat="server">
                                                <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
                                                <Items>
                                                    <dx:LayoutGroup Caption="Thông tin bảng giá" GroupBoxDecoration="HeadingLine">
                                                        <CellStyle>
                                                            <Paddings Padding="0px" />
                                                        </CellStyle>
                                                        <ParentContainerStyle>
                                                            <Paddings Padding="0px" />
                                                        </ParentContainerStyle>
                                                        <Items>
                                                            <dx:LayoutItem Caption="Tên bảng giá">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                                                        <table>
                                                                            <tr>
                                                                                <td style="width: 90%">
                                                                                    <dx:ASPxComboBox ID="ccbBangGia" ClientInstanceName="ccbBangGia" runat="server" TextFormatString="{0};{1}" NullText="Chọn bảng giá" Width="100%" DataSourceID="dsBangGia" TextField="TenBangGia" ValueField="IDBangGia" EnableCallbackMode="True" OnCallback="ccbBangGia_Callback">
                                                                                        <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="InfosInput">
                                                                                            <RequiredField ErrorText="Chọn bảng giá" IsRequired="True" />
                                                                                        </ValidationSettings>
                                                                                        <ClientSideEvents DropDown="function(s,e){ LoadBangGia() }" SelectedIndexChanged="ccbBangGiaSelectChange" ></ClientSideEvents>
                                                                                     <Columns>
                                                                                        <dx:ListBoxColumn FieldName="MaBangGia" Width="50px" Caption="Mã BG" />
                                                                                        <dx:ListBoxColumn FieldName="TenBangGia" Width="250px" Caption="Tên Bảng Giá" />
                                                                                    </Columns>
                                                                                    </dx:ASPxComboBox>
                                                                                    <dx:ASPxHiddenField ID="hiddenfile" ClientInstanceName="hiddenfile" runat="server"></dx:ASPxHiddenField>
                                                                                    <asp:SqlDataSource ID="dsBangGia" runat="server" 
                                                                                        ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>"
                                                                                         SelectCommand="SELECT IDBangGia,MaBangGia, TenBangGia FROM bgBangGia WHERE (DaXoa = 0)">
                                                                                    </asp:SqlDataSource>
                                                                                </td>
                                                                                <td style="width: 10%; padding-left: 10px;">
                                                                                    <dx:ASPxHyperLink ID="btnThemBangGia" ClientInstanceName="btnThemBangGia" Target="_blank" runat="server" Text="Thêm"  ImageHeight="30px" ImageUrl="~/images/add.png" ImageWidth="30px" ToolTip="Thêm mới">
                                                                                        <ClientSideEvents Click="function(){popBangGia.Show()}" />           
                                                                                    </dx:ASPxHyperLink>

                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Phạm vi áp dụng">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                                                         <dx:ASPxMemo ID="memoPhamViApDung" ReadOnly ="true" runat="server" Rows="5" Width="100%">
                                                                        </dx:ASPxMemo>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Ghi chú">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                                                        <dx:ASPxMemo ID="memoGhiChu" ReadOnly="true" runat="server" Rows="5" Width="100%">
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

                                <dx:SplitterPane Name="splpInfoImport"  >
                                    <ContentCollection>
                                        <dx:SplitterContentControl ID="SplitterContentControl2" runat="server">
                                                <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
                                                <PanelCollection>
                                                    <dx:PanelContent ID="PanelContent3" runat="server">
                                                        <dx:ASPxFormLayout ID="flayoutInfosImport" ClientInstanceName="flayoutInfosImport" runat="server" Width="100%">
                                                            <Items>
                                                                <dx:LayoutGroup Caption="Thông tin hàng hóa" ColCount="6" GroupBoxDecoration="HeadingLine">
                                                                    <Items>
                                                                        <dx:LayoutItem Caption="" ColSpan="3" ShowCaption="False" Width="100%">
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
                                                                                    <dx:ASPxHiddenField ID="hiddenFields"  ClientInstanceName="hiddenFields" runat="server"></dx:ASPxHiddenField>
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
                                                                            
                                                                        <dx:LayoutItem ShowCaption="False">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                                    <dx:ASPxButton ID="btnXuatExcel" runat="server" AutoPostBack="False" ClientInstanceName="btnXuatExcel" Text="Xuất excel" OnClick="btnXuatExcel_Click" Visible="False">
                                                                                    </dx:ASPxButton>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                        </dx:LayoutItem>
                                                                            
                                                                    </Items>
                                                                </dx:LayoutGroup>
                                                            </Items>
                                                            <SettingsItemCaptions Location="Top" />
                                                        </dx:ASPxFormLayout>

                                                        <dx:ASPxGridView ID="gridImportPro" ClientInstanceName="gridImportPro" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="ID" OnRowDeleting="gridImportPro_RowDeleting" DataSourceID="dsChiTietBangGia" OnCustomColumnDisplayText="gridImportPro_CustomColumnDisplayText" OnRowUpdating="gridImportPro_RowUpdating">
                                                            <SettingsEditing Mode="Batch">
                                                            </SettingsEditing>
                                                            <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" />
                                                            <SettingsPager Mode="ShowAllRecords">
                                                            </SettingsPager>
                                                            <SettingsBehavior AllowSort="False" />
                                                            <SettingsCommandButton>
                                                                <ShowAdaptiveDetailButton ButtonType="Image">
                                                                </ShowAdaptiveDetailButton>
                                                                <HideAdaptiveDetailButton ButtonType="Image">
                                                                </HideAdaptiveDetailButton>
                                                                <ApplyFilterButton ButtonType="Image" RenderMode="Image">
                                                                    <Image IconID="save_saveto_32x32office2013">
                                                                    </Image>
                                                                </ApplyFilterButton>
                                                                <UpdateButton Text="Lưu lại">
                                                                    <Image IconID="save_saveto_32x32office2013" ToolTip="Lưu lại tất cả">
                                                                    </Image>
                                                                </UpdateButton>
                                                                <CancelButton Text="Hủy">
                                                                    <Image IconID="actions_cancel_32x32office2013" ToolTip="Hủy thao tác">
                                                                    </Image>
                                                                </CancelButton>
                                                                <DeleteButton ButtonType="Image" RenderMode="Image">
                                                                    <Image IconID="actions_cancel_16x16">
                                                                    </Image>
                                                                </DeleteButton>
                                                            </SettingsCommandButton>
                                                            <SettingsText EmptyDataRow="Chưa có dữ liệu" />
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn Caption="STT" ReadOnly="true" FieldName="ID" ShowInCustomizationForm="True" VisibleIndex="0" Width="50px">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn Caption="Tên hàng hóa" ReadOnly="true" FieldName="TenHangHoa" ShowInCustomizationForm="True" VisibleIndex="2" Width="60%">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn Caption="Mã HH" ReadOnly="true" FieldName="MaHang" ShowInCustomizationForm="True" VisibleIndex="1" Width="100px">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewCommandColumn Caption="Xóa" ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="9" Width="50px" Name="chucnang">
                                                                </dx:GridViewCommandColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Giá mới"  FieldName="GiaMoi" ShowInCustomizationForm="True" VisibleIndex="6" Width="150px">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0" Increment="500" NumberFormat="Custom">
                                                                    </PropertiesSpinEdit>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Giá vốn" ReadOnly="true" FieldName="GiaVon" ShowInCustomizationForm="True" VisibleIndex="4" Width="150px">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom"></PropertiesSpinEdit>
                                                                                              
                                                                    <CellStyle>
                                                                        <Paddings Padding="2px" />
                                                                    </CellStyle>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn  ReadOnly="true" Caption="Đơn giá nhập cuối" FieldName="DonGia" ShowInCustomizationForm="True" VisibleIndex="5" Width="150px">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0"></PropertiesSpinEdit>
                                                                </dx:GridViewDataSpinEditColumn>              
                                                                <dx:GridViewDataTextColumn Caption="ĐVT" ReadOnly="true" FieldName="TenDonViTinh" ShowInCustomizationForm="True" VisibleIndex="3" Width="100px">
                                                                </dx:GridViewDataTextColumn>                     
                                                            </Columns>
                                                            <%--<FormatConditions>
                                                                <dx:GridViewFormatConditionHighlight FieldName="DonGia" Expression="[GiaMoi] < [DonGia]" Format="LightRedFillWithDarkRedText" />
                                                                <dx:GridViewFormatConditionHighlight FieldName="DonGia" Expression="[GiaMoi] > [DonGia]" Format="GreenFillWithDarkGreenText" />
                                                            </FormatConditions>--%>
                                                        </dx:ASPxGridView>  
                                                         <dx:ASPxGridViewExporter ID="exproter" runat="server" ExportedRowType="All" GridViewID="gridImportPro" >
                                                        </dx:ASPxGridViewExporter>  
                                                        <asp:SqlDataSource ID="dsChiTietBangGia" runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
                                                            DeleteCommand="DELETE FROM bgChiTietBangGia WHERE (ID = @ID)" >
                                                            <DeleteParameters>
                                                                <asp:Parameter  Name="ID"  Type="Int32"/>
                                                            </DeleteParameters>
                                                        </asp:SqlDataSource>
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
                            <dx:SplitterPane Name="splpProcess" MaxSize="100px" Size="10px">
                            <ContentCollection>
                                <dx:SplitterContentControl ID="SplitterContentControl4" runat="server">  
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

     <dx:ASPxPopupControl ID="popBangGia"  runat="server" Width="800" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popBangGia"
        HeaderText="Danh sách bảng giá" ShowHeader="true" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">        
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxPanel ID="Panel12" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent ID="PanelContent4" runat="server">
                               <dx:ASPxGridView ID="gridBangGia" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridBangGia" Width="100%" DataSourceID="dsachBangGia" KeyFieldName="IDBangGia" OnCustomColumnDisplayText="gridBangGia_CustomColumnDisplayText">
                                                <SettingsEditing Mode="PopupEditForm">
                                                </SettingsEditing>
                                                <Settings VerticalScrollableHeight="0"/>
                                                <SettingsPager AlwaysShowPager="True" >
                                                    <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
                                                </SettingsPager>
                                                <SettingsPopup>
                                                    <EditForm HorizontalAlign="Center" VerticalAlign="WindowCenter" />
                                                </SettingsPopup>
                                                <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xóa dữ liệu ??" PopupEditFormCaption="Thông tin" />
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
                                                <Paddings Padding="0px" PaddingTop="20px" />
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
                                                <EditFormLayoutProperties>
                                                    <Items>
                                                        <dx:GridViewColumnLayoutItem ColumnName="Mã bảng giá">
                                                        </dx:GridViewColumnLayoutItem>
                                                        <dx:GridViewColumnLayoutItem ColumnName="Tên bảng giá">
                                                        </dx:GridViewColumnLayoutItem>
                                                        <dx:GridViewColumnLayoutItem ColumnName="Phạm vi áp dụng">
                                                        </dx:GridViewColumnLayoutItem>
                                                        <dx:GridViewColumnLayoutItem ColumnName="Ghi chú">
                                                        </dx:GridViewColumnLayoutItem>
                                                        <dx:EditModeCommandLayoutItem HorizontalAlign="Right">
                                                        </dx:EditModeCommandLayoutItem>
                                                    </Items>
                                                </EditFormLayoutProperties>
                                                <Columns>
                                                    <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="5" Width="200px">
                                                    </dx:GridViewCommandColumn>
                                                    <dx:GridViewDataTextColumn FieldName="IDBangGia" ReadOnly="True" VisibleIndex="0" Caption="STT" Width="60px">
                                                        <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                                                        <EditFormSettings Visible="False" />
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <CellStyle HorizontalAlign="Center">
                                                        </CellStyle>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="TenBangGia" VisibleIndex="2" Caption="Tên bảng giá">
                                                        <PropertiesTextEdit>
                                                            <ValidationSettings SetFocusOnError="True">
                                                                <RequiredField ErrorText="Nhập thông tin" IsRequired="True" />
                                                            </ValidationSettings>
                                                        </PropertiesTextEdit>
                                                        <Settings AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Phạm vi áp dụng" FieldName="PhamViApDung" ShowInCustomizationForm="True" VisibleIndex="3">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Ghi chú" FieldName="GhiChu" ShowInCustomizationForm="True" VisibleIndex="4">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Mã bảng giá" FieldName="MaBangGia" ShowInCustomizationForm="True" VisibleIndex="1">
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                            </dx:ASPxGridView>
                                            <asp:SqlDataSource ID="dsachBangGia" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>"
                                                 SelectCommand="SELECT IDBangGia, MaBangGia,TenBangGia, GhiChu, PhamViApDung FROM bgBangGia WHERE (DaXoa = 0) AND IDBangGia > 1" 
                                                 InsertCommand="INSERT INTO bgBangGia(MaBangGia,TenBangGia, GhiChu, PhamViApDung, DaXoa) VALUES (@MaBangGia,@TenBangGia, @GhiChu, @PhamViApDung, 0)"
                                                 UpdateCommand="UPDATE bgBangGia SET MaBangGia =@MaBangGia, TenBangGia = @TenBangGia, GhiChu = @GhiChu, PhamViApDung = @PhamViApDung WHERE (IDBangGia = @IDBangGia)"
                                                 DeleteCommand="UPDATE bgBangGia SET DaXoa = 1 WHERE (IDBangGia = @IDBangGia)" 
                                                >
                                                <DeleteParameters>
                                                    <asp:Parameter Name="IDBangGia"  />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="TenBangGia" />
                                                    <asp:Parameter Name="GhiChu" />
                                                    <asp:Parameter  Name="PhamViApDung" />
                                                    <asp:Parameter DefaultValue="MaBangGia" Name="MaBangGia" />
                                                </InsertParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="TenBangGia" />
                                                    <asp:Parameter Name="GhiChu"  />
                                                    <asp:Parameter Name="PhamViApDung" />
                                                    <asp:Parameter  Name="IDBangGia" />
                                                    <asp:Parameter DefaultValue="MaBangGia" Name="MaBangGia" />
                                                </UpdateParameters>
                                            </asp:SqlDataSource>
                                            <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
                                                <ClientSideEvents BrowserWindowResized="function(s, e) {
	                                                UpdateControlHeight(gridBangGia);
                                                }" ControlsInitialized="function(s, e) {
	                                                UpdateControlHeight(gridBangGia);
                                                }" />
                                            </dx:ASPxGlobalEvents>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="popupViewExcel" runat="server" ClientInstanceName="popupViewExcel" HeaderText="Nhập hàng hóa từ Excel" Width="600px" Height="200px" PopupHorizontalAlign="WindowCenter">
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
                            <dx:ASPxHyperLink ID="linkNhapKho" runat="server" Text="BangGia.xls" NavigateUrl="~/BieuMau/banggia.xls">
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
                                <BrowseButton Text="Chọn file excel...">
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
