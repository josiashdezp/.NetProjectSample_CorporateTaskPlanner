<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="Recover.aspx.cs" Inherits="Recover" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
   <center>
       &nbsp;</center>
    <center>
    <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" MembershipProvider="<%$ AppSettings:Proveedor_Membresia_Roles %>" AnswerLabelText="Respuesta: " GeneralFailureText="Su intento de recuperar la contraseña no fue exitoso. Por favor pruebe nuevamente." QuestionFailureText="Su respuesta no pudo ser verificada. Por favor intente nuevamente." QuestionInstructionText="Responda la siguiente pregunta para recibir su contraseña" QuestionLabelText="Pregunta: " QuestionTitleText="Confirmación de Identidad" SuccessText="Su contraseña se le ha enviado por correo." UserNameFailureText="No ha sido posible acceder a sus informaciones. Por favor, intente nuevamente." UserNameInstructionText="Entre su nombre de usuario para recibir la contraseña" UserNameTitleText=" Olvidó su contraseña ?" SuccessPageUrl="~/Index.aspx" CssClass="LoginForm" Height="111px">
        <MailDefinition From="notificaciones@dpcf.bandec.cu" Priority="High" Subject="Planificador Online">
        </MailDefinition>
        <TextBoxStyle CssClass="Input" />
        <TitleTextStyle CssClass="Encabezado" />
        <SubmitButtonStyle CssClass="Button" />
    </asp:PasswordRecovery>
    </center>
</asp:Content>

