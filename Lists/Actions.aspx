<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="Actions.aspx.cs" Inherits="Lists_Actions" Title="Gestor de Tareas" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" namespace="DevExpress.Web.ASPxCallback" tagprefix="dxcb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">    
    <dxcp:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server">
        <LoadingPanelImage AlternateText="Cargando ..." Url="~/Images/cargando.gif" />
        <PanelCollection>
            <dxp:PanelContent runat="server">
                <table width="90%"><tbody><TR><TD vAlign=top align=center rowSpan=1 colspan="2"><H3>Tareas Registradas:</H3>Tipo de tarea: <asp:DropDownList runat="server" AutoPostBack="True" DataTextField="TipoAccion" DataValueField="TipoID" DataSourceID="SqlDataSource_TipoAcciones" CssClass="Input" ID="DropDownList_Tipos" OnDataBound="DropDownList_Tipos_DataBound" OnSelectedIndexChanged="DropDownList_Tipos_SelectedIndexChanged"><asp:ListItem Value="0">- Seleccionar -</asp:ListItem>
</asp:DropDownList>
<asp:SqlDataSource runat="server" 
                        ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
                        SelectCommand="SELECT dbo.TipoAccion.TipoID, dbo.TipoAccion.TipoAccion FROM dbo.TipoAccion " 
                        ID="SqlDataSource_TipoAcciones" 
                        
                        ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>"></asp:SqlDataSource>
                    &nbsp; &nbsp;
    <asp:LinkButton runat="server" CommandName="New" CssClass="Input" ID="LinkButton_Nuevo" OnClick="LinkButton_Nuevo_Click">Nueva</asp:LinkButton>
                    &nbsp;&nbsp;
 <asp:LinkButton runat="server" CssClass="Input" ID="LinkButton_Delete" OnClick="LinkButtonDelete_Click" OnClientClick="return confirm(&quot;Al borrar esta tarea se eliminar&#225;n autom&#225;ticamente las ejecuciones que tiene programadas . \n  &#191;Desea continuar con la operacion?&quot;);">Eliminar</asp:LinkButton>
                    &nbsp;
    <asp:LinkButton ID="LinkButton_Edit" runat="server" CssClass="Input" OnClick="LinkButton_Edit_Click">Modificar</asp:LinkButton>
    <br />
    <br />
    <asp:Label runat="server" ForeColor="Tomato" ID="Label_Error" Visible="False"></asp:Label>
                    <br />
                    <br />
 </TD></TR>
    <tr>
        <td align="center" rowspan="1" style="width: 40%" valign="top">
            <asp:GridView runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AccionID" EmptyDataText="No hay tareas registradas." GridLines="Horizontal" PageSize="25" DataSourceID="SqlDataSourceAcciones" CssClass="Listados" Width="95%" ID="GridView_Acciones" OnDataBound="GridView_Acciones_DataBound">
<AlternatingRowStyle CssClass="Altern"></AlternatingRowStyle>
<Columns>
<asp:CommandField SelectText="Mostrar" ShowSelectButton="True"></asp:CommandField>
<asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
</Columns>
<EmptyDataRowStyle CssClass="Empty"></EmptyDataRowStyle>

<HeaderStyle CssClass="Encabezado"></HeaderStyle>

<SelectedRowStyle BackColor="#C0FFC0" Font-Bold="False"></SelectedRowStyle>
</asp:GridView>
 <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" DeleteCommand="DELETE FROM Acciones WHERE (AccionID = @AccionID)" SelectCommand="stp_MostrarAccionesPorTrabajador" SelectCommandType="StoredProcedure" ID="SqlDataSourceAcciones" ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>"><DeleteParameters>
