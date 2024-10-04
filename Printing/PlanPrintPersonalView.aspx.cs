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

public partial class Pruebas_PlanPersonalViewPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Page.User.Identity.IsAuthenticated) && (Session.Count > 0))
        {
            if (Request.QueryString.Count != 0)
            {
                #region Los parámetros que vienen
                int Mes = int.Parse(Request.QueryString["Mes"].ToString());
                int Anio = int.Parse(Request.QueryString["Anio"].ToString());
                short PlanID = short.Parse(Request.QueryString["Plan"].ToString());
                
                bool Wk = (Request.QueryString["Wk"].ToString() == "1") ? true : false;
                string NID = Session["NID"].ToString();  // ESTE VIENE DE SESSION PORQUE ES EL PLAN DEL USUARIO                                 
                #endregion

                #region Datos del Trabajador 
                Label_Mes.Text = Thread.CurrentThread.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(Request.QueryString["Mes"])).ToUpper() + "  " + Request.QueryString["Anio"];

                //Table Adapters para descargar los datos de la BD
                DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter TA_Trabajador = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
                DataSet_GestorTareasTableAdapters.CargoTableAdapter TA_Cargo = new DataSet_GestorTareasTableAdapters.CargoTableAdapter();

                // Buscamos la información necesaria
                DataSet_GestorTareas.TrabajadorDataTable Trabajador = TA_Trabajador.GetDataBy_NID(Session["NID"].ToString());
                DataSet_GestorTareas.CargoDataTable Cargo = TA_Cargo.GetDataBy_CargoID(Trabajador[0].CargoID);

                //Llenamos las etiquetas
                Label_Nombre.Text = Trabajador[0].NombreCompleto;
                Label_Cargo.Text = Cargo[0].Cargo;

                #endregion

                #region Datos del Jefe Inmediato                
                
                //Localizar los datos del Jefe
                Trabajador = TA_Trabajador.GetDataBy_BuscarJefe(Session["NID"].ToString());                
                Cargo = TA_Cargo.GetDataBy_CargoID(Trabajador[0].CargoID);
                
                //Mostrar en las etiquetas
                Label_NombreJefe.Text = Trabajador[0].NombreCompleto;
                Label_CargoJefe.Text = Cargo[0].Cargo;                

                #endregion                

                #region Carga da datos de las Tareas desde la BD                
                
                DataSet_Planificador_InformesTableAdapters.MostrarTareasDelMesPorPlanIDTableAdapter Ejec_TableAdap = new DataSet_Planificador_InformesTableAdapters.MostrarTareasDelMesPorPlanIDTableAdapter();
                DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDDataTable TareasDelMes = Ejec_TableAdap.GetData(Mes, PlanID, NID, Anio.ToString());                

                
                #endregion

                #region Tareas Principales

                //Seleccionamos filtrando las tareas de ese día.
                DataRow[] TareasPrincipales = TareasDelMes.Select("EsPrincipal = true");               

                //Eliminamos las tareas repetidas asignándole NULL
                for (int i = 0; i < TareasPrincipales.Length - 1; i++)
                {
                    for (int j = i + 1; j < TareasPrincipales.Length; j++)
                    {
                        //Se pone esto porque puede ser que ya fuera eliminada, por lo que no hay necesidad de comparala.
                        if (TareasPrincipales[i] != null)
                            if ((TareasPrincipales[i]["NombreAccion"].ToString() + TareasPrincipales[i]["Detalles"].ToString()) == (TareasPrincipales[j]["NombreAccion"].ToString() + TareasPrincipales[j]["Detalles"].ToString()))
                                TareasPrincipales[j] = null;
                    }
                }
                
                //Para poner una celda con texto es necesario la fila.
                TableRow FilaDeTarea = new TableRow();
                TableCell CeldaTarea = new TableCell();
                byte Indice = 0;

                if (TareasPrincipales.Length > 0)
                {
                    for (int ind = 0; ind < TareasPrincipales.Length; ind++)
                    {
                         //Para poner una celda con texto es necesario la fila.
                        FilaDeTarea = new TableRow();

                        //Si el valor tiene NULL (Porque era uno repetido que quitamos en BorrarElementosRepetidos )
                        if (TareasPrincipales[ind] == null)
                            continue;
                        else
                        {
                            //Consecutivo.
                            TableCell CeldaNro = new TableCell();
                            Indice++;
                            CeldaNro.Text = Indice.ToString();

                            FilaDeTarea.Cells.Add(CeldaNro);

                            //Celda del nombre de la tarea
                            CeldaTarea = new TableCell();
                            CeldaTarea.Text = TareasPrincipales[ind]["NombreAccion"].ToString() + "&nbsp;" + TareasPrincipales[ind]["Detalles"].ToString();
                            CeldaTarea.Style.Add(HtmlTextWriterStyle.TextAlign, "left");
                            CeldaTarea.Style.Add(HtmlTextWriterStyle.TextDecoration, "underline");
                            FilaDeTarea.Cells.Add(CeldaTarea);

                            //Insewrtamos en la tabla la fila con los datos
                            Tabla_TareasPrincipales.Rows.Add(FilaDeTarea);
                        }                       
                    }
                }
                else
                {
                    CeldaTarea.Text = "No se han definido tareas principales. <br><br>";
                    CeldaTarea.Style.Add(HtmlTextWriterStyle.TextDecoration, "underline");
                    CeldaTarea.Style.Add(HtmlTextWriterStyle.TextAlign, "center");
                    FilaDeTarea.Cells.Add(CeldaTarea);
                    Tabla_TareasPrincipales.Rows.Add(FilaDeTarea);
                }

                #endregion

                #region Llenado del CALENDARIO y de los EVENTOS por cada DÍA

                //Estos son los datos necesarios para trabajar                
                string[] DiasDeLaSemana = Thread.CurrentThread.CurrentCulture.DateTimeFormat.DayNames;                
                int DiasDelMes = Thread.CurrentThread.CurrentCulture.Calendar.GetDaysInMonth(Anio, Mes);

                //Contador del día del mes
                int DiaInsertado = 1;                

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
                            //Si el día de la columna coincide con el de la fecha del mes a insertar 
                            if (PlanificadorOnline.EsElMismoDiaDeLaSemana(Table_Month.Rows[0].Cells[indDiaDeSemana - 1].Text,Thread.CurrentThread.CurrentCulture.Calendar.GetDayOfWeek(new DateTime(Anio, Mes, DiaInsertado))))                            
                            {
                                //Ponemos el número a la celda del día
                                NuevaCelda.Text = "<div style=\"text-align:right;font-weight:bold;margin-bottom:5px;\">" + (DiaInsertado).ToString() + "</div>" + "<ul style=\"margin:0 0 0 15px;padding:0;text-align:left;\">";

                                //Estos son los datos de las tareas para ese día.                                
                                string FechaDelDia = new DateTime(Anio, Mes, DiaInsertado).ToString();
                                
                                //Seleccionamos filtrando las tareas de ese día.
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
                                    //Si hay más de una tarea en el día, le aplicamos agrupamiento por NombreAccion
                                    if (TareasDelDia.Length > 1)
                                    {
                                        //Preparamos el parámetro del  listado de campos a comparar
                                        string[] CampoAComparar = { "NombreAccion" };
                                        TareasDelDiaAgrupadas = PlanificadorOnline.AgruparCamposPorRegistro(TareasDelDia, CampoAComparar,"Detalles",true);
                                    }
                                    else
                                    {
                                        PlanificadorOnline.ResultadosCombinados AdicionarDatos = new PlanificadorOnline.ResultadosCombinados();
                                        AdicionarDatos.ObjetoDatos = TareasDelDia[0];

                                        TareasDelDiaAgrupadas.Add(AdicionarDatos);
                                    }


                                    //Después de agrupar las filas entonces las escribimos en el cuadro de ese día
                                    for (int i = 0; i < TareasDelDiaAgrupadas.Count; i++)
                                    {
                                        DataRow FilaDatos = (DataRow)TareasDelDiaAgrupadas[i].ObjetoDatos;
                                        string Detalles = TareasDelDiaAgrupadas[i].ObjetoSumado == null ? "" : TareasDelDiaAgrupadas[i].ObjetoSumado.ToString();
                                        NuevaCelda.Text += "<li>" + FilaDatos["NombreAccion"] + ".&nbsp;" + Detalles + "</li>";
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
                        Table_Month.Rows[j].Cells[Table_Month.Rows[j].Cells.Count - 1].Visible = false;
                        Table_Month.Rows[j].Cells[Table_Month.Rows[j].Cells.Count - 2].Visible = false;
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