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

public partial class Printing_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Page.User.Identity.IsAuthenticated) && (Session.Count > 0))
        {
            if (Request.QueryString.Count != 0)
            {
                // Asignamos la url de esta página a la de convertir a MSWord
                HyperLink_ConvertWord.NavigateUrl = Page.Request.Url.ToString().Replace("Monthly.", "Monthly_MSWord.");
                
                #region Captura de los parámetros
                int Mes = int.Parse(Request.QueryString["Mes"].ToString());
                int Anio = int.Parse(Request.QueryString["Anio"].ToString());
                short PlanID = short.Parse(Request.QueryString["Plan"].ToString());
                string PlanNombre = "";
                bool Wk = (Request.QueryString["Wk"].ToString() == "1") ? true : false;
                string NID = Session["NID"].ToString();  // ESTE VIENE DE SESSION PORQUE ES EL PLAN DEL USUARIO                
                #endregion

                #region Datos del trabajador

                Label_Mes.Text = System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(Request.QueryString["Mes"])).ToUpper() + "  " + Request.QueryString["Anio"];

                //Table Adapters para descargar los datos de la BD
                DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter TA_Trabajador = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
                DataSet_GestorTareas.TrabajadorDataTable Trabajador = TA_Trabajador.GetDataBy_NID(Session["NID"].ToString());
                
                //Mostramos los datos en el label
                Label_Nombre.Text = Trabajador[0].NombreCompleto;

                #endregion

                #region Datos del Jefe Inmediato

                //Localizar los datos del Jefe
                Trabajador = TA_Trabajador.GetDataBy_BuscarJefe(Session["NID"].ToString());

                //Buscar datos cargo del jefe
                DataSet_GestorTareasTableAdapters.CargoTableAdapter TA_Cargo = new DataSet_GestorTareasTableAdapters.CargoTableAdapter();
                DataSet_GestorTareas.CargoDataTable Cargo = TA_Cargo.GetDataBy_CargoID(Trabajador[0].CargoID);             

                //Mostrar en las etiquetas
                Label_NombreJefe.Text = Trabajador[0].NombreCompleto;
                Label_CargoJefe.Text = Cargo[0].Cargo;

                #endregion

                #region Datos de las tareas (Se carga acá para usarlo en las dos secciones sgtes)

                //Descargar tareas de la BD y ya vienen ordenadas ascendentemente por fecha planificada
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

                /**************************************************************************
                * La filosofía en este caso no es como la del plan de trabajo individual 
                * que es por cada día del mes ver las tareas que se hacen sino al contrario
                * ver por cada tarea, los días que se ejecutan pero a su vez debe ser ordenado
                * ascendentemente. Es decir primero las tareas que se ejecutan al inicio del
                * mes.
                ****************************************************************************/

                #region Llenado del CALENDARIO y de los EVENTOS por cada DÍA                                

                // Bandera y contador de elementos en el ciclo de llenar tabla.
                bool FinDeLista = false;
                byte IndiceAccion = 1;

                //Para llenar la tabla hacemos el ciclo hasta que lleguemos al final del conjunto de datos agrupados
                while (!FinDeLista)
                {
                    //Creamos la fila nueva 
                    TableRow NuevaFila = new TableRow();

                    //obtenemos todos los días cuando se ejecuta la primera tarea.
                    DataRow[] DiasDeLaTarea = TareasDelMes.Select("NombreAccion='" + TareasDelMes[0]["NombreAccion"].ToString() + "'");                    
                    
                    //Variables que reciben los listados del STRUCT ResultadosCombinados.
                    List<PlanificadorOnline.ResultadosCombinados> DiasDeLaTareaAgrupados = new List<PlanificadorOnline.ResultadosCombinados>();
                    List<PlanificadorOnline.ResultadosCombinados> ResponsablesDeLaTareaAgrupados = new List<PlanificadorOnline.ResultadosCombinados>();
                    List<PlanificadorOnline.ResultadosCombinados> EjecutantesDeLaTareaAgrupados = new List<PlanificadorOnline.ResultadosCombinados>();
                    List<PlanificadorOnline.ResultadosCombinados> DetallesDeLaTareaAgrupados = new List<PlanificadorOnline.ResultadosCombinados>();

                    //Preparamos el parámetro del  listado de campos a comparar
                    string[] CampoAComparar = { "NombreAccion" };                    

                    // Recibimos los listados ordenados con los días, los responsables y los ejecutantes.
                    DiasDeLaTareaAgrupados = PlanificadorOnline.AgruparCamposPorRegistro(DiasDeLaTarea, CampoAComparar, "FechaPlanificada",false);
                    ResponsablesDeLaTareaAgrupados = PlanificadorOnline.AgruparCamposPorRegistro(DiasDeLaTarea, CampoAComparar, "ResponsableCargo",false);
                    EjecutantesDeLaTareaAgrupados = PlanificadorOnline.AgruparCamposPorRegistro(DiasDeLaTarea, CampoAComparar, "EjecutaNombre",false);
                    DetallesDeLaTareaAgrupados = PlanificadorOnline.AgruparCamposPorRegistro(DiasDeLaTarea, CampoAComparar, "Detalles",false);
                    
                    //Ahora recorremos las columnas de la fila para llenarlas. (La primera es un consecutivo se hace con el índice del ciclo)
                    for (int indColumna = 1; indColumna <= 5; indColumna++)
                    {
                        //Creamos la celda insertar                        
                        TableCell NuevaCelda = new TableCell();
                        NuevaCelda.BorderColor = System.Drawing.Color.Black;
                        NuevaCelda.BorderStyle = BorderStyle.Solid;
                        NuevaCelda.BorderWidth = Unit.Pixel(1);
                        NuevaCelda.VerticalAlign = VerticalAlign.Top;                        

                        DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow DatosFilaAccion = (DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow)DiasDeLaTareaAgrupados[0].ObjetoDatos;
                        string DatosDiasAgrupados = DiasDeLaTareaAgrupados[0].ObjetoSumado.ToString();
                        string DatosResponsablesAgrupados = ResponsablesDeLaTareaAgrupados[0].ObjetoSumado.ToString();
                        string DatosEjecutantesAgrupados = EjecutantesDeLaTareaAgrupados[0].ObjetoSumado.ToString();
                        string DetallesTareaAgrupados = DetallesDeLaTareaAgrupados[0].ObjetoSumado.ToString();

                        #region Columna del campo Nro de fila
                        if (indColumna == 1)
                        {
                            NuevaCelda.HorizontalAlign = HorizontalAlign.Center;
                            NuevaCelda.Text = IndiceAccion.ToString();
                        }
                        #endregion
                        else
                            #region Columna del campo Actividad (NombreAccion)
                            if (indColumna == 2)
                            {
                                if (DetallesTareaAgrupados != "")
                                {
                                    NuevaCelda.Text = DatosFilaAccion["NombreAccion"].ToString() + "(" + DetallesTareaAgrupados + ")";
                                }
                                else
                                {
                                    NuevaCelda.Text = DatosFilaAccion["NombreAccion"].ToString();
                                }
                                
                                /*if (DatosFilaAccion["Detalles"].ToString() != "") 
                                    NuevaCelda.Text = DatosFilaAccion["NombreAccion"].ToString() + " (" + DatosFilaAccion["Detalles"].ToString() + ")";
                                else
                                    NuevaCelda.Text = DatosFilaAccion["NombreAccion"].ToString();*/
                            }
                            #endregion
                            else
                                #region Columna del campo Fecha (FechaPlanificada)
                                if (indColumna == 3)
                                {
                                    NuevaCelda.HorizontalAlign = HorizontalAlign.Left;

                                    //Tomamos la cadena de fechas separada por comas y le hacemos el split y luego tomamos de cada elemento solo el día.
                                    string[] Dias = DatosDiasAgrupados.Split(',');
                                    foreach (string Dia in Dias)
                                        NuevaCelda.Text += Dia.TrimStart().Substring(0, 2) + ", ";                                   

                                    //Quitamos la coma finaly ponemos un punto
                                    if (NuevaCelda.Text.Length > 0)
                                    {
                                        NuevaCelda.Text = NuevaCelda.Text.Remove(NuevaCelda.Text.Length - 2, 2);
                                        NuevaCelda.Text += ".";
                                    } 
                                }
                                #endregion
                                else
                                    #region Columna del campo Dirige (ResponsableCargo)

                                    if (indColumna == 4)
                                    {
                                        NuevaCelda.Style.Add(HtmlTextWriterStyle.Margin, "0");
                                        NuevaCelda.Style.Add(HtmlTextWriterStyle.Padding, "0");
                                        
                                        //Caja de texto que pondremos en la celda
                                        TextBox Caja = new TextBox();
                                        Caja.CssClass = "CajaTexto";
                                        Caja.Width = Unit.Percentage(100);
                                        Caja.Height = Unit.Percentage(100);
                                        Caja.TextMode = TextBoxMode.MultiLine;
                                        Caja.BorderStyle = BorderStyle.None;
                                        Caja.Rows = 3;
                                        
                                        //Tomamos la cadena de Responsables separada por comas y le hacemos el split y luego tomamos de cada elemento solo el valor.
                                        string[] Responsables = DatosResponsablesAgrupados.Split(',');
                                        foreach (string Responsable in Responsables)
                                            if (Responsable != "")
                                            Caja.Text += Responsable.TrimStart()+ ", ";

                                        //Quitamos la coma finaly ponemos un punto
                                        if (Caja.Text.Length > 0)
                                        {
                                            Caja.Text = Caja.Text.Remove(Caja.Text.Length - 2, 2);
                                            Caja.Text += ".";
                                        }
                                        
                                        //Metemos la caja de texto en la celda.
                                        NuevaCelda.Controls.Add(Caja);
                                    }

                                    #endregion
                                    else
                                        #region Columna del campo Participa (EjecutaNombre)
                                        if (indColumna == 5)
                                        {
                                            NuevaCelda.Style.Add(HtmlTextWriterStyle.Margin, "0");
                                            NuevaCelda.Style.Add(HtmlTextWriterStyle.Padding, "0");
                                            
                                            //Caja de texto que pondremos en la celda
                                            TextBox Caja = new TextBox();
                                            Caja.CssClass = "CajaTexto";
                                            Caja.Width = Unit.Percentage(100);
                                            Caja.Height = Unit.Percentage(100);
                                            Caja.TextMode = TextBoxMode.MultiLine;
                                            Caja.BorderStyle = BorderStyle.None;
                                            Caja.Rows = 3;
                                            
                                            //Tomamos la cadena de Responsables separada por comas y le hacemos el split y luego tomamos de cada elemento solo el valor.
                                            string[] Ejecutantes = DatosEjecutantesAgrupados.Split(',');
                                            foreach (string Ejecutante in Ejecutantes)
                                                if (Ejecutante != "")
                                                    Caja.Text += Ejecutante.TrimStart() + ", ";

                                            //Quitamos la coma finaly ponemos un punto
                                            if (Caja.Text.Length > 0)
                                            {
                                                Caja.Text = Caja.Text.Remove(Caja.Text.Length - 2, 2);
                                                Caja.Text += ".";
                                            }
                                            
                                            NuevaCelda.Controls.Add(Caja);
                                        }
                                        #endregion

                        //Adicionamos la celda
                        NuevaFila.Cells.Add(NuevaCelda);
                    }

                    //Adicionamos la fila a la tabla
                    Table_Tareas.Rows.Add(NuevaFila);

                    //Aumentamos para los consecutivos pero la lista solo debe tener un 
                    IndiceAccion++;

                    //Borramos del datatable la tarea que ya se puso en la tabla para que no salga nuevamente
                    foreach (DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDRow FilaDeAccion in DiasDeLaTarea)
                        if (FilaDeAccion != null)
                            TareasDelMes.RemoveMostrarTareasDelMesPorPlanIDRow(FilaDeAccion);

                    //Verificamos si llegamos al final del DataTable y está vacío.
                    FinDeLista = (TareasDelMes.Count == 0);                                       
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