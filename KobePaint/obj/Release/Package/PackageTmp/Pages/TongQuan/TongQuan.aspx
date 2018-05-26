<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TongQuan.aspx.cs" Inherits="KobePaint.Pages.TongQuan.TongQuan" %>

<%@ Register Assembly="DevExpress.XtraCharts.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.XtraCharts.v16.1, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:WebChartControl ID="WebChartControl1" runat="server" CrosshairEnabled="True" Height="200px" Width="500px">
        <DiagramSerializable>
            <dx:XYDiagram>
                <axisx visibleinpanesserializable="-1">
                </axisx>
                <axisy visibleinpanesserializable="-1">
                </axisy>
            </dx:XYDiagram>
        </DiagramSerializable>
<Legend Name="Default Legend"></Legend>
        <SeriesSerializable>
            <dx:Series Name="Series 1">
            </dx:Series>
        </SeriesSerializable>
    </dx:WebChartControl>
</asp:Content>
