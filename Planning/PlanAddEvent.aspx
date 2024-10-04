<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="PlanAddEvent.aspx.cs" Inherits="Planning_PlanAddEvent" Title="Planificador Online. Adicionar Tarea al Plan." MaintainScrollPositionOnPostback="true"  %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"   Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"   Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<%@ Register Src="../Controls/DateOrFrecuencySelector.ascx" TagName="DateOrFrecuencySelector"   TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<ext:scriptmanager id="ScriptManager1" runat="server"></ext:scriptmanager>        
<h2>
    &nbsp;&nbsp; Adicionar Tareas al Plan:</h2>
        <br />
        <center>
            <asp:Wizard ID="Wizard_Add" runat="server" CssClass="LoginForm" Width="95%" 
                ActiveStepIndex="1" CancelDestinationPageUrl="~/Planning/PlanMonthView.aspx" 
                DisplayCancelButton="True" OnActiveStepChanged="Wizard_Add_ActiveStepChanged" 
                OnNextButtonClick="Wizard_Add_NextButtonClick" 
                OnCancelButtonClick="Wizard_Add_CancelButtonClick" OnLoad="Wizard_Add_Load" 
                DisplaySideBar="False" BackColor="Transparent" BorderColor="Transparent">
            <FinishCompleteButtonStyle CssClass="Button" />
            <FinishPreviousButtonStyle CssClass="Button" />
            <NavigationButtonStyle CssClass="Button" />
            <WizardSteps>
                <asp:WizardStep ID="WizardStep_Acciones" runat="server" Title="Acciones">
                    <p style="text-align:left; font-weight:bold">&nbsp;&nbsp;&nbsp;Seleccione las Tareas a Programar :</p>                    
                    <br />
                    Tipo de Acción:
                    <asp:DropDownList ID="DropDownList_Tipos" runat="server" AutoPostBack="True" CssClass="Input" DataSourceID="SqlDataSource_Tipos" DataTextField="TipoAccion" DataValueField="TipoID" OnSelectedIndexChanged="DropDownList_Tipos_SelectedIndexChanged" AppendDataBoundItems="true" OnDataBound="DropDownList_Tipos_DataBound">
                        <asp:ListItem Value="0">- Seleccionar -</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CssClass="Input"
                        OnClientClick="popupAcciones.Show();" Text="Adicionar tareas" UseSubmitBehavior="False" />
                    <asp:SqlDataSource ID="SqlDataSource_Tipos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                        SelectCommand="SELECT [TipoID], [TipoAccion] FROM [TipoAccion] ORDER BY [TipoAccion]">
                    </asp:SqlDataSource>
                    <br /><br />
                    <asp:GridView ID="GridView_Acciones" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        CssClass="Listados" DataKeyNames="AccionID" DataSourceID="SqlDataSource_Acciones"
                        GridLines="Horizontal" Width="96%" EmptyDataText="No hay acciones de este tipo." PageSize="15">
                        <HeaderStyle CssClass="Encabezado" />
                        <AlternatingRowStyle CssClass="Altern" />
                        <Columns>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="20%" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox_Select" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="AccionID" HeaderText="AccionID" InsertVisible="False"
                                ReadOnly="True" SortExpression="AccionID" Visible="False" />
                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                                <HeaderStyle Width="30%" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" ReadOnly="True"
                                SortExpression="Descripcion">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle Width="50%" />
                            </asp:BoundField>
                        </Columns>
                        <EmptyDataRowStyle CssClass="Empty" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_Acciones" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                        SelectCommand="stp_MostrarAccionesPorTrabajador" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Tipos" Name="TipoAccionID" PropertyName="SelectedValue"
                                Type="Int16" />
                            <asp:SessionParameter Name="NID" SessionField="NID" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:Label ID="Label_msg_1" runat="server" ForeColor="Tomato" Text="Seleccione las acciones a programar."
                        Visible="False"></asp:Label>
                    &nbsp;<br />
                    &nbsp;</asp:WizardStep>                
                <asp:WizardStep ID="WizardStep_Programar" runat="server" Title="Programar" StepType="Finish">
                    <br />
                    <br />
                    <table style="width: 97%; margin: auto;">
                        <tr>
                            <td align="left" class="Encabezado" style="width: 200px">
                                PASO 1:&nbsp; Tareas</td>
                            <td align="left" class="Encabezado" style="width: 25%">
                                PASO 2:&nbsp; Ejecutantes</td>
                            <td align="left" class="Encabezado" style="width: 25%">
                                PASO 3:&nbsp; Responsable</td>
                        </tr>
                        <tr>
                            <td style="width: 200px" valign="top" align="center" rowspan="3">
                                &nbsp;
                                <asp:ListBox ID="ListBox_Acciones" runat="server" CssClass="Input" Rows="5" SelectionMode="Multiple">
                                </asp:ListBox>
                                &nbsp;<br />
                                &nbsp;
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ListBox_Acciones"
                                    ErrorMessage="Seleccione las acciones" Font-Bold="True" ForeColor="Tomato"></asp:RequiredFieldValidator>
                                </td>
                            <td align="center" style="width: 33%" valign="top" rowspan="3">
                                &nbsp;<asp:ListBox ID="ListBox_Ejecuta" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Subordinados"
                                    DataTextField="NombreCompleto" DataValueField="NID" Rows="5" SelectionMode="Multiple" OnDataBound="ListBox_Ejecuta_DataBound">
                                </asp:ListBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ListBox_Ejecuta"
                                    Display="Dynamic" ErrorMessage="Seleccione los ejecutantes" Font-Bold="True"
                                    ForeColor="Tomato" InitialValue="0"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSource_Subordinados" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                        SelectCommand="stp_MostrarTrabajadoresSubordinados" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="NIDJefe" SessionField="NID" Type="String" />
                            <asp:Parameter DefaultValue="true" Name="IncluirJefe" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                            </td>
                            <td align="center" style="width: 33%" valign="top">
                                <asp:DropDownList ID="DropDownList_ResponsablesSelecc" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Subordinados" DataTextField="NombreCompleto" DataValueField="NID" AppendDataBoundItems="True">
                                    <asp:ListItem Selected="True">No tiene</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="Encabezado" style="width: 33%" valign="top">
                                PASO 4: Otros implicados</td>
                        </tr>
                        <tr>
                            <td align="center" style="width: 33%" valign="top">
                                <asp:TextBox ID="TextBox_OtrosImplicados" runat="server" CssClass="Input" Rows="3" 
                                    TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="Encabezado" colspan="1" style="width: 200px" valign="top">
                                PASO 5:&nbsp; Observaciones</td>
                            <td align="left" class="Encabezado" colspan="2" valign="top">
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="Encabezado" colspan="3" valign="top">
                                <asp:TextBox ID="TextBox_Detalles" runat="server" CssClass="Input" TextMode="MultiLine" Width="80%" Rows="4"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="Encabezado" colspan="3" valign="top">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td align="left" class="Encabezado" valign="top" style="width: 200px">
                                PASO 6:&nbsp; Programación</td>
                            <td align="center" class="Encabezado" valign="top">
                            </td>
                            <td align="center" class="Encabezado" valign="top">
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="3" style="height: 51px" valign="top">
                                <br />
                                <uc1:DateOrFrecuencySelector ID="DateOrFrecuencySelector_Program" runat="server" myCssClass="Input" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="3" valign="top">
                    <TABLE style="WIDTH: 99%"><TBODY><TR><TD align="center" style="width: 25%" valign="middle">
                    <asp:Button ID="Button_AddProgram" runat="server" CssClass="Input" Text="Generar fechas" OnClick="ButtonAddProgram_Click" />

 </TD>
                        <td align="center" style="width: 50%" valign="middle">
                            <asp:Label runat="server" Font-Bold="True" ForeColor="ForestGreen" ID="Label_Msg" Visible="False">Generación terminada.</asp:Label>
                            <asp:Label runat="server" Font-Bold="True" ForeColor="Tomato" ID="Label_Error" Visible="False">Se han generado excepciones al planificar las tareas. Esto puede ocurrir porque algunas se programaron para la misma persona, fecha y hora más de una vez.</asp:Label>
                        </td>
                        <td align="center" style="width: 25%" valign="middle">
                            <asp:Button ID="Button_DeleteAll" runat="server" CssClass="Input" OnClick="Button_DeleteAll_Click"
                                OnClientClick="return confirm( '&#191;Est&#225; seguro que desea borrar toda la programaci&#243;n generada?');"
                                Text="Borrar todos" />
                        </td>
                    </TR><TR>
                        <td align="center" colspan="3" valign="top">
                            <br />
     <asp:GridView runat="server" AutoGenerateColumns="False" DataKeyNames="AccionNombre,AccionID,EjecutaNombre,EjecutaID,FrecuenciaTipo,FechasEjecucion" EmptyDataText="No se han programado tareas hasta el momento" DataMember="EjecucionInsert" CssClass="Listados" Width="100%" ID="GridView_ProgramInsert" OnRowDataBound="GridView_ProgramInsert_RowDataBound" OnRowDeleting="GridView_ProgramInsert_RowDeleting" GridLines="Horizontal">
