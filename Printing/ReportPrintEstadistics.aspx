<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportPrintEstadistics.aspx.cs" Inherits="Printing_ReportPrintCumplimiento" %>
<%@ Register assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dxpc" %>
<%@ Register assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" namespace="DevExpress.Web.ASPxCallback" tagprefix="dxcb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Planificador Corporativo. Cumplimiento de Tareas</title> 
      <style type="text/css"> 
* {
    border-style: none;
    border-width: 0px;
    padding: 0;
    margin: 0;    
}

BODY 
 {
    font-family:"Arial";    
    font-size:12pt;
    padding:10px;
  }
H1 
   {
font-family:"Arial";
 font-size:14pt;
line-height:25px;
text-align:center;
}
    
h3{font-family:Copperplate Gothic Bold;}

.Logo    {    float:left;    }
                
Input, Textarea
{
	text-decoration: none;
	color: #000000;
	border: #d3d3d3 1px solid;	
	vertical-align: middle;	
	background-color: #f4f4f4; 
	width:40px;
}

Textarea
{
width:auto;
font-family:"Arial";    
    font-size:12pt;
}

#Contenido
{
padding:25px;
margin:10px auto;
}


li 
{
margin:10px;
list-style:none;
}
      </style>
      <style type="text/css" media="print">
      Input, Textarea
{
	text-decoration: none;
	color: #000000;
	border:0;
	vertical-align: middle;	
	background-color:#ffffff;
}

Textarea
{
width:auto;
font-family:"Arial";    
    font-size:12pt;
}
      </style>
      <script language="javascript" type="text/javascript">
          function MostrarCausasSuspension() {
              HiddenFieldDetalles = window.document.getElementById("HiddenDetalles");
              TextAreaCausas = window.document.getElementById("TextArea_Causas");
              TextAreaCausas.value = HiddenFieldDetalles.value;
          }
      </script>
</head>
<body onload="MostrarCausasSuspension();">
    <form id="form1" runat="server">
    <div>
    <img class="Logo" alt="Logo Bandec" src="../Images/logo_bandec_vino.JPG" 
             style="width: 51px; height: 51px" />                    
        <h3>Banco de Crédito y Comercio
            <br />
            Dirección Provincial Cienfuegos
        </h3>                            
        <div id="Contenido">
  <h1>  Resumen Cuantitativo del Cumplimiento del  
      <asp:Label ID="Label_NombrePlan" runat="server" Text=""></asp:Label> del mes de <asp:Label ID="Label_Fecha" runat="server" Text=""></asp:Label></h1>
  <br />  
  <center>
    Presentado por:<asp:Label ID="Label_Trabajador" runat="server" Font-Underline="True"></asp:Label>
    <br /><br />
    Instancia:
        <asp:Label ID="Label_Instancia" runat="server" Font-Underline="True">Dirección Provincial de Bandec</asp:Label>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Área de Trabajo:
        <asp:Label ID="Label_Area" runat="server" Font-Underline="True"></asp:Label>
&nbsp;
<br />
        <br />        
      <ul>
       <li>Cantidad de actividades planificadas:<asp:TextBox ID="TextBox_planificadas" 
                runat="server" ></asp:TextBox></li>
                <li>Cantidad de actividades cumplidas:<asp:TextBox ID="TextBox_cumplidas" 
                runat="server" ></asp:TextBox></li>
                <li>Cantidad de actividades incumplidas:<asp:TextBox ID="TextBox_incumplidas" 
                runat="server" ></asp:TextBox></li>
                <li>Cantidad de actividades modificadas:<asp:TextBox ID="TextBox_modificadas" 
                runat="server" ></asp:TextBox></li>
                <li>Cantidad de actividades nuevas:<asp:TextBox ID="TextBox_nuevas" runat="server" 
                 ></asp:TextBox></li>                
      </ul>                          
<h1>Resumen Cualitativo sobre las Causas que Originaron el Inclumplimiento de una Tarea o Actividad :</h1>
<br /><br />
      <textarea id="TextArea_Causas" name="AreaTexto" rows="25" 
          style="overflow:hidden;width:100%"></textarea></center>
        </div>
    </div>
    
    </form>
</body>
</html>