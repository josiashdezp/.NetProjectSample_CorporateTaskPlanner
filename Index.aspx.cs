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

public partial class Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((bool)Application["ApplicationConfigured"])
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                string[] UserRole = Roles.GetRolesForUser();                
                
                HyperLink Planes = (HyperLink)LoginView_Main.FindControl("HyperLink_Planes");
                
                HyperLink Control = (HyperLink)LoginView_Main.FindControl("HyperLink_Control");
                HyperLink Users = (HyperLink)LoginView_Main.FindControl("HyperLink_Users");
                HyperLink Config = (HyperLink)LoginView_Main.FindControl("HyperLink_Config");

                HyperLink Objetivos = (HyperLink)LoginView_Main.FindControl("HyperLink_Objetivos");
                
                
                HyperLink Cargos = (HyperLink)LoginView_Main.FindControl("HyperLink_Cargos");
                HyperLink Areas = (HyperLink)LoginView_Main.FindControl("HyperLink_Areas");
                HyperLink Titulos = (HyperLink)LoginView_Main.FindControl("HyperLink_Titulos");
                HyperLink Tareas = (HyperLink)LoginView_Main.FindControl("HyperLink_Tareas");                

                switch (UserRole[0].ToLower())
                {
                    case "administrador":
                        Planes.Enabled = false;
                        Objetivos.Enabled = false;
                        Control.Enabled = false;
                        Users.Enabled = true;
                        Config.Enabled = true;

                        Cargos.Enabled = true;
                        Areas.Enabled = true;
                        Titulos.Enabled = true;
                        Tareas.Enabled = false;
                        break;
                    case "jefe":
                        Planes.Enabled = true;
                        Objetivos.Enabled = true;
                        Control.Enabled = true;
                        Users.Enabled = true;
                        Config.Enabled = false;

                        Cargos.Enabled = true;
                        Areas.Enabled = true;
                        Titulos.Enabled = true;
                        Tareas.Enabled = true;
                        break;
                    case "trabajador":
                        Planes.Enabled = true;
                        Objetivos.Enabled = false;
                        Control.Enabled = false;
                        Users.Enabled = false;
                        Config.Enabled = false;

                        Cargos.Enabled = false;
                        Areas.Enabled = false;
                        Titulos.Enabled = false;
                        Tareas.Enabled = true;
                        break;
                }
            }

            if (!Page.IsPostBack)
                if (Request.QueryString["error"] != null)
                {
                    Login LoginForm = (Login)LoginView_Main.FindControl("Login1");
                    Literal Mensaje = (Literal)LoginForm.FindControl("Literal_Mnsg2");
                    Mensaje.Text = "Error de acceso.<br>Causa:" + Session["error"].ToString() + "<br> Contacte su administrador de red.";
                    Mensaje.Visible = true;
                    Session.Abandon();
                }
        }
        else
        {
            Server.Transfer("ConfigApplication.aspx", false);
        }            
    }

    protected void Login1_LoggedIn(object sender, EventArgs e)
    {
        Login The_Login = (Login)LoginView_Main.FindControl("Login1");

        //Guardamos en la session los datos de acceso del usuario: NID, AreaID y AreaNombre.
        MembershipUser Usuario = Membership.GetUser(The_Login.UserName);

        if (Roles.IsUserInRole(Usuario.UserName,"Administrador"))
        {
            Session.Add("AreaID", "-" );
            Session.Add("AreaNombre", "-");
            Session.Add("NID", "00000000000");
        }
        else
        {
            try
            {
                DataSet_GestorTareasTableAdapters.MostrarDatosdeAccesoDelTrabajadorTableAdapter TableAdapt_DatosDeAcceso = new DataSet_GestorTareasTableAdapters.MostrarDatosdeAccesoDelTrabajadorTableAdapter();
                DataSet_GestorTareas.MostrarDatosdeAccesoDelTrabajadorDataTable DatosDeAcceso = TableAdapt_DatosDeAcceso.GetData_MostrarDatosDeAcceso(Usuario.ProviderUserKey.ToString());

                if (DatosDeAcceso.Count > 0)
                {
                    Session.Add("AreaID", DatosDeAcceso[0].AreaID);
                    Session.Add("AreaNombre", DatosDeAcceso[0].AreaNombre);
                    Session.Add("NID", DatosDeAcceso[0].NID);
                }
                else
                {
                    throw new Exception("El usuario \""+ Usuario.UserName +"\" no está registrado como trabajador en el sistema.");
                }
            }
            catch (Exception Error)
            {                
                FormsAuthentication.SignOut();
                Session.Add("error", Error.Message);
                Response.Redirect("Index.aspx?error=1");                
            }
        }
    }
    
    protected void Login1_PreRender(object sender, EventArgs e)
    {
        Login MyLogin = (Login)sender;
        MyLogin.Focus();
    }

    //Este es el procedimiento usado por el control SUBSTITUCION para refrescar la lista de noticias.
    private void DescargarNoticias()
    { }
    protected void HyperLink_AdminPlanes_Load(object sender, EventArgs e)
    {
        HyperLink AdminPlanes = sender as HyperLink;
        if (AdminPlanes != null)
            AdminPlanes.NavigateUrl += "?Anio=" + DateTime.Today.Year.ToString();
    }
}