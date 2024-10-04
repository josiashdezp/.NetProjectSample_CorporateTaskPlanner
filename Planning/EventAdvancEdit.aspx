<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventAdvancEdit.aspx.cs" Inherits="Planning_EventMove" %>
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
    <script type="text/javascript" language="javascript">

        function ValidateCheckBoxList(source, arguments) {
            alert(String(CheckBoxList_Planes.items.Count));
            arguments.isValid = false;
        }
        function ValidarFecha(source, arguments) {
            if (arguments.Value.toString() != '')
                arguments.IsValid = true;
            else
                arguments.IsValid = false;
        }   
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ScriptManager ID="ScriptManager1" runat="server" Locale="es-ES" RemoveViewState="False">
    </ext:ScriptManager>
    <div>
        <dxcp:ASPxCallbackPanel ID="CallbackPanel_EventMove" runat="server" Width="100%" ClientInstanceName="CallbackPanel_EventMove" OnCallback="CallbackPanel_EventMove_Callback">
        <PanelCollection>
        <dxp:PanelContent runat="server">    
        <br />
        <h3>Modificación Avanzada de Tareas</h3>
    <br />
    <table width="100%" cellspacing="5">
        <tr>
            <td width="25%" align="right" style="font-weight: bold" valign="top">
                &nbsp;Nombre de la tarea:&nbsp;
            </td>
            <td width="75%" align="left">
                &nbsp;<asp:Label ID="Label_Nombre" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right" class="Altern" width="25%" style="font-weight: bold" valign="top">
                Fecha y hora programada:&nbsp;
            </td>
            <td class="Altern" width="75%" align="left">
                &nbsp;<asp:Label ID="Label_Fecha" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right" width="25%" style="font-weight: bold" class="Altern" valign="top">
                Detalles de la ejecución:&nbsp;
            </td>
            <td width="75%" align="left" class="Altern">
                &nbsp;<asp:TextBox ID="TextBox_Detalles" runat="server" CssClass="Input" TextMode="MultiLine"
                    Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td width="25%" align="right" style="font-weight: bold" valign="top">
                &nbsp;Otros implicados:&nbsp;
            </td>
            <td width="75%" align="left">
                &nbsp;<asp:TextBox ID="TextBox_Implicados" runat="server" CssClass="Input" TextMode="MultiLine"
                    Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" style="font-weight: bold" valign="top" width="25%">
                Operación a realizar:&nbsp;
            </td>
            <td align="left" width="75%">
                <asp:RadioButtonList ID="RadioButtonList_Modificar" runat="server" CellPadding="5"
                    CssClass="Input" Font-Bold="False">
                    <asp:ListItem Value="0">Modificar solo esta tarea</asp:ListItem>
                    <asp:ListItem Value="1">Modificar todas las planificaciones de esta tarea en el rango:</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right" valign="top" width="25%">
            </td>
            <td align="left" width="75%">
                <table style="width: 100%">
                    <tr>
                        <td align="right" style="width: 100px">
                            Desde:</td>
                        <td align="left" style="width: 100px">
                            <ext:DateField ID="DateField_Desde" runat="server" IDMode="Legacy"
                                MaxDate="" MinDate="" SelectedDate="">
                            </ext:DateField>
                        </td>
                        <td align="right" style="width: 100px">
                            Hasta:</td>
                        <td align="left" style="width: 100px">
                            <ext:DateField ID="DateField_Hasta" runat="server" IDMode="Legacy"
                                MaxDate="" MinDate="" SelectedDate="">
                            </ext:DateField>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:LinkButton ID="LinkButton_Aceptar" runat="server" OnClick="LinkButton_Aceptar_Click">Aceptar</asp:LinkButton>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton_Cancela" runat="server">Cancelar</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadioButtonList_Modificar"
                    Display="Dynamic" ErrorMessage="Seleccione la operaci&#243;n a realizar." ForeColor="Tomato"></asp:RequiredFieldValidator>
                <asp:Label ID="Label_Mnsg" runat="server" Font-Bold="True"></asp:Label>
            </td>
        </tr>
    </table>
                </dxp:PanelContent>
</PanelCollection>
        </dxcp:ASPxCallbackPanel>    
    </div>
    </form>
</body>
</html>