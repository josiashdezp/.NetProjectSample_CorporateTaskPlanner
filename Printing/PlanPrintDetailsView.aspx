<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanPrintDetailsView.aspx.cs" Inherits="Pruebas_PlanYearViewPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Plan de Trabajo. Vista de Detalles. Planificador Online.</title>   
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
        <br />        
        <asp:Label ID="Label_Plan" runat="server" Font-Bold="False"></asp:Label>
        &nbsp;&nbsp;&nbsp; MES: &nbsp;&nbsp;
        <asp:Label ID="Label_Mes" runat="server" Font-Bold="True" Text="Label"></asp:Label>
         &nbsp;&nbsp;
        <br /><br />
         <asp:Table ID="Table_Month" runat="server" Width="99%" BorderStyle="None" CellPadding="5" CellSpacing="0" Font-Size="Small">
             <asp:TableHeaderRow runat="server" ID="Fila_Encabezado" BorderStyle="None" Width="100%" TableSection="TableHeader" >
               <asp:TableHeaderCell runat="server" ID="Cell_Domingo" BorderColor="Black" 
                     BorderStyle="Solid" BorderWidth="1px" Width="5%">Nro.</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell1" BorderColor="Black" 
                     BorderStyle="Solid" BorderWidth="1px" Width="30%">Actividad</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell2" BorderColor="Black" 
                     BorderStyle="Solid" BorderWidth="1px" Width="10%">Fecha</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell3" BorderColor="Black" 
                     BorderStyle="Solid" BorderWidth="1px" Width="15%">Dirige</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell4" BorderColor="Black" 
                     BorderStyle="Solid" BorderWidth="1px" Width="15%">Participa</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell5" BorderColor="Black" 
                     BorderStyle="Solid" BorderWidth="1px" Width="25%">Información sobre el cumplimiento</asp:TableHeaderCell>
               </asp:TableHeaderRow>             
         </asp:Table>
    </div>
    </form>   
</body>
</html>
