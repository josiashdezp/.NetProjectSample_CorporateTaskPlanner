using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Collections;
using System.Configuration;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Pruebas_PlanMonthViewPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Page.User.Identity.IsAuthenticated) && (Session.Count > 0))
        {
            if (Request.QueryString.Count != 0)
            {
                //Los parámetros que vienen
                int Mes = int.Parse(Request.QueryString["Mes"].ToString());
                int Anio = int.Parse(Request.QueryString["Anio"].ToString());
                short PlanID = short.Parse(Request.QueryString["Plan"].ToString());
                string PlanNombre = "";
                bool Wk = (Request.QueryString["Wk"].ToString() == "1") ? true : false;
                string NID = Request.QueryString["NID"].ToString();  // ESTE VIENE DE REQUEST PORQUE ES EL QUE SE SELECCIONE.                
                
                #region Datos a Mostrar en las etiquetas de arriba

                Label_Mes.Text = Thread.CurrentThread.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(Request.QueryString["Mes"])).ToUpper() + "  " + Request.QueryString["Anio"];

                DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter TA_Trabajador = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
                DataSet_GestorTareas.TrabajadorDataTable Trabajador = TA_Trabajador.GetDataBy_NID(Request.QueryString["NID"].ToString());

                DataSet_GestorTareasTableAdapters.CargoTableAdapter TA_Cargo = new DataSet_GestorTareasTableAdapters.CargoTableAdapter();
                DataSet_GestorTareas.CargoDataTable Cargo = TA_Cargo.GetDataBy_CargoID(Trabajador[0].CargoID);

                if (PlanID == 0)
                {
                    PlanNombre = "PLAN DE TRABAJO";
                }
                else
                {
                    DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter TA_Planes = new DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter();
                    DataSet_GestorTareas.PlanAccionesDataTable Plan = TA_Planes.GetDataBy_AnioPlan(PlanID, Anio.ToString());
                    PlanNombre = Plan[0].Nombre.ToUpper();
                }    
                
                Label_Nombre.Text = Trabajador[0].NombreCompleto;
                Label_Cargo.Text = Cargo[0].Cargo;
                Label_Plan.Text = PlanNombre.ToUpper();

                #endregion

                #region Llenado del CALENDARIO y de los EVENTOS por cada DÍA               
                
                //Estos son los datos necesarios para trabajar
                string[] DiasDeLaSemana = Thread.CurrentThread.CurrentCulture.DateTimeFormat.DayNames;
                int DiasDelMes = Thread.CurrentThread.CurrentCulture.Calendar.GetDaysInMonth(Anio, Mes);

                //Contador del día del mes
                int DiaInsertado = 1;

                /***************************************************************
                 * ESTA SECCIÓN ES PARA DESCARGAR DE LA BD LAS TAREAS DEL MES. *
                 * *************************************************************/

                //Cambiar a ver las tareas del MES pero las que no son PRIVADAS
                DataSet_Planificador_InformesTableAdapters.MostrarEjecucionDeTareasPorTrabajadorTableAdapter Ejec_TableAdap = new DataSet_Planificador_InformesTableAdapters.MostrarEjecucionDeTareasPorTrabajadorTableAdapter();
                DataSet_Planificador_Informes.MostrarEjecucionDeTareasPorTrabajadorDataTable TareasDelMes = Ejec_TableAdap.GetData_EjecucionDeTareasPorTrabajador(Anio.ToString(), Mes, PlanID, NID, Session["NID"].ToString());

                //Mientras los días registrados no sean todos los días del mes
                while (DiaInsertado <= DiasDelMes)
                {
                    // Fila de la semana a insertar
                    TableRow NuevaFila = new TableRow();

                    //Ciclo para insertar los días de la semana. De 1 a 7 para hacer de Lunes a Viernes. 
                    for (int indDiaDeSemana = 1; indDiaDeSemana <= 7; indDiaDeSemana++)
                    {
                        //Creamos la celda del día con el formato apropiado
                        TableCell NuevaCelda = new TableCell();
                        NuevaCelda.BorderColor = System.Drawing.Color.Black;
                        NuevaCelda.BorderStyle = BorderStyle.Solid;
                        NuevaCelda.BorderWidth = Unit.Pixel(1);
                        NuevaCelda.VerticalAlign = VerticalAlign.Top;
                        NuevaCelda.HorizontalAlign = HorizontalAlign.Justify;


                        //Si al cambiar de día de la semana el día a insertar es mayor que la cantidad de días del mes, se adicionan celdas en blanco.
                        if (DiaInsertado > DiasDelMes)
                        {
                            NuevaCelda.Text = "&nbsp;";
                            NuevaFila.Cells.Add(NuevaCelda);
                        }
                        else
                        {
                            //Verificamos que el nombre del día del mes a insertar se corresponda con el de la semana                    
                            if (DiasDeLaSemana[indDiaDeSemana - 1] == Thread.CurrentThread.CurrentCulture.DateTimeFormat.GetDayName(Thread.CurrentThread.CurrentCulture.Calendar.GetDayOfWeek(new DateTime(Anio, Mes, DiaInsertado))))
                            {
                                //Ponemos el número a la celda del día
                                NuevaCelda.Text = (DiaInsertado).ToString() + "<br>";

                                //Estos son los datos de las tareas para ese día.
                                string FechaDelDia = new DateTime(Anio, Mes, DiaInsertado).ToShortDateString();
                                DataRow[] TareasDelDia = TareasDelMes.Select("FechaPlanificada = '" + FechaDelDia + "'"); //or " + new DateTime(Anio, Mes, DiaInsertado).ToShortDateString() + "between FechaPlanificada and FechaCierra");

                                if (TareasDelDia.Length == 0)
                                {
                                    NuevaCelda.Text += "&nbsp;";
                                }
                                else
                                {
                                    for (int i = 0; i < TareasDelDia.Length; i++)
                                    {
                                        NuevaCelda.Text += "&#8226;&nbsp;&nbsp;" + TareasDelDia[i]["NombreAccion"] + "<br>";
                                        NuevaCelda.Text += TareasDelDia[i]["Detalles"] + "<br>";

                                        //Si es de rango ponemos el rango si no cerramos la lista
                                        if (Convert.ToDateTime(TareasDelDia[i]["FechaPlanificada"]) < Convert.ToDateTime(TareasDelDia[i]["FechaCierra"]))
                                            NuevaCelda.Text += "( Del " + Convert.ToDateTime(TareasDelDia[i]["FechaPlanificada"]).Day.ToString() + " al " + Convert.ToDateTime(TareasDelDia[i]["FechaCierra"]).Day.ToString() + ")";
                                    }
                                }                                

                                //Adicionamos la celda a la fila.
                                NuevaFila.Cells.Add(NuevaCelda);
                                DiaInsertado++;
                            }
                            else
                            {
                                //Las celdas en blanco al principio del calendario.
                                NuevaCelda.Text = "&nbsp;";
                                NuevaFila.Cells.Add(NuevaCelda);
                                continue;
                            }
                        }
                    }
                    Table_Month.Rows.Add(NuevaFila);
                }

                //Si no se muestran los fines de semana recorremos la tabla y ocultamos las últimas celdas de cada fila.
                if (!Wk)
                {
                    for (int j = 0; j < Table_Month.Rows.Count; j++)
                    {
                        Table_Month.Rows[j].Cells[0].Visible = false;
                        Table_Month.Rows[j].Cells[Table_Month.Rows[j].Cells.Count - 1].Visible = false;
                    }
                }
                #endregion
            }
            else
            {
                Response.Redirect("~/Index.aspx");
            }
        }
        else
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Index.aspx");
        }       
    }
}