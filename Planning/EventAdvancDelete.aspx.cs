using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EventAdvancedDelete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count == 0)
            Response.Redirect("~/Index.aspx", true);
        else
        {
            if (!Page.IsPostBack)
            {
                //Recogemos la ID del querystring
            int EjecID = int.Parse(Request.QueryString["id"].ToString());

            //Localizamos en el WEB.CONFIG la cadena de conexión a la BD del PlanificadorOnline            
            System.Configuration.Configuration SiteWebConfigFile = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(AppRelativeVirtualPath);
            System.Configuration.ConnectionStringSettings ConnString;
            ConnString = SiteWebConfigFile.ConnectionStrings.ConnectionStrings["BDPlanificadorConnectionString"];

            //Creamos el control de acceso a datos
            SqlCommand Command = new SqlCommand();
            SqlConnection Conexion = new SqlConnection(ConnString.ConnectionString);

            //Datos para leer las informaciones
            Command.Connection = Conexion;
            Command.CommandType = System.Data.CommandType.Text;
            Command.CommandText = "SELECT     NombreAccion, FechaPlanificada, FechaEjecutada, FechaNotificar FROM view_MostrarPlanEjecuciones WHERE EjecucionID = " + Request.QueryString["id"].ToString() + "AND NID = '" + Session["NID"] + "'";
            

            //Conectamos y leemos los datos que vamos a mostrar y terminamos la conexion
            Conexion.Open();
            SqlDataReader Tarea = Command.ExecuteReader();
            while (Tarea.Read())
            {
                Label_Nombre.Text = Tarea["NombreAccion"].ToString();
                DateField_Desde.SelectedDate = new DateTime(Convert.ToDateTime(Tarea["FechaPlanificada"].ToString()).Year, Convert.ToDateTime(Tarea["FechaPlanificada"].ToString()).Month, 1);
                DateField_Hasta.SelectedDate = new DateTime(Convert.ToDateTime(Tarea["FechaPlanificada"].ToString()).Year, Convert.ToDateTime(Tarea["FechaPlanificada"].ToString()).Month, 1);
            }
            Conexion.Close();
            }                        
        }
    }

    protected void LinkButton_Aceptar_Click(object sender, EventArgs e)
    {
        DataSet_GestorTareasTableAdapters.EjecucionTableAdapter TAEjecucion = new DataSet_GestorTareasTableAdapters.EjecucionTableAdapter();
        string Resultado = "";

        try
        {
            switch (int.Parse(RadioButtonList_Delete.SelectedItem.Value.ToString()))
            {
                case 0:  //Si es 0 es borrar solo una tarea.

                    if (TAEjecucion.Delete(int.Parse(Request.QueryString["id"])) == 1)
                    {
                        Resultado = "Tarea borrada exitosamente,";
                        Label_Msg.ForeColor = System.Drawing.Color.ForestGreen;
                    }
                        
                    break;

                case 1: //Si es 1 es borrar la tarea seleccionada en el rango.
                    if (CustomValidator_Desde.IsValid && CustomValidator_Hasta.IsValid)
                    {
                        Resultado = "Total de programaciones borradas: " + TAEjecucion.Delete_TareasProgramadasPorUsuario(Session["NID"].ToString(), int.Parse(Request.QueryString["id"]), Convert.ToDateTime(DateField_Desde.SelectedValue), Convert.ToDateTime(DateField_Hasta.SelectedValue)).ToString() + ".<br>Tarea completada exitosamente.";
                        Label_Msg.ForeColor = System.Drawing.Color.ForestGreen;
                    }
                    else
                    {
                        throw new Exception("Datos incompletos");
                    }
                    break;
            }
        }
        catch (SqlException Error)
        {
            Resultado = "Ha ocurrido una excepción. Mensaje:" + Error.Message;
            Label_Msg.ForeColor = System.Drawing.Color.Tomato;
        }
        finally
        {
            Label_Msg.Visible = true;
            Label_Msg.Text = Resultado;
        }
    }

}
