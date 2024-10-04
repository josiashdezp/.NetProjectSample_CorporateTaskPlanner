<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanPrintPersonalView.aspx.cs" Inherits="Pruebas_PlanPersonalViewPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Plan de Trabajo Individual. Planificador Online.</title>   
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
         <table cellpadding="3" cellspacing="0" class="style1" style='width:70%;' 
             align="center">
             <tr>
                 <td align="right">
                                          Cargo del que lo aprueba:<asp:Label ID="Label_CargoJefe" runat="server" 
                                              Font-Bold="True" Text="Label" Font-Underline="True"></asp:Label>
                 </td>
             </tr>
             <tr>
                 <td align="left">
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Aprobado:</td>
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
            PLAN DE TRABAJO INDIVIDUAL&nbsp;PARA EL MES DE: &nbsp;&nbsp;
        <asp:Label ID="Label_Mes" runat="server" Font-Bold="True" Text="Label"></asp:Label>
         <br /><br />
         Tareas Principales:         
         <!-- <asp:BulletedList ID="Lista_TareasPrincipales" runat="server" BulletStyle="Numbered">            
           </asp:BulletedList> -->
         <asp:Table width="60%" runat="server" ID="Tabla_TareasPrincipales">         
         </asp:Table>         
         </center>        
         
         <asp:Table ID="Table_Month" runat="server" Width="99%" BorderStyle="None" CellPadding="5" CellSpacing="0" Font-Size="Small">
             <asp:TableHeaderRow runat="server" ID="Fila_Encabezado" BorderStyle="None" Width="100%" TableSection="TableHeader" >
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell1" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Lunes</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Martes</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell3" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Miércoles</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell4" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Jueves</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell5" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Viernes</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="TableHeaderCell6" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Sábado</asp:TableHeaderCell>
               <asp:TableHeaderCell runat="server" ID="Cell_Domingo" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="14%">Domingo</asp:TableHeaderCell>
               </asp:TableHeaderRow>             
         </asp:Table>
    </div>
    <br />
     <table align="center" class="style1">
         <tr>
             <td align="right">
                 Cargo del que lo presenta:
        <asp:Label ID="Label_Cargo" runat="server" Font-Bold="True" Text="Label"></asp:Label>
             </td>
         </tr>
         <tr>
             <td align="right">
                 Nombre (s) y apellidos:<asp:Label ID="Label_Nombre" runat="server" Font-Bold="True" Text="Label"></asp:Label>
                 </td>
         </tr>
     </table>
    </form>   
</body>
</html>
