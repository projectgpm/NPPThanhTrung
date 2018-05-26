<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Main.master" CodeBehind="Default.aspx.cs" Inherits="KobePaint._Default" %>

<%@ Register src="Pages/GiaoHang/PheDuyetGiaoHang.ascx" tagname="PheDuyetGiaoHang" tagprefix="uc1" %>
<%@ Register src="Pages/TraHang/PheDuyetTraHang.ascx" tagname="PheDuyetTraHang" tagprefix="uc2" %>


<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
   <style>
        .countGH, .countTH {
            background:#EA2626;
            display:inline-block;
            border-radius: 13px;
            color: white;
            font-weight: bold;
            height: 13px; 
            /*padding: 2px 3px 2px 3px;*/
            text-align: center;
            min-width: 10px;

            position: relative;
            bottom: 1ex; 
            font-size: 70%;
        }
    </style>
    <script type="text/javascript">
        function onTabClick(s, e) {
            var span;
            if (e.tab.name == 'tGiaoHang') {
                span = document.getElementsByClassName("countGH");
            }
            else {
                span = document.getElementsByClassName("countTH");
            }
            for (var i = 0; i < span.length; i++) {
                span[i].style.display = 'none';
            }
        }
    </script>
    <dx:ASPxPageControl ID="pageControl" runat="server" Width="100%" ActiveTabIndex="0" TabAlign="Justify" EncodeHtml="False">
        <TabPages>
            <dx:TabPage Text="Phiếu giao hàng chờ duyệt" Name="tGiaoHang">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server">
                        <uc1:PheDuyetGiaoHang ID="PheDuyetGiaoHang1" runat="server" />
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Phiếu trả hàng chờ duyệt" Name="tTraHang">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl2" runat="server">
                        <uc2:PheDuyetTraHang ID="PheDuyetTraHang1" runat="server" />
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
        <ClientSideEvents TabClick="onTabClick" />
        <ActiveTabStyle Font-Bold="True" ForeColor="#1F77C0">
        </ActiveTabStyle>
        <TabStyle HorizontalAlign="Center">
            <Paddings Padding="5px" />
        </TabStyle>
    </dx:ASPxPageControl>
</asp:Content>