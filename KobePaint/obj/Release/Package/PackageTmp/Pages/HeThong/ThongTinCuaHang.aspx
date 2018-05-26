<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ThongTinCuaHang.aspx.cs" Inherits="KobePaint.Pages.HeThong.ThongTinCuaHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <%--  <script type="text/javascript">
            function OnSubmitClick(s, e) {
                console.log()
                if (!ASPxClientEdit.ValidateGroup('entryGroup')) e.processOnServer = false;
            }
    </script>--%>
   
    <dx:ASPxPopupControl ID="pcLogin" ClientInstanceName="pcLogin" runat="server"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        HeaderText="THÔNG TIN CỬA HÀNG" ShowOnPageLoad="true" ShowCloseButton="False" CloseAction="None" PopupAction="None" FooterText="Quản lý dự án bồi thường - giải phóng mặt bằng" Width="500px">
        <ClientSideEvents PopUp="function(s, e) { s.UpdatePosition(); }" />
        <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" Font-Size="Large" />
        <FooterStyle HorizontalAlign="Center" />
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxFormLayout ID="formLayout" runat="server" Width="100%" DataSourceID="dsChiNhanh">
                    <Items>
                        <dx:LayoutItem FieldName="TenChiNhanh" Caption="Tên cửa hàng">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxTextBox ID="txtTenChiNhanh" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem FieldName="DienThoai" Caption="Điện thoại">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">
                                    <dx:ASPxTextBox ID="txtDienThoai" Width="100%" runat="server">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Địa chỉ" FieldName="DiaChi">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                    <dx:ASPxTextBox ID="txtDiaChi" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Mã số thuế" FieldName="MST">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxTextBox ID="txtMST" Width="100%" runat="server">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                                           
                        <dx:LayoutItem Caption="Tỉnh thành" FieldName="TinhThanh">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                    <dx:ASPxTextBox ID="txtTinhThanh" runat="server" Width="100%">                                               
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Quỹ thu chi" FieldName="QuyThuChi">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                    <dx:ASPxSpinEdit ID="spQuyThuChu" DisplayFormatString="N0" Width="100%" runat="server">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                         <dx:LayoutItem Caption="Logo hiện tại" FieldName="Logo">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server" SupportsDisabledAttribute="True">
                                  
                                    <dx:ASPxBinaryImage ID="BinaryImage"   ClientInstanceName="ClientBinaryImage" Width="100" Height="80" runat="server">
                                        <EditingSettings>
                                            <UploadSettings>
                                                <UploadValidationSettings MaxFileSize="4194304"></UploadValidationSettings>
                                            </UploadSettings>
                                        </EditingSettings>
                                    </dx:ASPxBinaryImage>
                                     
                                    
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>    
                         <dx:LayoutItem Caption="Logo mới" FieldName="Logo">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer10" runat="server" SupportsDisabledAttribute="True">
                                     <dx:ASPxUploadControl ID="uploadfile" runat="server" Width="100%">
                                <BrowseButton Text="Chọn file...">
                                </BrowseButton>
                                <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg, .jpeg, .png" NotAllowedFileExtensionErrorText="Vui lòng chọn đúng định dạng ảnh">
                                </ValidationSettings>
                            </dx:ASPxUploadControl>
                                    
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem> 
                        <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer8" runat="server">
                                    <dx:ASPxButton ID="btOK" runat="server" Text="Cập nhật" AutoPostBack="true" Width="150px" OnClick="btOK_Click">
                                       <%-- <ClientSideEvents Click="OnSubmitClick" />          --%>                          
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server">
                                    <dx:ASPxLabel ID="lblError" runat="server" ForeColor="Red">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        
        </ContentStyle>
    
    </dx:ASPxPopupControl>
    <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	            pcLogin.UpdatePosition();
            }" />
    </dx:ASPxGlobalEvents>
    <asp:SqlDataSource ID="dsChiNhanh" runat="server" 
        ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT chChiNhanh.* FROM chChiNhanh WHERE (IDChiNhanh = @IDChiNhanh )">
        <SelectParameters>
            <asp:Parameter DefaultValue="IDChiNhanh" Name="IDChiNhanh" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
