<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="Degrees.aspx.cs" Inherits="Lists_Degrees" Title="Planificador Online. Titulos Académicos." %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
    &nbsp;<table width="100%">
        <tr>
            <td colspan="2" style="text-decoration: underline">
                <h2> Títulos Académicos:</h2>
                    <input id="Button_Insertar" class="Input" type="button" value="Nuevo" /><br />
                <br />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
    
        
<asp:GridView id="GridView_Titulos" runat="server" CssClass="Listados" OnRowDeleting="GridView1_RowDeleting" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="TituloID" DataSourceID="SqlDataSource_Titulos" EmptyDataText="No hay registros de datos para mostrar." GridLines="Horizontal" Width="80%"><Columns>
<asp:TemplateField ShowHeader="False"><EditItemTemplate>
<asp:LinkButton runat="server" Text="Actualizar" CommandName="Update" CausesValidation="True" id="LinkButton1"></asp:LinkButton> <asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" CausesValidation="False" id="LinkButton2"></asp:LinkButton>
</EditItemTemplate>
<ItemTemplate>
<asp:LinkButton id="LinkButton1" runat="server" Text="Editar" CommandName="Edit" CausesValidation="False"></asp:LinkButton> <asp:LinkButton id="LinkButton2" runat="server" Text="Eliminar" CommandName="Delete" CausesValidation="False" OnClientClick='return confirm("¿Seguro desea borrar el registro actual?");'></asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="TituloID" InsertVisible="False" SortExpression="TituloID" HeaderText="C&#243;digo"></asp:BoundField>
<asp:BoundField DataField="Titulo" SortExpression="Titulo" HeaderText="Nombre">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
</Columns>
<HeaderStyle CssClass="Encabezado"></HeaderStyle>
<AlternatingRowStyle CssClass="Altern"></AlternatingRowStyle>
</asp:GridView>&nbsp;<asp:SqlDataSource id="SqlDataSource_Titulos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" DeleteCommand="DELETE FROM [Titulos] WHERE [TituloID] = @TituloID" InsertCommand="INSERT INTO [Titulos] ([Titulo]) VALUES (@Titulo)" ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>" SelectCommand="SELECT [TituloID], [Titulo] FROM [Titulos]" UpdateCommand="UPDATE [Titulos] SET [Titulo] = @Titulo WHERE [TituloID] = @TituloID">
                    <DeleteParameters>
                        <asp:Parameter Name="TituloID" Type="Int16" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Titulo" Type="String" />
                        <asp:Parameter Name="TituloID" Type="Int16" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Titulo" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR /><asp:Label id="Label_Error" runat="server" Visible="False" Font-Bold="True" ForeColor="Tomato"></asp:Label>

    </td>
        </tr>
        <tr>
        </tr>
    </table>
    &nbsp;<dxpc:aspxpopupcontrol id="ASPxPopupControl1" runat="server" cssclass="Listados"
                    headertext="Registrar nivel escolar" modal="True" popupelementid="Button_Insertar"
                    width="225px" allowdragging="True" popuphorizontalalign="WindowCenter" popupverticalalign="WindowCenter"><ContentCollection>
<dxpc:PopupControlContentControl runat="server"><asp:DetailsView runat="server" Height="50px" DefaultMode="Insert" Width="100%" DataSourceID="SqlDataSource_Titulos" CssClass="Listados" ID="DetailsView_Titulos" GridLines="Horizontal" AutoGenerateRows="False" DataKeyNames="TituloID">
<AlternatingRowStyle CssClass="Altern"></AlternatingRowStyle>
<Fields>
<asp:BoundField ReadOnly="True" DataField="TituloID" InsertVisible="False" SortExpression="TituloID" HeaderText="TituloID"></asp:BoundField>
    <asp:TemplateField HeaderText="Titulo" SortExpression="Titulo">
        <EditItemTemplate>
            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Titulo") %>'></asp:TextBox>
        </EditItemTemplate>
        <InsertItemTemplate>
            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Titulo") %>' ValidationGroup="Insertar"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                ErrorMessage="Campo requerido." ForeColor="Tomato" ValidationGroup="Insertar">*</asp:RequiredFieldValidator>
        </InsertItemTemplate>
        <ItemTemplate>
            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Titulo") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField ShowHeader="False">
        <InsertItemTemplate>
            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insertar" ValidationGroup="Insertar"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancelar" ValidationGroup="Insertar"></asp:LinkButton>
        </InsertItemTemplate>
        <ItemTemplate>
            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="New"
                Text="Nuevo"></asp:LinkButton>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField>
        <InsertItemTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                ForeColor="Tomato" ValidationGroup="Insertar" />
        </InsertItemTemplate>
    </asp:TemplateField>
</Fields>
</asp:DetailsView>
 &nbsp;<BR />(Clic fuera de esta ventana para cerrar)</dxpc:PopupControlContentControl>
</ContentCollection>
<ModalBackgroundStyle Opacity="30"></ModalBackgroundStyle>
<HeaderStyle CssClass="Encabezado" Font-Bold="True" ForeColor="#FFFFE1"></HeaderStyle>
</dxpc:aspxpopupcontrol>
</asp:Content>