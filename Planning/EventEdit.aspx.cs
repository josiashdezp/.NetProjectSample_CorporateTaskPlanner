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

public partial class Planning_EventEdit : System.Web.UI.Page
{
    
    //Variables que se usan en la página
    internal SqlCommand Command;
    internal SqlConnection Conexion;

    protected void Page_Load(object sender, EventArgs e)
    {
        /**************************************************************
         *  Al cargar la página se reciben los siguientes datos:       
         *     el identificador de la tarea: id
         *     la acción a ejecutar: op  ( Ejecutar EX, Suspender SS, Reprogramar RP)
         *     el mes:  Mes
         ************************************************************/
        
        //Si la página no es llamada de forma correcta, se redirecciona.
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

            if (!IsPostBack) //Si es la primera vez que se carga. 
            {
                //Inicializar objetos del FORM
                Label_Resultado.Visible = false;
                Label_Resultado.Text = "";                
                
                //Variables que se usan para configurar el DateField.
                string PlanID = "";
                string NID = "";
                string Anio = "";                

                //Controles para el acceso a la BD, vamos a localizar datos de la EJECUCION y del PLAN si es necesario.
                Command.CommandType = CommandType.Text;
                Command.CommandText = "SELECT EjecucionID, PlanID, AnioID, NID, AccionID, NombreAccion, Descripcion, Observaciones,Detalles, FechaPlanificada, FechaEjecutada, TipoAccion, NID_Ejecuta, FechaNotificar, Notificada, Aprobada, EjecutaNombre, Estado, EstadoID FROM view_MostrarPlanEjecuciones where EjecucionID =" + Request.QueryString["id"].ToString();
                Conexion.Open();

                SqlDataReader Tarea = Command.ExecuteReader();
                while (Tarea.Read())
                {
                    //Si lo que se va es a modificar
                    if (Request.QueryString["op"].ToString() == "MD")
                        //Si el que planificó la tarea desea modificarla
                        if (Tarea["NID"].ToString() == Session["NID"].ToString())
                        {
                            // Se pone el comentario de reemplazo de los detalles
                            Label_Observaciones.Text = "(Estas modificaciones remplazarán los detalles actuales.)";
                            Label_Observaciones.Visible = true;
                        }
                        else
                        {
                            //Si no es el que planificó la tarea se adiciona al final de los comentario
                            Label_Observaciones.Text = "(Estas modificaciones se adicionarán después de los detalles orientados por el planificador.)";
                            Label_Observaciones.Visible = true;
                        }
                    else
                        Label_Observaciones.Visible = false;
                        
                    //Mostramos los valores en el FORM
                    Label_Nombre.Text = Tarea["NombreAccion"].ToString();
                    Label_Descripc.Text = Tarea["Descripcion"].ToString();
                    Label_Detalles.Text = Tarea["Detalles"].ToString();
                    TextBox_Observac.Text = Tarea["Observaciones"].ToString(); 
                    

                    //Datos del Plan
                    PlanID = Tarea["PlanID"].ToString();
                    NID = Tarea["NID"].ToString();
                    Anio = Tarea["AnioID"].ToString();

                    //La fecha seleccionada por defecto en el DateField es que tenía inicialmente la Tarea
                    DateField_NuevaFecha.SelectedDate = Convert.ToDateTime(Tarea["FechaPlanificada"]);
                }
                Conexion.Close();

                //Configuramos interfaz del FORM según opción.
                switch (Request.QueryString["op"].ToString())
                {
                    case "PN":
                        Label_Titulo.Text = "Tarea Pendiente";
                        Label_Estado.Text = "Pendiente.";
                        Label_Etiqueta.Text = "Resultado:";

                        TextBox_Observac.Visible = true;
                        Label_Etiqueta.Visible = false;
                        RequiredFieldValidator_Text.Visible = false;

                        Label_Fecha.Visible = false;
                        DateField_NuevaFecha.Visible = false;

                        Label_Hora.Visible = false;
                        TimeField_Hora.Visible = false;

                        RequiredFieldValidator_Text.ErrorMessage = "";

                        break;
                    case "EX":
                        Label_Titulo.Text = "Ejecutar Tarea";
                        Label_Estado.Text = "Ejecutada.";
                        Label_Etiqueta.Text = "Resultado:";

                        TextBox_Observac.Visible = true;
                        Label_Etiqueta.Visible = true;
                        RequiredFieldValidator_Text.Visible = true;

                        Label_Fecha.Visible = false;
                        DateField_NuevaFecha.Visible = false;
                        
                        Label_Hora.Visible = false;
                        TimeField_Hora.Visible = false;
                        
                        RequiredFieldValidator_Text.ErrorMessage = "El resultado de la ejecución es un campo obligatorio.";

                        break;
                    case "SS":
                        Label_Titulo.Text = "Suspender Tarea";
                        Label_Estado.Text = "Suspendida.";
                        Label_Etiqueta.Text = "Causas:";

                        TextBox_Observac.Visible = true;
                        Label_Etiqueta.Visible = true;
                        RequiredFieldValidator_Text.Visible = true;

                        Label_Fecha.Visible = false;
                        DateField_NuevaFecha.Visible = false;

                        Label_Hora.Visible = false;
                        TimeField_Hora.Visible = false;
                        
                        RequiredFieldValidator_Text.ErrorMessage = "Aclare la causa por la que se suspende.";

                        break;
                    case "CF":
                        Label_Titulo.Text = "Cambiar Fecha de Ejecución";
                        Label_Estado.Text = "- No cambia el estado -";

                        TextBox_Observac.Visible = false;
                        Label_Etiqueta.Visible = false;
                        RequiredFieldValidator_Text.Visible = false;

                        Label_Fecha.Visible = true;
                        Label_Hora.Visible = true;
                        DateField_NuevaFecha.Visible = true;
                        TimeField_Hora.Visible = true;
                        goto case "CONFIG-DATE";
                    case "RP":
                        Label_Titulo.Text = "Reprogramar Tarea";
                        Label_Estado.Text = "Reprogramada.";
                        Label_Etiqueta.Text = "Causas:";

                        TextBox_Observac.Visible = true;
                        Label_Etiqueta.Visible = true;
                        RequiredFieldValidator_Text.Visible = true;

                        Label_Fecha.Visible = true;
                        Label_Hora.Visible = true;
                        DateField_NuevaFecha.Visible = true;
                        TimeField_Hora.Visible = true;
                        RequiredFieldValidator_Text.ErrorMessage = "Aclare la causa por la que se reprograma esta tarea.";
                        goto case "CONFIG-DATE";                        
                    case "PG":
                        Label_Titulo.Text = "Tarea en Progreso";
                        Label_Etiqueta.Text = "Desarrollo actual:";
                        Label_Estado.Text = "En progreso.";

                        TextBox_Observac.Visible = true;
                        Label_Etiqueta.Visible = true;
                        RequiredFieldValidator_Text.Visible = true;

                        Label_Fecha.Visible = false;
                        Label_Hora.Visible = false;
                        DateField_NuevaFecha.Visible = false;
                        TimeField_Hora.Visible = false;
                        RequiredFieldValidator_Text.ErrorMessage = "Escriba el desarrollo actual de la tarea.";                        
                        break;
                    case "NT":
                        Label_Titulo.Text = "Notificar Implicados";
                        Label_Etiqueta.Text = "Mensaje:";
                        Label_Estado.Text = "- No cambia de estado - ";

                        TextBox_Observac.Visible = true;
                        Label_Etiqueta.Visible = true;
                        RequiredFieldValidator_Text.Visible = true;

                        Label_Fecha.Visible = false;
                        Label_Hora.Visible = false;
                        DateField_NuevaFecha.Visible = false;
                        TimeField_Hora.Visible = false;
                        RequiredFieldValidator_Text.ErrorMessage = "Especifique el contenido del mensaje.";
                        break;
                    case "CONFIG-DATE":
                        Command.CommandText = "Select FechaInicio, FechaCierre from PlanAcciones where PlanID=" + PlanID + " and Anio='" + Anio + "' and NID='" + NID + "'";
                        Conexion.Open();

                        SqlDataReader Plan = Command.ExecuteReader();
                        Plan.Read();
                        DateTime FechaInicio = Convert.ToDateTime(Plan["FechaInicio"].ToString());
                        DateTime FechaCierre = Convert.ToDateTime(Plan["FechaCierre"].ToString());

                        //Configuramos el control de la fecha para que no salga del rango del plan.
                        DateField_NuevaFecha.MinDate = FechaInicio;
                        DateField_NuevaFecha.MaxDate = FechaCierre;                        
                        Conexion.Close();
                        break;
                    case "MD":
                        Label_Titulo.Text = "Modificar Tarea";
                        Label_Etiqueta.Text = "Detalles para la ejecución:";
                        Label_Estado.Text = "- No cambia de estado - ";

                        TextBox_Observac.Visible = true;
                        Label_Etiqueta.Visible = true;
                        RequiredFieldValidator_Text.Visible = true;

                        Label_Fecha.Visible = false;
                        Label_Hora.Visible = false;
                        DateField_NuevaFecha.Visible = false;
                        TimeField_Hora.Visible = false;
                        RequiredFieldValidator_Text.ErrorMessage = "Especifique los nuevos detalles.";
                        break;
                }               
            }
        }              
    }    
    
    protected void LinkButton_Save_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["op"] == "NT")
        {
            #region Enviar notificación a implicados

            //Localizamos los trabajadores implicados 
            DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter TAdap_Trab = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
            DataSet_GestorTareas.TrabajadorDataTable Trabajadores = TAdap_Trab.GetDataBy_EjecucionID(Convert.ToInt16(Request.QueryString["id"]));
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
                                "<b>Observaciones:</b><br><span>" + TextBox_Observac.Text +
                                "</span><br /><hr />" +
                                "<center>Planificador Online. Departamento de Automatización y Procedimientos. BANDEC. Cienfuegos. 2010.</center>";

                //Enviamos los EMAILs
                try
                {
                    PlanificadorOnline Planificador = new PlanificadorOnline();
                    Planificador.EnviarMensajeCorreo(Destinatarios, "Planificador Online. Aviso de tareas pendientes", Cuerpo);
                    Label_Resultado.Text = "Mensaje enviado exitosamente a las " + DateTime.Now.ToString();
                    Label_Resultado.ForeColor = System.Drawing.Color.ForestGreen;
                    Label_Resultado.Visible = true;
                }
                catch (Exception Error)
                {
                    Label_Resultado.Text = Error.Message;
                    Label_Resultado.ForeColor = System.Drawing.Color.Tomato;
                    Label_Resultado.Visible = true;
                }
            }    

            #endregion
        }
        else if (Request.QueryString["op"] == "CF")
        {
            #region Cambiar la fecha: El que planificó una tarea desea cambiarla de la fecha que la planificó
            //Cambiar fecha
            DataSet_GestorTareasTableAdapters.EjecucionTableAdapter Ejecuc_TableAdapt = new DataSet_GestorTareasTableAdapters.EjecucionTableAdapter();

            //Datos de la fecha y la hora
            DateTime FechaHora;
            if (TimeField_Hora.SelectedItem.Value != "")
            {
                //Si seleccionó una hora se adiciona
                TimeSpan Hora = new TimeSpan(
                 Convert.ToDateTime(TimeField_Hora.SelectedItem.Value).Hour,
                 Convert.ToDateTime(TimeField_Hora.SelectedItem.Value).Minute,
                 Convert.ToDateTime(TimeField_Hora.SelectedItem.Value).Second);

                FechaHora = DateField_NuevaFecha.SelectedDate.Add(Hora);
            }
            else
            {
                //Si no, solo tomamos la fecha.
                FechaHora = DateField_NuevaFecha.SelectedDate;
            }

            try
            {
                Ejecuc_TableAdapt.Update_CambiarFecha(FechaHora,FechaHora, Convert.ToInt32(Request.QueryString["id"].ToString()));
                Label_Resultado.Visible = true;
                Label_Resultado.Text = "Los datos se guardaron exitosamente";
                Label_Resultado.ForeColor = System.Drawing.Color.ForestGreen;
            }
            catch (Exception Error1)
            {
                Label_Resultado.Visible = true;
                Label_Resultado.Text = "Ha ocurrido una excepción. Causa: " + Error1.Message + ". Si este problema persiste contacte su administrador";
                Label_Resultado.ForeColor = System.Drawing.Color.Tomato;
            }
            #endregion
        }
        else if (Request.QueryString["op"] == "MD")
        {
            #region Modificar Tarea: El que planificó o supervisa la tarea desea modificar las instrucciones de ejecución.
             
            //Creamos el TableAdapter e la EJECUCION
            DataSet_GestorTareasTableAdapters.EjecucionTableAdapter Ejecuc_TableAdapt = new DataSet_GestorTareasTableAdapters.EjecucionTableAdapter();
            DataSet_GestorTareas.EjecucionDataTable TablaEjecucion = Ejecuc_TableAdapt.GetDataBy_EjecucionID(Int16.Parse(Request.QueryString["id"].ToString()));

            if (TablaEjecucion[0].NID == Session["NID"].ToString())            
                //Si es el que la PLANIFICA se cambia el contenido de los detalles
                TablaEjecucion[0].Detalles = TextBox_Observac.Text;            
            else            
                //Si no es el que planifica se le adicionan sus observaciones a las ya establecidas.
                TablaEjecucion[0].Detalles += " " + TextBox_Observac.Text;

            try
            {
                Ejecuc_TableAdapt.Update(TablaEjecucion);
                Label_Resultado.Visible = true;
                Label_Resultado.Text = "Los datos se guardaron exitosamente";
                Label_Resultado.ForeColor = System.Drawing.Color.ForestGreen;
            }
            catch (Exception ErrorGuardar)
            {
                Label_Resultado.Visible = true;
                Label_Resultado.Text = "Ha ocurrido una excepción. Causa: " + ErrorGuardar.Message + ". Si este problema persiste contacte su administrador.";
                Label_Resultado.ForeColor = System.Drawing.Color.Tomato;
            }
            #endregion
        }
        else
        {
            #region Cambiar el estado (Incluye, reprogramar, suspender, ejecutar y pendiente...)
            
            // Este es el procedimiento que cambia el estado
            Command.CommandType = CommandType.StoredProcedure;
            Command.CommandText = "stp_CambiarEstadoDeTarea";

            // Conformamos el parámetro de EjecucionID
            SqlParameter EjecucionID = new SqlParameter("EjecucionID", Convert.ToInt32(Request.QueryString["id"].ToString()));
            Command.Parameters.Add(EjecucionID);

            // Conformamos el parámetro NuevoEstado que se toma del QUERYSTRING
            SqlParameter NuevoEstado = new SqlParameter("NuevoEstado", Request.QueryString["op"].ToString());
            Command.Parameters.Add(NuevoEstado);

            #region Manipulación de los datos de fecha y hora.

            object FechaHora;
            if (Request.QueryString["op"].ToString() == "RP")
            {
                if (TimeField_Hora.SelectedItem.Value != "")
                {
                    TimeSpan Hora = new TimeSpan(
                 Convert.ToDateTime(TimeField_Hora.SelectedItem.Value).Hour,
                 Convert.ToDateTime(TimeField_Hora.SelectedItem.Value).Minute,
                 Convert.ToDateTime(TimeField_Hora.SelectedItem.Value).Second);

                    FechaHora = DateField_NuevaFecha.SelectedDate.Add(Hora);
                }
                else
                { FechaHora = DateField_NuevaFecha.SelectedDate; }
            }
            else 
            {
                FechaHora = DBNull.Value;
            }


        #endregion
            
            //Parámetro de NuevaFecha
            SqlParameter NuevaFecha = new SqlParameter("NuevaFecha", FechaHora);
            Command.Parameters.Add(NuevaFecha);

            //Las Observaciones
            SqlParameter Observaciones = new SqlParameter("Observaciones", TextBox_Observac.Text);
            Command.Parameters.Add(Observaciones);

            // Y finalmente se insertan en la BD.
            Conexion.Open();

            try
            {
                Command.ExecuteNonQuery();

                Label_Resultado.Visible = true;
                Label_Resultado.Text = "Los datos se guardaron exitosamente.";
                Label_Resultado.ForeColor = System.Drawing.Color.ForestGreen;
            }
            catch (Exception Error)
            {
                Label_Resultado.Visible = true;
                Label_Resultado.Text = "Ha ocurrido una excepción. Causa: " + Error.Message + ". Si es te problema persiste contacte su administrador";
                Label_Resultado.ForeColor = System.Drawing.Color.Tomato;
            }
            finally
            {
                Conexion.Close();
            }
            #endregion
        }       
    }

    protected void LimpiarFormulario()
    {
        TextBox_Observac.Text = "";
        DateField_NuevaFecha.Clear();
    }        
}
