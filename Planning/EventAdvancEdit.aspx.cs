using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Planning_EventMove : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count > 0)
        {
            if (!Page.IsPostBack)
            {
                //Recogemos la ID del querystring
                int EjecID = int.Parse(Request.QueryString["id"].ToString());

                /*            

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
                   
                 */



                DataSet_Planificador_InformesTableAdapters.view_EjecucionDeTareasTableAdapter TableAdapt_Ejecuc = new DataSet_Planificador_InformesTableAdapters.view_EjecucionDeTareasTableAdapter();
                DataSet_Planificador_Informes.view_EjecucionDeTareasDataTable TablaEjecucion = TableAdapt_Ejecuc.GetDataBy_EjecucionID(EjecID);

                
                
                if (TablaEjecucion.Rows.Count > 0)
                {
                    Label_Nombre.Text = TablaEjecucion[0]["NombreAccion"].ToString();
                    Label_Fecha.Text = TablaEjecucion[0]["FechaPlanificada"].ToString();
                    TextBox_Detalles.Text = TablaEjecucion[0]["Detalles"].ToString();
                    TextBox_Implicados.Text = TablaEjecucion[0]["OtrosImplicados"].ToString();

                    DateField_Desde.SelectedDate = new DateTime(TablaEjecucion[0].FechaPlanificada.Year,TablaEjecucion[0].FechaPlanificada.Month,1);
                    DateField_Hasta.SelectedDate = new DateTime(TablaEjecucion[0].FechaPlanificada.Year,TablaEjecucion[0].FechaPlanificada.Month,1);
                }
                else
                {
                    Label_Mnsg.Text = "No es posible mostrar los datos de la tarea seleccionada.<br>Refresque la página y si este problema persiste contacte su administrador de red.";
                }
            }
        }
        else
        {
            Response.Redirect("~/Index.aspx", true);
        }
    }   

    protected void LinkButton_Aceptar_Click(object sender, EventArgs e)
    {
        DataSet_GestorTareasTableAdapters.EjecucionTableAdapter TAEjecucion = new DataSet_GestorTareasTableAdapters.EjecucionTableAdapter();
        string Resultado = "";

        try
        {
            switch (int.Parse(RadioButtonList_Modificar.SelectedItem.Value.ToString()))
            {
                case 0:  //Si es 0 es modificar solo una tarea.

                    if (TAEjecucion.Update_CambiarDetalles(TextBox_Detalles.Text, int.Parse(Request.QueryString["id"])) == 1)
                    {
                        Label_Mnsg.ForeColor = System.Drawing.Color.ForestGreen;
                        Resultado = "Se actualizaron los detalles exitosamente.<br>";
                    }

                    if (TAEjecucion.Update_CambiarOtrosImplicados(TextBox_Implicados.Text, int.Parse(Request.QueryString["id"])) == 1)
                    {
                        Resultado += "Se actualizaron los implicados exitosamente.";
                        Label_Mnsg.ForeColor = System.Drawing.Color.ForestGreen;
                    }
                    break;

                case 1: //Si es 1 es modificar la tarea seleccionada en el rango.
                    if ((!DateField_Desde.IsNull)&& (!DateField_Hasta.IsNull))
                    {
                        Resultado = "Se actualizaron " + TAEjecucion.Update_CambiarDetallesDeTareasEnRango(TextBox_Detalles.Text,DateField_Desde.SelectedDate,DateField_Hasta.SelectedDate,Session["NID"].ToString(), int.Parse(Request.QueryString["id"])) + " detalles exitosamente.<br>";
                        Resultado += "Se actualizaron " + TAEjecucion.Update_ImplicadosDeTareasEnRango(TextBox_Implicados.Text,DateField_Desde.SelectedDate,DateField_Hasta.SelectedDate,Session["NID"].ToString(), int.Parse(Request.QueryString["id"])) + " implicados exitosamente.";
                        Label_Mnsg.ForeColor = System.Drawing.Color.ForestGreen;                         
                    }
                    else
                    {
                        throw new Exception("Datos incompletos");
                    }
                    break;
            }
        }
        catch (Exception Error)
        {
            Resultado = "Ha ocurrido una excepción. Causa: " + Error.Message;
            Label_Mnsg.ForeColor = System.Drawing.Color.Tomato;
        }
        finally
        {
            Label_Mnsg.Visible = true;
            Label_Mnsg.Text = Resultado;
        }
    }
    protected void CallbackPanel_EventMove_Callback(object source, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
    {

    }
}
