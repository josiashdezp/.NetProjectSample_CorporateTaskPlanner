using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Planning_PlanMes : System.Web.UI.Page
{
    #region Campo que se utiliza. Instancia de la clase Planificador.
    PlanificadorOnline Planificador;
    DataSet_GestorTareas.DiasFeriadosRow[] DiasFeriadosDelMes;
    #endregion

    //Inicializamos la instancia del Planificador.
    protected void Page_Load(object sender, EventArgs e)
    {
        Planificador = new PlanificadorOnline();
    }

    //Este es el último evento en que se pueden modificar el contenido de la página antes de mostrarla. En este punto ya se evaluaron las expresiones DATABIND
    protected void Page_PreRender(object sender, EventArgs e)
    {
        //Llamamos este evento para mostrar las estadísticas al cargar por Postback        
        //ASPxCallbackPanel_Estadisticas_Callback(sender, null);        
    }

    //Seleccionar el año actual por defecto o el que estaba antes de cargar la página
    protected void DropDownList_Anio_DataBound(object sender, EventArgs e)
    {
        //Est es para que sirva para cualquirea de los controles de Anio que usan el procedimiento y no tener que volver a escribirlo
        DropDownList ListaDeAnio = (DropDownList)sender;

        // Es decir , si es la primera vez que se carga
        if (!Page.IsPostBack)
        {
            if (ListaDeAnio.Items.Count > 0)
                if (Request.QueryString.Count != 0)
                    if (Request.QueryString["Goto"] != null)
                        ListaDeAnio.SelectedValue = Convert.ToDateTime(Request.QueryString["Goto"]).Year.ToString();
                    else
                        ListaDeAnio.SelectedValue = Request.QueryString["Anio"].ToString();
                else
                    ListaDeAnio.SelectedValue = DateTime.Now.Year.ToString();
            else
                ListaDeAnio.Items.Add(DateTime.Now.Year.ToString());

            // Esto es para que se cumpla solo para la lista de anio de el month view y no para la del popup del reporte estadístico
            if (ListaDeAnio.ID == DropDownList_Anio.ID)
                MonthView.StartDate = new DateTime(Convert.ToInt16(ListaDeAnio.SelectedValue), Convert.ToInt16(DropDownList_Mes.SelectedValue), 1);
        }
    }

    //Actualizar la fecha de inicio del MonthView.
    protected void DropDownList_Anio_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Si el año es el actual, ponemos el mes actual
        if (DropDownList_Anio.SelectedValue == DateTime.Now.Year.ToString())
            DropDownList_Mes.SelectedValue = DateTime.Now.Month.ToString();
        else // Si no ponemos en el mes de ENERO
            DropDownList_Mes.SelectedIndex = 0;

        //Actualizamos la fecha del MonthView y los enlaces de la página.
        MonthView.StartDate = new DateTime(Convert.ToInt16(DropDownList_Anio.SelectedValue), Convert.ToInt16(DropDownList_Mes.SelectedValue), 1);
        ActualizarEnlaceDeImprimirVistasDelPlan(MonthView.StartDate.Month.ToString());

        //Se actualiza el MonthView porque se cambió la fecha de inicio del mismo.    
        MonthView.Update(CallBackUpdateType.Full);
    }

    //Al enlazar a datos seleccionamos el que dice "TODOS LOS TIPOS" o el anteriormente seleccionado
    protected void DropDownList_Filter_DataBound(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) DropDownList_Filter.SelectedIndex = DropDownList_Filter.Items.IndexOf(DropDownList_Filter.Items.FindByText("Todos los tipos"));
    }

    //Al cambiar el plan a ver, actualizar datos del plan que se muestran
    protected void DropDownList_Plan_SelectedIndexChanged(object sender, EventArgs e)
    {
        MostrarDatosDelPlan();
    }

    //Cuando se enlaza a datos si no hay planes se adicionan ITEMS con valores por efecto
    protected void DropDownList_Plan_DataBound(object sender, EventArgs e)
    {
        //Esto es para que el procedimiento sirva para cualquiera de los DropDownList de planes que hay en la página.
        DropDownList ListaDePlanes = (DropDownList)sender;

        ListItem ItemVacia = new ListItem();
        if (ListaDePlanes.Items.Count == 0)
        {
            ItemVacia.Text = "- No hay planes -";
            ItemVacia.Value = "-1";

            ListaDePlanes.Items.Add(ItemVacia);
            LimpiarDatosDelPlanMostrados();
            return;
        }

        ItemVacia.Text = "- Todos los planes -";
        ItemVacia.Value = "0";
        ItemVacia.Selected = true;
        ListaDePlanes.Items.Insert(0, ItemVacia);
        if (!Page.IsPostBack)
            if (Request.QueryString.Count != 0)
                if (Request.QueryString["Goto"] == null)
                    ListaDePlanes.SelectedValue = Request.QueryString["PlanID"].ToString();

        //Esta operación es solo para cuando sea los planes de la vista Mensual y no el listado para el reporte estadístico que se abre en el popup.
        if (ListaDePlanes.ID == DropDownList_Plan.ID)
            MostrarDatosDelPlan();
    }

    //Al cargar por primera vez, seleccionamos el MES actual.
    protected void DropDownList_Mes_Load(object sender, EventArgs e)
    {
        //Esto es para que puedan usar este procedimiento cualquiera de ls controles de mes de la página
        DropDownList ListaDeMes = (DropDownList)sender;

        if (!Page.IsPostBack)
            if (Request.QueryString["Goto"] != null)
                ListaDeMes.SelectedValue = Convert.ToDateTime(Request.QueryString["Goto"]).Month.ToString();
            else
                ListaDeMes.SelectedValue = DateTime.Now.Month.ToString();

        //Esto es solo para la lista de Mes del Month View
        if (ListaDeMes.ID == DropDownList_Mes.ID)
            DiasFeriadosDelMes = Planificador.ObtenerDiasFeriados(int.Parse(ListaDeMes.SelectedItem.Value));
    }

    protected void DropDownList_Mes_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Cambiamos la fecha del MonthView al mes seleccionado el Primer día.
        MonthView.StartDate = new DateTime(Convert.ToInt16(DropDownList_Anio.SelectedValue), Convert.ToInt16(DropDownList_Mes.SelectedValue), 1);
        ActualizarEnlaceDeImprimirVistasDelPlan(MonthView.StartDate.Month.ToString());

        //Se actualiza el MonthView porque se cambió la fecha de inicio del mismo.    
        MonthView.Update(CallBackUpdateType.Full);
    }

    #region Operaciones con los eventos dentro del calendario

    //Al cargar el calendario se muestran u ocultan los fines de semana.
    protected void MonthView_Load(object sender, EventArgs e)
    {
        MonthView.ShowWeekend = CheckBox_WeekEnd.Checked;
        MonthView.Update(CallBackUpdateType.Full);
    }

    //Click en el menú alternativo que se ejecuta por CALLBACK
    protected void MonthView_EventMenuClick(object sender, EventMenuClickEventArgs e)
    {
        DataSet_GestorTareasTableAdapters.EjecucionTableAdapter TA_Ejecucion = new DataSet_GestorTareasTableAdapters.EjecucionTableAdapter();
        if (e.Command == "Delete")
        {
            string Mensaje = "";
            try
            {
                TA_Ejecucion.DeleteQuery_ByEjecucionID(Convert.ToInt32(e.Value));
                Mensaje = "Tarea borrada exitosamente.";
            }
            catch (Exception ErrorBorrar)
            {
                Mensaje = "No es posible borrar la tarea en este momento. \n Causa:" + ErrorBorrar.Message + "\n Intente en unos minutos, si este error persiste contacte su administrador.";
            }
            finally
            {
                MonthView.DataBind();
                MonthView.UpdateWithMessage(Mensaje);
            }
        }
        else if (e.Command == "EsPrincipal")
        {
            System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(Page.AppRelativeVirtualPath);
            System.Configuration.ConnectionStringSettings connString;
            if (rootWebConfig.ConnectionStrings.ConnectionStrings.Count > 0)
            {
                connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BDPlanificadorConnectionString"];

                if (null != connString)
                {
                    //Configuración de la conexión
                    SqlConnection SqlConString = new SqlConnection(connString.ConnectionString);
                    SqlCommand EjecutProc = new SqlCommand();
                    EjecutProc.Connection = SqlConString;

                    //Configuración de los parámetros y el procedimiento
                    EjecutProc.CommandType = CommandType.StoredProcedure;
                    EjecutProc.CommandText = "stp_ActualizarTareaPrincipal";
                    SqlParameter Param_EjecucionID = new SqlParameter("EjecucionID", SqlDbType.Int);                    
                    Param_EjecucionID.Value = e.Value;
                    EjecutProc.Parameters.Add(Param_EjecucionID);

                    try
                    {
                        //Ejecución del procedimiento
                        SqlConString.Open();

                        if (EjecutProc.ExecuteNonQuery() == 1)
                        {
                            MonthView.DataBind();
                            MonthView.UpdateWithMessage("Tarea actualizada satisfactoriamente.");
                        }
                        else
                        {
                            MonthView.DataBind();
                            MonthView.UpdateWithMessage("La tarea no se ha podido actualizar.");
                        }

                    }
                    catch (Exception ErrorActualizar)
                    {
                        MonthView.UpdateWithMessage(ErrorActualizar.Message);
                    }

                    //Liberación de las variables
                    EjecutProc.Dispose();
                }
                else
                {
                    MonthView.UpdateWithMessage("La tarea no se ha podido actualizar por problemas de conexión al servidor de bases de datos. /n Contacte su administrador.");
                }
            }
            else
                Label_msg.Text = "Error de conexión a la base de datos. /n Contacte su administrador de red.";
        }
    }

    // Para asignarle el valor a los BUBBLE antes de mostrarlos.
    protected void BubbleMonth_RenderContent(object sender, DayPilot.Web.Ui.Events.Bubble.RenderEventArgs e)
    {
        if (e is RenderEventBubbleEventArgs)
        {
            RenderEventBubbleEventArgs re = e as RenderEventBubbleEventArgs;

            string FechaPlanificada, FechaCierra;

            FechaPlanificada = (re.Start.ToShortTimeString() == "12:00 a.m.") ? re.Start.ToShortDateString() : re.Start.ToShortDateString() + " " + re.Start.ToShortTimeString();
            FechaCierra = (re.End.ToShortTimeString() == "12:00 a.m.") ? re.End.ToShortDateString() : re.End.ToShortDateString() + " " + re.End.ToShortTimeString();
            re.InnerHTML =
                "<b>Plan:</b>&nbsp;" + re.Tag["NombrePlan"].ToString() + "<BR>" +
                "<b>Tarea:</b>&nbsp;" + re.Text +
                "<br><b>Descripción:</b><br />" + re.Tag["Descripcion"].ToString() +
                "<br><b>Detalles:</b><br />" + re.Tag["Detalles"].ToString() +
                "<br><b>Tipo de Tarea:</b>&nbsp;" + re.Tag["TipoAccion"].ToString() +
                "<br><b>Planificada para:</b>&nbsp;" + FechaPlanificada +
                "<br><b>Fecha Vencimiento:</b>&nbsp;" + FechaCierra +
                "<br><b>Planificada por:</b><br />" + re.Tag["PlanificadorNombre"].ToString() +
                "<br><b>Ejecuta:</b><br />" + re.Tag["EjecutaNombre"].ToString() +
                "<br><b>Supervisa:</b><br />" + re.Tag["ResponsableNombre"].ToString() +
                "<br><b>Estado:</b>&nbsp;" + re.Tag["Estado"].ToString() +
                "<br><b>Observaciones:</b><br />" + re.Tag["Observaciones"].ToString() + "<br>";
        }
    }

    /// Comment
    /// Este es para darle formato a los eventos antes de mostrarlos en la página y asignar el MENU
    /// Este procedimiento está pendiente de completar porque los menúes no están configurados con todas las opciones según eltipo de usuario conectado.   
    protected void MonthView_BeforeEventRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeEventRenderEventArgs e)
    {
        //Limpiamos el valor del menú para que ho hayan errores
        e.ContextMenuClientName = "";

        //Asignamos el color de fondo.
        e.BackgroundColor = e.Tag["EstadoColor"];

        #region Adicionar la etiqueta con el nombre dle que ejecuta para aclarar en caso de los responsables.
        if ( //Si el usuario conectado no es el planifica o el que ejecuta ( cuando es RESPONSABLE)
          ((Session["NID"].ToString() != e.Tag["NID"]) && (Session["NID"].ToString() != e.Tag["NID_Ejecuta"]))
          || // y si el usuario no es el que ejecuta y tampoco el responsable (Cuando le PLANIFICA TAREAS A OTRO.)
          ((Session["NID"].ToString() != e.Tag["NID_Ejecuta"]) && (e.Tag["NID_Ejecuta"] != e.Tag["NID_Responsable"]))
          )
        {
            e.InnerHTML = e.Text + "&nbsp;&nbsp;(" + e.Tag["EjecutaUserName"] + ")";
        }
        #endregion

        #region Poner en negrita las tareas principales.

        if (Convert.ToBoolean(e.Tag["EsPrincipal"]))
            e.InnerHTML = "<b>" + e.InnerHTML + "<b/>";

        #endregion

        #region Asignación de menú alternativo        
        //Si son acciones de rango el menú cambia. No permite REPROGRAMAR o CAMBIAR FECHA
            if (e.Start != e.End)
            {
                //Para estas tareas no se reprograma porque el menú no lo permite todavía.
                #region Opciones del menú cuando son Tareas de Rango

                //Si son tareas propias. (Es decir planificadas por mi, para mi. PLANIFICO y EJECUTO)
                if ((e.Tag["NID_Ejecuta"] == Session["NID"].ToString()) && (e.Tag["NID"] == Session["NID"].ToString()))
                {
                    //Si ya fueron aprobadas por mi jefe, no deben cambiarse ni modificarse
                    //Estas son las operaciones que hace: Modificar, Ejecutar, Progreso, CambiarFecha,  Suspender   
                    e.ContextMenuClientName = "MenuPlanificaEjecuta_Rango";

                    //Si no han sido aprobadas se adiciona el privilegio:  Borrar.

                }
                else //De lo contrario
                {
                    //Si solo es quien ejecuta
                    if ((e.Tag["NID_Ejecuta"] == Session["NID"].ToString()) && (e.Tag["NID"] != Session["NID"].ToString()))
                        e.ContextMenuClientName = "MenuEjecutaRango";
                    else
                        //Si es quien planificó la tarea solamente
                        if ((e.Tag["NID_Ejecuta"] != Session["NID"].ToString()) && (e.Tag["NID"] == Session["NID"].ToString()))
                            e.ContextMenuClientName = "MenuPlanificadorRango";
                        else
                            //Si es quien revisa la ejecución. RESPONSABLE
                            if (e.Tag["NID_Responsable"] == Session["NID"].ToString())
                                e.ContextMenuClientName = "MenuResponsableRango";
                }
                #endregion
            }
            else
            {
                #region Opciones del menú para tareas normales que se ejecutan y vencen el mismo día

                //Si son tareas propias. (Es decir planificadas por mi, para mi. YO PLANIFICO y EJECUTO)
                if ((e.Tag["NID_Ejecuta"] == Session["NID"].ToString()) && (e.Tag["NID"] == Session["NID"].ToString()))
                {
                    //Si ya fueron aprobadas por mi jefe, no deben cambiarse ni modificarse
                    //Estas son las operaciones que hace: Modificar, Ejecutar, Progreso, CambiarFecha,  Suspender   
                    e.ContextMenuClientName = "MenuPlanificaEjecuta_PlanNOAprobado";

                    //Si no han sido aprobadas se adiciona el privilegio:  Borrar.

                }
                else //De lo contrario
                {
                    //Si solo es quien ejecuta
                    if ((e.Tag["NID_Ejecuta"] == Session["NID"].ToString()) && (e.Tag["NID"] != Session["NID"].ToString()))
                    {
                        e.ContextMenuClientName = "MenuEjecuta";
                        //ModificarMenuItemDelEvento(e);
                    }
                    else
                        //Si es quien planificó la tarea solamente
                        if ((e.Tag["NID_Ejecuta"] != Session["NID"].ToString()) && (e.Tag["NID"] == Session["NID"].ToString()))
                        {
                            e.ContextMenuClientName = "MenuPlanifica";
                            //ModificarMenuItemDelEvento(e);
                        }
                        else
                            //Si es quien revisa la ejecución. (RESPONSABLE)
                            if (e.Tag["NID_Responsable"] == Session["NID"].ToString())
                                e.ContextMenuClientName = "MenuResponsable";
                }
                #endregion
            }
        #endregion        
    }

    //Operaciones en el MonthView que son con CALLBACK: Refrescar. 
    protected void MonthView_Command(object sender, DayPilot.Web.Ui.Events.CommandEventArgs e)
    {
        if (e.Command == "refresh")
        {
            MonthView.DataBind();
            MonthView.Update(CallBackUpdateType.EventsOnly);
        }
    }

    //Antes de Pintar la celda hay que ponerle si es feriado o no.
    protected void MonthView_BeforeCellRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeCellRenderEventArgs e)
    {
        foreach (DataSet_GestorTareas.DiasFeriadosRow DiaFeriado in DiasFeriadosDelMes)
            if ((int.Parse(DiaFeriado.Dia) == e.Start.Day) && (int.Parse(DiaFeriado.Mes) == e.Start.Month))
            {
                e.HeaderText += String.Format("<br><h4>&nbsp;&nbsp;&nbsp;DIA FERIADO</H4><br><center>{0}</center>", DiaFeriado.Nombre);
                break;
            }
    }

    #endregion

    //Muestra información adicional del plan seleccionado en el formulario de arriba (fecha, observaciones, etc.)
    private void MostrarDatosDelPlan()
    {
        //Creamos las instancias de los DataTable y localizamos el Plan seleccionados
        DataSet_GestorTareas.PlanAccionesDataTable Table_Planes;
        DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter TableAdap_Planes = new DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter();
        Table_Planes = TableAdap_Planes.GetDataBy_AnioPlan(Convert.ToInt16(DropDownList_Plan.SelectedItem.Value), DropDownList_Anio.SelectedItem.Value);

        if (Table_Planes.Count != 0)
        {
            //Mostramos los datos en los controles.            
            Label_Observaciones.Text = Table_Planes[0].Observaciones;

            //Habilitar el enlace de adicionar tarea si el plan es del usuario conectado y mostrar mensaje.
            HyperLink_AddTask.Enabled = (Table_Planes[0].NID == Session["NID"].ToString());
            if (!HyperLink_AddTask.Enabled)
            {
                Label_msg.Text = "No tiene permiso para adicionar tareas en este plan.";
                Label_msg.Visible = true;
            }
            else
                Label_msg.Visible = false;

            //Otros datos que hay que actualizar.            
            MonthView.ShowWeekend = CheckBox_WeekEnd.Checked;
            ActualizarEnlacesDeLaPagina(Table_Planes[0].PlanID, Table_Planes[0].Anio, DropDownList_Mes.SelectedItem.Value);
        }
        else
        {
            //Si no se seleccionó ningún plan se muestran este mensaje.
            HyperLink_AddTask.Enabled = false;
            Label_msg.Text = "Para adicionar tareas seleccione un plan específico.";
            Label_msg.Visible = true;

            //Actualizar enlaces para imprimir todo.
            ActualizarEnlacesDeLaPagina(0, DropDownList_Anio.SelectedItem.Value, DropDownList_Mes.SelectedItem.Value);
        }
    }

    //Reinicia la vista de detalles dle plan seleccionado
    private void LimpiarDatosDelPlanMostrados()
    {
        Label_Observaciones.Text = "";

        HyperLink_AddTask.Enabled = false;

        ActualizarEnlacesDeLaPagina(0, DropDownList_Anio.SelectedValue, DropDownList_Mes.SelectedValue);
    }

    //Actualizar los enlaces que salen de la página según los datos que se muestran    
    private void ActualizarEnlacesDeLaPagina(int PlanID, string Anio, string Mes)
    {
        //Para asegurar que el mes tenga siempre 2 caracteres se rellena con 0 a la izq de ser necesario
        string MesString = (Mes.ToString().Length == 1) ? Mes.PadLeft(2, '0') : Mes;

        //Mostrar fines de semana.
        string Wk = (CheckBox_WeekEnd.Checked) ? "1" : "0";

        //Enlaces de IMPRIMIR plan Mensual (Item Nro 0)
        PopupMenuOpciones.Items[0].NavigateUrl = "~/Printing/PlanPrintMonthly.aspx?";
        PopupMenuOpciones.Items[0].NavigateUrl += "Mes=" + MesString.ToString() + "&Anio=" + Anio + "&Plan=" + PlanID.ToString() + "&Wk=" + Wk;

        //Enlaces de IMPRIMIR plan Individual (Item Nro 1)
        PopupMenuOpciones.Items[1].NavigateUrl = "~/Printing/PlanPrintPersonalView.aspx?";
        PopupMenuOpciones.Items[1].NavigateUrl += "Mes=" + MesString.ToString() + "&Anio=" + Anio + "&Plan=" + PlanID.ToString() + "&Wk=" + Wk;

        //Imprimir vista de detalles no está habilitada (Item 2)
        PopupMenuOpciones.Items[2].NavigateUrl = "~/Printing/PlanPrintDetailsView.aspx?";
        PopupMenuOpciones.Items[2].NavigateUrl += "Mes=" + MesString.ToString() + "&Anio=" + Anio + "&Plan=" + PlanID.ToString();

        //Enlace de IMPRIMIR otros planes (Item Nro 3) No está habilitada.
        PopupMenuOpciones.Items[3].NavigateUrl = "~/Printing/PlanPrint.aspx";

        //Enlaces de IMPRIMIR plan provincial (Item Nro 4)
        PopupMenuOpciones.Items[4].NavigateUrl = "~/Printing/PlanPrintGenView.aspx?";
        PopupMenuOpciones.Items[4].NavigateUrl += "Mes=" + MesString.ToString() + "&Anio=" + Anio + "&Plan=" + PlanID.ToString() + "&Wk=" + Wk;

        //Enlaces de IMPRIMIR plan de prevención(Item Nro 5) No está habilitado.
        PopupMenuOpciones.Items[5].NavigateUrl = "~/Printing/PlanPrevencPrint.aspx?";
        PopupMenuOpciones.Items[5].NavigateUrl += "Mes=" + MesString.ToString() + "&Anio=" + Anio;

        //Enlaces de Adicionar Planes. (Item Nro 6)      
        PopupMenuOpciones.Items[6].NavigateUrl = "~/Planning/PlanMain.aspx?Anio=" + Anio;

        //Buscar tareas es el item (7). No necesita cambio de la URL

        // Imprimir resumen cuantitativo es el (8).
        PopupMenuOpciones.Items[8].NavigateUrl = "~/Printing/ReportPrintEstadistics.aspx?";
        PopupMenuOpciones.Items[8].NavigateUrl += "Mes=" + MesString.ToString() + "&Anio=" + Anio + "&Plan=" + PlanID.ToString();

        //Enlace de Adicionar tareas. No está en el menú POP
        HyperLink_AddTask.NavigateUrl = "~/Planning/PlanAddEvent.aspx?PlanID=" + PlanID.ToString() + "&Anio=" + Anio;
    }
    private void ActualizarEnlaceDeImprimirVistasDelPlan(string Mes)
    {
        //Para asegurar que el mes tenga siempre 2 caracteres se rellena con 0 a la izq de ser necesario
        string MesString = (Mes.ToString().Length == 1) ? Mes.PadLeft(2, '0') : Mes;

        //Actualizar enlace del Hyperlink Imprimir Plan Mensual. Item 0 del menú
        int PositionDelInterrogatPlanMensual = PopupMenuOpciones.Items[0].NavigateUrl.IndexOf("?");
        string CadenaDelMesPlanMens = PopupMenuOpciones.Items[0].NavigateUrl.Substring(PositionDelInterrogatPlanMensual + 1, 6); // Buscamos desde ? hasta el final, la cadena:  Mes=xx
        PopupMenuOpciones.Items[0].NavigateUrl = PopupMenuOpciones.Items[0].NavigateUrl.Replace(CadenaDelMesPlanMens, "Mes=" + MesString); // Sustituimos esa cadena por la nueva.        

        //Actualizar enlace del Hyperlink Imprimir Plan Individual. Item 1 del menú
        int PositionDelInterrogatPlanIndivid = PopupMenuOpciones.Items[1].NavigateUrl.IndexOf("?");
        string CadenaDelMesPlanIndiv = PopupMenuOpciones.Items[1].NavigateUrl.Substring(PositionDelInterrogatPlanIndivid + 1, 6); // Buscamos desde ? hasta el final, la cadena:  Mes=xx
        PopupMenuOpciones.Items[1].NavigateUrl = PopupMenuOpciones.Items[1].NavigateUrl.Replace(CadenaDelMesPlanIndiv, "Mes=" + MesString); // Sustituimos esa cadena por la nueva.        

        //Actualizar enlace del Hyperlink Vista detallada. Item 2 del menú
        int PositionDelInterrogatDetallada = PopupMenuOpciones.Items[2].NavigateUrl.IndexOf("?");
        string CadenaDelMesDetallada = PopupMenuOpciones.Items[2].NavigateUrl.Substring(PositionDelInterrogatDetallada + 1, 6); // Buscamos desde ? hasta el final, la cadena:  Mes=xx
        PopupMenuOpciones.Items[2].NavigateUrl = PopupMenuOpciones.Items[2].NavigateUrl.Replace(CadenaDelMesDetallada, "Mes=" + MesString); // Sustituimos esa cadena por la nueva.        

        //Enlaces de IMPRIMIR plan provincial (Item Nro 4)
        int PositionDelInterrogatProv = PopupMenuOpciones.Items[4].NavigateUrl.IndexOf("?");
        string CadenaDelMesProv = PopupMenuOpciones.Items[4].NavigateUrl.Substring(PositionDelInterrogatProv + 1, 6); // Buscamos desde ? hasta el final, la cadena:  Mes=xx
        PopupMenuOpciones.Items[4].NavigateUrl = PopupMenuOpciones.Items[4].NavigateUrl.Replace(CadenaDelMesProv, "Mes=" + MesString); // Sustituimos esa cadena por la nueva.

        //Enlaces de IMPRIMIR plan de prevención (Item Nro 5)
        int PositionDelInterrogatPrevenc = PopupMenuOpciones.Items[5].NavigateUrl.IndexOf("?");
        string CadenaDelMesPrevenc = PopupMenuOpciones.Items[5].NavigateUrl.Substring(PositionDelInterrogatPrevenc + 1, 6); // Buscamos desde ? hasta el final, la cadena:  Mes=xx
        PopupMenuOpciones.Items[5].NavigateUrl = PopupMenuOpciones.Items[5].NavigateUrl.Replace(CadenaDelMesPrevenc, "Mes=" + MesString); // Sustituimos esa cadena por la nueva.

        //Enlaces de imprimir resumen estadístico (Item 8)
        int PositionDelInterrogatEstadist = PopupMenuOpciones.Items[8].NavigateUrl.IndexOf("?");
        string CadenaDelMesEstadist = PopupMenuOpciones.Items[8].NavigateUrl.Substring(PositionDelInterrogatEstadist + 1, 6); // Buscamos desde ? hasta el final, la cadena:  Mes=xx
        PopupMenuOpciones.Items[8].NavigateUrl = PopupMenuOpciones.Items[8].NavigateUrl.Replace(CadenaDelMesEstadist, "Mes=" + MesString); // Sustituimos esa cadena por la nueva.
    }

    //En el enlace a IMPRIMIR PLAN poner si se muestra el fin de semana o no.
    private void ActualizarEnlacesDeImprimirVistasDelPlan(bool ShowWeekEnd)
    {
        // Si está activado es 1 si no 0.
        string Wk = (ShowWeekEnd) ? "Wk=1" : "Wk=0";

        //Plan Mensual es el item 0 del menu. Buscamos donde dice Wk=X donde X es 1 o 0.
        int PositionDelWkPlanMes = PopupMenuOpciones.Items[0].NavigateUrl.LastIndexOf("&");
        string CadenaDelWeekEndPlanMes = PopupMenuOpciones.Items[0].NavigateUrl.Substring(PositionDelWkPlanMes + 1, 4); // Buscamos de atrás para adelante los 4 últimos caracteres
        PopupMenuOpciones.Items[0].NavigateUrl = PopupMenuOpciones.Items[0].NavigateUrl.Replace(CadenaDelWeekEndPlanMes, Wk); // Sustituimos esa cadena por la nueva.    

        //Plan Individual es el item 1 del menú. Buscamos donde dice Wk=X donde X es 1 o 0.
        int PositionDelWkPlanIndiv = PopupMenuOpciones.Items[1].NavigateUrl.LastIndexOf("&");
        string CadenaDelWeekEndPlanIndiv = PopupMenuOpciones.Items[1].NavigateUrl.Substring(PositionDelWkPlanIndiv + 1, 4); // Buscamos de atrás para adelante los 4 últimos caracteres
        PopupMenuOpciones.Items[1].NavigateUrl = PopupMenuOpciones.Items[1].NavigateUrl.Replace(CadenaDelWeekEndPlanIndiv, Wk); // Sustituimos esa cadena por la nueva.        

        //Plan Provincial es el item 5 del menú. Buscamos donde dice Wk=X donde X es 1 o 0.
        int PositionDelWkPlanProv = PopupMenuOpciones.Items[5].NavigateUrl.LastIndexOf("&");
        string CadenaDelWeekEndPlanProv = PopupMenuOpciones.Items[5].NavigateUrl.Substring(PositionDelWkPlanProv + 1, 4); // Buscamos de atrás para adelante los 4 últimos caracteres
        PopupMenuOpciones.Items[5].NavigateUrl = PopupMenuOpciones.Items[5].NavigateUrl.Replace(CadenaDelWeekEndPlanProv, Wk); // Sustituimos esa cadena por la nueva.        

        //Vista detallada es el item 3 del menú. No muestra fines de semana        
    }

    //Establece los parámetros de la dirección que llama a la página de EJECUTAR, SUSPENDER, etc. 
    protected void ASPCallback_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
    {
        char[] Separador = new char[] { '|' };
        string[] Parametros = e.Parameter.Split(Separador);

        switch (Parametros[1])
        {
            case "Reprogramar":
                e.Result = String.Format("EventEdit.aspx?id={0}&op=RP&Mes={1}", Parametros[0], DropDownList_Mes.SelectedItem.Value);
                break;
            case "Suspender":
                e.Result = String.Format("EventEdit.aspx?id={0}&op=SS", Parametros[0]);
                break;
            case "Ejecutada":
                e.Result = String.Format("EventEdit.aspx?id={0}&op=EX", Parametros[0]);
                break;
            case "Progreso":
                e.Result = String.Format("EventEdit.aspx?id={0}&op=PG", Parametros[0]);
                break;
            case "CambiarFecha":
                e.Result = String.Format("EventEdit.aspx?id={0}&op=CF&Mes={1}", Parametros[0], DropDownList_Mes.SelectedItem.Value);
                break;
            case "Notificar":
                e.Result = String.Format("EventEdit.aspx?id={0}&op=NT", Parametros[0]);
                break;
            case "Modificar":
                e.Result = String.Format("EventAdvancEdit.aspx?id={0}&op=MD", Parametros[0]);
                break;
            case "Pendiente":
                e.Result = String.Format("EventEdit.aspx?id={0}&op=PN", Parametros[0]);
                break;
            case "Borrar":
                e.Result = String.Format("EventAdvancDelete.aspx?id={0}", Parametros[0]);
                break;
        }
    }

    //Este procedimiento conforma los valores que van en el filtro.
    private void FiltrarEventos()
    {
        //Asignamos el valor o vaciío según o que esté seleccionado
        string TipoAccionValue = (DropDownList_Filter.SelectedIndex == 0) ? "" : DropDownList_Filter.SelectedValue;
        string EstadoValue = DropDownList_Estado.SelectedIndex == 0 ? "" : DropDownList_Estado.SelectedValue;

        //Conformamos la cadena de filtrado  y asignamos la nueva cadena al objeto.
        SqlDataSource_PlanMes.FilterExpression = String.Format("TipoAccion like '%{0}%' and Estado like '%{1}%'", TipoAccionValue, EstadoValue);
    }

    //Al cambiar los valores seleccionados refrescamos los filtros de SQLDataSourcePlanMes.
    protected void DropDownList_Filter_SelectedIndexChanged(object sender, EventArgs e)
    {
        MonthView.DataBind();
        MonthView.Update(CallBackUpdateType.EventsOnly);
    }
    protected void DropDownList_Estado_SelectedIndexChanged(object sender, EventArgs e)
    {
        MonthView.DataBind();
        MonthView.Update(CallBackUpdateType.EventsOnly);
    }

    //Antes de seleccionar filtramos los valores.
    protected void SqlDataSource_PlanMes_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        FiltrarEventos();
    }

    // Cuando cambiamos el check box actualizamos los enlaces de imprimir el plan mensual.
    protected void CheckBox_WeekEnd_CheckedChanged(object sender, EventArgs e)
    {
        ActualizarEnlacesDeImprimirVistasDelPlan(CheckBox_WeekEnd.Checked);
    }

    //Procedimiento para obtener los datos de la estadística del dpto.
    private void RefrescarEstadistica(SqlDataSourceStatusEventArgs e)
    {
        //Variables necesarias del procedimiento
        // DataReader para obtener los datos
        e.Command.Connection.Open();
        System.Data.Common.DbDataReader TareasDataReader = e.Command.ExecuteReader(CommandBehavior.Default);
        
        //Contadores
        int Planificadas = 0,
            Incumplidas = 0,
            Modificadas = 0,
            Cumplidas = 0;

        if (TareasDataReader.HasRows)
        {
            while (TareasDataReader.Read())
            {
                Planificadas++;

                if (TareasDataReader["Estado"].ToString() == "Ejecutada")
                    Cumplidas++;
                else
                    if ((TareasDataReader["Estado"].ToString() == "Suspendida") || (TareasDataReader["Estado"].ToString() == "Pendiente"))
                        Incumplidas++;
                    else
                        if ((TareasDataReader["Estado"].ToString() == "Reprogramada") || (TareasDataReader["Estado"].ToString() == "En progreso"))
                            Modificadas++;
            }            
        }

        //Guardamos en la session losd datos de la estadistica
        Session.Add("Cumplidas", Cumplidas);
        Session.Add("Incumplidas", Incumplidas);
        Session.Add("Modificadas", Modificadas);
        Session.Add("Planificadas", Planificadas);
    }

    //Cuando se terminan de seleccionar los datos de las tareas se refresca las estadísticas mostradas
    protected void SqlDataSource_PlanMes_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {       
        RefrescarEstadistica(e);
        MostrarEstadistica();
    }

    //Mostrar los datros de las estadística
    protected void PanelEstadistica_Callback(object source, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
    {
        MostrarEstadistica();   
    }

    //Leemos del session y mostramos en los labels.
    private void MostrarEstadistica()
    {
        
        Label_Cumplidas.Text = int.Parse(Session["Cumplidas"].ToString()).ToString();
        Label_Incumplidas.Text = int.Parse(Session["Incumplidas"].ToString()).ToString();
        Label_Modificadas.Text = int.Parse(Session["Modificadas"].ToString()).ToString();
        Label_Planificadas.Text = int.Parse(Session["Planificadas"].ToString()).ToString();
        Label_Hora.Text = DateTime.Now.ToShortTimeString();
    }
    
    protected void MonthView_EventMove(object sender, EventMoveEventArgs e)
    {
        if (e.Tag["Estado"] == "Ejecutada")
        {
            MonthView.DataBind();
            MonthView.UpdateWithMessage("Solo se puede mover las tareas que no estén ejecutadas.");
        }
        else
        {
            //Cambiar fecha
            DataSet_GestorTareasTableAdapters.EjecucionTableAdapter Ejecuc_TableAdapt = new DataSet_GestorTareasTableAdapters.EjecucionTableAdapter();

            try
            {
                Ejecuc_TableAdapt.Update_CambiarFecha(e.NewStart, e.NewEnd, Convert.ToInt32(e.Value));
                MonthView.DataBind();
                MonthView.UpdateWithMessage("Su tarea se cambió de fecha exitosamente.");
            }
            catch (Exception)
            {
                MonthView.UpdateWithMessage("Ha ocurrido un error al actualizar la tarea. Intente de nuevo.");
            }  
        }


        
    }
    protected void MonthView_EventResize(object sender, EventResizeEventArgs e)
    {       
        if (e.Tag["Estado"] == "Ejecutada")
        {
            MonthView.DataBind();
            MonthView.UpdateWithMessage("Solo se puede modificar las tareas que no estén ejecutadas.");
        }
        else
        {
            //Cambiar fecha
            DataSet_GestorTareasTableAdapters.EjecucionTableAdapter Ejecuc_TableAdapt = new DataSet_GestorTareasTableAdapters.EjecucionTableAdapter();

            try
            {
                Ejecuc_TableAdapt.Update_CambiarFecha(e.NewStart, e.NewEnd, Convert.ToInt32(e.Value));
                MonthView.DataBind();
                MonthView.UpdateWithMessage("Su tarea se cambió de fecha exitosamente.");
            }
            catch (Exception)
            {
                MonthView.UpdateWithMessage("Ha ocurrido un error al actualizar la tarea. Intente de nuevo.");
            }
        }
    }
}