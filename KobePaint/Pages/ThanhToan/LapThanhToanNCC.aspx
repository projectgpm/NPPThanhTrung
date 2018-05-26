<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="LapThanhToanNCC.aspx.cs" Inherits="KobePaint.Pages.ThanhToan.LapThanhToanNCC" %>
<%@ Register Assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function onCCBKhachHangChanged(s, e) {
            cbpThanhToan.PerformCallback('Customer');
        }
        function onCCBPhieuThanhToanChanged(s, e) {
            cbpThanhToan.PerformCallback('PhieuTT');
        }

        // hình thức thanh toán
        function initCCBHinhThuc(s, e) {
            if (s.GetSelectedIndex() == 0) {
                SetVisiblePhieuTT(false);
            }
            else {
                SetVisiblePhieuTT(true);
            }
        }

        function onCCBHinhThucChanged(s, e) {
            if (s.GetSelectedIndex() == 0) {
                SetVisiblePhieuTT(true);
                txtSoTienDaTT.SetText('0');
                ccbPhieuThanhToan.SetText('');
                speSoTienTT.SetNumber(0);
            }
            else {
                SetVisiblePhieuTT(true);
                txtSoTienDaTT.SetText('0');
                ccbPhieuThanhToan.SetText('');
                speSoTienTT.SetNumber(0);
            }
        }
        function SetVisiblePhieuTT(bVisible) {
            formThanhToan.GetItemByName('itemPhieuTT').SetVisible(bVisible);
            formThanhToan.GetItemByName('itemSoTienDaTT').SetVisible(bVisible);
        }

        function checkInput() {
            if (ccbKhachHang.GetSelectedIndex() == -1) {
                alert('Vui lòng chọn khách hàng!!');
                ccbKhachHang.Focus();
                return false;
            }

            if (rdlHinhThuc.GetSelectedIndex() == 0 && speSoTienTT.GetValue() <= 0) {
                alert('Số tiền thanh toán phải lớn hơn 0')
                speSoTienTT.Focus();
                return false;
            }

            if (rdlHinhThuc.GetSelectedIndex() == 0 && txtCongNoHienTai.GetValue() < speSoTienTT.GetValue()) {
                alert('Số tiền thanh toán phải nhỏ hơn công nợ hiện tại')
                speSoTienTT.Focus();
                return false;
            }

            if (rdlHinhThuc.GetSelectedIndex() == 1 && ccbPhieuThanhToan.GetSelectedIndex() == -1) {
                alert('Vui lòng chọn phiếu thanh toán')
                ccbPhieuThanhToan.Focus();
                return false;
            }
            if (dateNgayTT.GetValue() == null) {
                alert('Vui lòng chọn ngày thanh toán')
                dateNgayTT.Focus();
                return false;
            }
            return true;
        }
        function onSaveClick() {
            if (checkInput())
                cbpThanhToan.PerformCallback('ThanhToan');

        }

        function onReviewClick() {
            if (checkInput())
                cbpThanhToan.PerformCallback('Review');
        }
        function onEndCallBack(s, e) {
            if (s.cp_rpView) {
                hdfViewReport.Set('view', '1');
                popupViewReport.Show();
                reportViewer.GetViewer().Refresh();
                delete (s.cp_rpView);
            }
            if (s.cp_Reset) {
            delete (s.cp_Reset);
            ShowPopup(4000);
        }
        }
    </script>
    <dx:ASPxCallbackPanel ID="cbpThanhToan" ClientInstanceName="cbpThanhToan" runat="server" Width="100%" OnCallback="cbpThanhToan_Callback">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent1" runat="server">
                <dx:ASPxFormLayout ID="formThanhToan" ClientInstanceName="formThanhToan" runat="server" Width="100%">
                    <Items>
                        <dx:LayoutGroup Caption="Lập phiếu thanh toán nhà cung cấp" ColCount="2" GroupBoxDecoration="HeadingLine" HorizontalAlign="Center">
                            <Items>
                                <dx:LayoutItem Caption="Khách hàng">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                            <dx:ASPxComboBox ID="ccbKhachHang" ClientInstanceName="ccbKhachHang" runat="server" Width="100%" DataSourceID="dsKhachHang" NullText="--- Chọn khách hàng ---" ValueField="IDKhachHang" TextField="HoTen">
                                                <ClientSideEvents SelectedIndexChanged="onCCBKhachHangChanged" />
                                            </dx:ASPxComboBox>
                                            <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>"
                                                 SelectCommand="SELECT [IDKhachHang], [HoTen] FROM [khKhachHang] Where LoaiKhachHangID = 2 AND DaXoa = 0"></asp:SqlDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Công nợ hiện tại" HelpText="(Đvt: đồng)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                            <dx:ASPxTextBox ID="txtCongNoHienTai" ClientInstanceName="txtCongNoHienTai" runat="server" Width="100%" ReadOnly="true" DisplayFormatString="N0">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                    <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Hình thức thanh toán" ColSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                            <dx:ASPxRadioButtonList ID="rdlHinhThuc" ClientInstanceName="rdlHinhThuc" runat="server" ItemSpacing="50px" RepeatColumns="2" SelectedIndex="0">
                                                <ClientSideEvents SelectedIndexChanged="onCCBHinhThucChanged" Init="initCCBHinhThuc" />
                                                <Items>
                                                    <dx:ListEditItem Selected="True" Text="Công nợ giảm dần" Value="0" />
                                                    <dx:ListEditItem Text="Theo phiếu giao hàng" Value="1" />
                                                </Items>
                                                <Border BorderStyle="None" />
                                            </dx:ASPxRadioButtonList>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phiếu thanh toán" Name="itemPhieuTT" ClientVisible="false">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                            <dx:ASPxComboBox ID="ccbPhieuThanhToan" ClientInstanceName="ccbPhieuThanhToan" runat="server" Width="100%" NullText="--Chọn phiếu thanh toán--" ValueField="IDNhapKho" TextFormatString="Mã phiếu {0} - {1} đồng">
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Mã phiếu" FieldName="MaPhieu" />
                                                    <dx:ListBoxColumn Caption="Tổng tiền" FieldName="TongTien" />
                                                    <dx:ListBoxColumn Caption="Đã thanh toán" FieldName="ThanhToan" />
                                                </Columns>
                                                <ClientSideEvents SelectedIndexChanged="onCCBPhieuThanhToanChanged" />
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem Caption="Số tiền đã thanh toán" HelpText="(Đvt: đồng)" Name="itemSoTienDaTT" ClientVisible="false">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                            <dx:ASPxTextBox ID="txtSoTienDaTT" ClientInstanceName="txtSoTienDaTT" runat="server" Width="100%"  Enabled="false" DisplayFormatString="N0">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxHiddenField ID="hiddenfield" ClientInstanceName="hiddenfield" runat="server"></dx:ASPxHiddenField>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                    <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                            
                                <dx:LayoutItem Caption="Số tiền thanh toán" ColSpan="2" HelpText="(Đvt: đồng)" Name="itemSoTienTT" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server">
                                            <dx:ASPxSpinEdit ID="speSoTienTT" ClientInstanceName="speSoTienTT" runat="server" Number="0" DecimalPlaces="2" Increment="5000" Width="100%" DisplayFormatString="N0">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                    <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Số hóa đơn">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">
                                            <dx:ASPxTextBox ID="txtHoaDon" ClientInstanceName="txtHoaDon" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Ngày thanh toán">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer8" runat="server">
                                            <dx:ASPxDateEdit ID="dateNgayTT" ClientInstanceName="dateNgayTT" runat="server" Width="100%" OnInit="dateEditControl_Init">
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Nội dung thanh toán" ColSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server">
                                            <dx:ASPxMemo ID="memoNoiDungTT" ClientInstanceName="memoNoiDungTT" runat="server" Rows="5" Width="100%">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                        <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False" Width="100%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer10" runat="server">
                                    <div style="align-items: center; text-align: center; padding-top: 5px;">
                                    <table  style="margin: 0 auto;">
                                        <tr>
                                            <td >
                                                <dx:ASPxButton ID="btnReview" runat="server" Text="Xem trước" Width="100" BackColor="#5cb85c" AutoPostBack="False">
                                                    <ClientSideEvents Click="onReviewClick" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-left: 10px">
                                                <dx:ASPxButton ID="btnSave" runat="server" Text="Thanh toán" AutoPostBack="false" UseSubmitBehavior="true">
                                                    <ClientSideEvents Click="onSaveClick" />
                                                </dx:ASPxButton>
                                            </td>
                                         
                                            <td style="padding-left:10px;">
                                                <dx:ASPxButton ID="btnRenew" runat="server" Text="Lập mới" Width="100" BackColor="#d9534f" OnClick="btnRenew_Click" UseSubmitBehavior="false">
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                        </div>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="onEndCallBack" />
    </dx:ASPxCallbackPanel>
    <dx:ASPxPopupControl ID="popupViewReport" ClientInstanceName="popupViewReport" runat="server" HeaderText="Phiếu thanh toán đại lý" Width="850px" ShowHeader="false" Height="600px" ScrollBars="Auto" PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" >
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
