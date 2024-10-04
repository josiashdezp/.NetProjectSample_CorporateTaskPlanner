<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="PlanPrintAll.aspx.cs" Inherits="Planning_PlanPrint" Title="Imprimir planes de trabajo. Planificador Online." MaintainScrollPositionOnPostback="true" %>
<%@ PreviousPageType VirtualPath="~/Planning/PlanPrint.aspx" %>
<%@ Register Assembly="DevExpress.XtraReports.v8.2.Web, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.XtraReports.Web" TagPrefix="dxxr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<h2>Imprimir Planes de Trabajo</h2>
<br />
<br />
<dxxr:reporttoolbar id="ReportToolbar1" runat="server" reportviewer="<%# ReportViewer_PrintReports %>"  showdefaultbuttons="False"><Items>
<dxxr:ReportToolbarButton ItemKind="Search" ToolTip="Display the search window"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarSeparator></dxxr:ReportToolbarSeparator>
<dxxr:ReportToolbarButton ItemKind="PrintReport" ToolTip="Print the report"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarButton ItemKind="PrintPage" ToolTip="Print the current page"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarSeparator></dxxr:ReportToolbarSeparator>
<dxxr:ReportToolbarButton Enabled="False" ItemKind="FirstPage" ToolTip="First Page"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarButton Enabled="False" ItemKind="PreviousPage" ToolTip="Previous Page"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarLabel Text="Page"></dxxr:ReportToolbarLabel>
<dxxr:ReportToolbarComboBox Width="65px" ItemKind="PageNumber"></dxxr:ReportToolbarComboBox>
<dxxr:ReportToolbarLabel Text="of"></dxxr:ReportToolbarLabel>
<dxxr:ReportToolbarTextBox IsReadOnly="True" ItemKind="PageCount"></dxxr:ReportToolbarTextBox>
<dxxr:ReportToolbarButton ItemKind="NextPage" ToolTip="Next Page"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarButton ItemKind="LastPage" ToolTip="Last Page"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarSeparator></dxxr:ReportToolbarSeparator>
<dxxr:ReportToolbarButton ItemKind="SaveToDisk" ToolTip="Export a report and save it to the disk"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarButton ItemKind="SaveToWindow" ToolTip="Export a report and show it in a new window"></dxxr:ReportToolbarButton>
<dxxr:ReportToolbarComboBox Width="70px" ItemKind="SaveFormat"><Elements>
<dxxr:ListElement Text="Pdf" Value="pdf"></dxxr:ListElement>
<dxxr:ListElement Text="Xls" Value="xls"></dxxr:ListElement>
<dxxr:ListElement Text="Rtf" Value="rtf"></dxxr:ListElement>
<dxxr:ListElement Text="Mht" Value="mht"></dxxr:ListElement>
<dxxr:ListElement Text="Text" Value="txt"></dxxr:ListElement>
<dxxr:ListElement Text="Csv" Value="csv"></dxxr:ListElement>
<dxxr:ListElement Text="Image" Value="png"></dxxr:ListElement>
</Elements>
</dxxr:ReportToolbarComboBox>
</Items>

<Styles>
<LabelStyle>
<Margins MarginLeft="3px" MarginRight="3px"></Margins>
</LabelStyle>
</Styles>
</dxxr:reporttoolbar>
    <dxxr:reportviewer id="ReportViewer_PrintReports" runat="server" BackColor="White" OnLoad="ReportViewer_PrintReports_Load">
        <Border BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
    </dxxr:reportviewer>

</asp:Content>

