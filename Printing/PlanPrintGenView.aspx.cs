using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class PlanMonthGeneralPrint : System.Web.UI.Page
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
                string NID = Session["NID"].ToString();  // ESTE VIENE DE SESSION PORQUE ES EL PLAN DEL USUARIO                
                
                #region Datos a Mostrar en las etiquetas de arriba

                Label_Mes.Text = Thread.CurrentThread.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(Request.QueryString["Mes"])).ToUpper() + "  " + Request.QueryString["Anio"];               

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

                Label_Plan.Text = PlanNombre;                

                #endregion

                #region Llenado del CALENDARIO y de los EVENTOS por cada DÍA                             

                //Estos son los datos necesarios para trabajar
                string[] DiasDeLaSemana = Thread.CurrentThread.CurrentCulture.DateTimeFormat.DayNames;
                int DiasDelMes = Thread.CurrentThread.CurrentCulture.Calendar.GetDaysInMonth(Anio, Mes);

                //Contador del día del mes
                int DiaInsertado = 1;

                //Descargar tareas de la BD
                DataSet_Planificador_InformesTableAdapters.MostrarTareasDelMesPorPlanIDTableAdapter Ejec_TableAdap = new DataSet_Planificador_InformesTableAdapters.MostrarTareasDelMesPorPlanIDTableAdapter();
                DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDDataTable TareasDelMes = Ejec_TableAdap.GetData(Mes, PlanID, NID, Anio.ToString());

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
                                NuevaCelda.Text = "<div style=\"text-align:right;font-weight:bold;margin-bottom:5px;\">" + (DiaInsertado).ToString() + "</div>" + "<ul style=\"margin:0 0 0 15px;padding:0;text-align:left;\">";

                                //Estos son los datos de las tareas para ese día.                                
                                string FechaDelDia = new DateTime(Anio, Mes, DiaInsertado).ToString();                                
                                DataRow[] TareasDelDia = TareasDelMes.Select("(Convert(SUBSTRING(Convert(FechaPlanificada,System.String),1,10),System.DateTime) <= Convert('" + FechaDelDia + "',System.DateTime)) and (Convert(SUBSTRING(Convert(FechaCierra,System.String),1,10),System.DateTime) >= Convert('" + FechaDelDia + "',System.DateTime))");
                                                                
                                //Variable que recibe el listado del STRUCT ResultadosCombinados que contiene las tareas del día agrupadas por el ejecutor y el campo de datos agrupados, es decir los nombres de los ejecutantes.
                                List<PlanificadorOnline.ResultadosCombinados> TareasDelDiaAgrupadas = new List<PlanificadorOnline.ResultadosCombinados>();

                                //Si no hay tareas para ese día se pone espacio en blanco.
                                if (TareasDelDia.Length == 0)
                                {
                                    NuevaCelda.Text += "<br>&nbsp;";
                                }
                                else
                                {
                                    //Si hay más de una tarea en el día, le aplicamos agrupamiento por NombreAccion y concatena el campo EjecutaNombre y lo devuelve en los detalles.                                    
                                    if (TareasDelDia.Length > 1)
                                    {
                                        //Preparamos el parámetro del  listado de campos a comparar
                                        string[] CampoAComparar = { "NombreAccion" };

                                        TareasDelDiaAgrupadas = PlanificadorOnline.AgruparCamposPorRegistro(TareasDelDia, CampoAComparar, "OtrosImplicados",true);
                                    }
                                    else
                                    {
                                        PlanificadorOnline.ResultadosCombinados AdicionarDatos = new PlanificadorOnline.ResultadosCombinados();
                                        AdicionarDatos.ObjetoDatos = TareasDelDia[0];

                                        if (TareasDelDia[0]["OtrosImplicados"].ToString() != "")
                                            AdicionarDatos.ObjetoSumado = "(Resp:&nbsp;" + TareasDelDia[0]["OtrosImplicados"] + ")";
                                        else
                                            AdicionarDatos.ObjetoSumado = "";
                                        
                                        TareasDelDiaAgrupadas.Add(AdicionarDatos);
                                    }                                        

                                    //Después de agrupar las filas entonces las escribimos en el cuadro de ese día
                                    for (int i = 0; i < TareasDelDiaAgrupadas.Count; i++)
                                    {
                                        DataRow FilaDatos = (DataRow)TareasDelDiaAgrupadas[i].ObjetoDatos;
                                        
                                        NuevaCelda.Text += "<li>" + FilaDatos["NombreAccion"] + "&nbsp;";

                                        if (TareasDelDiaAgrupadas[i].ObjetoSumado.ToString() != "")
                                            NuevaCelda.Text += "(Resp:&nbsp;" + TareasDelDiaAgrupadas[i].ObjetoSumado + ")";                                        
                                        
                                        NuevaCelda.Text += "</li>";
                                    }
                                }

                                //Adicionamos la celda a la fila.
                                NuevaCelda.Text += "</ul>";
                                NuevaFila.Cells.Add(NuevaCelda);
                                DiaInsertado++;
                            }
                            else
                            {
                                //Las celdas en blanco al principio del calendario.
                                NuevaCelda.Text = "<br>&nbsp;";
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