<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="EditUser.aspx.cs" Inherits="EditUser" Title="Modificar datos de usuarios." MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<ext:scriptmanager id="ScriptManager1" runat="server"></ext:scriptmanager>
<br />
<br />
    <table style="margin: auto;" cellspacing="5" class="LoginForm" width="70%">
        <tr>
            <td align="right" colspan="2">
<h3>&nbsp;&nbsp;&nbsp;&nbsp;Datos personales:</h3>
                <br />
            </td>
        </tr>
        <tr>
            <td style="width: 25%" align="right">
                NID:</td>
            <td style="width: 50%" align="left">
                <asp:Label ID="Label_NID" runat="server" Font-Bold="True"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 25%; height: 24px;">
                Nombre completo:</td>
            <td align="left" style="width: 50%; height: 24px;">
                <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Width="160px" ValidationGroup="Personales"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                    ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="right" style="width: 33%">
                            Dirección de correo:</td>
                        <td align="left">
                            <asp:TextBox ID="TextBox_Email" runat="server" CssClass="Input" ValidationGroup="Personales"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator_Email" runat="server" ControlToValidate="TextBox_Email"
                                ErrorMessage="*" ForeColor="Tomato" ValidationGroup="Personales"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator_Email" runat="server" ControlToValidate="TextBox_Email"
                                ErrorMessage="No es una dirección válida." ForeColor="Tomato" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Personales"></asp:RegularExpressionValidator>
                        </td>
        </tr>
        <tr>
            <td style="width: 25%;" align="right">
                Nivel escolar:</td>
            <td align="left" style="width: 50%">
                <asp:DropDownList ID="DropDownList_NivelEscolar" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Nivel"
                    DataTextField="Nivel" DataValueField="NivelID" ValidationGroup="Personales">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DropDownList_NivelEscolar"
                    ForeColor="Tomato">*</asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSource_Nivel" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="SELECT [Nivel], [NivelID] FROM [NivelEscolar] ORDER BY [NivelID]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Título:</td>
            <td align="left" style="width: 50%">
                <asp:DropDownList ID="DropDownList_Titulo" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Titulos"
                    DataTextField="Titulo" DataValueField="TituloID" ValidationGroup="Personales">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="DropDownList_Titulo"
                    ForeColor="Tomato" ValidationGroup="Personal">*</asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSource_Titulos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="SELECT [TituloID], [Titulo] FROM [Titulos] ORDER BY [Titulo]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
            </td>
            <td align="left" style="width: 50%">
                <asp:Literal ID="Literal_DatosPersonales" runat="server" EnableViewState="False"></asp:Literal></td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="Button_Personal" runat="server" CssClass="Input" Text="Guardar cambios" ValidationGroup="Personales" OnClick="Button_Personal_Click" />
                &nbsp;&nbsp;
                <asp:Button ID="Button_Cancel" runat="server" CausesValidation="False" CommandName="Cancel"
                    CssClass="Input" Text="Cancelar" ValidationGroup="Personal" /></td>
        </tr>
    </table>
    <br />
    <br />
    <table style="margin: auto;" cellspacing="5" class="LoginForm" width="70%">
        <tr>
            <td align="left" colspan="2">
    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Datos de trabajo:</h3>
                <p>
                    &nbsp;</p>
            </td>
        </tr>
        <tr>
            <td style="width: 25%" align="right">
                Fecha de entrada:</td>
            <td style="width: 50%" align="left">
                <ext:datefield id="DateField_Entrada" runat="server" ValidationGroup="Trabajo"></ext:datefield>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Cargo:</td>
            <td align="left" style="width: 50%">
                <asp:DropDownList ID="DropDownList_Cargo" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Cargos"
                    DataTextField="Cargo" DataValueField="CargoID" ValidationGroup="Trabajo">
                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_Cargos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="SELECT [Cargo], [CargoID] FROM [Cargo] ORDER BY [Cargo]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 25%" align="right">
                Área de Trabajo:
            </td>
            <td align="left" style="width: 50%">
                <asp:DropDownList ID="DropDownList_Area" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Areas"
                    DataTextField="NombreArea" DataValueField="AreaID" ValidationGroup="Trabajo">
                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_Areas" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="SELECT AreaID, NombreArea FROM Areas">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Reserva de cuadros:</td>
            <td align="left" style="width: 50%">
                &nbsp;<asp:CheckBox ID="CheckBox_Reserva" runat="server" AutoPostBack="True" Text="  Pertenece a la reserva" /></td>
        </tr>
        <tr>
            <td style="width: 25%" align="right">
                &nbsp;Fecha de entrada a la reserva:</td>
            <td align="left" style="width: 50%">
                <ext:datefield id="DateField_Reserva" runat="server" ValidationGroup="Trabajo"></ext:datefield>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <asp:Literal ID="Literal_DatosTrabajo" runat="server" EnableViewState="False"></asp:Literal></td>
        </tr>
        <tr>
            <td style="width: 25%; height: 25px;">
            </td>
            <td colspan="1" style="width: 50%; height: 25px;" align="center">
                <asp:Button ID="Button_Trabajo" runat="server" CssClass="Input" Text="Guardar cambios" ValidationGroup="Trabajo" OnClick="Button_Trabajo_Click" />
                &nbsp;&nbsp;
                <asp:Button ID="Button_Cancel2" runat="server" CausesValidation="False" CommandName="Cancel"
                    CssClass="Input" Text="Cancelar" ValidationGroup="Trabajo" /></td>
        </tr>
    </table>
    <br />
    <br />
    <table style="margin: auto;" cellspacing="5" class="LoginForm" width="70%">
        <tr>
            <td align="left" colspan="3">
                <h3 style="width: 50%">
                    &nbsp; &nbsp; Datos del Sistema:</h3>
                <p>
                    &nbsp;</p>
            </td>
        </tr>
        <tr>
            <td style="width: 25%" align="right">
                Nombre de usuario:</td>
            <td style="width: 35%" align="left">
                &nbsp;<asp:Label ID="Label_UserName" runat="server" Font-Bold="True"></asp:Label></td>
            <td align="left" style="width: 50%">
                <input id="Button_Acceso" type="button" value="Cambiar usuario" class="Input" />
                (*)</td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Función:
            </td>
            <td align="left" style="width: 35%">
                <asp:DropDownList ID="DropDownList_Roles" runat="server" CssClass="Input"
                    DataTextField="Nombre" DataValueField="Codigo" ValidationGroup="Trabajo" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_Roles_SelectedIndexChanged">
                </asp:DropDownList></td>
            <td align="left" style="width: 50%">
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Está conectado:</td>
            <td align="left" style="width: 35%">
                <asp:Label ID="Label_EstaConectado" runat="server" Font-Bold="True"></asp:Label></td>
            <td align="left" style="width: 50%">
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Permiso de acceso:</td>
            <td align="left" style="width: 35%">
                <asp:Label ID="Label_Acceso" runat="server" Font-Bold="True"></asp:Label>
                &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td align="left" style="width: 50%">
                <asp:Button ID="Button_Bloquear" runat="server" CausesValidation="False"
                    CssClass="Input" Text="Conceder / Denegar" ValidationGroup="Acceso" OnClick="Button_Bloquear_Click" /></td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Última&nbsp; conexión:</td>
            <td align="left" style="width: 35%">
                <asp:Label ID="Label_UltimaConexion" runat="server" Font-Bold="True"></asp:Label></td>
            <td align="left" style="width: 50%">
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Estado&nbsp; actual:</td>
            <td align="left" style="width: 35%">
                <asp:Label ID="Label_Estado" runat="server" Font-Bold="True"></asp:Label></td>
            <td align="left" style="width: 50%">
                <asp:Button ID="Button_LockOut" runat="server" CausesValidation="False"
                    CssClass="Input" Text="Desbloquear" ValidationGroup="Acceso" OnClick="Button_LockOut_Click" /></td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Planificación:
            </td>
            <td align="left" colspan="2">
                </td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
            </td>
            <td align="left" style="height: 13px">
                <asp:BulletedList ID="BulletedList_Subordinados" runat="server" BulletStyle="Disc"
                    DataSourceID="SqlDataSource_Subordinados" DataTextField="NombreCompleto" DataValueField="NID"
                    Font-Bold="True">
                </asp:BulletedList>
                <asp:SqlDataSource ID="SqlDataSource_Subordinados" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="stp_MostrarTrabajadoresSubordinados" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Label_NID" Name="NIDJefe" PropertyName="Text" Type="String" />
                        <asp:Parameter DefaultValue="false" Name="IncluirJefe" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td align="left" style="width: 50%"><input id="Button_Cambiar" type="button" value="Cambiar subordinados" class="Input" /></td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
            </td>
            <td align="right" colspan="2">
                <asp:Literal ID="Literal_Sistema" runat="server" EnableViewState="False"></asp:Literal><br />
            </td>
        </tr>
        <tr>
            <td colspan="3" style="padding-right: 5px; padding-left: 5px; font-weight: normal;
                font-size: small; padding-bottom: 5px; color: #b22222; padding-top: 5px; height: 25px;
                background-color: #ffdd9d; text-align: justify">
                <SPAN style="font-weight:bold;">(*) IMPORTANTE: "Cambiar usuario"</SPAN> borra
                el usuario asignado al trabajador y crea uno nuevo con la información que se solicita.
                Esta operación
                no afecta los datos personales ni los planes de trabajo almacenados.&nbsp;<br />
                Utilice esta opción, solo cuando el trabajador no recuerde su contraseña ni la información
                para recuperarla.</td>
        </tr>
    </table>
    <dxpc:ASPxPopupControl ID="ASPxPopupControl1" runat="server" ClientInstanceName="popupCambiar"
        HeaderText="" Height="69px" Modal="True" PopupElementID="Button_Change"
        Width="190px" AllowDragging="True" AllowResize="True" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" EnableAnimation="False" FooterText="Puede mover y cambiarle el tamaño a esta ventana según sea necesario." ShowFooter="True">
        <ContentCollection>
            <dxpc:PopupControlContentControl runat="server">
            </dxpc:PopupControlContentControl>
        </ContentCollection>
        <Windows>
            <dxpc:PopupWindow Modal="True" Name="Acceso" PopupElementID="Button_Acceso">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                       <h3>Cambiar datos de acceso</h3>
                       <table style="width: 100%">
                            <tr>
                                <td align="right" style="width: 40%">
                                    Nombre de usuario:</td>
                                <td align="left" style="width: 50%">
                                    <asp:TextBox ID="TextBox_UserName" runat="server" CssClass="Input" ValidationGroup="NewUser"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox_UserName"
                                        ErrorMessage="*" ForeColor="Tomato" ValidationGroup="NewUser"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 40%">
                                    Contraseña:</td>
                                <td align="left" style="width: 50%">
                                    <asp:TextBox ID="TextBox_Password" runat="server" CssClass="Input" ValidationGroup="NewUser" TextMode="Password"></asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox_Password"
                                        ErrorMessage="*" ForeColor="Tomato" ValidationGroup="NewUser"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 40%;">
                                    Confirmar contraseña:</td>
                                <td align="left" style="width: 50%; height: 14px">
                                    <asp:TextBox ID="TextBox_Password2" runat="server" CssClass="Input" ValidationGroup="NewUser" TextMode="Password"></asp:TextBox>
                                    &nbsp;<br />
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TextBox_Password"
                                        ControlToValidate="TextBox_Password2" Display="Dynamic" ErrorMessage="Las contrase&#241;as no coinciden entre s&#237;."
                                        ForeColor="Tomato"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 40%">
                                    Pregunta de seguridad:</td>
                                <td align="left" style="width: 50%">
                                    <asp:TextBox ID="TextBox_SegPregunta" runat="server" CssClass="Input" ValidationGroup="NewUser"></asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox_SegPregunta"
                                        ErrorMessage="*" ForeColor="Tomato" ValidationGroup="NewUser"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 40%">
                                    Respuesta de seguridad:</td>
                                <td align="left" style="width: 50%">
                                    <asp:TextBox ID="TextBox_SegRespuesta" runat="server" CssClass="Input" ValidationGroup="NewUser"></asp:TextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox_SegRespuesta"
                                        ErrorMessage="*" ForeColor="Tomato" ValidationGroup="NewUser"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 40%">
                                    Función:</td>
                                <td align="left" style="width: 50%">
                                    <asp:Label ID="Label_Role" runat="server" Font-Bold="True"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Label_Mnsg" runat="server" Font-Bold="True"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="Button_Cambiar" runat="server" CssClass="Input" OnClick="Button_Cambiar_Click"
                                        Text="Cambiar usuario" ValidationGroup="NewUser" />
                                    &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
                                    <input id="Button_CerrarAcceso" class="Input" type="button" value="Cancelar" onclick="popupCambiar.HideWindow(popupCambiar.GetWindowByName('Acceso'));" /></td>
                            </tr>
                        </table>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:PopupWindow>
            <dxpc:PopupWindow Modal="True" Name="Subordinados" PopupElementID="Button_Cambiar">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                       <h3>Cambiar trabajadores subordinados</h3>
                       <table style="width: 100%">
                            <tr>
                                <td colspan="2">
                                    <asp:CheckBox ID="CheckBox_Filtrar" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox_Filtrar_CheckedChanged"
                                        Text="  Solo trabajadores de su &#225;rea." />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    Trabajadores del centro:<br />
                                    <br />
                                    <asp:ListBox ID="ListBox_Trabajadores" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Trabajadores"
                                        DataTextField="NombreCompleto" DataValueField="NID" ValidationGroup="Add"></asp:ListBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ListBox_Trabajadores"
                                        ErrorMessage="Seleccione los trabajadores a adicionar" ForeColor="Tomato" ValidationGroup="Add"></asp:RequiredFieldValidator>
                                </td>
                                <td style="width: 50%">
                                    Reciben planes del usuario:<br />
                                    <br />
                                    <asp:ListBox ID="ListBox_Subordinados" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Subordinados"
                                        DataTextField="NombreCompleto" DataValueField="NID" ValidationGroup="Quitar"></asp:ListBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ListBox_Subordinados"
                                        ErrorMessage="Seleccione los trabajadores a quitar." ForeColor="Tomato" ValidationGroup="Quitar"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%">
                                    <asp:Button ID="Button_Addicionar" runat="server" CssClass="Input" OnClick="Button_Adicionar_Click"
                                        Text="Adicionar &gt;&gt;" ValidationGroup="Add" />
                                    &nbsp;
                                </td>
                                <td style="width: 50%">
                                    <asp:Button ID="Button_Quitar" runat="server" CssClass="Input" OnClick="Button_Quitar_Click"
                                        Text="&lt;&lt; Quitar" ValidationGroup="Quitar" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                    <asp:Label ID="Label_MnsgSubord" runat="server" Font-Bold="True"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                            <td colspan="2">
                                &nbsp; &nbsp;<input id="Button_CerrarSubordinados" class="Input" type="button" value="Terminar" onclick="popupCambiar.HideWindow(popupCambiar.GetWindowByName('Subordinados'));" /></td>
                            </tr>
                        </table>
                        <asp:SqlDataSource ID="SqlDataSource_Trabajadores" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                            SelectCommand="stp_MostrarTrabajadoresPorAreas" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList_Area" Name="CodigoArea" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:PopupWindow>
        </Windows>
        <ModalBackgroundStyle Opacity="35">
        </ModalBackgroundStyle>
        <ClientSideEvents CloseUp="function(s, e) {
 if (popupCambiar.cpID != null)
  {
	PosInit = window.location.href.indexOf('ID=') + 3;
	PosEnd = window.location.href.indexOf('&amp;');

	//La id en la url es desde 'ID=' hasta '&amp;'	
	IDActual = window.location.href.substring(PosInit,PosEnd);
	DireccionNueva = window.location.href.replace(IDActual,popupCambiar.cpID);	
	window.navigate(DireccionNueva);	
  }
}" />
    </dxpc:ASPxPopupControl>
</asp:Content>

