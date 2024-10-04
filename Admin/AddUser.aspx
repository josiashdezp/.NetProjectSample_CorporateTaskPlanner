<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="AddUser.aspx.cs" Inherits="Lists_AddUser" Title="Adicionar Trabajador." MaintainScrollPositionOnPostback="true" ValidateRequest="false" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<ext:ScriptManager ID="ScriptManager1" runat="server"></ext:ScriptManager>
<h3>&nbsp;&nbsp;&nbsp;&nbsp;Adicionar trabajador:</h3>
<br />
<center>
    <asp:Wizard ID="Wizard_AddUser" runat="server" CssClass="LoginForm" Width="75%" ActiveStepIndex="0" CancelDestinationPageUrl="~/Admin/AdminUsers.aspx" DisplayCancelButton="True" FinishCompleteButtonText="Crear Usuario" OnNextButtonClick="Wizard_AddUser_NextButtonClick" CellPadding="5" CellSpacing="5" OnActiveStepChanged="Wizard_AddUser_ActiveStepChanged" DisplaySideBar="False" OnPreviousButtonClick="Wizard_AddUser_PreviousButtonClick" HeaderText="Asistente para el registro de usuarios en el sistema.">
        <WizardSteps>
            <asp:WizardStep runat="server" AllowReturn="False" Title="Acceso">
                &nbsp;<table style="width: 100%" cellpadding="0" cellspacing="5">
                    <tr>
                        <td class="Encabezado" colspan="2">
               Datos de Acceso</td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%">
                Nombre de usuario:</td>
            <td align="left">
                <asp:TextBox ID="TextBox_UserName" runat="server" CssClass="Input" ValidationGroup="Acceso"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    ForeColor="Tomato" ControlToValidate="TextBox_UserName" ValidationGroup="Acceso"></asp:RequiredFieldValidator>
                <asp:Label ID="Label_User" runat="server" ForeColor="Tomato"></asp:Label>
                            </td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%">
                Correo electrónico:</td>
            <td align="left">
                <asp:TextBox ID="TextBox_Email" runat="server" CssClass="Input"  ValidationGroup="Acceso"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                    ForeColor="Tomato" ControlToValidate="TextBox_Email" ValidationGroup="Acceso"></asp:RequiredFieldValidator>
                &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                    ControlToValidate="TextBox_Email" Display="Dynamic" ErrorMessage="No es una direcci&#243;n de correo v&#225;lida."
                    ForeColor="Tomato" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                &nbsp;<asp:Label ID="Label_Email" runat="server" ForeColor="Tomato"></asp:Label>
                        </td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%">
                Contraseña:</td>
            <td align="left">
                <asp:TextBox ID="TextBox_Password" runat="server" TextMode="Password" CssClass="Input" ValidationGroup="Acceso"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                    ForeColor="Tomato" ControlToValidate="TextBox_Password" ValidationGroup="Acceso"></asp:RequiredFieldValidator>
                <asp:Label ID="Label_Password" runat="server" ForeColor="Tomato"></asp:Label>
                </td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%">
                Confirmar Contraseña:</td>
            <td align="left">
                <asp:TextBox ID="TextBox_Password2" runat="server" TextMode="Password" CssClass="Input" ValidationGroup="Acceso"></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TextBox_Password"
                    ControlToValidate="TextBox_Password2" ErrorMessage="No coincide con la original." ForeColor="Tomato" ValidationGroup="Acceso"></asp:CompareValidator></td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%">
                Función:</td>
            <td align="left">
                <asp:DropDownList ID="DropDownList_Roles" runat="server" CssClass="Input" ValidationGroup="Acceso">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="DropDownList_Roles"
                    ErrorMessage="*" ForeColor="Tomato" ValidationGroup="Acceso"></asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%">
                Pregunta de Seguridad:</td>
            <td align="left">
                <asp:TextBox ID="TextBox_SeguridadPregunta" runat="server" CssClass="Input" ValidationGroup="Acceso"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                    ForeColor="Tomato" ControlToValidate="TextBox_SeguridadPregunta" ValidationGroup="Acceso"></asp:RequiredFieldValidator>
                <asp:Label ID="Label_SegPregunt" runat="server" ForeColor="Tomato"></asp:Label>
                </td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%; height: 26px;">
                Respuesta de Seguridad:</td>
            <td align="left" style="height: 26px">
                <asp:TextBox ID="TextBox_SeguridadRespuesta" runat="server" CssClass="Input" ValidationGroup="Acceso"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*"
                    ForeColor="Tomato" ControlToValidate="TextBox_SeguridadRespuesta" ValidationGroup="Acceso"></asp:RequiredFieldValidator>
                <asp:Label ID="Label_SegRespuest" runat="server" ForeColor="Tomato"></asp:Label>
                </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%; height: 26px">
                        </td>
                        <td align="left" style="height: 26px">
                            <asp:Label ID="Label_General" runat="server" ForeColor="Tomato"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="Personales">
                <br />
                <table style="width: 100%" cellpadding="0" cellspacing="5">
                    <tr>
                        <td class="Encabezado" colspan="2">
                            Datos Personales<br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%;">
                Número de Identidad:</td>
            <td align="left" style="height: 13px">
                <asp:TextBox ID="TextBox_CI" runat="server" MaxLength="11" CssClass="Input" ValidationGroup="Personales"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="NID es un campo requerido."
                    ForeColor="Tomato" ControlToValidate="TextBox_CI" ValidationGroup="Personales" Display="Dynamic">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator_ci" runat="server" ControlToValidate="TextBox_CI"
                    ErrorMessage="No es un n&#250;mero de identidad v&#225;lido." ForeColor="Tomato" ValidationExpression="\d{11}" ValidationGroup="Personales" Display="Dynamic"></asp:RegularExpressionValidator>
                        <asp:Label ID="Label_CI" runat="server" ForeColor="Tomato" Visible="False">Ya existe un trabajador con este NID.</asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%">
                Nombre&nbsp; completo:</td>
            <td align="left">
                <asp:TextBox ID="TextBox_NombreCompleto" runat="server" Width="181px" CssClass="Input" ValidationGroup="Personales"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El nombre del trabajador es un campo necesario."
                    ForeColor="Tomato" ControlToValidate="TextBox_NombreCompleto" ValidationGroup="Personales">*</asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%">
                Nivel&nbsp; escolar:</td>
            <td align="left">
                <asp:DropDownList ID="DropDownList_NivelEscolar" runat="server" DataSourceID="SqlDataSource_NivelEscolar"
                    DataTextField="Nivel" DataValueField="NivelID" CssClass="Input" ValidationGroup="Personales">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="DropDownList_NivelEscolar"
                    ErrorMessage="*" ForeColor="Tomato" ValidationGroup="Personales"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSource_NivelEscolar" runat="server"
                    ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" SelectCommand="SELECT [NivelID], [Nivel] FROM [NivelEscolar]">
                </asp:SqlDataSource>
            </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%">
                Título:
            </td>
            <td align="left">
                <asp:DropDownList ID="DropDownList_Titulo" runat="server" DataSourceID="SqlDataSource_Titulo"
                    DataTextField="Titulo" DataValueField="TituloID" CssClass="Input" ValidationGroup="Personales">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="DropDownList_Titulo"
                    ErrorMessage="*" ForeColor="Tomato" ValidationGroup="Personales"></asp:RequiredFieldValidator><asp:SqlDataSource ID="SqlDataSource_Titulo" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="SELECT [TituloID], [Titulo] FROM [Titulos] order by Titulo asc"></asp:SqlDataSource>
            </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%">
                        </td>
                        <td align="left">
                            <br />
                            <asp:Label ID="Label_UsuarioCreado" runat="server" Font-Bold="True" ForeColor="ForestGreen"
                                Visible="False"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="Trabajo">
                <table style="width: 100%">
                    <tr>
                        <td class="Encabezado" colspan="2">
                            Datos del Trabajo</td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%;">
                Fecha de entrada:</td>
            <td align="left">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 30%">
                            <ext:DateField ID="DateField_FechaEntrada" runat="server" IDMode="Legacy" MaxDate="" MinDate="" SelectedDate="" ValidationGroup="Trabajo" AllowBlank="False">
                            </ext:DateField>
                        </td>
                        <td style="width: 60%">
                            &nbsp;<asp:CustomValidator ID="CustomValidator_FechaEntrada" runat="server" ControlToValidate="DateField_FechaEntrada"
                                ErrorMessage="Especifique la fecha de entrada a la instituci&#243;n." ForeColor="Tomato"
                                OnServerValidate="CustomValidator_FechaEntrada_ServerValidate" ValidationGroup="Trabajo" ValidateEmptyText="True">*</asp:CustomValidator>
                        </td>
                    </tr>
                </table>
            </td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%;">
                Cargo:</td>
            <td align="left" style="height: 13px">
                <asp:DropDownList ID="DropDownList_Cargo" runat="server" DataSourceID="SqlDataSource_Cargo"
                    DataTextField="Cargo" DataValueField="CargoID" CssClass="Input" ValidationGroup="Trabajo">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="DropDownList_Cargo"
                    ErrorMessage="*" ForeColor="Tomato" ValidationGroup="Trabajo"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSource_Cargo" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="SELECT [CargoID], [Cargo], [EsCuadro] FROM [Cargo] ORDER BY [Cargo]">
                </asp:SqlDataSource>
            </td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%" valign="middle">
                Area&nbsp; de Trabajo:</td>
            <td align="left">
                <asp:DropDownList runat="server" DataTextField="NombreArea" DataValueField="AreaID" DataSourceID="SqlDataSource_AreasDeTrabajo" CssClass="Input" ID="DropDownList_Areas"  ValidationGroup="Trabajo" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_Areas_SelectedIndexChanged" ><asp:ListItem Selected="True" Value="0">- Seleccionar - </asp:ListItem>
