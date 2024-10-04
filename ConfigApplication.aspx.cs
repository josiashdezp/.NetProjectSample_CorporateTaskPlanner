using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class FirstUseConfig : System.Web.UI.Page
{
    //Al cargar inicializamos algunos controles de la página
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) Label_Msg.Visible = false;
    }

    //Guardar configuración de la aplicación en el Web.Config AppSettings.
    protected void Button_Save_Click(object sender, EventArgs e)
    {

        //TODO  Sería bueno escribir todas las operaciones en el LOG de instalación para poder consultarlo si ocurre un problema.
        try
        {
            //Abrimos el Web.config
            System.Configuration.Configuration AppWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);

            //Localizamos las secciones que necesitamos modificar
            System.Configuration.KeyValueConfigurationElement InstitucionNombre = AppWebConfig.AppSettings.Settings["InstitucionNombre"];
            System.Configuration.KeyValueConfigurationElement InstitucionAbreviatura = AppWebConfig.AppSettings.Settings["InstitucionAbreviatura"];
            System.Configuration.KeyValueConfigurationElement InstitucionDireccion = AppWebConfig.AppSettings.Settings["InstitucionDireccion"];
            System.Configuration.KeyValueConfigurationElement DependenciaNombre = AppWebConfig.AppSettings.Settings["DependenciaNombre"];
            System.Configuration.KeyValueConfigurationElement DependenciaDireccion = AppWebConfig.AppSettings.Settings["DependenciaDireccion"];
            System.Configuration.KeyValueConfigurationElement SuperUsuario = AppWebConfig.AppSettings.Settings["SuperUsuario"];

            #region Datos del Sistema.

            //Asignamos lo valores que identifican la institución y la entidad
            InstitucionNombre.Value = TextBox_NombreInstituc.Text;
            InstitucionAbreviatura.Value = TextBox_AbrevInstituc.Text;
            InstitucionDireccion.Value = TextBox_DireccionInstituc.Text;

            DependenciaNombre.Value = TextBox_NombreDependenc.Text;
            DependenciaDireccion.Value = TextBox_DireccionDependenc.Text;

            #endregion

            #region Datos del administrador de red. Si no se puede crear la cuenta se genera la excepción

            if (SuperUsuario.Value == "")
            {
                MembershipCreateStatus Resultado;
                MembershipUser Administrador = Membership.CreateUser(TextBox_Usuario.Text, TextBox_PasswordConfirm.Text, TextBox_Email.Text, TextBox_SegPregunta.Text, TextBox_SegRespuesta.Text, true, out Resultado);

                //Si no se pudo crear la cuenta del administrador, se genera la excepción con el mensaje, de lo contrario, actualizamos la variable de configuración.
                if (Administrador == null)
                    throw new Exception("No se pudo crear la cuenta de administrador. Causa: " + PlanificadorOnline.MostrarMensajesDeValidacion(Resultado));
                else
                {
                    SuperUsuario.Value = Administrador.UserName;
                }
                    
            }

            #endregion

            //Guardamos los cambios.
            AppWebConfig.Save(ConfigurationSaveMode.Modified);

            //Establcemos la variable como que se configuró el sistema.
            Application["ApplicationConfigured"] = true;

            //Mostramos el mensaje
            Label_Msg.Text = "Configuración guardada exitosamente. Puede comenzar a utilizar a aplicación";
            Label_Msg.ForeColor = System.Drawing.Color.ForestGreen;
            Label_Msg.Visible = true;

            //Finalmente activamos el botón para ir a la página principal
            Button_Continue.Enabled = true;
        }
        catch (Exception Error)
        {
            //Si ocurre algún error.
            Label_Msg.Text = "No se pudo guardar la configuración del sistema. Causa:" + Error.Message;
            Label_Msg.ForeColor = System.Drawing.Color.Tomato;
            Label_Msg.Visible = true;

            Application["ApplicationConfigured"] = false;
        }
    }
    
    //Ir a la página de Login.
    protected void Button_Continue_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Index.aspx");
    }
}
