<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="AreasAndDepartmts.aspx.cs" Inherits="Lists_Dptos" Title="Clasificador de Áreas y Departamentos" %>

<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
    <table style="width: 85%">
        <tr>
            <td style="width: 50%">
                <h2> Áreas y Departamentos:</h2>
            </td>
            <td style="width: 25%" align="right">
                Mostrar clasificador de : &nbsp;
            </td>
            <td style="width: 25%" align="left" valign="middle">
                <asp:RadioButtonList ID="RadioButtonList_Vista" runat="server" CssClass="Input" RepeatDirection="Horizontal" AutoPostBack="True">
                    <asp:ListItem Selected="True">Departamentos</asp:ListItem>
                    <asp:ListItem Value="Areas">&#193;reas</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
    </table>    
    <br /><br />
    <table width="100%">            
        <tr>
            <td colspan="3" rowspan="1">
                <asp:MultiView ID="MultiView_Listas" runat="server" OnLoad="MultiView_Listas_Load">
                    <asp:View ID="View_Dptos" runat="server">
                        <table style="width: 100%">
                            <tr>
                                <td colspan="">
                
Mostrar departamentos del área : <asp:DropDownList id="DropDownList_Areas" runat="server" CssClass="Input" AutoPostBack="True" DataValueField="AreaID" DataTextField="NombreArea" DataSourceID="SqlDataSource_AreasList">
            </asp:DropDownList> <asp:SqlDataSource id="SqlDataSource_AreasList" runat="server" SelectCommand="SELECT [AreaID], [NombreArea] FROM [Areas] ORDER BY [NombreArea]" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>">
            </asp:SqlDataSource>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input id="Button_InsertarDpto" class="Input" type="button" value="Nuevo Departamento" />&nbsp;
                <br />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                
<asp:GridView id="GridView_Dptos" runat="server" CssClass="Listados" DataSourceID="SqlDataSource_Dptos" Width="70%" GridLines="Horizontal" EmptyDataText="No hay registros de datos para mostrar." DataKeyNames="DptoID" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowDeleting="GridView_Dptos_RowDeleting">
<EmptyDataRowStyle CssClass="Empty"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField ShowHeader="False"><EditItemTemplate>
<asp:LinkButton runat="server" Text="Actualizar" CommandName="Update" CausesValidation="True" id="LinkButton1"></asp:LinkButton>&nbsp;<asp:LinkButton runat="server" Text="Cancelar" CommandName="Cancel" CausesValidation="False" id="LinkButton2"></asp:LinkButton>
</EditItemTemplate>
<ItemTemplate>
<asp:LinkButton id="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Editar"></asp:LinkButton>&nbsp;<asp:LinkButton id="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Eliminar" OnClientClick='return confirm("¿Seguro desea borrar el registro actual?");'></asp:LinkButton>
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField ReadOnly="True" DataField="DptoID" InsertVisible="False" SortExpression="DptoID" HeaderText="C&#243;digo"></asp:BoundField>
    <asp:TemplateField HeaderText="Nombre de Dpto." SortExpression="NombreDpto">
        <EditItemTemplate>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="Input" Text='<%# Bind("NombreDpto") %>'
                Width="191px"></asp:TextBox>
        </EditItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        <ItemTemplate>
            <asp:Label ID="Label1" runat="server" Text='<%# Bind("NombreDpto") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField>
        <ItemTemplate>
            <asp:LinkButton ID="LinkButton_Area" runat="server" CommandName="Select">Cambiar de área</asp:LinkButton>
            <dxpc:ASPxPopupControl ID="PopupControl_Areas" runat="server" PopupElementID="LinkButton_Area"
                PopupHorizontalAlign="OutsideLeft" PopupVerticalAlign="Middle" ShowHeader="False"
                Width="200px">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        Pasar al área :<asp:DropDownList ID="DropDownList_ChangeArea" runat="server" AppendDataBoundItems="True"
                            AutoPostBack="True" CssClass="Input" DataSourceID="SqlDataSource_AreasList" DataTextField="NombreArea"
                            DataValueField="AreaID" OnSelectedIndexChanged="DropDownList_ChangeArea_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="00">- Seleccionar - </asp:ListItem>
                        </asp:DropDownList>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:ASPxPopupControl>
        </ItemTemplate>
    </asp:TemplateField>