<AlternatingRowStyle CssClass="Altern"></AlternatingRowStyle>
<Columns>
<asp:BoundField DataField="EjecutaID" ReadOnly="True" Visible="False">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
    <ItemStyle HorizontalAlign="Center" />
</asp:BoundField>
<asp:BoundField DataField="AccionID" ReadOnly="True" Visible="False">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
    <ItemStyle HorizontalAlign="Center" />
</asp:BoundField>
<asp:BoundField DataField="AccionNombre" HeaderText="Acci&#243;n" ReadOnly="True" SortExpression="AccionNombre">
<HeaderStyle HorizontalAlign="Right"></HeaderStyle>
    <ItemStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="EjecutaNombre" HeaderText="Ejecutor" ReadOnly="True" SortExpression="EjecutaNombre">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
    <ItemStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="ResponsableNombre" HeaderText="Responsable" NullDisplayText=" No tiene " SortExpression="ResponsableNombre">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
    <ItemStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="FrecuenciaTipo" HeaderText="Frecuencia" SortExpression="FrecuenciaTipo">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
    <ItemStyle HorizontalAlign="Center" />
</asp:BoundField>
<asp:TemplateField HeaderText="Fecha" SortExpression="FechasEjecucion"><EditItemTemplate>
    &nbsp;<asp:Label ID="Label2" runat="server" Text='<%# Eval("FechasEjecucion", "{0:d}") %>'></asp:Label>
                                            