<asp:ControlParameter ControlID="GridView_Acciones" PropertyName="SelectedValue" Name="AccionID"></asp:ControlParameter>
</DeleteParameters>
<SelectParameters>
<asp:ControlParameter ControlID="DropDownList_Tipos" PropertyName="SelectedValue" Name="TipoAccionID" Type="Int16"></asp:ControlParameter>
<asp:SessionParameter SessionField="NID" Name="NID" Type="String"></asp:SessionParameter>
</SelectParameters>
</asp:SqlDataSource>
        </td>
        <td align="center" style="width: 56%" valign="top">
            <asp:MultiView ID="MultiView_Forms" runat="server">
                <asp:View ID="View_General" runat="server">
                    <asp:FormView ID="FormView_General" runat="server" DataKeyNames="AccionID"
         DataSourceID="SqlDataSource_EditAcciones" EmptyDataText="No hay tareas seleccionadas."
         OnItemInserted="FormView_Acciones_ItemInserted" 
         OnItemUpdated="FormView_Acciones_ItemUpdated" 
         Width="90%" OnDataBound="FormView_General_DataBound">
                        <EditItemTemplate>
                            <table style="width: 100%" class="LoginForm">
                 <tr>
                     <td align="left" class="Encabezado" colspan="2">
                         &nbsp; Datos Generales</td>
                 </tr>
                 <tr>
                     <td align="right" style="width: 25%">
                         Nombre:</td>
                     <td align="left" style="width: 75%">
                         <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Text='<%# Bind("Nombre", "{0}") %>'
                             ValidationGroup="1"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                             Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato" ValidationGroup="1">*</asp:RequiredFieldValidator></td>
                 </tr>
                 <tr>
                     <td align="right" style="width: 25%">
                         Descripcion:</td>
                     <td style="width: 75%">
                         <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="Input" Text='<%# Bind("Descripcion", "{0}") %>'
                             TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                     </td>
                 </tr>
                 <tr>
                     <td align="right" style="width: 25%">
                         Es pública:</td>
                     <td style="width: 75%" align="left">
                         <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                 </tr>
                 <tr>
                     <td align="right" style="width: 25%">
                         Tipo:&nbsp;</td>
                     <td align="left" style="width: 75%">
                         <asp:DropDownList ID="DropDownList_TipoAcciones" runat="server" AutoPostBack="True"
                             DataSourceID="SqlDataSource_TipoAccionesEdit" DataTextField="TipoAccion" DataValueField="TipoID"
                             SelectedValue='<%# Bind("TipoID", "{0}") %>'
                             ValidationGroup="1" CssClass="Input">
                         </asp:DropDownList>&nbsp;
                         <asp:SqlDataSource ID="SqlDataSource_TipoAccionesEdit" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                             SelectCommand="SELECT [TipoID], [TipoAccion] FROM [TipoAccion] ORDER BY [TipoAccion]">
                         </asp:SqlDataSource>
                     </td>
                 </tr>
                 <tr>
                     <td colspan="2">
                         <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                             ForeColor="Tomato" ValidationGroup="1" />
                         &nbsp;</td>
                 </tr><tr>
                     <td align="center" colspan="2">
                         <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update"
                             Text="Actualizar"></asp:LinkButton>
                         &nbsp;&nbsp;
                         <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                             Text="Cancelar">
                                    </asp:LinkButton></td>
                 </tr>
                            </table>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <center>
                                &nbsp;</center>
                            <table style="width: 100%" class="LoginForm">
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
                                            Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato" ValidationGroup="1">*</asp:RequiredFieldValidator></td>
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
                                    <td colspan="2" style="width: 75%" align="left">
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
                                        <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert"
                                            Text="Insertar" ValidationGroup="1"></asp:LinkButton>
                                        &nbsp; &nbsp;&nbsp;
                                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="Cancelar">
                                    </asp:LinkButton></td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table style="width: 100%" runat="server" id="table_General" class="LoginForm">
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
                                            TextMode="MultiLine" Width="95%" CssClass="Input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%;">
                                        Es pública:</td>
                                    <td colspan="2" style="width: 75%" align="left">
                                        &nbsp;&nbsp;
                                        <asp:CheckBox ID="EsPublicaCheckBox" runat="server" Checked='<%# Bind("EsPublica") %>' Enabled="false" /></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                </asp:View>
                <asp:View ID="View_Prevencion" runat="server">
                    <asp:FormView ID="FormView_Prevencion" runat="server" DataKeyNames="AccionID" DataSourceID="SqlDataSource_AccPrevent"
                        EmptyDataText="No hay tareas seleccionadas." OnItemInserted="FormView_Acciones_ItemInserted"
                        OnItemUpdated="FormView_Acciones_ItemUpdated" Width="90%" OnDataBound="FormView_Prevencion_DataBound">
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
                                        <asp:TextBox ID="TextBoxPuntoVulnerable" runat="server" CssClass="Input" Rows="3"
                                            Text='<%# Bind("PuntoVulnerable", "{0}") %>' TextMode="MultiLine" ValidationGroup="AccPrevent"
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
                                        <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Text='<%# Bind("NombreAccion", "{0}") %>'
                                            ValidationGroup="AccPrevent"></asp:TextBox>
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
                                        <asp:TextBox ID="TextBoxPuntoVulnerable" runat="server" CssClass="Input" Rows="3"
                                            Text='<%# Bind("PuntoVulnerable", "{0}") %>' TextMode="MultiLine" ValidationGroup="AccPrevent"
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
                                        <asp:TextBox ID="TextBox_Cumplimiento" runat="server" CssClass="Input" Rows="3" Text='<%# Bind("Cumplimiento", "{0}") %>'
                                            TextMode="MultiLine" ValidationGroup="AccPrevent" Width="90%"></asp:TextBox>
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
                                    <td align="right" style="width: 25%">
                                        Nombre:</td>
                                    <td align="left" colspan="2" style="width: 75%">
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Nombre", "{0}") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%" valign="top">
                                        Descripcion:</td>
                                    <td colspan="2" style="width: 75%">
                                        <asp:TextBox ID="TextBox1" runat="server" EnableTheming="False" Font-Names="Verdana, Tahoma, san-serif"
                                            Font-Size="Smaller" ReadOnly="True" Rows="4" Text='<%# Bind("Descripcion", "{0}") %>'
                                            TextMode="MultiLine" Width="95%" CssClass="Input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
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
                                            TextMode="MultiLine" Width="95%" CssClass="Input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
                                        Manifestación:</td>
                                    <td align="left" colspan="2" style="width: 75%">
                                        <asp:TextBox ID="TextBox_Manifestacion" runat="server" Font-Names="Verdana, Tahoma, san-serif"
                                            Font-Size="Smaller" ReadOnly="True" Rows="3" Text='<%# Bind("Manifestacion", "{0}") %>'
                                            TextMode="MultiLine" Width="95%" CssClass="Input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
                                        Cumplimiento:</td>
                                    <td align="left" colspan="2" style="width: 75%">
                                        <asp:TextBox ID="TextBox3" runat="server" Font-Names="Verdana,Tahoma,san-serif" Font-Size="Smaller"
                                            ReadOnly="True" Rows="3" Text='<%# Bind("Cumplimiento", "{0}") %>' TextMode="MultiLine"
                                            Width="95%" CssClass="Input"></asp:TextBox></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="SqlDataSource_AccPrevent" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                        DeleteCommand="DELETE FROM Acciones WHERE (AccionID = @AccionID)" FilterExpression="AccionID={0}"
                        InsertCommand="stp_InsertarAccionesPreventivas" InsertCommandType="StoredProcedure" SelectCommand="stp_MostrarDetallesDeAccion"
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
                            <asp:ControlParameter ControlID="DropDownList_Tipos" Name="TipoID" PropertyName="SelectedValue"
                                Type="Int16" />
                            <asp:Parameter Name="EsPublica" Type="Boolean" />
                            <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int16" />
                            <asp:Parameter Name="PuntoVulnerable" Type="String" />
                            <asp:Parameter Name="Manifestacion" Type="String" />
                            <asp:Parameter Name="Cumplimiento" Type="String" />
                            <asp:Parameter Name="ObjetivoFormacionID" Type="Int16" DefaultValue="0" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </asp:View>
                <asp:View ID="View_Formacion" runat="server">
                    <asp:FormView ID="FormView_Formacion" runat="server" DataKeyNames="AccionID"
         DataSourceID="SqlDataSource_EditAcciones" EmptyDataText="No hay tareas seleccionadas."
         OnItemInserted="FormView_Acciones_ItemInserted" 
         OnItemUpdated="FormView_Acciones_ItemUpdated"
         Width="90%" OnDataBound="FormView_Formacion_DataBound">
                        <EditItemTemplate>
                            <table style="width: 100%" class="LoginForm">
                                <tr>
                                    <td align="left" class="Encabezado" colspan="2">
                                        &nbsp; Datos Generales</td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
                                        Nombre:</td>
                                    <td align="left" style="width: 75%">
                                        <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Text='<%# Bind("Nombre", "{0}") %>'
                                            ValidationGroup="1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                                            Display="Dynamic" ErrorMessage="El nombre es obligatorio." ForeColor="Tomato" ValidationGroup="1">*</asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
                                        Descripcion:</td>
                                    <td style="width: 75%">
                                        <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="Input" Text='<%# Bind("Descripcion", "{0}") %>'
                                            TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
                                        Es pública:</td>
                                    <td style="width: 75%" align="left">
                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
                                        Tipo:&nbsp;</td>
                                    <td align="left" style="width: 75%">
                                        <asp:DropDownList ID="DropDownList_TipoAcciones" runat="server" AutoPostBack="True"
                             DataSourceID="SqlDataSource_TipoAccionesEdit" DataTextField="TipoAccion" DataValueField="TipoID"
                             SelectedValue='<%# Bind("TipoID", "{0}") %>'
                             ValidationGroup="1" CssClass="Input">
                                        </asp:DropDownList>&nbsp;
                                        <asp:SqlDataSource ID="SqlDataSource_TipoAccionesEdit" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                             SelectCommand="SELECT [TipoID], [TipoAccion] FROM [TipoAccion] ORDER BY [TipoAccion]">
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
                                        Objetivos:</td>
                                    <td align="right" style="width: 75%">
                                        <asp:LinkButton ID="LinkButton_Objetivos" runat="server" 
                                            onload="HyperLink_Objetivos_Load" OnClientClick="PopupObjetivos.ShowWindow(PopupObjetivos.GetWindow(0));" 
                                            CausesValidation="False">Modificar objetivos</asp:LinkButton>
                                    </td>
                                </tr>
                 <tr>
                     <td align="right" colspan="2">
                         <asp:DropDownList ID="DropDownList_Objetivos" runat="server" 
                             AppendDataBoundItems="True" CssClass="Input" 
                             DataSourceID="SqlDataSource_Objetivos" DataTextField="Objetivo" 
                             DataValueField="ObjetivoID" EnableTheming="True" 
                             SelectedValue='<%# Bind("ObjetivoFormacionID", "{0}") %>'>
                             <asp:ListItem Value="0">- No tiene -</asp:ListItem>
                         </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="DropDownList_Objetivos"
                             ErrorMessage="RequiredFieldValidator" ForeColor="Tomato" InitialValue="0" ValidationGroup="3">*</asp:RequiredFieldValidator>&nbsp;
                         <asp:SqlDataSource
                                 ID="SqlDataSource_Objetivos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                 SelectCommand="SELECT ObjetivoID, Objetivo, AreaID FROM ObjetivosFormacion WHERE (AreaID = @AreaID)">
                                 <SelectParameters>
                                     <asp:SessionParameter Name="AreaID" SessionField="AreaID" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                     </td>
                 </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                             ForeColor="Tomato" ValidationGroup="1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update"
                                            Text="Actualizar"></asp:LinkButton>
                                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="Cancelar">
                                    </asp:LinkButton></td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <center>
                                &nbsp;</center>
                            <table style="width: 100%" class="LoginForm">
                                <tr>
                                    <td align="left" class="Encabezado" colspan="2">
                                        &nbsp; Detalles de la Acción de Formación:</td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%">
                                        Nombre:</td>
                                    <td align="left" style="width: 75%">
                                        <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Text='<%# Bind("NombreAccion", "{0}") %>'
                                            ValidationGroup="3"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                                            Display="Dynamic" ErrorMessage="El nombre es obligatorio." 
                                            ForeColor="Tomato" ValidationGroup="3">*</asp:RequiredFieldValidator></td>
                                </tr>
                                <tr style="color: #000000">
                                    <td align="right" style="width: 25%">
                                        Descripcion:</td>
                                    <td style="width: 75%">
                                        <asp:TextBox ID="TextBoxDescripcion" runat="server" CssClass="Input" Text='<%# Bind("Descripcion", "{0}") %>'
                                            TextMode="MultiLine" ValidationGroup="1" Width="95%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="color: #000000">
                                    <td align="right" style="width: 25%">
                                        Es pública:</td>
                                    <td style="width: 75%" align="left">
                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("EsPublica") %>' /></td>
                                </tr>
                 <tr style="color: #000000">
                     <td align="right" style="width: 25%">
                         Objetivo:</td>
                     <td align="right" style="width: 75%">
                         <asp:LinkButton ID="LinkButton_Objetivos" runat="server" 
                             onload="HyperLink_Objetivos_Load" OnClientClick="PopupObjetivos.ShowWindow(PopupObjetivos.GetWindow(0));">Modificar objetivos</asp:LinkButton>
                     </td>
                 </tr>
                 <tr>
                     <td align="left" colspan="2">
                         &nbsp;&nbsp;
                         <asp:DropDownList ID="DropDownList_Objetivos" runat="server" 
                             AppendDataBoundItems="True" CssClass="Input" 
                             DataSourceID="SqlDataSource_Objetivos" DataTextField="Objetivo" 
                             DataValueField="ObjetivoID" EnableTheming="True" 
                             SelectedValue='<%# Bind("ObjetivoFormacionID", "{0}") %>' ValidationGroup="3">
                             <asp:ListItem Value="0">- No tiene -</asp:ListItem>
                         </asp:DropDownList>
                         &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                             ControlToValidate="DropDownList_Objetivos" Display="Dynamic" 
                             ErrorMessage="RequiredFieldValidator" ForeColor="Tomato" InitialValue="0" 
                             ValidationGroup="3">*</asp:RequiredFieldValidator>
                         &nbsp;&nbsp;<asp:SqlDataSource ID="SqlDataSource_Objetivos" runat="server" 
                             ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
                             SelectCommand="SELECT ObjetivoID, Objetivo, AreaID FROM ObjetivosFormacion WHERE (AreaID = @AreaID)">
                             <SelectParameters>
                                 <asp:SessionParameter Name="AreaID" SessionField="AreaID" />
                             </SelectParameters>
                         </asp:SqlDataSource>
                     </td>
                 </tr>
                 <tr>
                     <td align="center" colspan="2">
                         <asp:ValidationSummary ID="ValidationSummary3" runat="server" 
                             DisplayMode="List" ForeColor="Tomato" ValidationGroup="1" />
                         &nbsp;</td>
                 </tr>
                 <tr>
                     <td align="center" colspan="2">
                         <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" 
                             Text="Insertar" ValidationGroup="3"></asp:LinkButton>
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                         <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                             CommandName="Cancel" Text="Cancelar" ValidationGroup="3"></asp:LinkButton>
                     </td>
                 </tr>
                            </table>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table style="width: 100%" runat="server" id="table_General" class="LoginForm">
                                <tr>
                                    <td align="left" class="Encabezado" colspan="2">
                                        &nbsp; Datos de la Acción:</td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%;">
                                        Nombre:</td>
                                    <td align="left" style="width: 75%">
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Nombre", "{0}") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%;" valign="top">
                                        Descripcion:</td>
                                    <td style="width: 75%">
                                        <asp:TextBox ID="TextBox1" runat="server" EnableTheming="False" Font-Names="Verdana, Tahoma, san-serif"
                                            Font-Size="Smaller" ReadOnly="True" Rows="4" Text='<%# Bind("Descripcion", "{0}") %>'
                                            TextMode="MultiLine" Width="95%" CssClass="Input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 25%;">
                                        Es pública:</td>
                                    <td style="width: 75%" align="left">
                                        &nbsp;&nbsp;
                                        <asp:CheckBox ID="EsPublicaCheckBox" runat="server" Checked='<%# Bind("EsPublica") %>' Enabled="false" /></td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Objetivo:</td>
                                    <td align="left" style="width: 75%">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2" style="height: 52px">
                                        &nbsp;<asp:DropDownList ID="DropDownList_Objetivos" runat="server" 
                                            AppendDataBoundItems="True" CssClass="Input" 
                                            DataSourceID="SqlDataSource_Objetivos" DataTextField="Objetivo" 
                                            DataValueField="ObjetivoID" Enabled="False" EnableTheming="True" 
                                            SelectedValue='<%# Bind("ObjetivoFormacionID", "{0}") %>'>
                                            <asp:ListItem Value="0">- No tiene -</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;
                                        <asp:SqlDataSource ID="SqlDataSource_Objetivos" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
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
                            <asp:Parameter Name="NombreAccion" Type="String" DefaultValue="" />
                            <asp:Parameter Name="Descripcion" Type="String" ConvertEmptyStringToNull="False" DefaultValue="" />
                            <asp:ControlParameter ControlID="DropDownList_Tipos" Name="TipoID" PropertyName="SelectedValue"
                                Type="Int16" />
                            <asp:Parameter Name="EsPublica" Type="Boolean" ConvertEmptyStringToNull="False" />
                            <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int16" /><asp:Parameter Name="ObjetivoFormacionID" Type="Int16" />
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
            </asp:MultiView>
        </td>
    </tr>
