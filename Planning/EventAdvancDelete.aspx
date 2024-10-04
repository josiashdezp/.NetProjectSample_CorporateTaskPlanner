<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventAdvancDelete.aspx.cs" Inherits="EventAdvancedDelete" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>

<%@ Register assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" namespace="DevExpress.Web.ASPxCallbackPanel" tagprefix="dxcp" %>
<%@ Register assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" namespace="DevExpress.Web.ASPxPanel" tagprefix="dxp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
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
    <div><ext:ScriptManager ID="ScriptManager1" runat="server" Locale="es-ES" RemoveViewState="False">
    </ext:ScriptManager>
        <br />
        <h3>
            Eliminación de Tareas</h3>
        <br />
        <center>
            <br />
            <table style="width: 100%">
                <tr>
                    <td align="right" colspan="2" style="font-weight: bold">
                        Nombre de la tarea: &nbsp;
                    </td>
                    <td align="left" colspan="4">
                        <asp:Label ID="Label_Nombre" runat="server" Font-Bold="False"></asp:Label></td>
                </tr>
                <tr>
                    <td align="left" colspan="6">
        <div style="margin: auto; width: 90%">
            <asp:RadioButtonList ID="RadioButtonList_Delete" runat="server" CellPadding="5" Font-Bold="True">
                <asp:ListItem Value="0">Borrar solo esta tarea</asp:ListItem>
                <asp:ListItem Value="1">Borrar todas las planificaciones de esta tarea en el rango:</asp:ListItem>
            </asp:RadioButtonList>
            </div>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="font-weight: bold; width: 10%">
                        Desde:&nbsp;
                    </td>
                    <td align="left" style="width: 20%">
                        <ext:DateField ID="DateField_Desde" runat="server" IDMode="Legacy" MaxDate="" MinDate=""
                            SelectedDate="">
                        </ext:DateField>
                    </td>
                    <td align="left" style="width: 20%">
                        <asp:CustomValidator ID="CustomValidator_Desde" runat="server" ClientValidationFunction="ValidarFecha"
                            ControlToValidate="DateField_Desde" ErrorMessage="Campo obligatorio." ForeColor="Tomato"></asp:CustomValidator>
                    </td>
                    <td align="right" style="font-weight: bold; width: 10%">
                        Hasta: &nbsp;
                    </td>
                    <td align="left" style="width: 20%">
                        <ext:DateField ID="DateField_Hasta" runat="server" IDMode="Legacy" MaxDate="" MinDate=""
                            SelectedDate="">
                        </ext:DateField>
                    </td>
                    <td align="left" style="width: 20%">
                        <asp:CustomValidator ID="CustomValidator_Hasta" runat="server" ClientValidationFunction="ValidarFecha"
                            ControlToValidate="DateField_Hasta" ErrorMessage="Campo obligatorio." ForeColor="Tomato"></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="6" style="height: 50px">
                        <asp:LinkButton ID="LinkButton_Aceptar" runat="server" OnClick="LinkButton_Aceptar_Click">Aceptar</asp:LinkButton>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        <asp:LinkButton ID="LinkButton_Cancela" runat="server">Cancelar</asp:LinkButton>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="6" style="height: 30px">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadioButtonList_Delete"
                Display="Dynamic" ErrorMessage="Seleccione la opción a ejecutar." ForeColor="Tomato"></asp:RequiredFieldValidator>
                        <asp:Label ID="Label_Msg" runat="server" Font-Bold="True" Text="" Visible="true"></asp:Label></td>
                </tr>
            </table>
        </center>
    </div>
    </form>
</body>
</html>