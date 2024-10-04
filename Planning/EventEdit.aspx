<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventEdit.aspx.cs" Inherits="Planning_EventEdit" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Modificar tareas.</title>
    <link href="../Styles/WebPlanner_Styles.css" rel="stylesheet" type="text/css" />
    <style type="text/css" media="screen">
    
    .parrafo {text-align:justify;display:inline;}
    h3{text-align:center;}
    a 
    {
        color:#ff9933;
        text-decoration:none;
        font-weight:bold;
    }
    </style>
    <script language="javascript" type="text/javascript"> 
    
    function ValidarFecha(source,arguments)
    {    
        if (arguments.Value.toString()!='') 
            arguments.IsValid=true;
        else
            arguments.IsValid=false;
    }    
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
             <ext:ScriptManager ID="ScriptManager1" runat="server">
                </ext:ScriptManager>        
           <table style="width: 100%; margin: auto; border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-bottom-width: 1px; border-bottom-color: black; border-top-color: black; border-right-width: 1px; border-right-color: black;" cellspacing="5">
                <tr>
                    <td align="left" colspan="2" style="font-weight: bold; height: 20px">
                <h3>
                    <asp:Label ID="Label_Titulo" runat="server"></asp:Label></h3>               
                    </td>
                </tr>
            <tr>
                <td align="left" colspan="2" style="font-weight: bold">
                    Nombre de la tarea:&nbsp;<asp:Label ID="Label_Nombre" runat="server" Font-Bold="False"></asp:Label>&nbsp;</td>
            </tr>
            <tr>
                <td align="left" style="font-weight: bold; width: 50%;" colspan="2">
                    Cambiar al Estado:
                    <asp:Label ID="Label_Estado" runat="server" Font-Bold="False"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 50%; font-weight: bold;" align="left" colspan="2">
                    Descripción:
                </td>
            </tr>
            <tr>
                <td colspan="2" align="justify"><asp:Label ID="Label_Descripc" runat="server" Font-Bold="False"></asp:Label></td>
            </tr>
               <tr>
                   <td align="justify" colspan="2" style="font-weight: bold">
                       Detalles:</td>
               </tr>
               <tr>
                   <td align="justify" colspan="2">
                       <asp:Label ID="Label_Detalles" runat="server" Font-Bold="False"></asp:Label></td>
               </tr>
            <tr>
                <td style="width: 22%; font-weight: bold;" align="left">
                    <asp:Label ID="Label_Etiqueta" runat="server" Font-Bold="True"></asp:Label></td>
                <td align="left" style="width: 70%">
                    &nbsp;
                    <asp:Label ID="Label_Observaciones" runat="server" Font-Bold="False" Visible="False"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_Text" runat="server"
                        ControlToValidate="TextBox_Observac" ForeColor="Tomato"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td align="left" colspan="2">
                    <asp:TextBox ID="TextBox_Observac" runat="server" TextMode="MultiLine" Width="95%" CssClass="Input" Rows="5"></asp:TextBox>
                </td>
            </tr>
               <tr>
                   <td align="left" colspan="2">
                            <table style="width: 85%">
                                <tr>
                                    <td align="left" style="width: 33%">
                    <asp:Label ID="Label_Fecha" runat="server" Font-Bold="True" Visible="False">Reprogramar para:</asp:Label></td>
                                    <td align="left" style="width: 30%"><ext:DateField ID="DateField_NuevaFecha" runat="server" ValidationGroup="Fecha" IDMode="Legacy" MaxDate="" MinDate="" SelectedDate="" HideWithLabel="False" ShowToday="False"></ext:DateField></td>
                                    <td align="left" style="width: 40%">&nbsp;<asp:CustomValidator ID="CustomValidator_Fecha" runat="server" ControlToValidate="DateField_NuevaFecha" ErrorMessage="Campo obligatorio." ForeColor="Tomato" ValidateEmptyText="True" ClientValidationFunction="ValidarFecha" Display="Dynamic"></asp:CustomValidator></td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 30%">
                                        <asp:Label ID="Label_Hora" runat="server" Font-Bold="True" Visible="False">Hora:</asp:Label></td>
                                    <td align="left" style="width: 30%">
                                        <ext:TimeField ID="TimeField_Hora" runat="server" AllowBlank="True" AutoPostBack="false"
                                            BlankText="Campo obligatorio." Format="hh:mm tt" Increment="30"
                                            MaxHeight="150px" MinListWidth="35px" SelectedIndex="0" Width="120px">
                                        </ext:TimeField>
                                    </td>
                                    <td align="left" style="width: 40%">
                                    </td>
                                </tr>
                            </table>
                   </td>
               </tr>
                <tr>
                    <td align="center" colspan="2" style="height: 33px">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 50%; height: 14px;"><asp:Label ID="Label_Resultado" runat="server" ForeColor="ForestGreen" Font-Bold="True"></asp:Label></td>
                                <td style="width: 50%; height: 14px;"><asp:LinkButton ID="LinkButton_Save" runat="server" OnClick="LinkButton_Save_Click">Aceptar</asp:LinkButton></td>
                            </tr>
                        </table>
                    </td>
                </tr>
        </table>
    </form>
</body>
</html>