</Columns>

<HeaderStyle CssClass="Encabezado"></HeaderStyle>

<AlternatingRowStyle CssClass="Altern"></AlternatingRowStyle>
</asp:GridView> 
                                    <br />
                                    <asp:Label id="Label_ErrorDpto" runat="server" ForeColor="Tomato" Font-Bold="True"></asp:Label></td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="View_Areas" runat="server">
                        <table style="width: 100%">
                            <tr>
                                <td align="center">
    <input id="Button_InsertarArea" class="Input" type="button" value="Nueva Área" /><br />
                                    <br />
                                    <asp:GridView
        ID="GridView_Areas" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        CssClass="Listados" DataKeyNames="AreaID" DataSourceID="SqlDataSource_Areas"
        EmptyDataText="No hay registros de datos para mostrar." GridLines="Horizontal"
        OnRowDeleting="GridView_Areas_RowDeleting" Width="65%">
        <EmptyDataRowStyle CssClass="Empty" />
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                        Text="Actualizar"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancelar"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                        Text="Editar"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm("¿Seguro desea borrar el registro actual?");' Text="Eliminar"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="AreaID" HeaderText="C&#243;digo" InsertVisible="False" ReadOnly="True"
                SortExpression="AreaID">
                <HeaderStyle Width="25%" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Nombre del Area" SortExpression="NombreArea">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="Input" Text='<%# Bind("NombreArea") %>'
                        Width="217px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("NombreArea") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="Encabezado" />
        <AlternatingRowStyle CssClass="Altern" />
    </asp:GridView>
                                    <br />
    <asp:Label ID="Label_ErrorArea" runat="server" Font-Bold="True" ForeColor="Tomato" Visible="False"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 100px">
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                </asp:MultiView></td>
        </tr>
        <tr>
        </tr>
    </table>
    <asp:SqlDataSource id="SqlDataSource_Dptos" runat="server" SelectCommand="SELECT [DptoID], [NombreDpto], [AreaID] FROM [Departamentos]&#13;&#10;where AreaID = @Area" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" UpdateCommand="UPDATE [Departamentos] SET [NombreDpto] = @NombreDpto, [AreaID] = @AreaID WHERE [DptoID] = @DptoID" ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>" InsertCommand="INSERT INTO [Departamentos] ([NombreDpto], [AreaID]) VALUES (@NombreDpto, @AreaID)" DeleteCommand="DELETE FROM [Departamentos] WHERE [DptoID] = @DptoID" OnUpdating="SqlDataSource_Dptos_Updating">
        <DeleteParameters>
            <asp:Parameter Name="DptoID" Type="Int16" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="NombreDpto" Type="String" />
            <asp:Parameter Name="AreaID" Type="Int16" />
            <asp:Parameter Name="DptoID" Type="Int16" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Areas" Name="Area" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="NombreDpto" Type="String" />
            <asp:Parameter Name="AreaID" Type="Int16" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Areas" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
        DeleteCommand="DELETE FROM [Areas] WHERE [AreaID] = @AreaID" InsertCommand="INSERT INTO [Areas] ([NombreArea]) VALUES (@NombreArea)"
        ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>"
        SelectCommand="SELECT [AreaID], [NombreArea] FROM [Areas]" UpdateCommand="UPDATE [Areas] SET [NombreArea] = @NombreArea WHERE [AreaID] = @AreaID">
        <DeleteParameters>
            <asp:Parameter Name="AreaID" Type="Int16" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="NombreArea" Type="String" />
            <asp:Parameter Name="AreaID" Type="Int16" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="NombreArea" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <dxpc:ASPxPopupControl ID="ASPxPopupControl1" runat="server" AllowDragging="True"
        CssClass="Listados" DragElement="Window" HeaderText="" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        Width="300px">
        <ContentCollection>
            <dxpc:PopupControlContentControl runat="server">
                </dxpc:PopupControlContentControl>
        </ContentCollection>
        <HeaderStyle CssClass="Encabezado" Font-Bold="True" ForeColor="#FFFFE1" />
        <Windows>
            <dxpc:PopupWindow HeaderText="Nuevo Departamento" Name="Departamentos" PopupElementID="Button_InsertarDpto"
                ShowHeader="True">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <asp:DetailsView ID="DetailsView_Dptos" runat="server" AutoGenerateRows="False" CssClass="Listados"
                    DataKeyNames="DptoID" DataSourceID="SqlDataSource_Dptos" DefaultMode="Insert"
                    GridLines="Horizontal" Height="50px" Width="100%" OnItemInserted="DetailsView_Dptos_ItemInserted">
                    <AlternatingRowStyle CssClass="Altern" />
                    <Fields>
                        <asp:BoundField DataField="DptoID" HeaderText="DptoID" InsertVisible="False" ReadOnly="True"
                            SortExpression="DptoID" />
                        <asp:TemplateField HeaderText="Nombre:" SortExpression="NombreDpto">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NombreDpto") %>' CssClass="Input"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NombreDpto") %>' ValidationGroup="Insert" CssClass="Input"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox2"
                                    ErrorMessage="Campo obligatorio." ForeColor="Tomato" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("NombreDpto") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Area:" SortExpression="AreaID">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="Input" Text='<%# Bind("AreaID") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" CssClass="Input" DataSourceID="SqlDataSource_NewAreas"
                                    DataTextField="NombreArea" DataValueField="AreaID" SelectedValue='<%# Bind("AreaID") %>'
                                    ValidationGroup="Insert">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator_area" runat="server" ControlToValidate="DropDownList1"
                                    ErrorMessage="Seleccione el área a donde pertenece." ForeColor="Tomato" ValidationGroup="Insert">*</asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="SqlDataSource_NewAreas" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                    SelectCommand="SELECT [AreaID], [NombreArea] FROM [Areas]"></asp:SqlDataSource>
                            </InsertItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("AreaID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <InsertItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Insert"
                                    Text="Insertar" ValidationGroup="Insert"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                    Text="Cancelar" ValidationGroup="Insert"></asp:LinkButton>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="New"
                                    Text="Nuevo"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <InsertItemTemplate>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                                    ForeColor="Tomato" ValidationGroup="Insert" />
                            </InsertItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                </asp:DetailsView>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:PopupWindow>
            <dxpc:PopupWindow HeaderText="Nueva &#193;rea" Name="Areas" PopupElementID="Button_InsertarArea"
                ShowHeader="True">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CssClass="Listados"
                            DataSourceID="SqlDataSource_Areas" DefaultMode="Insert" GridLines="Horizontal"
                            Height="50px" OnItemInserted="DetailsView1_ItemInserted" Width="100%">
                            <AlternatingRowStyle CssClass="Altern" />
                            <Fields>
                                <asp:TemplateField HeaderText="Nombre del &#193;rea: " SortExpression="NombreArea">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="Input" Text='<%# Bind("NombreArea") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="Input" Text='<%# Bind("NombreArea") %>'
                                            ValidationGroup="InsertArea"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1"
                                            ErrorMessage="Cmapo obligatorio." ForeColor="Tomato" ValidationGroup="InsertArea">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("NombreArea") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <InsertItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Insert"
                                            Text="Insertar" ValidationGroup="InsertArea"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="Cancelar" ValidationGroup="InsertArea"></asp:LinkButton>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="New"
                                            Text="Nuevo"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <InsertItemTemplate>
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="List"
                                            ForeColor="Tomato" ValidationGroup="InsertArea" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                        <br />
                        (Clic fuera de esta ventana para cerrar)</dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:PopupWindow>
        </Windows>
    </dxpc:ASPxPopupControl>
    &nbsp;&nbsp;
</asp:Content>

