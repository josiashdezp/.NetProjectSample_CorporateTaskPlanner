<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="UserConfig.aspx.cs" Inherits="EditUser" Title="Modificar datos de usuarios." MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
    <ext:scriptmanager id="ScriptManager1" runat="server"></ext:scriptmanager>
<br />
<br />
    <table style="margin: auto;" cellspacing="5" class="LoginForm" width="70%">
        <tr>
            <td align="right" colspan="2">
<h3>&nbsp;&nbsp;&nbsp;&nbsp;Datos personales:</h3>
                <p>
                    &nbsp;</p>
            </td>
        </tr>
        <tr>
            <td style="width: 25%" align="right">
                NID:</td>
            <td style="width: 50%" align="left">
                <asp:Label ID="Label_NID" runat="server" CssClass="Labels" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td align="right" style="width: 25%;">
                Nombre completo:</td>
            <td align="left" style="width: 50%">
                <asp:TextBox ID="TextBox_Nombre" runat="server" CssClass="Input" Width="160px" ValidationGroup="DatosPersonales"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_Nombre"
                    ForeColor="Tomato" ValidationGroup="DatosPersonales">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="right" style="width: 25%">
                Correo electrónico:</td>
            <td align="left" style="width: 50%">
                <asp:TextBox ID="TextBox_Email" runat="server" CssClass="Input" ValidationGroup="DatosPersonales"
                    Width="160px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator_Correo" runat="server" ControlToValidate="TextBox_Email"
                    ForeColor="Tomato" ValidationGroup="DatosPersonales">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator_Correo" runat="server"
                    ControlToValidate="TextBox_Email" Display="Dynamic" ErrorMessage="No es una dirección de correo válida."
                    ForeColor="Tomato" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
        </tr>
        <tr>
            <td style="width: 25%;" align="right">
                Nivel escolar:</td>
            <td align="left" style="width: 50%">
                <asp:DropDownList ID="DropDownList_NivelEscolar" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Nivel"
                    DataTextField="Nivel" DataValueField="NivelID" ValidationGroup="DatosPersonales">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DropDownList_NivelEscolar"
                    ForeColor="Tomato" ValidationGroup="DatosPersonales">*</asp:RequiredFieldValidator>
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
                    DataTextField="Titulo" DataValueField="TituloID" ValidationGroup="DatosPersonales">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="DropDownList_Titulo"
                    ForeColor="Tomato" ValidationGroup="DatosPersonales">*</asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSource_Titulos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                    SelectCommand="SELECT [TituloID], [Titulo] FROM [Titulos] ORDER BY [Titulo]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="2">
                <asp:Literal ID="Literal_PersonalData" runat="server" EnableViewState="False"></asp:Literal></td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="Button_Personal" runat="server" CssClass="Input" Text="Guardar cambios" ValidationGroup="DatosPersonales" OnClick="Button_Personal_Click" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button_Cancel" runat="server" CausesValidation="False" CommandName="Cancel"
                    CssClass="Input" Text="Cancelar" ValidationGroup="DatosPersonales" /></td>
        </tr>
    </table>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_ActualizarDatos" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
        ProviderName="<%$ ConnectionStrings:BDPlanificadorConnectionString.ProviderName %>"
        UpdateCommand="stp_ActualizarDatosDeTrabajador" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="NID" Type="String" />
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="Planifica" Type="Boolean" />
            <asp:Parameter Name="FechaEntrada" Type="String" />
            <asp:Parameter Name="EsReserva" Type="Boolean" />
            <asp:Parameter Name="EsReservaDesde" Type="String" />
            <asp:Parameter Name="CargoID" Type="Int32" />
            <asp:Parameter Name="NivelID" Type="Int32" />
            <asp:Parameter Name="TituloID" Type="Int32" />
            <asp:Parameter Name="TipoArea" Type="Int32" />
            <asp:Parameter Name="CodigoArea" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <table style="margin: auto;" cellspacing="5" class="LoginForm" width="70%">
        <tr>
            <td align="right" colspan="2">
                <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cambiar Contraseñas:</h3>
                <p>
                    &nbsp;</p>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Contraseña:</asp:Label></td>
            <td align="left">
                <asp:TextBox ID="CurrentPassword" runat="server" CssClass="Input" TextMode="Password"
                    ValidationGroup="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                    ErrorMessage="La contraseña es obligatoria." ForeColor="Tomato" ToolTip="La contraseña es obligatoria."
                    ValidationGroup="Password">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" style="height: 23px">
                <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">Nueva contraseña:</asp:Label></td>
            <td align="left" style="height: 23px">
                <asp:TextBox ID="NewPassword" runat="server" CssClass="Input" TextMode="Password"
                    ValidationGroup="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                    ErrorMessage="La nueva contraseña es obligatoria." ForeColor="Tomato" ToolTip="La nueva contraseña es obligatoria."
                    ValidationGroup="Password">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirmar la nueva contraseña:</asp:Label></td>
            <td align="left">
                <asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="Input" TextMode="Password"
                    ValidationGroup="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                    ErrorMessage="Confirmar la nueva contraseña es obligatorio." ForeColor="Tomato"
                    ToolTip="Confirmar la nueva contraseña es obligatorio." ValidationGroup="Password">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                    ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="Confirmar la nueva contraseña debe coincidir con la entrada Nueva contraseña."
                    ForeColor="Tomato" ValidationGroup="Password"></asp:CompareValidator>
                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal></td>
        </tr>
        <tr>
            <td style="width: 25%" align="right">
            </td>
            <td align="center" style="width: 50%">
                <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                    CssClass="Input" Text="Cambiar contraseña" ValidationGroup="Password" OnClick="ChangePasswordPushButton_Click" />
                &nbsp; &nbsp;
                <asp:Button ID="Button_Cancel3" runat="server" CausesValidation="False" CommandName="Cancel"
                    CssClass="Input" Text="Cancelar" ValidationGroup="Password" /></td>
        </tr>
    </table>
    <br />
    <table class="LoginForm" width="70%" style="margin:auto;">
        <tr>
            <td colspan="2">
                <h3>Información para recuperar contraseñas:</h3><br /></td>
        </tr>
        <tr>
            <td align="right" style="width: 167px">
                Pregunta de Seguridad:
            </td>
            <td align="left">
                <asp:TextBox ID="TextBox_SecQuestion" runat="server" CssClass="Input" ValidationGroup="SecurityData"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox_SecQuestion"
                    Font-Bold="True" ForeColor="#FF8000" ValidationGroup="SecurityData">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr style="color: #000000">
            <td align="right" style="width: 167px">
                Respuesta de Seguridad:
            </td>
            <td align="left">
                <asp:TextBox ID="TextBox_SecAnsw" runat="server" CssClass="Input" ValidationGroup="SecurityData"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox_SecAnsw"
                    Font-Bold="True" ForeColor="#FF8000" ValidationGroup="SecurityData">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td align="right" style="width: 167px">
                Contraseña Actual:
            </td>
            <td align="left">
                <asp:TextBox ID="TextBox_SecPassword" runat="server" CssClass="Input" TextMode="Password"
                    ValidationGroup="SecurityData"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox_SecPassword"
                    Font-Bold="True" ForeColor="#FF8000" ValidationGroup="SecurityData">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td></td>
            <td><asp:Literal ID="FailureText_SecData" runat="server" EnableViewState="False"></asp:Literal></td>
        </tr>
        <tr>
            <td align="right" style="height: 28px">
            </td>
            <td align="center">
                <asp:Button ID="Button_SaveSecData" runat="server" CausesValidation="true" CssClass="Input" Text="Guardar cambios" UseSubmitBehavior="true" ValidationGroup="SecurityData" OnClick="Button_SaveSecData_Click" />
                &nbsp;&nbsp;
                <asp:Button ID="Button_Cancel4" runat="server" CausesValidation="false" CssClass="Input" CommandName="Cancel"  Text="Cancelar" ValidationGroup="SecurityData" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp; &nbsp;
            </td>
        </tr>
    </table>
    <br />
</asp:Content>