</asp:DropDownList>
 <asp:RequiredFieldValidator runat="server" ForeColor="Tomato" ControlToValidate="DropDownList_Areas" ErrorMessage="*" ID="RequiredFieldValidator_Areas" Enabled="False" ValidationGroup="Trabajo"></asp:RequiredFieldValidator>
    <br />
 <asp:SqlDataSource ID="SqlDataSource_AreasDeTrabajo" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
     SelectCommand="SELECT AreaID, NombreArea FROM Areas ORDER BY NombreArea">
 </asp:SqlDataSource>
            </td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%;">
                Recibe tareas&nbsp; de:</td>
            <td align="left" style="height: 26px">
                <asp:ListBox ID="ListBox_Cuadros" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Cuadros" DataTextField="NombreCompleto" DataValueField="NID" ValidationGroup="Trabajo" SelectionMode="Multiple"></asp:ListBox>
                <asp:SqlDataSource
                        ID="SqlDataSource_Cuadros" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                        SelectCommand="stp_MostrarTrabajadoresQuePlanifican" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_Areas" Name="AreaID" PropertyName="SelectedValue" />
                    </SelectParameters>
                    </asp:SqlDataSource>
            </td>
                    </tr>
                    <tr>
            <td align="right" style="width: 30%;">
                            Es reserva de cuadros:</td>
            <td align="left" style="height: 26px">
                <table style="width: 70%">
                    <tr>
                        <td align="left" style="width: 10%">
                            <asp:CheckBox ID="CheckBox_EsReserva" runat="server" onclick="callbackpanel_reserva.PerformCallback('');" ValidationGroup="Trabajo" />
                            </td>
                        <td style="width: 40%" align="right">
                Desde la fecha:
                        </td>
                        <td align="left">
                            <ext:DateField ID="DateReserva" runat="server" IDMode="Legacy" MaxDate="" MinDate="" SelectedDate="" ValidationGroup="Trabajo">
                            </ext:DateField>
                        </td>
                        <td align="left">
                            <asp:CustomValidator ID="CustomValidator_Reserva" runat="server" ControlToValidate="DateReserva"
                                ErrorMessage="Especifique la fecha desde cuando entr&#243; en la reserva." ForeColor="Tomato" OnServerValidate="CustomValidator_Reserva_ServerValidate"
                                ValidationGroup="Trabajo">*</asp:CustomValidator></td>
                    </tr>
                </table>
            </td>
                    </tr>
                </table>
                <br />
                <br />
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="Sistema" StepType="Step">
                <table style="width: 100%" cellpadding="0" cellspacing="5">
                    <tr>
                        <td class="Encabezado" colspan="2">
                            Control de Tareas</td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%">
                        </td>
                        <td align="left" style="height: 13px">
                <asp:CheckBox ID="CheckBox_Planifica" runat="server" Font-Bold="False" AutoPostBack="True" OnCheckedChanged="CheckBox_Planifica_CheckedChanged" ValidationGroup="Supervision" />&nbsp;
                Planifica tareas a otros trabajadores.</td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 30%">
                Planifica tareas a:</td>
            <td align="left" style="height: 13px">
                <asp:CheckBox ID="CheckBox_Filtrar" runat="server" Font-Bold="False" AutoPostBack="True" OnCheckedChanged="CheckBox_Filtrar_CheckedChanged" ValidationGroup="Supervision" />
 &nbsp;Solo trabajadores de su área.<br />
                <asp:ListBox ID="ListBox_TrabajadoresSubordinados" runat="server" CssClass="Input" Rows="5" SelectionMode="Multiple" DataSourceID="SqlDataSource_Subordinados" DataTextField="NombreCompleto" DataValueField="NID" ValidationGroup="Supervision"></asp:ListBox>
 <asp:CustomValidator ID="CustomValidator_Sistema" runat="server" ControlToValidate="ListBox_TrabajadoresSubordinados"
                                ErrorMessage="*" ForeColor="Tomato" OnServerValidate="CustomValidator_Sistema_ServerValidate"
                                ValidationGroup="Supervision" ValidateEmptyText="True" SetFocusOnError="True">*</asp:CustomValidator>
 <asp:SqlDataSource ID="SqlDataSource_Subordinados" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
    SelectCommand="stp_MostrarTrabajadoresPorAreas" SelectCommandType="StoredProcedure"><SelectParameters>
        <asp:Parameter Name="CodigoArea" Type="Int32" />
</SelectParameters>
</asp:SqlDataSource>
            </td>
                    </tr>
                </table>
                <br />
            </asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Finish" Title="Resultados">
                <table style="width: 100%">
                    <tr>
                        <td class="Encabezado">
                                Resultados de la Operación</td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <asp:TextBox ID="TextBox_Logs" runat="server" EnableTheming="False" Rows="10" TextMode="MultiLine"
                                Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </asp:WizardStep>
        </WizardSteps>
        <NavigationButtonStyle CssClass="Input" />        
        <FinishNavigationTemplate>
            <asp:Button ID="FinishPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious"
                CssClass="Input" Text="Anterior" />&nbsp;
            <asp:Button ID="NewUserButton" runat="server" CausesValidation="False" CommandName="New"
                CssClass="Input" Text="Nuevo usuario" OnClick="NewUser_Button_Click" />
            <asp:Button ID="ButtonTerminar" runat="server" CommandName="MoveComplete" CssClass="Input"
                Text="Terminar" OnClick="TerminateButton_Click" />
        </FinishNavigationTemplate>
        <HeaderStyle CssClass="Encabezado" />
    </asp:Wizard>
</center>
<br />
</asp:Content>

