<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="AdminUsers.aspx.cs" Inherits="AdminUsers" Title="Trabajadores Registrados. Planificador Online." %>

<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
    <br />
    <h3>&nbsp;&nbsp;Usuarios del Sistema:</h3>
    <br />
    <table style="width: 100%">
        <tr>
            <td>
                <asp:CheckBox ID="CheckBox_Todos" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox_Todos_CheckedChanged"
                    Text="Ver todos los usuarios" TextAlign="Left" />&nbsp; Nombre del área:
                <asp:DropDownList ID="DropDownList_Filtrar" runat="server" AutoPostBack="True" CssClass="Input" DataSourceID="SqlDataSource_Areas" DataTextField="NombreArea" DataValueField="AreaID" OnSelectedIndexChanged="DropDownList_Filtrar_SelectedIndexChanged">
                    <asp:ListItem Value="00000000000">- Seleccionar -</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;<asp:HyperLink ID="HyperLink_AddUser" runat="server" CssClass="Input"
                    NavigateUrl="~/Admin/AddUser.aspx">Adicionar Trabajador</asp:HyperLink><asp:SqlDataSource ID="SqlDataSource_Areas" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>" SelectCommand="SELECT AreaID, NombreArea FROM Areas"></asp:SqlDataSource>
                <br />
                <asp:Label ID="Label_Mnsg" runat="server" Font-Bold="True" ForeColor="Tomato" Visible="False"></asp:Label>
                <br />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:GridView ID="GridView_Trabajadores" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" CssClass="Listados" DataKeyNames="UserID,NID" DataSourceID="SqlDataSource_Trabajadores"
                    GridLines="Horizontal" Width="85%" PageSize="20" EmptyDataText="No se han registrado trabajadores en esta área.">
                    <EmptyDataRowStyle CssClass="Empty" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("UserID", "~/Admin/EditUser.aspx?ID={0}&OP=sist") %>'
                                    Text="Modificar"></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" Visible="False" />
                        <asp:BoundField DataField="NID" HeaderText="NID" ReadOnly="True" SortExpression="NID" Visible="False" />
                        <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre completo" SortExpression="NombreCompleto" />
                        <asp:CheckBoxField DataField="Planifica" HeaderText="Planifica" SortExpression="Planifica" />
                        <asp:CheckBoxField DataField="EsReserva" HeaderText="Es reserva" SortExpression="EsReserva" />
                        <asp:CheckBoxField DataField="EsCuadro" HeaderText="Es cuadro" SortExpression="EsCuadro" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                    Text="Eliminar" OnClientClick="return confirm( 'Si existe alguna planificación creada por este trabajador, se borrará conjuntamente con sus datos personales y de acceso. Esta operación no se puede revertir. ¿Desea continuar con la operación?');"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="Encabezado" />
                    <AlternatingRowStyle CssClass="Altern" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_Trabajadores" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="stp_MostrarTrabajadoresPorAreas" SelectCommandType="StoredProcedure" DeleteCommand="DELETE FROM Trabajador WHERE (NID = @NID) AND (UserID = @UserID)" OnSelecting="SqlDataSource_Trabajadores_Selecting" OnDeleting="SqlDataSource_Trabajadores_Deleting">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_Filtrar" ConvertEmptyStringToNull="False"
                            DefaultValue="" Name="CodigoArea" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView_Trabajadores" Name="NID" PropertyName="SelectedDataKey" />
                        <asp:ControlParameter ControlID="GridView_Trabajadores" Name="UserID" PropertyName="SelectedDataKey" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    
</asp:Content>

