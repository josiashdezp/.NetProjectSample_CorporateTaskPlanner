using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Printing_ReportPrintCumplimiento : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            if (Session.Count == 0)
            {
                Session.Abandon();
                FormsAuthentication.SignOut();
                Response.Redirect("../Index.aspx", true);
            }
            else
            {
                //Los parámetros que vienen
                int Mes = int.Parse(Request.QueryString["Mes"].ToString());
                int Anio = int.Parse(Request.QueryString["Anio"].ToString());
                short PlanID = short.Parse(Request.QueryString["Plan"].ToString());
                string PlanNombre = "";

                //Este es el valor que se debe mostrar en el textArea.
                string ResumenCualitativo = "",
                    ResumenCausasPorTarea = "";
                
                //Datos estadísticos tomados de la SESSION que se llenaron el MonthView.
                Label_Area.Text = Session["AreaNombre"].ToString();
                TextBox_cumplidas.Text = Session["Cumplidas"].ToString();
                TextBox_incumplidas.Text = Session["Incumplidas"].ToString();
                TextBox_modificadas.Text = Session["Modificadas"].ToString();
                TextBox_planificadas.Text = Session["Planificadas"].ToString();
                TextBox_nuevas.Text = Convert.ToString(0);

                #region Datos del plan

                if (PlanID != 0)
                {
                    DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter TA_Planes = new DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter();
                    DataSet_GestorTareas.PlanAccionesDataTable DT_Plan = TA_Planes.GetDataBy_AnioPlan(PlanID, Anio.ToString());
                    Label_NombrePlan.Text = DT_Plan[0].Nombre.ToUpper();
                }
                else
                {
                    Label_NombrePlan.Text = "Plan de Trabajo";
                }

                #endregion
                
                #region Datos del trabajador

                Label_Fecha.Text = System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(Request.QueryString["Mes"])).ToUpper() + "/" + Request.QueryString["Anio"];

                //Table Adapters para descargar los datos del trabajador
                DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter TA_Trabajador = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
                DataSet_GestorTareas.TrabajadorDataTable Trabajador = TA_Trabajador.GetDataBy_NID(Session["NID"].ToString());

                DataSet_GestorTareasTableAdapters.CargoTableAdapter TA_Cargo = new DataSet_GestorTareasTableAdapters.CargoTableAdapter();
                DataSet_GestorTareas.CargoDataTable Cargo = TA_Cargo.GetDataBy_CargoID(Trabajador[0].CargoID);             

                //Mostramos en el label.                
                Label_Trabajador.Text = Trabajador[0].NombreCompleto + ".&nbsp;&nbsp;" + Cargo[0].Cargo;

                #endregion

                #region Obtengo las tareas suspendidas con todos sus datos (Se cuentan las Suspendidas y Pendientes)

                //Descargar tareas de la BD y ya vienen ordenadas ascendentemente por fecha planificada
                DataSet_Planificador_InformesTableAdapters.MostrarTareasDelMesPorPlanIDTableAdapter Ejec_TableAdap = new DataSet_Planificador_InformesTableAdapters.MostrarTareasDelMesPorPlanIDTableAdapter();
                DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDDataTable TareasDelMes = Ejec_TableAdap.GetData(Mes, PlanID, Session["NID"].ToString(), Anio.ToString());                
                DataRow[] TareasSuspendidasDelMes = TareasDelMes.Select("Estado='Suspendida' or Estado='Pendiente'","NombreAccion asc"); 

                #endregion

                #region Obtenemos las observaciones y las mostramos en el HiddenField para mostrarlas en el Cliente.

                if (TareasSuspendidasDelMes.Length != 0)
                {
                    //Si es diferente de 0 es que hay tareas suspendidas 
                    #region Agrupar las causas por tarea suspendida

                    //Preparamos el parámetro del  listado de campos a comparar. En este caso solo será por NombreAccion.
                    string[] CompararPorAccion = { "NombreAccion" };

                    //Variable que recibe el listados del STRUCT ResultadosCombinados.
                    List<PlanificadorOnline.ResultadosCombinados> CausasPorTareas = new List<PlanificadorOnline.ResultadosCombinados>();
                    CausasPorTareas = PlanificadorOnline.AgruparCamposPorRegistro(TareasSuspendidasDelMes, CompararPorAccion, "Observaciones",true);

                    #endregion

                    #region Agrupar los ejecutantes por cada causa de tarea suspendida

                    //Preparamos el parámetro del  listado de campos a comparar
                    string[] CompararPorCampos = { "NombreAccion","Observaciones" };

                    //Variable que recibe el listados del STRUCT ResultadosCombinados.
                    List<PlanificadorOnline.ResultadosCombinados> EjecutantesPorCausa = new List<PlanificadorOnline.ResultadosCombinados>();
                    EjecutantesPorCausa = PlanificadorOnline.AgruparCamposPorRegistro(TareasSuspendidasDelMes, CompararPorCampos, "EjecutaNombre",true);

                    #endregion

                    //Dos variables necesarias para mostrar los resultados apropiadamente en el TextArea.
                    Char CambioLinea = (char)13;
                    byte Indice = 0;
                    int ContadorTareas = CausasPorTareas.Count;
                    int ContadorCausas = EjecutantesPorCausa.Count;
                    bool EndOfFile = false;

                    
                    for (int i = 0; i < ContadorTareas; i++)
                    {
                        
                        DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow TareasAgrupaCausas = (DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow)CausasPorTareas[i].ObjetoDatos;
                        string EstadoCausaAnterior = "";

                        for (int j = 0; j < ContadorCausas; j++)
                        {                            
                            DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow CausasAgrupaEjecutantes = (DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow)EjecutantesPorCausa[j].ObjetoDatos;
                            
                            DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow CausasAgrupaEjecutantesSiguiente; 
                            if (j< ContadorCausas-1)
                            {
                                  //DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow CausasAgrupaEjecutantesSiguiente = (DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow)EjecutantesPorCausa[j+1].ObjetoDatos;
                            }
                            else
                            {
                                //DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow CausasAgrupaEjecutantesSiguiente = (DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow)EjecutantesPorCausa[j].ObjetoDatos;
                            } 


                            //Si el nombre de la TAREA son iguales en ambos grupos de registros es que estamos trabajando con las causas de esa tarea.
                            if (TareasAgrupaCausas.NombreAccion == CausasAgrupaEjecutantes.NombreAccion)
                            {
                                Indice++;

                              //  if (CausasAgrupaEjecutantes.Observaciones == CausasAgrupaEjecutantesSiguiente.Observaciones)
                              //  { }


                                string Observaciones = (CausasAgrupaEjecutantes.Observaciones == "") ? "No se especifican las causas." : CausasAgrupaEjecutantes.Observaciones;

                                //La primera vez se pone el encabezado
                                    if (j == 0)
                                    {
                                        EstadoCausaAnterior = CausasAgrupaEjecutantes.Estado;
                                        ResumenCausasPorTarea += Indice.ToString() + ". " + TareasAgrupaCausas.NombreAccion + "  (" + CausasAgrupaEjecutantes.Estado + ")" + CambioLinea.ToString() + "   Causas: ";
                                    }
                                    else
                                    {
                                        DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow CausasAgrupaEjecutantesAnterior = (DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow)EjecutantesPorCausa[j-1].ObjetoDatos;
                                        EstadoCausaAnterior = CausasAgrupaEjecutantesAnterior.Estado;
                                    }
                                

                                if (CausasAgrupaEjecutantes.Estado != EstadoCausaAnterior)
                                {
                                    ResumenCausasPorTarea += (Indice + 1).ToString() + ". " + TareasAgrupaCausas.NombreAccion + "  (" + CausasAgrupaEjecutantes.Estado + ")" + CambioLinea.ToString() + "   Causas: ";
                                    ResumenCausasPorTarea += Observaciones + " (" + EjecutantesPorCausa[j].ObjetoSumado + ")" + CambioLinea.ToString() + CambioLinea.ToString();
                                }
                                else
                                {
                                    ResumenCausasPorTarea += Observaciones + " (" + EjecutantesPorCausa[j].ObjetoSumado + ")" + CambioLinea.ToString() + CambioLinea.ToString();
                                }
                            }
                        }
                       
                        ResumenCualitativo += ResumenCausasPorTarea;
                        ResumenCausasPorTarea = "";
                    }
                    
                }
                else
                {
                    //Si no hay tareas suspendidas mostramos un mensaje.
                    ResumenCualitativo = "En este mes no se suspendieron tareas.";
                }                
                
                //Creamos el objeto HiddenField desde donde se tomarán los datos en el cliente.
                ClientScript.RegisterHiddenField("HiddenDetalles", ResumenCualitativo);

                #endregion
            }            
        }
        else        
            Response.Redirect("../Index.aspx", true);        
    }    
}
