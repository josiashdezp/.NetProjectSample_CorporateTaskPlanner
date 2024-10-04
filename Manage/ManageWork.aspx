<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="ManageWork.aspx.cs" Inherits="Manage_ManageWork" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
    <table style="margin: auto" width="75%">
        <tr>
            <td colspan="3">
                <h4>
                    Controle y Evaluación:</h4>
            </td>
        </tr>
        <tr>
            <td style="width: 33%; height: 6px">
                <asp:HyperLink ID="HyperLink10" runat="server">Tareas Pendientes</asp:HyperLink></td>
            <td style="width: 33%; height: 6px">
                <asp:HyperLink ID="HyperLink11" runat="server">Tareas cumplidas</asp:HyperLink></td>
            <td style="width: 33%; height: 6px">
            </td>
        </tr>
    </table>
</asp:Content>