</tbody></table>
                <dxpc:ASPxPopupControl ID="ASPxPopupControl_Objetivos" runat="server" 
                    AllowDragging="True" CssClass="Listados" DragElement="Window" 
                    HeaderText="" PopupHorizontalAlign="WindowCenter" Width="600px" 
                    ClientInstanceName="PopupObjetivos" AllowResize="True" Height="500px" 
                    ShowFooter="True" ShowSizeGrip="True" FooterText="" 
                    PopupVerticalOffset="20" EnableClientSideAPI="True">
                    <ContentCollection>
                        <dxpc:PopupControlContentControl runat="server">
                        </dxpc:PopupControlContentControl>
                    </ContentCollection>
                    <ClientSideEvents CloseUp="function(s, e) {
window.navigate(window.document.URL);
}" Shown="function(s, e) {	
}" />
                    <Windows>
                        <dxpc:PopupWindow ContentUrl="~/Lists/ObjetivFormac.aspx" 
                            FooterText="Puede cambiar el tamaño de esta ventana según su necesidad." 
                            Modal="True">
                            <ContentCollection>
                                <dxpc:PopupControlContentControl runat="server">
                                </dxpc:PopupControlContentControl>
                            </ContentCollection>
                        </dxpc:PopupWindow>
                    </Windows>
                    <HeaderStyle Font-Bold="True" ForeColor="#FFFFE1" />
                </dxpc:ASPxPopupControl>
            </dxp:PanelContent>
        </PanelCollection>
    </dxcp:ASPxCallbackPanel>
    
</asp:Content>

