<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="LapPhieuThuChi.aspx.cs" Inherits="KobePaint.Pages.ThuChi.LapPhieuThuChi" %>
<%@ Register assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <script>
         function gridEndCallBack(s, e) {
             if (s.cpIsDelete == true) {
                 s.AddNewRow();
                 delete (s.cpIsDelete);
             }
         }
         function ccbLoaiPhieuSelectedIndex() {
             cbpThem.PerformCallback('ccbLoaiPhieuSelectedIndex');
         }
         function ShowLoaiThuChi() {
             popLoaiThuChi.Show();
         }

         function ListLoaiThuChi(s, e) {
             ccbLoaiThuChi.PerformCallback();
         }
         function spSoTienOnNumberChanged() {
             if (checkInput())
                 cbpThem.PerformCallback('spSoTienOnNumberChanged');
         }
         function onRenewClick() {
             cbpThem.PerformCallback('Renew');
         }

         function checkInput() {
             if (ccbLoaiPhieu.GetSelectedIndex() == -1) {
                 alert('Vui lòng chọn loại phiếu!!');
                 ccbLoaiPhieu.Focus();
                 return false;
             }
             if (ccbLoaiThuChi.GetSelectedIndex() == -1) {
                 alert('Vui lòng chọn loại thu chi!!');
                 ccbLoaiThuChi.Focus();
                 return false;
             }
             if (spSoTien.GetValue() == null) {
                 alert('Vui lòng nhập số tiền!!');
                 spSoTien.Focus();
                 return false;
             }
             if (dateNgayLap.GetValue() == null) {
                 alert('Vui lòng nhập ngày lập!!');
                 dateNgayLap.Focus();
                 return false;
             }
             return true;
         }

         function onLuuTiepTucClick() {
             if(checkInput())
                 cbpThem.PerformCallback('Save');
         }
         function onSaveClick() {
             if (checkInput()) {
                 cbpThem.PerformCallback('Save');
                 cbpThem.PerformCallback('redirect');
             }
         }
         function onReviewClick() {
             if (checkInput()) 
                 cbpThem.PerformCallback('Review');
         }
        
         // thong bao
         function endCallBack(s, e) {
             if (s.cp_rpView) {
                 hdfViewReport.Set('view', '1');
                 popupViewReport.Show();
                 reportViewer.GetViewer().Refresh();
                 delete (s.cp_rpView);
             }
             if (s.cp_Reset) {
                 cbpThem.PerformCallback('Reset');
                 delete (s.cp_Reset);
                 ShowPopup(4000);
             }
         }
    </script>
 
    <dx:ASPxCallbackPanel ID="cbpThem" ClientInstanceName="cbpThem" runat="server" Width="100%" OnCallback="cbpThem_Callback">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent1" runat="server">
                <dx:ASPxFormLayout ID="formThemHH" runat="server" Width="100%">
                    <Items>
                        <dx:LayoutGroup Caption="Thêm phiếu thu - chi" GroupBoxDecoration="HeadingLine" HorizontalAlign="Center" ColCount="2">
                            <Items>
                                <dx:LayoutItem Caption="Loại phiếu">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                            <dx:ASPxComboBox ID="ccbLoaiPhieu" runat="server" ClientInstanceName="ccbLoaiPhieu" Width="100%" NullText="-- Chọn loại phiếu --" >
                                                <Items>
                                                    <dx:ListEditItem Text="Phiếu thu" Value="0" />
                                                    <dx:ListEditItem Text="Phiếu chi" Value="1" />
                                                </Items>
                                               <ClientSideEvents SelectedIndexChanged="ccbLoaiPhieuSelectedIndex" />
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Loại thu chi">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                            <table style="width:100%">
                                                <tr>
                                                    <td style="padding-right:10px;width:100%;">
                                                        <dx:ASPxComboBox ID="ccbLoaiThuChi" runat="server" CallbackPageSize="20" ClientInstanceName="ccbLoaiThuChi" DataSourceID="dsLoaiThuChi" EnableCallbackMode="True" NullText="-- Chọn loại thu chi --" OnCallback="ccbLoaiThuChi_Callback" TextField="TenPhieu" ValueField="ID" Width="100%">
                                                            <ClientSideEvents DropDown="function(s,e){ ListLoaiThuChi();}" />
                                                            <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                                <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                            </ValidationSettings>
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource ID="dsLoaiThuChi" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>"                                                            
                                                            SelectCommand="SELECT ID, TenPhieu FROM pLoaiThuChi WHERE (DaXoa = 0)" >
                                                        </asp:SqlDataSource>
                                                    </td>
                                                    <td style="padding-right:10px;width:5px;">
                                                        <dx:ASPxButton ID="btnThemLoaiThuChi" runat="server" AutoPostBack="False" BackColor="#5CB85C" Text="Thêm">
                                                            <ClientSideEvents Click="function(s, e) { ShowLoaiThuChi(); }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Số tiền">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                            <dx:ASPxSpinEdit ID="spSoTien" ClientInstanceName="spSoTien" runat="server" Number="0" Width="100%" DisplayFormatString="N0" Increment="5000" >
                                                 <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                    <RequiredField ErrorText="Vui lòng nhập số lượng" IsRequired="True" />
                                                </ValidationSettings>
                                                <ClientSideEvents NumberChanged="spSoTienOnNumberChanged" />
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Tên người Nộp/Nhận">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                             <dx:ASPxTextBox ID="txtKhachHang" runat="server" Width="100%" NullText="-- Nhập họ và tên --">
                                            </dx:ASPxTextBox>
                                            
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Điện thoại">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtDienThoai" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Địa chỉ">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtDiaChi" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Ngày lập">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server">
                                            <dx:ASPxDateEdit ID="dateNgayLap" ClientInstanceName="dateNgayLap" runat="server" Width="100%" OnInit="dateNgayLap_Init">
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Nội dung">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                            <dx:ASPxMemo ID="memoNoiDung" runat="server" Rows="5" Width="100%">
                                            </dx:ASPxMemo>
                                            
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False" ColSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server">
                                            <table >
                                                <tr>
                                                     <td style="padding-right:10px;">
                                                        <dx:ASPxButton ID="btnPreview" runat="server" Text="Xem trước" BackColor="#5cb85c" AutoPostBack="False">
                                                            <ClientSideEvents Click="onReviewClick" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td style="padding-right:10px;">
                                                        <dx:ASPxButton ID="btnSave" runat="server" Text="Lưu" ValidationGroup="checkInput" AutoPostBack="false">
                                                            <ClientSideEvents Click="onSaveClick" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                   <td style="padding-right:10px;">
                                                        <dx:ASPxButton ID="btnLuuTiepTuc" runat="server" Text="Lưu & tiếp tục" ValidationGroup="checkInput" AutoPostBack="false">
                                                            <ClientSideEvents Click="onLuuTiepTucClick" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td style="padding-right:10px;">
                                                        <dx:ASPxButton ID="btnRenew" runat="server" Text="Lập mới" Width="100" BackColor="#d9534f" AutoPostBack="false" OnClick="btnRenew_Click">
                                                            <ClientSideEvents Click="onRenewClick" />
                                                        </dx:ASPxButton>
                                                        
                                                    </td>
                                                     <td >
                                                        <dx:ASPxButton ID="btnTroVe" runat="server" Text="Trở về" AutoPostBack="true" PostBackUrl="~/Pages/ThuChi/DanhSachThuChi.aspx" >
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

    <dx:ASPxPopupControl ID="popLoaiThuChi" ClientInstanceName="popLoaiThuChi" runat="server" HeaderText="Loại thu chi" Width="500px" Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter"
        CloseAction="CloseButton" CloseOnEscape="True" PopupVerticalAlign="WindowCenter"  
         
         ><ClientSideEvents PopUp="function(s, e) { gridLoaiThuChi.Refresh() }"/>
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                 <dx:ASPxGridView ID="gridLoaiThuChi" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridLoaiThuChi" Width="100%" DataSourceID="dsLThuChu" KeyFieldName="ID" OnCustomColumnDisplayText="gridLoaiThuChi_CustomColumnDisplayText">
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
                     <EditFormLayoutProperties>
                         <Items>
                             <dx:GridViewColumnLayoutItem ColumnName="Tên loại thu chi">
                             </dx:GridViewColumnLayoutItem>
                             <dx:EditModeCommandLayoutItem HorizontalAlign="Right">
                             </dx:EditModeCommandLayoutItem>
                         </Items>
                     </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="2" Width="200px" ShowClearFilterButton="True">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Caption="STT" Width="60px">
                            <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                            <EditFormSettings Visible="False" />
                            <HeaderStyle HorizontalAlign="Center" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TenPhieu" VisibleIndex="1" Caption="Tên loại thu chi">
                            <PropertiesTextEdit>
                                <ValidationSettings SetFocusOnError="True">
                                    <RequiredField ErrorText="Nhập thông tin" IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                 <asp:SqlDataSource ID="dsLThuChu" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
                     DeleteCommand="UPDATE [pLoaiThuChi] SET [DaXoa] = 1 WHERE [ID] = @ID" 
                     InsertCommand="INSERT INTO [pLoaiThuChi] ([TenPhieu]) VALUES (@TenPhieu)" 
                     SelectCommand="SELECT [ID], [TenPhieu] FROM [pLoaiThuChi] WHERE ([DaXoa] = @DaXoa)"
                     UpdateCommand="UPDATE [pLoaiThuChi] SET [TenPhieu] = @TenPhieu WHERE [ID] = @ID">
                     <DeleteParameters>
                         <asp:Parameter Name="ID" Type="Int32" />
                     </DeleteParameters>
                     <InsertParameters>
                         <asp:Parameter Name="TenPhieu" Type="String" />
                     </InsertParameters>
                     <SelectParameters>
                         <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
                     </SelectParameters>
                     <UpdateParameters>
                         <asp:Parameter Name="TenPhieu" Type="String" />
                         <asp:Parameter Name="ID" Type="Int32" />
                     </UpdateParameters>
                 </asp:SqlDataSource>
                <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
                    <ClientSideEvents BrowserWindowResized="function(s, e) {
	                    UpdateControlHeight(gridLoaiThuChi);
                    }" ControlsInitialized="function(s, e) {
	                    UpdateControlHeight(gridLoaiThuChi);
                    }" />
                </dx:ASPxGlobalEvents>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl ID="popupViewReport" ClientInstanceName="popupViewReport" runat="server" ShowHeader="false" HeaderText="Xem trước phiếu thu chi" Width="850px" PopupVerticalAlign="WindowCenter" Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter" >
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server">
                </dx:ASPxDocumentViewer>
                <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
                </dx:ASPxHiddenField>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    </asp:Content>
