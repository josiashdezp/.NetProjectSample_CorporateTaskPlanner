<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanPrintGenView.aspx.cs" Inherits="PlanMonthGeneralPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Plan de Trabajo General.Dirección Provincial. Planificador Online.</title>   
    <style type="text/css" media="all"> 
        BODY 
        {
        font-family:"Arial";
         size:landscape;
          }
        H1 
        {
            font-family:"Arial";
            font-size:14pt;
            line-height:25px;
         }

        .Logo    {    float:left;    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <div>
        <img class="Logo" alt="Logo Bandec" src="../Images/logo_bandec_vino.JPG" style="width: 60px; height: 66px" />            
        <h1>Banco de Crédito y Comercio
            <br />
            Dirección Provincial Cienfuegos
        </h1>                
        <center style="font-weight:bold;"><asp:Label ID="Label_Plan" runat="server" ></asp:Label>
        &nbsp;PARA EL MES DE&nbsp;
        <asp:Label ID="Label_Mes" runat="server" Text="Label" 
             Font-Underline="True"></asp:Label>
         &nbsp;&nbsp;</center>
        <br />
         <asp:Table ID="Table_Month" runat="server" Width="99%" BorderStyle="None" CellPadding="5" CellSpacing="0" Font-Size="Small">
             <asp:TableHeaderRow runat="server" ID="Fila_Encabezado" BorderStyle="None" Width="100%" TableSection="TableHeader" >
               <asp:TableHeaderCell runat="server" ID="Cell_Domingo" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Domingo</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell1" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Lunes</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Martes</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell3" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Miércoles</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell4" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Jueves</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell5" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Viernes</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell6" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Sábado</asp:TableHeaderCell>
               </asp:TableHeaderRow>             
         </asp:Table>
    </div>
    </form>   
</body>
</html>
