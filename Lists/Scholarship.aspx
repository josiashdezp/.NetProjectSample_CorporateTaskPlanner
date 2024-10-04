<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="Scholarship.aspx.cs" Inherits="Lists_Scholarship" Title="Untitled Page" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<TABLE width="100%"><TBODY><TR><TD 
style="TEXT-DECORATION: underline;">
<H3>Nivel de Escolaridad:</H3>
<input id="Button_Insertar" class="Input" type="button" value="Insertar" /></TD>
    </TR><TR><TD align="center" valign="top">
        <asp:GridView ID="GridView_NivelEscolar" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CssClass="Listados" DataKeyNames="NivelID" DataSourceID="SqlDataSource_NivelEscolar"
            EmptyDataText="No hay registros de datos para mostrar." Width="80%" GridLines="Horizontal" OnRowDeleting="GridView1_RowDeleting">
            <Columns><asp:TemplateField ShowHeader="False"><EditItemTemplate>
<asp:LinkButton runat="server" Text="Actualizar" CommandName="Update" CausesValidation="True" id="LinkButton1"></asp:LinkButton> <asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" CausesValidation="False" id="LinkButton2"></asp:LinkButton>
</EditItemTemplate>
<ItemTemplate>
<asp:LinkButton id="LinkButton1" runat="server" Text="Editar" CommandName="Edit" CausesValidation="False"></asp:LinkButton> <asp:LinkButton id="LinkButton2" runat="server" Text="Eliminar" CommandName="Delete" CausesValidation="False" OnClientClick='return confirm("¿Seguro desea borrar el registro actual?");'></asp:LinkButton>
</ItemTemplate>
</asp:TemplateField>
                <asp:BoundField DataField="NivelID" HeaderText="NivelID" InsertVisible="False" ReadOnly="True"
                    SortExpression="NivelID" />
                <asp:BoundField DataField="Nivel" HeaderText="Nivel" SortExpression="Nivel" />
            </Columns>
            <HeaderStyle CssClass="Encabezado" />
            <AlternatingRowStyle CssClass="Altern" Width="80%" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource_NivelEscolar" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
            DeleteCommand="DELETE FROM [NivelEscolar] WHERE [NivelID] = @NivelID" InsertCommand="INSERT INTO [NivelEscolar] ([Nivel]) VALUES (@Nivel)"
            ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>"
            SelectCommand="SELECT [NivelID], [Nivel] FROM [NivelEscolar]" UpdateCommand="UPDATE [NivelEscolar] SET [Nivel] = @Nivel WHERE [NivelID] = @NivelID">
            <DeleteParameters>
                <asp:Parameter Name="NivelID" Type="Int16" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Nivel" Type="String" />
                <asp:Parameter Name="NivelID" Type="Int16" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="Nivel" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource><BR /><asp:Label id="Label_Error" runat="server" ForeColor="Tomato" Font-Bold="True"></asp:Label>
        &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<dxpc:ASPxPopupControl ID="ASPxPopupControl1" runat="server" AllowDragging="True"
        CssClass="Listados" HeaderText="Registrar nivel de escolaridad" Modal="True"
        PopupElementID="Button_Insertar" Width="200px">
        <ContentCollection>
            <dxpc:PopupControlContentControl runat="server">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CssClass="Listados"
                    DataKeyNames="NivelID" DataSourceID="SqlDataSource_NivelEscolar" DefaultMode="Insert"
                    GridLines="Horizontal" Height="50px" Width="100%">
                    <AlternatingRowStyle CssClass="Altern" />
                    <Fields>
                        <asp:BoundField DataField="NivelID" HeaderText="NivelID" InsertVisible="False" ReadOnly="True"
                            SortExpression="NivelID" />
                        <asp:TemplateField HeaderText="Nivel" SortExpression="Nivel">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Nivel") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Nivel") %>' ValidationGroup="Insertar"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                    ErrorMessage="Campo obligatorio." ForeColor="Tomato" ValidationGroup="Insertar">*</asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Nivel") %>'></asp:Label>
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
                <br />
                (Clic fuera de esta ventana para cerrar)</dxpc:PopupControlContentControl>
        </ContentCollection>
        <ModalBackgroundStyle Opacity="30">
        </ModalBackgroundStyle>
        <HeaderStyle CssClass="Encabezado" Font-Bold="True" ForeColor="#FFFFE1" />
    </dxpc:ASPxPopupControl>
    </TD></TR><TR></TR></TBODY></TABLE>
    <br />
</asp:Content>

