<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageSendEmail.aspx.cs" Inherits="Manage_Manage_SendEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Notificar trabajadores implicados</title>
    <link href="../Styles/WebPlanner_Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">    
    <table style="margin:auto;width:97%;">    
        <tr>
            <td align="left" colspan="2" style="font-weight: bold">
        Observaciones a incluir en el mensaje:</td>
        </tr>
        <tr>
            <td align="center" colspan="2">
        <asp:TextBox ID="TextBox_Observaciones" runat="server" TextMode="MultiLine" Width="100%" Rows="5" CssClass="Input">Tiene tareas pendientes en el plan de trabajo. Revise por favor.</asp:TextBox></td>
        </tr>
        <tr>
            <td align="left" style="width: 65%">
                <asp:Label ID="Label_Mnsg" runat="server" Font-Bold="True"></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</td>
            <td align="right" style="width: 35%">
        <asp:Button ID="Button_Send" runat="server" OnClick="Button_Send_Click" Text="Enviar notificación" CssClass="Input" /></td>
        </tr>
    </table>    
    </form>
</body>
</html>