</EditItemTemplate>
<ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("FechasEjecucion", "{0:d}") %>'></asp:Label>
                                            
</ItemTemplate>
    <HeaderStyle HorizontalAlign="Center" />
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
    <asp:TemplateField HeaderText="Vence">
        <EditItemTemplate>
            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FechaVencimiento") %>'></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="Label1" runat="server" Text='<%# Eval("FechaVencimiento", "{0:d}") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField HeaderText="Hora" SortExpression="FechasEjecucion"><EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                            
</EditItemTemplate>
<ItemTemplate>
                                                <asp:Label ID="Label_Hora" runat="server" Text='<%# Eval("FechasEjecucion","{0:t}") %>'></asp:Label>
                                            
</ItemTemplate>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:TemplateField>
    <asp:BoundField DataField="Dia" HeaderText="D&#237;a" />
<asp:TemplateField InsertVisible="False" ShowHeader="False"><EditItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server"  />
                                            
</EditItemTemplate>
<ItemTemplate>
    &nbsp;<asp:LinkButton ID="LinkButton_Delete" runat="server" CommandName="Delete">Borrar</asp:LinkButton>
                                            
</ItemTemplate>
    <HeaderStyle HorizontalAlign="Center" />
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
</Columns>

<HeaderStyle CssClass="Encabezado" Font-Bold="False"></HeaderStyle>
     <EmptyDataRowStyle CssClass="Encabezado" />
