<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ThemKH.aspx.cs" Inherits="KobePaint.Pages.KH_NCC.ThemKH" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script>
    function onEndCallBack(s, e) {
        if (s.cp_Reset) {
            delete (s.cp_Reset);
            ShowPopup(4000);
        }
    }
    function btnLapMoiClick() {
        if (confirm('Xác nhận thao tác !!'))
            cbpInfo.PerformCallback('btnLapMoiClick');
    }
    function btnTroVeClick() {
        if (confirm('Xác nhận thao tác !!'))
            cbpInfo.PerformCallback('btnTroVeClick');
    }
    function btnLuuClick() {
        if (checkInput() && confirm('Xác nhận thao tác !!'))
            cbpInfo.PerformCallback('btnLuuClick');
    }
    function btnLuuTiepTucClick() {
        if (checkInput() && confirm('Xác nhận thao tác !!'))
            cbpInfo.PerformCallback('btnLuuTiepTucClick');
    }
    function checkInput() {
        if (txtTenKH.GetValue() == null) {
            txtTenKH.Focus();
            alert('Vui lòng nhập tên khách hàng !!');
            return false;
        }
        return true;
    }
   
</script>
    <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent1" runat="server">
                <dx:ASPxFormLayout ID="formThemKH" ClientInstanceName="formThemKH" runat="server" Width="100%">
                    <Items>
                        <dx:LayoutGroup Caption="Thêm khách hàng mới" GroupBoxDecoration="HeadingLine" ColCount="2">
                            <Items>
                                <dx:LayoutItem Caption="Mã khách hàng">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtMaKH" runat="server" Width="100%" Font-Bold="true" ForeColor="Blue">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem>
                                </dx:EmptyLayoutItem>
                                <dx:LayoutItem Caption="Loại khách hàng">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="ccbLoaiKH" runat="server" Width="100%" DataSourceID="dsLoaiKH" TextField="TenLoaiKhachHang" ValueField="IDLoaiKhachHang" SelectedIndex="0">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e) {
	                                                if(s.GetSelectedIndex() == 0)
                                                    {                                        
                                                        formThemKH.GetItemByName('layoutitemMaST').SetVisible(false);
                                                    }
                                                    else
                                                    {                                            
                                                        formThemKH.GetItemByName('layoutitemMaST').SetVisible(true);
                                                    }
                                                }" />
                                            </dx:ASPxComboBox>
                                            <asp:SqlDataSource ID="dsLoaiKH" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT IDLoaiKhachHang, TenLoaiKhachHang FROM khLoaiKhachHang WHERE (DaXoa = 0) AND (@Quyen &lt;&gt; 3) OR (DaXoa = 0) AND (IDLoaiKhachHang &lt;&gt; 2)">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="1" Name="Quyen" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Mã số thuế" Name="layoutitemMaST" ClientVisible="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtMaSoThue" runat="server" NullText="Nhập mã số thuế" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Tên khách hàng">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtTenKH" ClientInstanceName="txtTenKH" runat="server" Width="100%" NullText="Nhập tên khách hàng">
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="checkInput">
                                                    <RequiredField ErrorText="Nhập thông tin !!" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Điện thoại">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtDienThoai" runat="server" Width="100%" NullText="Nhập số điện thoại">
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
                                <dx:LayoutItem Caption="E-Mail">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtEmail" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Thông tin khác" ColSpan="2" Width="100%">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtGhiChu" runat="server" Rows="4" Width="100%">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" HorizontalAlign="Center" ShowCaption="False" Width="100%">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <div style="align-items: center; text-align: center; padding-top: 5px;">
                                            <table style="margin: 0 auto;">
                                                <tr>
                                                    <td >
                                                        <dx:ASPxButton ID="btnLuu" ClientInstanceName="btnLuu" runat="server" AutoPostBack="false" Text="Lưu">
                                                            <ClientSideEvents Click="btnLuuClick" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                     <td style="padding-left:10px;">
                                                        <dx:ASPxButton ID="btnLuuTiepTuc" ClientInstanceName="btnLuuTiepTuc" runat="server" AutoPostBack="false" Text="Lưu & tiếp tục">
                                                        <ClientSideEvents  Click="btnLuuTiepTucClick" />
                                                        </dx:ASPxButton>    
                                                    </td>
                                                     <td style="padding-left:10px">
                                                        <dx:ASPxButton ID="btnLapMoi" ClientInstanceName="btnLapMoi" runat="server" Text="Lập mới"  BackColor="#d9534f" AutoPostBack="false">
                                                            <ClientSideEvents Click="btnLapMoiClick" />
                                                        </dx:ASPxButton>    
                                                    </td>
                                                    <td style="padding-left:10px">
                                                        <dx:ASPxButton ID="btnTroVe" ClientInstanceName="btnTroVe" runat="server" Text="Trở về" AutoPostBack="false"  >
                                                        <ClientSideEvents Click="btnTroVeClick" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            </div>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>
             </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="onEndCallBack" />
    </dx:ASPxCallbackPanel>
</asp:Content>
