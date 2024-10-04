<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="Positions.aspx.cs" Inherits="Lists_Positions" Title="Clasificador de Cargos" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<table width="100%">
    <TBODY>
        <tr>
            <td style="TEXT-DECORATION: underline;" colSpan=2>
            <h2>Clasificador de Cargos:</h2>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input id="Button_Insert" class="Input" type="button" value="Nuevo Cargo" /></td>
        </tr>
        <tr>
            <td colSpan=2 rowSpan=1 valign="top" align="center">                                   
<br />
                <asp:GridView ID="GridView_Cargos" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" CssClass="Listados" DataKeyNames="CargoID" DataSourceID="SqlDataSource_Cargos"
                    EmptyDataText="No hay registros de datos para mostrar." GridLines="Horizontal"
                    Width="80%" OnRowDeleting="GridView_Cargos_RowDeleting">
                    <EmptyDataRowStyle CssClass="Empty" />
                    <Columns><asp:TemplateField ShowHeader="False"><EditItemTemplate>
<asp:LinkButton runat="server" Text="Actualizar" CommandName="Update" CausesValidation="true" id="LinkButton1"></asp:LinkButton> <asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" CausesValidation="False" id="LinkButton2"></asp:LinkButton>
</EditItemTemplate>
<ItemTemplate>
<asp:LinkButton id="LinkButton1" runat="server" Text="Editar" CommandName="Edit" CausesValidation="False"></asp:LinkButton> <asp:LinkButton id="LinkButton2" runat="server" Text="Eliminar" CommandName="Delete" CausesValidation="False" OnClientClick='return confirm("¿Seguro desea borrar el registro actual?");'></asp:LinkButton>
</ItemTemplate>
</asp:TemplateField>
                        <asp:BoundField DataField="CargoID" HeaderText="C&#243;digo" InsertVisible="False" ReadOnly="True"
                            SortExpression="CargoID" />
                        <asp:BoundField DataField="Cargo" HeaderText="Cargo" SortExpression="Cargo" />
                        <asp:CheckBoxField DataField="EsCuadro" HeaderText="Es Jefe o Directivo" SortExpression="EsCuadro" />
                    </Columns>
                    <HeaderStyle CssClass="Encabezado" />
                    <AlternatingRowStyle CssClass="Altern" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_Cargos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    DeleteCommand="DELETE FROM [Cargo] WHERE [CargoID] = @CargoID" InsertCommand="INSERT INTO [Cargo] ([Cargo], [EsCuadro]) VALUES (@Cargo, @EsCuadro)"
                    ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>"
                    SelectCommand="SELECT [CargoID], [Cargo], [EsCuadro] FROM [Cargo]" UpdateCommand="UPDATE [Cargo] SET [Cargo] = @Cargo, [EsCuadro] = @EsCuadro WHERE [CargoID] = @CargoID">
                    <DeleteParameters>
                        <asp:Parameter Name="CargoID" Type="Int16" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Cargo" Type="String" />
                        <asp:Parameter Name="EsCuadro" Type="Boolean" />
                        <asp:Parameter Name="CargoID" Type="Int16" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Cargo" Type="String" />
                        <asp:Parameter Name="EsCuadro" Type="Boolean" />
                    </InsertParameters>
                </asp:SqlDataSource>
                &nbsp;&nbsp;<br /><asp:Label id="Label_Error" runat="server" ForeColor="Tomato" Font-Bold="true"></asp:Label><br />
                
                &nbsp;
                <br />
    <dxpc:ASPxPopupControl ID="ASPxPopupControl_Cargos" runat="server"
        ClientInstanceName="PopupControl" FooterText="" HeaderText="Registrar nuevo cargo"
        PopupElementID="Button_Insert" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" CssClass="Listados" Modal="true" Width="264px">
        <ContentCollection>
            <dxpc:PopupControlContentControl runat="server">
<asp:DetailsView runat="server" DefaultMode="Insert" Width="101%" DataSourceID="SqlDataSource_Cargos" CssClass="Listados" ID="DetailsView_Cargos" AutoGenerateRows="False" DataKeyNames="CargoID" GridLines="Horizontal" ><Fields>
    <asp:BoundField DataField="CargoID" HeaderText="CargoID" InsertVisible="False" ReadOnly="true"
        SortExpression="CargoID" />
    <asp:TemplateField HeaderText="Cargo" SortExpression="Cargo">
        <EditItemTemplate>
            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Cargo") %>'></asp:TextBox>
        </EditItemTemplate>
        <InsertItemTemplate>
            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Cargo") %>' ValidationGroup="Insert"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                ErrorMessage="Campo obligatorio" ForeColor="Tomato" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
        </InsertItemTemplate>
        <ItemTemplate>
            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Cargo") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:CheckBoxField DataField="EsCuadro" HeaderText="Es Cuadro" SortExpression="EsCuadro" />
    <asp:TemplateField ShowHeader="False">
        <InsertItemTemplate>
            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="true" CommandName="Insert"
                Text="Insertar" ValidationGroup="Insert"></asp:LinkButton>
            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancelar" ValidationGroup="Insert"></asp:LinkButton>
        </InsertItemTemplate>
        <ItemTemplate>
            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="New"
                Text="Nuevo"></asp:LinkButton>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField>
        <InsertItemTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                ForeColor="Tomato" ValidationGroup="Insert" />
        </InsertItemTemplate>
    </asp:TemplateField>
</Fields>
                    <HeaderStyle CssClass="Encabezado" />
    <AlternatingRowStyle CssClass="Altern" />
</asp:DetailsView>
                <br />
                (Clic fuera de esta ventana para salir)
            </dxpc:PopupControlContentControl>
        </ContentCollection>
        <HeaderStyle BackColor="#FCD067" CssClass="Encabezado" Font-Bold="true" ForeColor="#FFFFE1" />
        <ModalBackgroundStyle Opacity="30">
        </ModalBackgroundStyle>
    </dxpc:ASPxPopupControl>
            </td>
         </tr>
   </TBODY>
</table>
    <br />
</asp:Content>

