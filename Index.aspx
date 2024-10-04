<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" Title="Gestor de Tareas. Bienvenido." %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxNewsControl" TagPrefix="dxnc" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
    <asp:LoginView ID="LoginView_Main" runat="server">
        <LoggedInTemplate>            
            <table border="0" cellpadding="0" cellspacing="0" width="80%" style="margin: auto; padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px;" align="center">
                <tr>
                 <td valign="top" colspan="5">
                   <br />
                   <h3>  Planes de Trabajo:</h3>
                   <br /></td> 
                </tr>
                <tr align="center">
                     <td style="width: 20%" valign="top">
                         <asp:HyperLink ID="HyperLink_Planes" runat="server" 
                             NavigateUrl="~/Planning/PlanMonthView.aspx">
                            <asp:Image ID="Image_Planes" runat="server" GenerateEmptyAlternateText="True" 
            ImageAlign="Middle" ImageUrl="~/Images/to_do.gif" 
                             DescriptionUrl="~/Planning/PlanMain.aspx" />                                                                             
                            <br />                            
                            Mostrar
                        </asp:HyperLink>
                        </td>
                    <td style="width: 20%" valign="top">
                        <asp:HyperLink ID="HyperLink_Imprimir" runat="server" 
                            NavigateUrl="~/Planning/PlanPrint.aspx" Enabled="false" >
                            <asp:Image ID="Image_Imprimir" runat="server" GenerateEmptyAlternateText="True" 
            ImageAlign="Middle" ImageUrl="~/Images/imprimir.png" 
                             DescriptionUrl="~/Planning/PlanPrint.aspx" />                                                                           
                            <br />                            
                            Imprimir
                        </asp:HyperLink>
                     </td>
                    <td style="width: 20%" valign="top">
                        <asp:HyperLink ID="HyperLink_AdminPlanes" runat="server" NavigateUrl="~/Planning/PlanMain.aspx" onload="HyperLink_AdminPlanes_Load">
                        <asp:Image ID="Image_AdminPlanes" runat="server" GenerateEmptyAlternateText="True" ImageAlign="Middle" ImageUrl="~/Images/adminplanes.gif" />
                        <br /> Administrar
                        </asp:HyperLink>
                     </td>
                     <td style="width: 20%" valign="top">
                         <asp:HyperLink ID="HyperLink_Control" runat="server" 
                             NavigateUrl="~/Manage/ManagePlanning.aspx">
                        <asp:Image ID="Image2" runat="server" GenerateEmptyAlternateText="True" ImageAlign="Middle" ImageUrl="~/Images/clasificadores.gif" />                        
                        <br />Control y Evaluación
                        </asp:HyperLink>
                     </td>
                     <td style="width: 20%" valign="top">
                         &nbsp;</td>
                </tr>
               <tr>
                    <td colspan="5" valign="top" style="height: 26px">
                        <br /> <br />
                        <h3>Clasificadores:</h3><br /></td>
                </tr>               
                <tr align="center">
                    <td style="width: 20%" valign="top">
                        <asp:HyperLink ID="HyperLink_Tareas" runat="server" 
                            NavigateUrl="~/Lists/Actions.aspx">
        <asp:Image ID="Image_Tareas" runat="server" GenerateEmptyAlternateText="True" 
            ImageAlign="Middle" ImageUrl="~/Images/trabajos.png" />                                                
                        <br />        
        Tareas/Acciones/Eventos
        </asp:HyperLink></td>
                    <td style="width: 20%" valign="top">
                        &nbsp;<asp:HyperLink ID="HyperLink_Areas" runat="server" 
                            NavigateUrl="~/Lists/Areas.aspx">                        
        <asp:Image ID="Image5" runat="server" GenerateEmptyAlternateText="True" ImageAlign="Middle" 
                            ImageUrl="~/Images/partes_todas.png" />                                
        <br />Áreas de Trabajo
        </asp:HyperLink></td>
                    <td style="width: 20%" valign="top">
                        <asp:HyperLink ID="HyperLink_Cargos" runat="server" 
                            NavigateUrl="~/Lists/Positions.aspx">
        <asp:Image ID="Image_Cargos" runat="server" GenerateEmptyAlternateText="True" 
                            ImageAlign="Middle" ImageUrl="~/Images/cargo.png" />
                        <br />Cargos/Puestos
        </asp:HyperLink></td>
                    <td style="width: 20%">
                        <asp:HyperLink ID="HyperLink_Titulos" runat="server" 
                            NavigateUrl="~/Lists/Degrees.aspx">
        <asp:Image ID="Image_Titulos" runat="server" GenerateEmptyAlternateText="True" 
               ImageAlign="Middle" ImageUrl="~/Images/titulo.png" />                        
                                                
                        <br />
        
        Títulos/Estudios Terminados
        </asp:HyperLink></td>
                    <td style="width: 20%">
                        <asp:HyperLink ID="HyperLink_Objetivos" runat="server" 
                            NavigateUrl="~/Lists/ObjetivosFormacion.aspx">                        
                        <asp:Image ID="Image1" runat="server" GenerateEmptyAlternateText="True" 
                             ImageAlign="Middle" ImageUrl="~/Images/target.gif" /> 
         
        <br />Objetivos de Formación</asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td valign="top" colspan="5">
                        <br /> <br />
                    <h3>    Administración del sistema:</h3><br /></td>
                </tr>
                <tr align="center">
                    <td style="width: 20%" valign="top">
                        &nbsp;<asp:HyperLink ID="HyperLink_Users" runat="server" 
                            NavigateUrl="~/Admin/AdminUsers.aspx">
                       <asp:Image ID="Image3" runat="server" GenerateEmptyAlternateText="True" 
                            ImageAlign="Middle" ImageUrl="~/Images/kdmconfig.gif" />
                        
                        <br />
                        
                        Usuarios
                        </asp:HyperLink></td>
                    <td style="width: 20%" valign="top">
                        <asp:HyperLink ID="HyperLink_Config" runat="server" 
                            NavigateUrl="#">
                        <asp:Image ID="Image4" runat="server" GenerateEmptyAlternateText="True" ImageAlign="Middle" 
                            ImageUrl="~/Images/config.gif" />
                        
                        <br />
                        
                        Opciones
                        </asp:HyperLink>&nbsp;</td>
                    <td style="width: 20%" valign="top">
                        &nbsp;</td>
                    <td style="width: 20%" valign="top">
                        &nbsp;</td>
                    <td style="width: 20%" valign="top">
                        &nbsp;</td>
                </tr>
            </table>            
            <br />            
        </LoggedInTemplate>
        <AnonymousTemplate>
        <div id="IndexContainer">
            <div id="InfoColumn">            
                <h4>Organice sus tareas por Planes de Trabajo.</h4>
                <p>
                    Diseñado de acuerdo con la Instrucción Nro 1 del Presidente del Consejo de Estado,
                    el Planificador Online permite organizar el trabajo en planes y tareas a ejecutar ofreciéndole un
                    formato adecuado para su impresión.</p>
                 <h4>Controle el cumplimiento de las tareas a realizar:</h4>
                 <p>
                       El Planificador Web permite a los directivos de la institución organizar, asignar
                       y controlar las tareas u objetivos de trabajo de los subordinados,
                       organizados por área o departamento, sirviendo así como asistente en la evaluación
                       y control.</p>            
                <h4>Accesible a través de la Red:</h4>
                <p>
                    El desarrollo sobre plataforma Web con tecnología de Páginas Activas de Servidor
                    proveen accesibilidad desde cualquier cliente de su red corporativa a través de
                    su navegador de internet preferido, sin necesidad de instalar componentes ni permisos
                    especiales.
                </p>            
               
            </div>
            <div id="LoginFormPlaceHolder">
            <asp:Login ID="Login1" runat="server" Width="100%" DisplayRememberMe="False" LoginButtonText="Aceptar" MembershipProvider="<%$ AppSettings:Proveedor_Membresia_Roles %>" PasswordLabelText="Contraseña :" PasswordRecoveryText="¿ Ha olvidado su contraseña ?" PasswordRecoveryUrl="~/Recover.aspx" TitleText="Entrada al Sistema" UserNameLabelText="Usuario :" DestinationPageUrl="~/Index.aspx" Height="148px" PasswordRequiredErrorMessage="La contraseña es obligatoria." UserNameRequiredErrorMessage="El nombre del usuario es olbigatorio." CssClass="LoginForm" OnLoggedIn="Login1_LoggedIn" OnPreRender="Login1_PreRender" FailureAction="RedirectToLoginPage">            
                  <TitleTextStyle CssClass="Encabezado" />
                  <TextBoxStyle CssClass="Input" />
                  <LoginButtonStyle CssClass="Button" />
                <LayoutTemplate>
                    <table border="0" cellpadding="1" cellspacing="0" style="margin: 0px auto; style: 100%">
                        <tr>
                            <td style="height: 172px">
                                <table border="0" cellpadding="0" style="width: 230px; height: 148px">
                                    <tr>
                                        <td align="center" class="Encabezado" colspan="2">
                                            Entrada al Sistema</td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Usuario :</asp:Label></td>
                                        <td>
                                            <asp:TextBox ID="UserName" runat="server" CssClass="Input" ValidationGroup="ctl07$Login1"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                ErrorMessage="El nombre del usuario es olbigatorio." ToolTip="El nombre del usuario es olbigatorio."
                                                ValidationGroup="ctl07$Login1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Contraseña :</asp:Label></td>
                                        <td>
                                            <asp:TextBox ID="Password" runat="server" CssClass="Input" TextMode="Password" ValidationGroup="ctl07$Login1"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                ErrorMessage="La contraseña es obligatoria." ToolTip="La contraseña es obligatoria."
                                                ValidationGroup="ctl07$Login1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2" style="color: red">
                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                            <asp:Literal ID="Literal_Mnsg2" runat="server" EnableViewState="False" Visible="False"></asp:Literal></td>
                                    </tr>
                                    <tr>
                                        <td align="right" colspan="2">
                                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" CssClass="Button"
                                                Text="Aceptar" ValidationGroup="ctl07$Login1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:HyperLink ID="PasswordRecoveryLink" runat="server" NavigateUrl="~/Recover.aspx">¿ Ha olvidado su contraseña ?</asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
              </asp:Login>    
            </div>
            <img alt="fondo inicio" id="Imagen" src="Images/people.gif" style="left: 20px; width: 242px; top: 25px; height: 195px;" />                        
         </div>
         </AnonymousTemplate>
    </asp:LoginView>            
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="ContenidoOpcional"> 
    <asp:LoginView ID="LoginView1" runat="server">
    <AnonymousTemplate>
     <div class="Noticias">
  <img src="./Images/warning.png" alt="ATENCION" class="left" />  
  <h2>¡Atención!</h2>  
  <h4>Utilidades de la versión 06.11.2012.</h4>
  <p> Ahora usted puede cambiar de fecha una tarea con solo unos clic del ratón. En la 
      vista de <b>&quot;Tareas Planificadas&quot;</b> pruebe arrastrar y cambiar el 
      tamaño de sus tareas.</p>
  </div>
    </AnonymousTemplate>
    </asp:LoginView>
</asp:Content>


