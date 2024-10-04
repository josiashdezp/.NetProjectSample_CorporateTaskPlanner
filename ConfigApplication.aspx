<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="ConfigApplication.aspx.cs" Inherits="FirstUseConfig" Title="Planificador Online. Configuración inicial del sistema." MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Configuración inicial del sistema:</h3>
   <br />
   <table style="width: 75%; margin: auto;" class="LoginForm">
       <tr>
           <td align="center" class="Encabezado" colspan="2">
               Datos de la Entidad</td>
       </tr>
        <tr>
            <td style="width: 33%" align="right">
                Nombre de la institución:
            </td>
            <td style="padding-left: 4px; width: 75%" align="left">
                <asp:TextBox ID="TextBox_NombreInstituc" runat="server" CssClass="Input" Width="70%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_NombreInstituc"
                    Display="Dynamic" ErrorMessage="El nombre de la institución es obligatorio. Por ejemplo: Banco de Crédito y Comercio."
                    ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
        </tr>
       <tr>
           <td align="right" style="width: 33%">
               Abreviatura:</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_AbrevInstituc" runat="server" CssClass="Input"></asp:TextBox></td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Dirección y teléfonos:</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_DireccionInstituc" runat="server" CssClass="Input"></asp:TextBox>
           </td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Nombre de la dependencia:</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_NombreDependenc" runat="server" CssClass="Input" Width="70%"></asp:TextBox>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox_NombreDependenc"
                   Display="Dynamic" ErrorMessage="Identifique la dependencia. Por ejemplo: Dirección Provincial Cienfuegos."
                   ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
       </tr>
        <tr>
            <td style="width: 33%" align="right">
                Dirección y teléfonos:</td>
            <td style="padding-left: 4px; width: 75%" align="left">
                <asp:TextBox ID="TextBox_DireccionDependenc" runat="server" CssClass="Input" Width="70%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_DireccionDependenc"
                    Display="Dynamic" ErrorMessage="Faltan el domicilio y los teléfonos de esta dependencia."
                    ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
        </tr>
       <tr>
           <td align="center" class="Encabezado" colspan="2">
              <br /> Administrador del Sistema</td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Nombre completo:</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_NombreCompleto" runat="server" CssClass="Input"></asp:TextBox>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox_NombreCompleto"
                   Display="Dynamic" ErrorMessage="Esrciba el nombre del trabajador." ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Nombre de usuario:</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_Usuario" runat="server" CssClass="Input"></asp:TextBox>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox_Usuario"
                   Display="Dynamic" ErrorMessage="El nombre de acceso para el administrador del sistema es requerido."
                   ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Contraseña:</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_Password" runat="server" CssClass="Input" TextMode="Password"></asp:TextBox>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox_Password"
                   Display="Dynamic" ErrorMessage="Falta la contraseña por establecer." ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Confirmar contraseña</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_PasswordConfirm" runat="server" CssClass="Input" TextMode="Password"></asp:TextBox>
               <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TextBox_Password"
                   ControlToValidate="TextBox_PasswordConfirm" ErrorMessage="Las contraseñas no coinciden entre sí."
                   ForeColor="Tomato">*</asp:CompareValidator></td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Correo electrónico</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_Email" runat="server" CssClass="Input"></asp:TextBox>
               <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_Email"
                   ErrorMessage="Dirección de correo no válida." ForeColor="Tomato" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator></td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Pregunta de seguridad:</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_SegPregunta" runat="server" CssClass="Input"></asp:TextBox>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TextBox_SegPregunta"
                   Display="Dynamic" ErrorMessage="La pregunta de seguridad y la respuesta son necesaria para la recuperación  de las contraseñas olvidadas."
                   ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
       </tr>
       <tr>
           <td align="right" style="width: 33%">
               Respuesta de seguridad:</td>
           <td align="left" style="padding-left: 4px; width: 75%">
               <asp:TextBox ID="TextBox_SegRespuesta" runat="server" CssClass="Input"></asp:TextBox>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox_SegRespuesta"
                   Display="Dynamic" ErrorMessage="La pregunta de seguridad y la respuesta son necesaria para la recuperación  de las contraseñas olvidadas."
                   ForeColor="Tomato">*</asp:RequiredFieldValidator></td>
       </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                    ForeColor="Tomato" />
                </td>
        </tr>
       <tr>
           <td align="center">
               &nbsp;<asp:Label ID="Label_Msg" runat="server"></asp:Label></td>
           <td align="right">
               <asp:Button ID="Button_Save" runat="server" CssClass="Input" Text="Guardar datos" OnClick="Button_Save_Click" />
               <asp:Button ID="Button_Continue" runat="server" CssClass="Input" Text="Ir a la página principal" OnClick="Button_Continue_Click" Enabled="False" /></td>
       </tr>
    </table>
</asp:Content>