</asp:GridView>
                            &nbsp;</td>
</TR></TBODY></TABLE>
                            </td>
                        </tr>
                    </table>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep_Finalizar" runat="server" Title="Finalizar" StepType="Complete">
                   <br />
                   &nbsp;
                   <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Resumen de la Operación:</h2>
                   <br />
                    <asp:TextBox ID="TextBox_Logs" runat="server" CssClass="Input" Height="190px" TextMode="MultiLine"
                        Width="90%"></asp:TextBox>
                    <br />
                    <br />
                    <asp:LinkButton ID="LinkButton_Reiniciar" runat="server" CausesValidation="False"
                        OnClick="LinkButton_Reiniciar_Click">Programar más tareas</asp:LinkButton>
                    &nbsp; &nbsp;
                    <asp:HyperLink ID="HyperLink_Volver" runat="server">Terminar</asp:HyperLink>
                    <br />
                </asp:WizardStep>
            </WizardSteps>
            <CancelButtonStyle CssClass="Button" />
            <SideBarStyle Width="20%" />
            <HeaderTemplate>
                <table style="width: 75%">
                    <tr>
                        <td align="left" style="vertical-align: middle; line-height: 10px; height: 31px;" valign="middle">
                           <h3><asp:Label ID="Label_Nombre" runat="server" CssClass="" OnLoad="Label_Nombre_Load"></asp:Label></h3></td>
                        <td align="right" style="vertical-align: middle; line-height: 10px; height: 31px;" valign="middle" class="Encabezado">
                Desde:</td>
                        <td align="left" valign="middle" style="vertical-align: middle; line-height: 10px; height: 31px;">
                            &nbsp;
                            <asp:Label ID="Label_Desde" runat="server" OnLoad="Label_Desde_Load" Font-Bold="True"></asp:Label></td>
                        <td align="right" style="vertical-align: middle; line-height: 10px;" valign="middle" class="Encabezado">
                            &nbsp;Hasta:</td>
                        <td align="left" valign="middle" style="vertical-align: middle; line-height: 10px; height: 31px;">
                            &nbsp;
                            <asp:Label ID="Label_Hasta" runat="server" OnLoad="Label_Hasta_Load" Font-Bold="True"></asp:Label></td>
                    </tr>
                </table>
                <hr />
            </HeaderTemplate>
            <HeaderStyle HorizontalAlign="Center" />
            <FinishNavigationTemplate>
                <asp:Button ID="FinishPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious"
                    CssClass="Button" Text="Anterior" />&nbsp;
                <asp:Button ID="FinishButton" runat="server" CausesValidation="False" CommandName="MoveComplete"
                    CssClass="Button" Text="Finalizar" />&nbsp;
                <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    CssClass="Button" Text="Cancelar" />
            </FinishNavigationTemplate>
        </asp:Wizard>
            <dxpc:ASPxPopupControl ID="PopupControlAddTarea" runat="server" AllowDragging="True"
                AllowResize="True" ClientInstanceName="popupAcciones"
                Height="425px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                Width="650px" FooterText="Puede mover y cambiar el tamaño de esta ventana según su necesidad." HeaderText="" Modal="True" ShowFooter="True" ShowSizeGrip="True">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
                <ClientSideEvents CloseUp="function(s, e) {
	window.navigate(window.location.href);
}" />
                <ContentStyle>
                    <Paddings Padding="0px" />
                </ContentStyle>
            </dxpc:ASPxPopupControl>
        </center>
</asp:Content>

