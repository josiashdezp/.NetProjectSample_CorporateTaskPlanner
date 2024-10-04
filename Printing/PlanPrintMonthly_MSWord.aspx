<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanPrintMonthly_MSWord.aspx.cs" Inherits="Printing_Default" Title="Planificador Corporativo. Plan Mensual" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Planificador Corporativo. Plan Mensual</title>  
    <style type="text/css" media="all" > 
        BODY 
        {
        font-family:"Arial";
         size:landscape;
         font-size:9pt;
          }
        H1 
        {
            font-family:"Arial";
            font-size:14pt;
            line-height:25px;
         }
         
         h3{font-family:Copperplate Gothic Bold;}

        .Logo    {    float:left;    }
        .style1
        {
            width: 100%;
        }
        
        .CajaTexto 
        {
        border:none;
        border-bottom:#000 solid 1px;        
        }
        
        .enlace
        {
        visibility:hidden;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
    <div>        
    <img class="Logo" alt="Logo Bandec" src="../Images/logo_bandec_vino.JPG" 
             style="width: 51px; height: 51px" />            
        <h3>Banco de Crédito y Comercio
            <br />
            Dirección Provincial Cienfuegos
        </h3>                          
         <table cellpadding="3" cellspacing="0" class="style1" style='width:65%;' 
             align="center">
             <tr>
                 <td align="right">
                                          Cargo del que lo aprueba:<asp:Label ID="Label_CargoJefe" runat="server" 
                                              Font-Bold="True" Text="Label" Font-Underline="True"></asp:Label>
                 </td>
             </tr>
             <tr>
                 <td align="left">
         Aprobado:</td>
             </tr>
             <tr>
                 <td align="right">
                                                                                    Nombre(s) y apellidos del que lo aprueba:
        <asp:Label ID="Label_NombreJefe" runat="server" Font-Bold="True" Text="Label" Font-Underline="True"></asp:Label>
                 </td>
             </tr>
         </table>
         <br />         
        <center>
        &nbsp;PLAN DE TRABAJO PARA EL MES DE: &nbsp;&nbsp;
        <asp:Label ID="Label_Mes" runat="server" Font-Bold="True" Text="Label"></asp:Label>
         <br /><br />
         Tareas Principales:         
       <asp:Table width="60%" runat="server" ID="Tabla_TareasPrincipales">         
         </asp:Table> 
         <br />
         </center>                 
         <asp:Table ID="Table_Tareas" runat="server" Width="100%" CellSpacing="0">
             <asp:TableRow ID="TableRow1" runat="server">
                 <asp:TableCell ID="TableCell1" runat="server" BorderColor="#000000" BorderStyle="Solid" 
                     BorderWidth="1px" HorizontalAlign="Center" Width="5%">No.</asp:TableCell>
                 <asp:TableCell ID="TableCell2" runat="server" BorderColor="#000000" BorderStyle="Solid" 
                     BorderWidth="1px" HorizontalAlign="Center" Width="35%">Actividad {Hora y lugar}</asp:TableCell>
                 <asp:TableCell ID="TableCell3" runat="server" BorderColor="#000000" BorderStyle="Solid" 
                     BorderWidth="1px" HorizontalAlign="Center" Width="30%">Fecha</asp:TableCell>
                 <asp:TableCell ID="TableCell4" runat="server" BorderColor="#000000" BorderStyle="Solid" 
                     BorderWidth="1px" HorizontalAlign="Center" Width="15%">Dirige</asp:TableCell>
                 <asp:TableCell ID="TableCell5" runat="server" BorderColor="#000000" BorderStyle="Solid" 
                     BorderWidth="1px" HorizontalAlign="Center" Width="15%">Participa</asp:TableCell>
             </asp:TableRow>
        </asp:Table>
         <br />
         <div style="text-align:right;">
        <asp:Label ID="Label1" runat="server" Font-Bold="True" 
            Text="Nombre(s) y apellidos del que lo elabora:"></asp:Label>
        <br />
        <asp:Label ID="Label_Nombre" runat="server"></asp:Label>
         </div>
    </div>
    </form>
</body>
</html>
