<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CapNhat.aspx.cs" Inherits="KobePaint.Pages.HangHoa.CapNhat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function gridEndCallBack(s, e) {
            if (s.cpIsDelete == true) {
                s.AddNewRow();
                delete (s.cpIsDelete);
            }
        }
        function onSaveClick() {
            if (ASPxClientEdit.ValidateGroup('checkInput'))
                cbpThemHH.PerformCallback('Save');
        }

        function onRenewClick() {
            cbpThemHH.PerformCallback('Renew');
        }
        //popup
        function ShowDVT() {
            pcDVT.Show();
        }
        function ShowNhomHH() {
            pcNhomHang.Show();
        }
        //load dvt
        function LoadDVT(s, e) {
            ccvDVT.PerformCallback();
        }
        // load nhomhh
        function LoadNhomHang(s, e) {
            ccbNhomHH.PerformCallback();
        }
        // thong bao
        function endCallBack(s, e) {
            if (s.cp_Reset) {
                cbpThemHH.PerformCallback('Reset');
                delete (s.cp_Reset);
                ShowPopup(4000);
            }
        }
    </script>
 
    <dx:ASPxCallbackPanel ID="cbpThemHH" ClientInstanceName="cbpThemHH" runat="server" Width="100%" OnCallback="cbpThemHH_Callback">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent1" runat="server">
                <dx:ASPxFormLayout ID="formThemHH" runat="server" Width="100%">
                    <Items>
                        <dx:LayoutGroup Caption="Cập nhật hàng hóa" GroupBoxDecoration="HeadingLine" HorizontalAlign="Center" ColCount="2">
                            <Items>
                               
                                <dx:LayoutItem Caption="Tên hàng hóa">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                            <dx:ASPxTextBox ID="txtTenHH" runat="server" Width="100%">
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                    <RequiredField ErrorText="Vui lòng nhập tên hàng hóa" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Tình trạng hàng hóa">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="ccbLoaiHangHoa" runat="server" Width="100%">
                                                <Items>
                                                    <dx:ListEditItem Text="Đang kinh doanh" Value="0" />
                                                    <dx:ListEditItem Text="Ngừng kinh doanh" Value="1" />
                                                </Items>
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                    <RequiredField ErrorText="Chọn thông tin" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Nhóm hàng hóa">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                            <table style="width:100%">
                                                <tr>
                                                    <td style="padding-right:10px;width:100%;">
                                                         <dx:ASPxComboBox ID="ccbNhomHH"  ClientInstanceName="ccbNhomHH" runat="server" Width="100%" DataSourceID="dsNhomHH" TextField="TenNhom" ValueField="IDNhomHH" NullText="-- Chọn nhóm hàng --" CallbackPageSize="20" EnableCallbackMode="True" OnCallback="ccbNhomHH_Callback">
                                                             <ClientSideEvents DropDown="function(s,e){LoadNhomHang();}" ></ClientSideEvents>
                                                            
                                                             <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                                    <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                                </ValidationSettings>
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource  ID="dsNhomHH" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDNhomHH], [TenNhom] FROM [hhNhomHang] WHERE ([DaXoa] = @DaXoa)">
                                                        <SelectParameters>
                                                                <asp:Parameter DefaultValue="False" Name="DaXoa" Type="Boolean" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>    
                                                    </td>
                                                    <td style="padding-right:10px;width:5px;">
                                                          <dx:ASPxButton ID="btn_ThemNhomHH" runat="server" Text="Thêm" BackColor="#5cb85c" AutoPostBack="False">
                                                             <ClientSideEvents Click="function(s, e) { ShowNhomHH(); }" />
                                                           </dx:ASPxButton>
                                                       
                                                    </td>
                                                </tr>
                                            </table>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="ĐVT">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server">
                                            <table style="width:100%">
                                                <tr>
                                                    <td style="padding-right:10px;width:100%;">
                                                        <dx:ASPxComboBox ID="ccbDVT" runat="server" DataSourceID="dsDVT" Width="100%" NullText="-- Chọn ĐVT --" CallbackPageSize="20" EnableCallbackMode="True" TextField="TenDonViTinh" ValueField="IDDonViTinh" 
                                                            ClientInstanceName="ccvDVT" OnCallback="ccbDVT_Callback" IncrementalFilteringMode="StartsWith" EnableSynchronization="False">
                                                   
                                                          <ClientSideEvents DropDown="function(s,e){LoadDVT();}" >

                                                          </ClientSideEvents>
                                                            <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                                <RequiredField ErrorText="Chọn đơn vị tính" IsRequired="True" />
                                                            </ValidationSettings>
                                                               
                                                        </dx:ASPxComboBox>  <%--DataBind Refresh --%>


                                                        <asp:SqlDataSource  ID="dsDVT" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT * FROM [hhDonViTinh] WHERE ([DaXoa] = @DaXoa)">
                                                        <SelectParameters>
                                                                <asp:Parameter DefaultValue="False" Name="DaXoa" Type="Boolean" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>    
                                                    </td>
                                                    <td style="padding-right:10px;width:5px;">
                                                          <dx:ASPxButton ID="btnPreview" runat="server" Text="Thêm" BackColor="#5cb85c" AutoPostBack="False">
                                                             <ClientSideEvents Click="function(s, e) { ShowDVT(); }" />
                                                           </dx:ASPxButton>
                                                       
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Giá vốn">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">
                                            <dx:ASPxSpinEdit ID="spGiaVon" runat="server" Width="100%" Number="0" DisplayFormatString="N0" Increment="5000">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Giá bán">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer8" runat="server">
                                            <dx:ASPxSpinEdit ID="spGiaBan" runat="server" DisplayFormatString="N0" Increment="5000" Number="0" Width="100%">
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                    <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Loại hàng hóa">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="ccbTinhTrang" runat="server" DataSourceID="dsLoaiHangHoa" TextField="TenLoai" ValueField="IDLoaiHangHoa" Width="100%">
                                            <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                    <RequiredField ErrorText="Vui lòng chọn loại hàng hóa" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                            <asp:SqlDataSource ID="dsLoaiHangHoa" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDLoaiHangHoa], [TenLoai] FROM [hhLoaiHangHoa]"></asp:SqlDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Barcode" ColSpan="2" RowSpan="5">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server">
                                            <dx:ASPxTokenBox ID="tkBarcode" runat="server" AllowMouseWheel="True" Height="100px" Tokens="" Width="100%" NullText="Hệ thống tự tạo barcode giống với mã hàng hóa nếu bỏ trống.">
                                            </dx:ASPxTokenBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False" ColSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer10" runat="server">
                                            <table >
                                                <tr>
                                                    <td >
                                                        <dx:ASPxButton ID="btnSave" runat="server" Text="Lưu lại" ValidationGroup="checkInput" AutoPostBack="false">
                                                            <ClientSideEvents Click="onSaveClick" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                   
                                                    <td style="padding-left:10px;">
                                                        <dx:ASPxButton ID="btnRenew" runat="server" Text="Lập mới" Width="100" BackColor="#d9534f" AutoPostBack="false">
                                                            <ClientSideEvents Click="onRenewClick" />
                                                        </dx:ASPxButton>
                                                        
                                                    </td>
                                                     <td style="padding-left:10px;">
                                                        <dx:ASPxButton ID="btnTroVe" runat="server" Text="Trở về" AutoPostBack="true" PostBackUrl="~/Pages/HangHoa/HangHoa.aspx" >
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>

            </dx:PanelContent>
        </PanelCollection>
         <ClientSideEvents EndCallback="endCallBack" />
    </dx:ASPxCallbackPanel>

    <dx:ASPxPopupControl ID="pcDVT" ClientInstanceName="pcDVT" runat="server" HeaderText="Đơn vị tính" Width="500px" Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter"
        CloseAction="CloseButton" CloseOnEscape="True" PopupVerticalAlign="WindowCenter"  
         
         ><ClientSideEvents PopUp="function(s, e) { gridDVT.Refresh() }"/>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxButton ID="btnXuatExcel_DVT" runat="server" OnClick="btnXuatExcel_DVT_Click" Text="Xuất Excel">
                  </dx:ASPxButton>
                <dx:ASPxGridViewExporter ID="exproter_DVT" runat="server" ExportedRowType="All" GridViewID="gridDVT">
                 </dx:ASPxGridViewExporter>
                 <dx:ASPxGridView ID="gridDVT" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridDVT" Width="100%" DataSourceID="dsDonVT" KeyFieldName="IDDonViTinh" OnCustomColumnDisplayText="gridDVT_CustomColumnDisplayText">
                    <SettingsEditing Mode="Inline">
                    </SettingsEditing>
                    <Settings VerticalScrollableHeight="0" ShowFilterRow="True"/>
                    <SettingsPager AlwaysShowPager="True" >
                        <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
                    </SettingsPager>
                    <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xóa dữ liệu ??" />
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
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="2" Width="200px" ShowClearFilterButton="True">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="IDDonViTinh" ReadOnly="True" VisibleIndex="0" Caption="STT" Width="60px">
                            <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                            <EditFormSettings Visible="False" />
                            <HeaderStyle HorizontalAlign="Center" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TenDonViTinh" VisibleIndex="1" Caption="Đơn vị tính">
                            <PropertiesTextEdit>
                                <ValidationSettings SetFocusOnError="True">
                                    <RequiredField ErrorText="Nhập thông tin" IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsDonVT" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>"
                     SelectCommand="SELECT [IDDonViTinh], [TenDonViTinh] FROM [hhDonViTinh] Where [DaXoa] = 0" 
                     InsertCommand="INSERT INTO [hhDonViTinh] ([TenDonViTinh],[NgayNhap]) VALUES (@TenDonViTinh,getdate())"
                     UpdateCommand="UPDATE [hhDonViTinh] SET [TenDonViTinh] = @TenDonViTinh WHERE [IDDonViTinh] = @IDDonViTinh"
                     DeleteCommand="UPDATE [hhDonViTinh] SET [DaXoa] = 1 WHERE [IDDonViTinh] = @IDDonViTinh" 
                    >
                    <DeleteParameters>
                        <asp:Parameter Name="IDDonViTinh" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TenDonViTinh" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TenDonViTinh" Type="String" />
                        <asp:Parameter Name="IDDonViTinh" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
                    <ClientSideEvents BrowserWindowResized="function(s, e) {
	                    UpdateControlHeight(gridDVT);
                    }" ControlsInitialized="function(s, e) {
	                    UpdateControlHeight(gridDVT);
                    }" />
                </dx:ASPxGlobalEvents>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="pcNhomHang" ClientInstanceName="pcNhomHang" runat="server" HeaderText="Nhóm hàng" Width="500px" Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter"
        CloseAction="CloseButton" CloseOnEscape="True" PopupVerticalAlign="WindowCenter"  
         
         ><ClientSideEvents PopUp="function(s, e) { gridNhomHang.Refresh() }"/>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                 <dx:ASPxButton ID="btnXuatExcel_NhomHang" runat="server" OnClick="btnXuatExcel_NhomHang_Click" Text="Xuất Excel">
                  </dx:ASPxButton>
                <dx:ASPxGridViewExporter ID="exproter_NhomHang" runat="server" ExportedRowType="All" GridViewID="gridNhomHang">
                 </dx:ASPxGridViewExporter>
                <dx:ASPxGridView ID="gridNhomHang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridNhomHang" Width="100%" DataSourceID="dsNhomHang" KeyFieldName="IDNhomHH" OnCustomColumnDisplayText="gridNhomHang_CustomColumnDisplayText">
                    <SettingsEditing Mode="Inline">
                    </SettingsEditing>
                    <Settings VerticalScrollableHeight="0" ShowFilterRow="True"/>
                    <SettingsPager AlwaysShowPager="True" >
                        <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
                    </SettingsPager>
                    <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xóa dữ liệu ??" />
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
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="2" Width="200px" ShowClearFilterButton="True">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="IDNhomHH" ReadOnly="True" VisibleIndex="0" Caption="STT" Width="60px">
                            <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                            <EditFormSettings Visible="False" />
                            <HeaderStyle HorizontalAlign="Center" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TenNhom" VisibleIndex="1" Caption="Tên nhóm">
                            <PropertiesTextEdit>
                                <ValidationSettings SetFocusOnError="True">
                                    <RequiredField ErrorText="Nhập thông tin" IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsNhomHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>"
                     DeleteCommand="UPDATE [hhNhomHang] SET [DaXoa] = 1 WHERE [IDNhomHH] = @IDNhomHH"
                     InsertCommand="INSERT INTO [hhNhomHang] ([TenNhom]) VALUES (@TenNhom)" 
                     SelectCommand="SELECT [IDNhomHH], [TenNhom] FROM [hhNhomHang] Where [DaXoa] = 0" 
                     UpdateCommand="UPDATE [hhNhomHang] SET [TenNhom] = @TenNhom WHERE [IDNhomHH] = @IDNhomHH">
                    <DeleteParameters>
                        <asp:Parameter Name="IDNhomHH" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TenNhom" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TenNhom" Type="String" />
                        <asp:Parameter Name="IDNhomHH" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
