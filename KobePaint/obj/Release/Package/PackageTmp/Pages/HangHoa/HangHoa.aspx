<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="HangHoa.aspx.cs" Inherits="KobePaint.Pages.HangHoa.HangHoa" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function onExcelClick() {
            popupViewExcel.Show();
        }
        function onFileUploadComplete() {
            popupViewExcel.Hide();
            gridHangHoa.Refresh();
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
      <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%" ColCount="4">
        <Items>
            
                    <dx:LayoutItem Caption="">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnThemHangHoa" runat="server" ImagePosition="Right" Text="Thêm hàng hóa" PostBackUrl="~/Pages/HangHoa/ThemHangHoa.aspx">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnNhapExcel" runat="server" AutoPostBack="false" Text="Nhập Excel" ClientInstanceName="btnNhapExcel">
                                    <ClientSideEvents Click="onExcelClick" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                <dx:ASPxButton ID="btnXuatExcel" runat="server" OnClick="btnXuatExcel_Click" Text="Xuất Excel">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Tình trạng hàng hóa" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="ccbLoaiHangHoa" runat="server" SelectedIndex="0">
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="Đang kinh doanh" Value="0" />
                                        <dx:ListEditItem Text="Ngừng kinh doanh" Value="1" />
                                    </Items>
                                     <ClientSideEvents SelectedIndexChanged="function(s, e){ gridHangHoa.Refresh(); }" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Nhóm khách hàng" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                <dx:ASPxGridViewExporter ID="exproter" runat="server" ExportedRowType="All" GridViewID="gridHangHoa">
                                </dx:ASPxGridViewExporter>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
            </Items>
         </dx:ASPxFormLayout>


    <dx:ASPxGridView ID="gridHangHoa" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridHangHoa" Width="100%" DataSourceID="dsHangHoa" KeyFieldName="IDHangHoa" OnCustomColumnDisplayText="grid_CustomColumnDisplayText">
        
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True"/>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <Templates>
            <DetailRow>
                <div style="width: 100%; text-align:center;">
                    <div style="display:inline-block;">
                        <dx:ASPxGridView ID="gridApGia" runat="server" AutoGenerateColumns="False" DataSourceID="dsTheKho" KeyFieldName="IDTheKho" Width="800px" OnBeforePerformDataSelect="gridApGia_BeforePerformDataSelect" OnRowValidating="gridApGia_RowValidating">
                            <SettingsPager Mode="EndlessPaging">
                            </SettingsPager>
                            <Settings ShowTitlePanel="True" ShowFooter="True" />
                            <SettingsCommandButton>
                                <ShowAdaptiveDetailButton ButtonType="Image">
                                </ShowAdaptiveDetailButton>
                                <HideAdaptiveDetailButton ButtonType="Image">
                                </HideAdaptiveDetailButton>
                                <NewButton ButtonType="Image" RenderMode="Image">
                                    <Image IconID="numberformats_accounting_16x16">
                                    </Image>
                                </NewButton>
                                <EditButton ButtonType="Image" RenderMode="Image">
                                    <Image IconID="tasks_edittask_16x16office2013">
                                    </Image>
                                </EditButton>
                                <DeleteButton ButtonType="Image" RenderMode="Image">

                                    <Image IconID="actions_close_16x16devav">
                                     
                                    </Image>
                                </DeleteButton>
                            </SettingsCommandButton>
                            <SettingsText Title="THẺ KHO" EmptyDataRow="không có dữ liệu" />
                            <Columns>
                              
                                <dx:GridViewDataTextColumn Caption="Diễn giải" FieldName="DienGiai" Width="100%" CellStyle-HorizontalAlign="Left" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Tồn" FieldName="Ton" VisibleIndex="5" Width="80px">
                                    <PropertiesSpinEdit DisplayFormatString="g">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Xuất" FieldName="Xuat" VisibleIndex="4" Width="80px">
                                    <PropertiesSpinEdit DisplayFormatString="g">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Nhập" FieldName="Nhap" VisibleIndex="3" Width="80px">
                                    <PropertiesSpinEdit DisplayFormatString="g">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataDateColumn Caption="Ngày" Width="150px" FieldName="NgayNhap" VisibleIndex="1" CellStyle-HorizontalAlign="Left">
                                    <PropertiesDateEdit DisplayFormatString="dd/MM/yy H:mm">
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                              
                            </Columns>
                            <TotalSummary>
                                <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="Nhap" ShowInColumn="Nhập" ShowInGroupFooterColumn="Nhập" SummaryType="Sum" />
                                <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="Xuat" ShowInColumn="Xuất" ShowInGroupFooterColumn="Xuất" SummaryType="Sum" />
                            </TotalSummary>
                            <Styles>
                                <Header HorizontalAlign="Center">
                                </Header>
                                <TitlePanel ForeColor="#00CC00" Font-Bold="True" Font-Size="14px">
                                </TitlePanel>
                            </Styles>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="dsTheKho" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [NgayNhap], [DienGiai], [Nhap], [Xuat], [Ton],[IDTheKho] FROM [kTheKho] WHERE ([HangHoaID] = @HangHoaID) ORDER BY [IDTheKho] DESC">
                              <SelectParameters>
                                <asp:SessionParameter Name="HangHoaID" SessionField="IDHangHoa" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </DetailRow>
        </Templates>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsDataSecurity AllowInsert="False" />
        <SettingsPopup>
            <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="TopSides" />
        </SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." PopupEditFormCaption="Nhập thông tin hàng hóa" ConfirmDelete="Xác nhận thao tác" />
        <Styles>
            <Header HorizontalAlign="Center">
            </Header>
            <GroupRow ForeColor="#428BCA">
            </GroupRow>
            <DetailRow HorizontalAlign="Center">
            </DetailRow>
            <DetailCell HorizontalAlign="Center">
            </DetailCell>
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
        <SettingsBehavior ConfirmDelete="True" AllowSelectByRowClick="True" />
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
            <EditButton ButtonType="Image" RenderMode="Image" Text="Cập nhật tên và giá">
                <Image IconID="edit_edit_16x16office2013" ToolTip="Cập nhật tên và giá">
                </Image>
            </EditButton>
            <DeleteButton ButtonType="Image"  RenderMode="Image">
                <Image IconID="arrows_play_16x16" ToolTip="Ngừng/Đang kinh doanh">
                </Image>
                 <%--<Image ToolTip="Ngừng kinh doanh" Url="../../images/add.png" Width="16px" Height="16px" />--%>
            </DeleteButton>
        </SettingsCommandButton>
        <EditFormLayoutProperties ColCount="2">
            <Items>
                <dx:GridViewColumnLayoutItem ColumnName="Hàng hóa">
                </dx:GridViewColumnLayoutItem>
                <dx:GridViewColumnLayoutItem ColumnName="Giá bán">
                </dx:GridViewColumnLayoutItem>
                <dx:EditModeCommandLayoutItem ColSpan="2" HorizontalAlign="Right">
                </dx:EditModeCommandLayoutItem>
            </Items>
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" VisibleIndex="9" Name="chucnang">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="IDHangHoa" ReadOnly="True" VisibleIndex="0" Width="50px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mã hàng" FieldName="MaHang" VisibleIndex="2" ReadOnly="True">
                <EditFormSettings Visible="False" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Nhóm hàng" FieldName="NhomHHID" VisibleIndex="6" Width="150px" ReadOnly="True">
               
                <PropertiesComboBox DataSourceID="dsNhomHang" TextField="TenNhom" ValueField="IDNhomHH">
                </PropertiesComboBox>
               
                <EditFormSettings Visible="False" />
               
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="Giá bán" FieldName="GiaBan" VisibleIndex="5">
                <PropertiesSpinEdit DecimalPlaces="2" DisplayFormatString="N0" NumberFormat="Custom" DisplayFormatInEditMode="True" Increment="5000">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="ĐVT" FieldName="DonViTinhID" VisibleIndex="3" ReadOnly="True">
                <PropertiesComboBox DataSourceID="dsDVT" DisplayFormatString="g" TextField="TenDonViTinh" ValueField="IDDonViTinh">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="TonKho" VisibleIndex="4" ReadOnly="True">
                <PropertiesSpinEdit DisplayFormatString="g">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn Caption="Hàng hóa" FieldName="TenHangHoa" VisibleIndex="1" Width="200px" Name="hanghoa">
                 <DataItemTemplate>
                    
                     <a target="_blank" href="CapNhat.aspx?id=<%# Container.KeyValue %>" > <%# Eval("TenHangHoa") %></a>
                </DataItemTemplate>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Loại hàng hóa" FieldName="LoaiHHID" VisibleIndex="8" Width="150px">
                <PropertiesComboBox DataSourceID="dsLoaiHangHoa" TextField="TenLoai" ValueField="IDLoaiHangHoa">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
    </dx:ASPxGridView>
      <asp:SqlDataSource ID="dsLoaiHangHoa" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDLoaiHangHoa], [TenLoai] FROM [hhLoaiHangHoa]"></asp:SqlDataSource>
      <asp:SqlDataSource ID="dsDVT" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDDonViTinh], [TenDonViTinh] FROM [hhDonViTinh] WHERE ([DaXoa] = @DaXoa)">
          <SelectParameters>
              <asp:Parameter DefaultValue="false" Name="DaXoa" Type="Boolean" />
          </SelectParameters>
      </asp:SqlDataSource>
      <asp:SqlDataSource ID="dsNhomHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDNhomHH], [TenNhom] FROM [hhNhomHang] WHERE ([DaXoa] = @DaXoa)">
          <SelectParameters>
              <asp:Parameter DefaultValue="false" Name="DaXoa" Type="Boolean" />
          </SelectParameters>
      </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsHangHoa" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT [IDHangHoa], [MaHang],[LoaiHHID], [TenHangHoa], [NhomHHID], [DonViTinhID], [TonKho], [GiaBan] FROM [hhHangHoa] WHERE ([DaXoa] = @DaXoa)"
        UpdateCommand="UPDATE [hhHangHoa] SET [TenHangHoa] = @TenHangHoa,[GiaBan] = @GiaBan WHERE  [IDHangHoa] = @IDHangHoa"
        DeleteCommand="UPDATE hhHangHoa SET DaXoa = CASE WHEN DaXoa = 1 THEN 0 ELSE 1 END WHERE (IDHangHoa = @IDHangHoa)"
        >
        <SelectParameters>
           <asp:ControlParameter ControlID="formThongTin$ccbLoaiHangHoa" Name="DaXoa" PropertyName="Value" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="IDHangHoa" Type="Int32" />
            <asp:Parameter Name="GiaBan" Type="Double" />
            <asp:Parameter Name="TenHangHoa" Type="String" />
        </UpdateParameters>
        <DeleteParameters>
             <asp:Parameter Name="IDHangHoa" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridHangHoa);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridHangHoa);
        }" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxPopupControl ID="popupViewExcel" runat="server" ClientInstanceName="popupViewExcel" HeaderText="Thêm hàng hóa từ Excel" Width="600px" Height="200px" PopupHorizontalAlign="WindowCenter">
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
                            <dx:ASPxHyperLink ID="linkNhapKho" runat="server" Text="ThemHangHoa.xls" NavigateUrl="~/BieuMau/them_hang_hoa.xls">
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
                                NullText="Chọn file excel thêm hàng hóa..." UploadMode="Advanced" ShowUploadButton="True" ShowProgressPanel="True"
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
