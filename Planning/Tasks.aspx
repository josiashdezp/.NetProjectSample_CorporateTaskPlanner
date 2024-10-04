<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Tasks.aspx.cs" Inherits="Planning_Tasks" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Registro de tareas a programar.</title>
    <link href="../Styles/WebPlanner_Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="Content">
        <table width="100%">
            <tbody>
                <tr>
                    <td align="center" colspan="2" rowspan="1" valign="top">
                        <h3>
                            Registro de tareas a programar:</h3>
                            <br />
                        Tipo de tarea:
                        <asp:DropDownList ID="DropDownList_Tipos" runat="server" AutoPostBack="True" CssClass="Input"
                            DataSourceID="SqlDataSource_TipoAcciones" DataTextField="TipoAccion" DataValueField="TipoID" OnSelectedIndexChanged="DropDownList_Tipos_SelectedIndexChanged" AppendDataBoundItems="True" OnDataBound="DropDownList_Tipos_DataBound">
                            <asp:ListItem Value="0">- Seleccionar -</asp:ListItem>
                        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_TipoAcciones" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>"
                            SelectCommand="SELECT [TipoID], [TipoAccion] FROM [TipoAccion] ORDER BY [TipoAccion]">
                        </asp:SqlDataSource>
                        &nbsp; &nbsp;
                        <asp:LinkButton ID="LinkButton_Nuevo" runat="server" CommandName="New" CssClass="Input"
                            OnClick="LinkButton_Nuevo_Click">Nueva</asp:LinkButton>
                        &nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton_Delete" runat="server" CssClass="Input" OnClick="LinkButtonDelete_Click"
                            OnClientClick='return confirm("Al borrar esta tarea se eliminarán automáticamente las ejecuciones que tiene programadas . \n  ¿Desea continuar con la operacion?");'>Eliminar</asp:LinkButton>
                        &nbsp;
                        <asp:LinkButton ID="LinkButton_Edit" runat="server" CssClass="Input" OnClick="LinkButton_Edit_Click">Modificar</asp:LinkButton>
                        <br />
                        <br />
                        <asp:Label ID="Label_Error" runat="server" ForeColor="Tomato" Visible="False"></asp:Label><br />
                    </td>
                </tr>
                <tr>
                    <td align="center" rowspan="1" style="width: 40%" valign="top">
                        <asp:GridView ID="GridView_Acciones" runat="server" AllowPaging="True" AllowSorting="True"
                            AutoGenerateColumns="False" CssClass="Listados" DataKeyNames="AccionID" DataSourceID="SqlDataSourceAcciones"
                            EmptyDataText="No hay tareas registradas." GridLines="Horizontal" OnDataBound="GridView_Acciones_DataBound"
                            OnSelectedIndexChanged="GridView_Acciones_SelectedIndexChanged" PageSize="25"
                            Width="97%">
                            <AlternatingRowStyle CssClass="Altern" />
                            <Columns>
                                <asp:CommandField SelectText="Mostrar" ShowSelectButton="True" />
                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                            </Columns>
                            <EmptyDataRowStyle CssClass="Empty" />
                            <HeaderStyle CssClass="Encabezado" />
                            <SelectedRowStyle BackColor="#C0FFC0" Font-Bold="False" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceAcciones" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                            DeleteCommand="DELETE FROM Acciones WHERE (AccionID = @AccionID)" ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>"
                            SelectCommand="stp_MostrarAccionesPorTrabajador" SelectCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="GridView_Acciones" Name="AccionID" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList_Tipos" Name="TipoAccionID" PropertyName="SelectedValue"
                                    Type="Int16" />
                                <asp:SessionParameter Name="NID" SessionField="NID" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td align="center" style="width: 55%" valign="top">
                        <asp:MultiView ID="MultiView_Forms" runat="server">
                            <asp:View ID="View_General" runat="server">
                                <asp:FormView ID="FormView_General" runat="server" DataKeyNames="AccionID" DataSourceID="SqlDataSource_EditAcciones"
                                    EmptyDataText="No hay tareas seleccionadas." OnItemInserted="FormView_Acciones_ItemInserted"
                                    OnItemUpdated="FormView_Acciones_ItemUpdated" Width="95%">
                                    <EditItemTemplate>
                                        <table class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3">
                                                    &nbsp; Datos Generales</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Text='<%# Bind("Nombre", "{0}") %>'
                                                        ValidationGroup="1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                                                        Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato"
                                                        ValidationGroup="1">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="Input" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Cambiar al tipo:&nbsp;</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:DropDownList ID="DropDownList_TipoAcciones" runat="server" AutoPostBack="True"
                                                        DataSourceID="SqlDataSource_TipoAccionesEdit" DataTextField="TipoAccion" DataValueField="TipoID"
                                                        SelectedValue='<%# Bind("TipoID", "{0}") %>' ValidationGroup="1">
                                                    </asp:DropDownList>&nbsp;
                                                    <asp:SqlDataSource ID="SqlDataSource_TipoAccionesEdit" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                                        SelectCommand="SELECT [TipoID], [TipoAccion] FROM [TipoAccion] ORDER BY [TipoAccion]">
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                                                        ForeColor="Tomato" ValidationGroup="1" />
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar"></asp:LinkButton>
                                                    &nbsp;&nbsp;
                                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                        Text="Cancelar">
                                    </asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <table class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3" style="height: 16px">
                                                    &nbsp; Datos Generales</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Text='<%# Bind("NombreAccion", "{0}") %>'
                                                        ValidationGroup="1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                                                        Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato"
                                                        ValidationGroup="1">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="right" style="width: 25%">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="Input" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="right" style="width: 25%">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="List"
                                                        ForeColor="Tomato" ValidationGroup="1" />
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <br />
                                                    <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar"
                                                        ValidationGroup="1"></asp:LinkButton>
                                                    &nbsp; &nbsp;&nbsp;
                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                        Text="Cancelar">
                                    </asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <table id="table_General" runat="server" class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3">
                                                    &nbsp; Datos Generales</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Nombre", "{0}") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;" valign="top">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox1" runat="server" EnableTheming="False" Font-Names="Verdana, Tahoma, san-serif"
                                                        Font-Size="Smaller" ReadOnly="True" Rows="4" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    &nbsp;&nbsp;
                                                    <asp:CheckBox ID="EsPublicaCheckBox" runat="server" Checked='<%# Bind("EsPublica") %>'
                                                        Enabled="false" /></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:FormView>
                            </asp:View>
                            <asp:View ID="View_Prevencion" runat="server">
                                <asp:FormView ID="FormView_Prevencion" runat="server" DataKeyNames="AccionID" DataSourceID="SqlDataSource_AccPrevent"
                                    EmptyDataText="No hay tareas seleccionadas." OnItemInserted="FormView_Acciones_ItemInserted"
                                    OnItemUpdated="FormView_Acciones_ItemUpdated" Width="95%">
                                    <EditItemTemplate>
                                        <table class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3">
                                                    &nbsp; Datos de la Acción Preventiva:</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Text='<%# Bind("Nombre", "{0}") %>'
                                                        ValidationGroup="AccPrevent"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                                                        Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato"
                                                        ValidationGroup="AccPrevent">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="Input" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Punto vulnerable:</td>
                                                <td align="left" colspan="2" style="width: 65%">
                                                    <asp:TextBox ID="TextBoxPuntoVulnerable" runat="server" CssClass="Input"
                                                        Rows="3" Text='<%# Bind("PuntoVulnerable", "{0}") %>' TextMode="MultiLine" ValidationGroup="AccPrevent"
                                                        Width="90%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBoxPuntoVulnerable"
                                                        Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Tomato" ValidationGroup="AccPrevent">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Manifestación:
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:TextBox ID="TextBox_Manifestacion" runat="server" CssClass="Input" Rows="3"
                                                        Text='<%# Bind("Manifestacion", "{0}") %>' TextMode="MultiLine" ValidationGroup="AccPrevent"
                                                        Width="90%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox_Manifestacion"
                                                        Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Tomato" ValidationGroup="AccPrevent">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%; height: 13px">
                                                    Cumplimiento:
                                                </td>
                                                <td align="left" colspan="2" style="height: 13px">
                                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="Input" Rows="3" Text='<%# Bind("Cumplimiento", "{0}") %>'
                                                        TextMode="MultiLine" ValidationGroup="AccPrevent" Width="90%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox_Manifestacion"
                                                        Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Tomato" ValidationGroup="AccPrevent">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    &nbsp;<asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="List"
                                                        ForeColor="Tomato" ValidationGroup="AccPrevent" />
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar"
                                                        ValidationGroup="AccPrevent"></asp:LinkButton>
                                                    &nbsp;&nbsp; &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                                                        CommandName="Cancel" Text="Cancelar" ValidationGroup="AccPrevent"></asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <table class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3">
                                                    &nbsp; Datos de la Acción Preventiva:</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input"
                                                        ValidationGroup="AccPrevent" Text='<%# Bind("NombreAccion", "{0}") %>'></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                                                        Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato"
                                                        ValidationGroup="AccPrevent">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="right" style="width: 25%">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="Input" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="right" style="width: 25%">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Punto vulnerable:</td>
                                                <td align="left" colspan="2" style="width: 65%">
                                                    <asp:TextBox ID="TextBoxPuntoVulnerable" runat="server" CssClass="Input"
                                                        Rows="3" Text='<%# Bind("PuntoVulnerable", "{0}") %>' TextMode="MultiLine" ValidationGroup="AccPrevent"
                                                        Width="90%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBoxPuntoVulnerable"
                                                        Display="Dynamic" ErrorMessage="Campo obligatorio." ForeColor="Tomato" ValidationGroup="AccPrevent">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Manifestación:
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:TextBox ID="TextBox_Manifestacion" runat="server" CssClass="Input" Rows="3"
                                                        Text='<%# Bind("Manifestacion", "{0}") %>' TextMode="MultiLine" ValidationGroup="AccPrevent"
                                                        Width="90%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox_Manifestacion"
                                                        Display="Dynamic" ErrorMessage="Campo obligatorio." ForeColor="Tomato" ValidationGroup="AccPrevent">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Cumplimiento:
                                                </td>
                                                <td align="left" colspan="2">
                                                    <asp:TextBox ID="TextBox_Cumplimiento" runat="server" CssClass="Input" Rows="3"
                                                        Text='<%# Bind("Cumplimiento", "{0}") %>' TextMode="MultiLine" ValidationGroup="AccPrevent"
                                                        Width="90%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_Cumplimiento"
                                                        Display="Dynamic" ErrorMessage="Campo obligatorio." ForeColor="Tomato" ValidationGroup="AccPrevent">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="List"
                                                        ForeColor="Tomato" ValidationGroup="1" />
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar"
                                                        ValidationGroup="AccPrevent"></asp:LinkButton>
                                                    &nbsp; &nbsp;&nbsp;
                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                        Text="Cancelar" ValidationGroup="AccPrevent"></asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <table id="table_General" runat="server" class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3">
                                                    &nbsp; Datos Generales</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Nombre", "{0}") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;" valign="top">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox1" runat="server" EnableTheming="False" Font-Names="Verdana, Tahoma, san-serif"
                                                        Font-Size="Smaller" ReadOnly="True" Rows="4" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    &nbsp;&nbsp;
                                                    <asp:CheckBox ID="EsPublicaCheckBox" runat="server" Checked='<%# Bind("EsPublica") %>'
                                                        Enabled="false" /></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Punto vulnerable:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBoxPuntoVulnerable" runat="server" Font-Names="Verdana, Tahoma, san-serif"
                                                        Font-Size="Smaller" ReadOnly="True" Rows="3" Text='<%# Bind("PuntoVulnerable", "{0}") %>'
                                                        TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Manifestación:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox_Manifestacion" runat="server" Font-Names="Verdana, Tahoma, san-serif"
                                                        Font-Size="Smaller" ReadOnly="True" Rows="3" Text='<%# Bind("Manifestacion", "{0}") %>'
                                                        TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Cumplimiento:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox3" runat="server" Font-Names="Verdana,Tahoma,san-serif" Font-Size="Smaller"
                                                        ReadOnly="True" Rows="3" Text='<%# Bind("Cumplimiento", "{0}") %>' TextMode="MultiLine"
                                                        Width="95%"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:FormView>
                                <asp:SqlDataSource ID="SqlDataSource_AccPrevent" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                    DeleteCommand="DELETE FROM Acciones WHERE (AccionID = @AccionID)" FilterExpression="AccionID={0}"
                                    InsertCommand="stp_InsertarAccionesPreventivas" InsertCommandType="StoredProcedure"
                                    SelectCommand="stp_MostrarDetallesDeAccion" SelectCommandType="StoredProcedure"
                                    UpdateCommand="stp_ActualizarAcciones" UpdateCommandType="StoredProcedure" OnUpdating="SqlDataSource_AccPrevent_Updating">
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="GridView_Acciones" Name="AccionID" PropertyName="SelectedValue" />
                                    </DeleteParameters>
                                    <FilterParameters>
                                        <asp:ControlParameter ControlID="GridView_Acciones" DefaultValue="0" Name="AccionID"
                                            PropertyName="SelectedValue" Type="Int16" />
                                    </FilterParameters>
                                    <InsertParameters>
                                        <asp:SessionParameter Name="NID" SessionField="NID" Type="String" />
                                        <asp:Parameter Name="NombreAccion" Type="String" />
                                        <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="" Name="Descripcion"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_Tipos" Name="TipoID" PropertyName="SelectedValue"
                                            Type="Int16" />
                                        <asp:Parameter ConvertEmptyStringToNull="False" Name="EsPublica" Type="Boolean" />
                                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int16" />
                                        <asp:Parameter Name="PuntoVulnerable" Type="String" />
                                        <asp:Parameter Name="Manifestacion" Type="String" />
                                        <asp:Parameter Name="Cumplimiento" Type="String" />
                                        <asp:Parameter DefaultValue="0" Name="ObjetivoFormacionID" Type="Int16" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Tipos" Name="TipoAccionID" PropertyName="SelectedValue"
                                            Type="Int16" />
                                        <asp:ControlParameter ControlID="GridView_Acciones" Name="AccionID" PropertyName="SelectedValue"
                                            Type="Int32" />
                                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int16" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="GridView_Acciones" Name="AccionID" PropertyName="SelectedValue"
                                            Type="Int16" />
                                        <asp:Parameter Name="Nombre" Type="String" />
                                        <asp:Parameter Name="Descripcion" Type="String" />
                                        <asp:Parameter Name="TipoID" Type="Int16" />
                                        <asp:Parameter Name="EsPublica" Type="Boolean" />
                                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int16" />
                                        <asp:Parameter Name="PuntoVulnerable" Type="String" />
                                        <asp:Parameter Name="Manifestacion" Type="String" />
                                        <asp:Parameter Name="Cumplimiento" Type="String" />
                                        <asp:Parameter Name="ObjetivoFormacionID" Type="Int16" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                            <asp:View ID="View_Formacion" runat="server">
                                <asp:FormView ID="FormView_Formacion" runat="server" DataKeyNames="AccionID" DataSourceID="SqlDataSource_EditAcciones"
                                    EmptyDataText="No hay tareas seleccionadas." OnItemInserted="FormView_Acciones_ItemInserted"
                                    OnItemUpdated="FormView_Acciones_ItemUpdated" Width="90%">
                                    <EditItemTemplate>
                                        <table class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3">
                                                    &nbsp; Datos Generales</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="ReadOnlyInput" Text='<%# Bind("Nombre", "{0}") %>'
                                                        ValidationGroup="1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                                                        Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato"
                                                        ValidationGroup="1">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="ReadOnlyInput" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Tipo:&nbsp;</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:DropDownList ID="DropDownList_TipoAcciones" runat="server" AutoPostBack="True"
                                                        DataSourceID="SqlDataSource_TipoAccionesEdit" DataTextField="TipoAccion" DataValueField="TipoID"
                                                        SelectedValue='<%# Bind("TipoID", "{0}") %>' ValidationGroup="1">
                                                    </asp:DropDownList>&nbsp;
                                                    <asp:SqlDataSource ID="SqlDataSource_TipoAccionesEdit" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                                        SelectCommand="SELECT [TipoID], [TipoAccion] FROM [TipoAccion] ORDER BY [TipoAccion]">
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="3">
                                                    &nbsp;&nbsp; Objetivo de formación:</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="3">
                                                    <asp:DropDownList ID="DropDownList_Objetivos" runat="server" AppendDataBoundItems="True"
                                                        CssClass="ReadOnlyInput" DataSourceID="SqlDataSource_Objetivos" DataTextField="Objetivo"
                                                        DataValueField="ObjetivoID" EnableTheming="True" SelectedValue='<%# Bind("ObjetivoFormacionID", "{0}") %>'>
                                                        <asp:ListItem Value="0">- No tiene -</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="DropDownList_Objetivos"
                                                        ErrorMessage="RequiredFieldValidator" ForeColor="Tomato" InitialValue="0" ValidationGroup="3">*</asp:RequiredFieldValidator>&nbsp;<asp:SqlDataSource
                                                            ID="SqlDataSource_Objetivos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                                            SelectCommand="SELECT ObjetivoID, Objetivo, AreaID FROM ObjetivosFormacion WHERE (AreaID = @AreaID)">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="AreaID" SessionField="AreaID" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                                                        ForeColor="Tomato" ValidationGroup="1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar"></asp:LinkButton>
                                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                        Text="Cancelar">
                                    </asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <center>
                                            &nbsp;</center>
                                        <table class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3">
                                                    &nbsp; Detalles de la Acción de Formación:</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="ReadOnlyInput" Text='<%# Bind("NombreAccion", "{0}") %>'
                                                        ValidationGroup="1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                                                        Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato"
                                                        ValidationGroup="1">*</asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="right" style="width: 25%">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="ReadOnlyInput" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td align="right" style="width: 25%">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="3">
                                                    &nbsp;&nbsp; Objetivo de formación:&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="3">
                                                    &nbsp;&nbsp;
                                                    <asp:DropDownList ID="DropDownList_Objetivos" runat="server" AppendDataBoundItems="True"
                                                        CssClass="ReadOnlyInput" DataSourceID="SqlDataSource_Objetivos" DataTextField="Objetivo"
                                                        DataValueField="ObjetivoID" EnableTheming="True" SelectedValue='<%# Bind("ObjetivoFormacionID", "{0}") %>'
                                                        ValidationGroup="3">
                                                        <asp:ListItem Value="0">- No tiene -</asp:ListItem>
                                                    </asp:DropDownList>
                                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="DropDownList_Objetivos"
                                                        Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Tomato" InitialValue="0"
                                                        ValidationGroup="3">*</asp:RequiredFieldValidator>&nbsp;<asp:SqlDataSource ID="SqlDataSource_Objetivos"
                                                            runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                                            SelectCommand="SELECT ObjetivoID, Objetivo, AreaID FROM ObjetivosFormacion WHERE (AreaID = @AreaID)">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="AreaID" SessionField="AreaID" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="List"
                                                        ForeColor="Tomato" ValidationGroup="1" />
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <br />
                                                    <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar"
                                                        ValidationGroup="1"></asp:LinkButton>
                                                    &nbsp; &nbsp;&nbsp;
                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                        Text="Cancelar">
                                    </asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <table id="table_General" runat="server" class="LoginForm" style="width: 100%">
                                            <tr>
                                                <td align="left" class="Encabezado" colspan="3">
                                                    &nbsp; Datos de la Acción:</td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;">
                                                    Nombre:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Nombre", "{0}") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;" valign="top">
                                                    Descripcion:</td>
                                                <td colspan="2" style="width: 75%">
                                                    <asp:TextBox ID="TextBox1" runat="server" EnableTheming="False" Font-Names="Verdana, Tahoma, san-serif"
                                                        Font-Size="Smaller" ReadOnly="True" Rows="4" Text='<%# Bind("Descripcion", "{0}") %>'
                                                        TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 25%;">
                                                    Es pública:</td>
                                                <td align="left" colspan="2" style="width: 75%">
                                                    &nbsp;&nbsp;
                                                    <asp:CheckBox ID="EsPublicaCheckBox" runat="server" Checked='<%# Bind("EsPublica") %>'
                                                        Enabled="false" /></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="3">
                                                    &nbsp; &nbsp; Objetivo de formación:
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="3" style="height: 52px">
                                                    &nbsp; &nbsp;&nbsp;
                                                    <asp:DropDownList ID="DropDownList_Objetivos" runat="server" AppendDataBoundItems="True"
                                                        DataSourceID="SqlDataSource_Objetivos" DataTextField="Objetivo" DataValueField="ObjetivoID"
                                                        Enabled="False" EnableTheming="True" SelectedValue='<%# Bind("ObjetivoFormacionID", "{0}") %>'>
                                                        <asp:ListItem Value="0">- No tiene -</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="SqlDataSource_Objetivos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                                        SelectCommand="SELECT ObjetivoID, Objetivo, AreaID FROM ObjetivosFormacion WHERE (AreaID = @AreaID)">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="AreaID" SessionField="AreaID" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:FormView>
                                <asp:SqlDataSource ID="SqlDataSource_EditAcciones" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                    DeleteCommand="DELETE FROM Acciones WHERE (AccionID = @AccionID)" FilterExpression="AccionID={0}"
                                    InsertCommand="stp_InsertarAccion" InsertCommandType="StoredProcedure" SelectCommand="stp_MostrarAccionesPorTrabajador"
                                    SelectCommandType="StoredProcedure" UpdateCommand="stp_ActualizarAcciones" UpdateCommandType="StoredProcedure">
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="GridView_Acciones" Name="AccionID" PropertyName="SelectedValue" />
                                    </DeleteParameters>
                                    <FilterParameters>
                                        <asp:ControlParameter ControlID="GridView_Acciones" DefaultValue="0" Name="AccionID"
                                            PropertyName="SelectedValue" Type="Int16" />
                                    </FilterParameters>
                                    <InsertParameters>
                                        <asp:SessionParameter Name="NID" SessionField="NID" Type="String" />
                                        <asp:Parameter DefaultValue="" Name="NombreAccion" Type="String" />
                                        <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="" Name="Descripcion"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_Tipos" Name="TipoID" PropertyName="SelectedValue"
                                            Type="Int16" />
                                        <asp:Parameter ConvertEmptyStringToNull="False" Name="EsPublica" Type="Boolean" />
                                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int16" />
                                        <asp:Parameter Name="ObjetivoFormacionID" Type="Int16" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Tipos" Name="TipoAccionID" PropertyName="SelectedValue"
                                            Type="Int16" />
                                        <asp:SessionParameter Name="NID" SessionField="NID" Type="String" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="GridView_Acciones" Name="AccionID" PropertyName="SelectedValue"
                                            Type="Int16" />
                                        <asp:Parameter Name="Nombre" Type="String" />
                                        <asp:Parameter Name="Descripcion" Type="String" />
                                        <asp:Parameter Name="TipoID" Type="Int16" />
                                        <asp:Parameter Name="EsPublica" Type="Boolean" />
                                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int16" />
                                        <asp:Parameter Name="PuntoVulnerable" Type="String" />
                                        <asp:Parameter Name="Manifestacion" Type="String" />
                                        <asp:Parameter Name="ObjetivoFormacionID" Type="Int16" />
                                        <asp:Parameter Name="Cumplimiento" Type="String" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                        </asp:MultiView>&nbsp;
                    </td>
                </tr>
            </tbody>
        </table>
    
    </div>
    </form>
</body>
</html>
