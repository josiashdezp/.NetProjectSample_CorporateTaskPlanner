using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Manage_Manage_SendEmail : System.Web.UI.Page
{
    //Variables que se usan en la página
    internal SqlCommand Command;
    internal SqlConnection Conexion;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count == 0)
        {
            Response.Redirect("~/Index.aspx", true);
        }
        else
        {
            //Configuramos los objetos de conexión y el comand con los datos del WEB.config
            Configuration config = WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);
            ConnectionStringsSection section = (ConnectionStringsSection)config.GetSection("connectionStrings");
            Conexion = new System.Data.SqlClient.SqlConnection(section.ConnectionStrings["BDPlanificadorConnectionString"].ConnectionString);
            Command = new System.Data.SqlClient.SqlCommand();
            Command.Connection = Conexion;

            if (!IsPostBack)
            {
                //Si es la primera vez que se carga, localizamos datos de la tarea. 

            }
        }
    }
    protected void Button_Send_Click(object sender, EventArgs e)
    {
        //Localizamos los trabajadores implicados 
        DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter TAdap_Trab = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
        DataSet_GestorTareas.TrabajadorDataTable Trabajadores = TAdap_Trab.GetDataBy_EjecucionID(Convert.ToInt32(Request.QueryString["id"]));
        DataSet_GestorTareas.TrabajadorRow[] TrabajadoresImplicados = (DataSet_GestorTareas.TrabajadorRow[])Trabajadores.Select("NID <> '" + Session["NID"].ToString() + "'");

        //Creamos lista con direcciones de los RESPONSABLES y EJECUTORES
        List<string> Destinatarios = new List<string>();
        foreach (DataSet_GestorTareas.TrabajadorRow Trabajador in TrabajadoresImplicados) Destinatarios.Add(Membership.GetUser(Trabajador.UserID).Email);

        //Localizamos datos de la ejecucion
        Command.CommandType = CommandType.Text;
        Command.CommandText = "select * from dbo.view_EjecuciondeTareas where EjecucionID = " + Request.QueryString["id"];
        Conexion.Open();

        SqlDataReader TareaEncontrada = Command.ExecuteReader();

        while (TareaEncontrada.Read())
        {
            //Conformamos el contenido del mensaje
            string Cuerpo = "<h2>Notificación de Tareas Pendientes:</h2><hr />" +
                            "<b>Plan:</b>" + TareaEncontrada["NombreAccion"].ToString() + "<br />" +
                            "<b>Tarea:</b>" + TareaEncontrada["NombrePlan"].ToString() + "<br />" +
                            "<b>Descripción:</b> " +
                            "<span>" + TareaEncontrada["Descripcion"] + "</span><br>" +
                            "<b>Detalles:</b> " +
                            "<span>" + TareaEncontrada["Detalles"] + "</span><br>" +
                            "<b>Fecha Planificada:</b>" + TareaEncontrada["FechaPlanificada"] + "<br />" +
                            "<b>Fecha de Vencimiento:</b>" + TareaEncontrada["FechaCierra"] + "<br />" +
                            "<b>Estado:</b>" + TareaEncontrada["Estado"] + "<br />" +
                            "<b>Planificada por:</b>" + TareaEncontrada["PlanificadorNombre"] + "<br />" +
                            "<b>Ejecutante:</b>" + TareaEncontrada["EjecutaNombre"] + "<br />" +
                            "<b>Responsable:</b>" + TareaEncontrada["ResponsableNombre"] + "<br />" +
                            "<b>Observaciones:</b><br><span>" + TextBox_Observaciones.Text +
                            "</span><br /><hr />" +
                            "<center>Planificador Online. Departamento de Automatización y Procedimientos. BANDEC. Cienfuegos. 2010.</center>";

            //Enviamos los EMAILs
            try
            {
                PlanificadorOnline Planificador = new PlanificadorOnline();
                Planificador.EnviarMensajeCorreo(Destinatarios, "Planificador Online. Aviso de tareas pendientes", Cuerpo);
                Label_Mnsg.Text = "Mensaje enviado exitosamente a las " + DateTime.Now.ToString();
                Label_Mnsg.ForeColor = System.Drawing.Color.ForestGreen;
                Label_Mnsg.Visible = true;
            }
            catch (Exception Error)
            {
                Label_Mnsg.Text = Error.Message;
                Label_Mnsg.ForeColor = System.Drawing.Color.Tomato;
                Label_Mnsg.Visible = true;
            }                    
        }        
    }
}
