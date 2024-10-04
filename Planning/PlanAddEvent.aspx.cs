using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Planning_PlanAddEvent : System.Web.UI.Page
{
    //Los datos PlanId y Nro están en el QueryString y NID del Planificador en el Session
    DateTime Desde, Hasta;
    string Nombre;
    
    //Esta estructura la usamos para almacenar los datos del responsable.
    private struct StructResponsable
    {
        public string NID;
        public string Nombre;
    }
    
    //Controles de Datos que se usa en la página
    DataSet DataSet_Ejecucion;
    DataSet_GestorTareas.EjecucionInsertDataTable TablaInsertar;
    DataSet_GestorTareas.EjecucionDataTable TablaEjecuciones;

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Wizard_Add.ActiveStepIndex = 0;
            LimpiarSession();            
        }           
    }

    //En el load se configura el FORM según el usuario
    protected void Wizard_Add_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count != 0)
        {
            //Asignación de valores a los controles de la página
            Wizard_Add.CancelDestinationPageUrl = "~/Planning/PlanMonthView.aspx?PlanID=" + Convert.ToInt16(Request.QueryString["PlanID"]) + "&Anio=" + Request.QueryString["Anio"];

            DataSet_GestorTareas.PlanAccionesDataTable Table_Planes;

            if (Page.IsPostBack)
            {
                Table_Planes = (DataSet_GestorTareas.PlanAccionesDataTable)Session["Table_Planes"];

                if (Table_Planes.Count != 0)
                {
                    Desde = Table_Planes[0].FechaInicio;
                    Hasta = Table_Planes[0].FechaCierre;
                    Nombre = Table_Planes[0].Nombre;

                    switch (Wizard_Add.ActiveStep.ID)
                    {
                        case "WizardStep_Acciones":
                            Label_msg_1.Visible = false;

                            //Asignamos los valores al validator para que cuando se cargue el control lo tome ya
                            DateOrFrecuencySelector_Program.MinDateValue = Desde;
                            DateOrFrecuencySelector_Program.MaxDateValue = Hasta;   
 
                            //Configuramos el POPUPCONTROL.
                            PopupControlAddTarea.ContentUrl = "~/Planning/Tasks.aspx?Type=" + DropDownList_Tipos.SelectedItem.Value;

                            break;
                        case "WizardStep_Programar":
                            Label_Error.Visible = false;
                            Label_Msg.Visible = false;
                            DateOrFrecuencySelector_Program.MinDateValue = Desde;
                            DateOrFrecuencySelector_Program.MaxDateValue = Hasta;                            

                            /* Al cargar la página si estamos en la opción de
                             * programar las tareas hay que crear el DataSet o 
                             * cargarlo desde el SESSION.
                             */

                            CargarGridViewDesdeDataSet();
                            break;
                        case "WizardStep_Finalizar":
                            CargarGridViewDesdeDataSet();
                            break;
                    }
                }
            }
            else
            {
                //Como es la primera vez lo creamos
                DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter TableAdap_Planes = new DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter();
                Table_Planes = TableAdap_Planes.GetDataBy_AnioPlanIDAndNID(Convert.ToInt16(Request.QueryString["PlanID"]), Request.QueryString["Anio"], Session["NID"].ToString());
                
                //Guardamos los datos en las variables
                Desde = Table_Planes[0].FechaInicio;
                Hasta = Table_Planes[0].FechaCierre;
                Nombre = Table_Planes[0].Nombre;
                
                //Cargamos la tabla en la sesión
                Session.Add("Table_Planes", Table_Planes);
            }
        }
        else
        {
            Response.Redirect("../Index.aspx");
        }
    }
    
    //Al cambia el paso se hacen operaciones según el paso que sea.
    protected void Wizard_Add_ActiveStepChanged(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            switch (Wizard_Add.ActiveStep.ID)
            {
                case "WizardStep_Acciones": break;

                case "WizardStep_Programar":
                    #region Al cambiar a PROGRAMAR se configuran los valores predeterminados.
                   
                    //Limpiamos los controles antes de asignar valores.
                    ListBox_Acciones.Items.Clear();

                    //Cargamos las acciones desde SESSION y seleccionamos la primera
                    Dictionary<string, string> Acciones = (Dictionary<string, string>)Session["AccionesSelecc"];
                    foreach (KeyValuePair<string, string> Accion in Acciones)
                    {
                        ListItem NuevaAccion = new ListItem(Server.HtmlDecode(Accion.Value), Accion.Key);
                        ListBox_Acciones.Items.Add(NuevaAccion);
                    }
                    ListBox_Acciones.SelectedIndex = 0;

                    //Enlazo a datos, el objeto se cargó en el LOAD.
                    CargarGridViewDesdeDataSet();
                    GridView_ProgramInsert.DataBind();
                    #endregion
                    break;

                case "WizardStep_Finalizar":
                    #region Al cambiar a FINALIZAR, se inserta en la BD las acciones programadas.
                    
                    HyperLink_Volver.NavigateUrl = Wizard_Add.CancelDestinationPageUrl;
                    TextBox_Logs.Text = "";

                    DataSet_GestorTareasTableAdapters.EjecucionTableAdapter Adapt_Ejecucion = new DataSet_GestorTareasTableAdapters.EjecucionTableAdapter();
                    TablaEjecuciones = Adapt_Ejecucion.GetDataBy_AnioPlanNID(Convert.ToInt16(Request.QueryString["PlanID"]), Request.QueryString["Anio"], Session["NID"].ToString());

                    for (int i = 0; i < TablaInsertar.Count; i++)
                    {
                        /*   NuevaEjecucion.EjecucionID -->Autonumérico
                             NuevaEjecucion.Observaciones --> Permite NULL
                             NuevaEjecucion.Aprobada --> Por defecto FALSE
                             NuevaEjecucion.Notificada --> Por defecto FALSE
                             NuevaEjecucion.Estado --> Por defecto es PN (pendiente)
                             NuevaEjecucion.FechaEjecutada --> Es cuando se ejecuta no se inserta ahora.
                             NuevaEjecucion.FechaNotificar -->Para si se va a avisar por correo. */

                        //Para evitar los errores a la hora de insertar muchos registros simultáneamente usamos INSERT del TablaAdapt en lugar del UPDATE.                        
                        try
                        {
                            //logs con datos de la tarea
                            TextBox_Logs.Text += String.Format("\n Tarea:'{0}' del trabajador: '{1}' con fecha ejecución : '{2}' y fecha de vencimiento: {3} ", TablaInsertar[i].AccionNombre, TablaInsertar[i].EjecutaNombre, TablaInsertar[i].FechasEjecucion.ToString(), TablaInsertar[i].FechaVencimiento.ToString());
                            
                            //insertamos y ponemos resultados.
                            Adapt_Ejecucion.Insert_DefaultValuesExec(Convert.ToInt16(Request.QueryString["PlanID"]), Request.QueryString["Anio"], Session["NID"].ToString(), TablaInsertar[i].AccionID, TablaInsertar[i].FechasEjecucion, TablaInsertar[i].FechaVencimiento, TablaInsertar[i].EjecutaID, TablaInsertar[i].ResponsableID, TablaInsertar[i].Detalles, TablaInsertar[i].OtrosImplicados );
                            TextBox_Logs.Text += "\n Tarea guardada exitosamente. \n";
                        }
                        catch (Exception ErrorUpdate)
                        {
                            //Si no el error.
                            TextBox_Logs.Text += "\n No se puede guardar la tarea. Causa : \n" + ErrorUpdate.Message + "\n";
                            continue;
                        }
                    }
                   
                    //Al terminar liberamos las variables ocupadas en memoria para insertar nuevos registros.
                    LimpiarSession();

                    #endregion
                    break;
            }
        }
    }    
    
    //En el bottón NEXT se valida el FORM antes de cambiar.
    protected void Wizard_Add_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        bool EsValida = false;

        switch (Wizard_Add.WizardSteps[e.CurrentStepIndex].ID)
        {
            case "WizardStep_Acciones": //Validamos el GridView y las acciones seleccionadas las guardamos en una lista en SESSION
              
                Dictionary<string, string> AccionesList = new Dictionary<string, string>(); 
                foreach (GridViewRow Fila in GridView_Acciones.Rows)
                {
                    CheckBox Seleccionada = (CheckBox)Fila.Cells[0].FindControl("CheckBox_Select");
                    if (Seleccionada.Checked)
                    {                        
                        EsValida = true;
                        AccionesList.Add(GridView_Acciones.DataKeys[Fila.RowIndex].Value.ToString(), Fila.Cells[2].Text);
                    }
                }
                if (EsValida) Session.Add("AccionesSelecc",AccionesList);

                Label_msg_1.Visible = !EsValida;
                e.Cancel = !EsValida;
                break;

            case "WizardStep_Programar":
                //TODO: Validar el form PROGRAMAR              
                break;
        }
    }

    //TODO: Revisar este procedimiento
    private void InsertarEnDataTableEjecucion(DataSet_GestorTareas.EjecucionRow FilaEjecucion, DataSet_GestorTareas.EjecucionInsertRow FilaEjecucionVista)
    {
        string Fecha = (FilaEjecucionVista.FrecuenciaTipo == "Permanente") ? "Período del plan" : FilaEjecucion.FechaPlanificada.ToShortDateString();
        string Msg = String.Format("\n Tarea:'{0}' del trabajador: '{1}' con fecha: '{2}': ", FilaEjecucionVista.AccionNombre, FilaEjecucionVista.EjecutaNombre, Fecha);

        try
        {
            TablaEjecuciones.AddEjecucionRow(FilaEjecucion);
            Msg += "Lista para guardarse. \n";
        }
        catch (Exception Error)
        {
            Msg += "No se podrá guardar. Causa: \n" + Error.Message + "\n";
        }
        finally
        {
            TextBox_Logs.Text += Msg;
        }
    }

    //Cargar datos de la ejecución configurada.
    protected void ButtonAddProgram_Click(object sender, EventArgs e)
    {
        #region Variables necesarias en el Procedimiento

        //Acá guardo el listado de fechas definitivas a insertar
        List<DateTime> ListaDeFechas = new List<DateTime>();

        //Acciones seleccionadas para programar
        Dictionary<int, string> ListaAccionesAInsertar = new Dictionary<int, string>();

        //Ejecutores seleccionados
        Dictionary<string, string> ListaDeEjecutores = new Dictionary<string, string>();

        //Datos del responsable.
        StructResponsable Responsable;

        //Referencia cultual del sitio para mostrar nombre del día de la semana.
        CultureInfo CultInfo = CultureInfo.CurrentCulture;

        #endregion

        #region Datos del Ejecutor y los Responsables

        //Ejecutores
        for (int ind = 0; ind < ListBox_Ejecuta.Items.Count; ind++)
        {
            if (ListBox_Ejecuta.Items[ind].Selected)
                ListaDeEjecutores.Add(ListBox_Ejecuta.Items[ind].Value, ListBox_Ejecuta.Items[ind].Text);
            else continue;
        }

        //Responsable        
        Responsable.NID = DropDownList_ResponsablesSelecc.SelectedValue;
        Responsable.Nombre = DropDownList_ResponsablesSelecc.SelectedItem.Text;              

        #endregion

        #region Acciones a Insertar

        for (int j = 0; j < ListBox_Acciones.Items.Count; j++)
            if (ListBox_Acciones.Items[j].Selected)
                ListaAccionesAInsertar.Add(Convert.ToInt16(ListBox_Acciones.Items[j].Value), ListBox_Acciones.Items[j].Text);

        #endregion

        #region Insertamos las Acciones por cada Ejecutor

        /******************************************************************* 
         * En este punto ya tengo la lista de EJECUTORES por cada acción seleccionada
         * y por cada ejecutor se van a generar fechas para insertar
         * *****************************************************************/

        foreach (KeyValuePair<int, string> Accion in ListaAccionesAInsertar)
        {
            foreach (KeyValuePair<string, string> Ejecutor in ListaDeEjecutores)
            {
                //Para validar el formulario del control
                bool FormOK = false;

                //Se valida según el tipo de programación
                if (DateOrFrecuencySelector_Program.TipoFrecuencia == "Fecha")
                    FormOK = DateOrFrecuencySelector_Program.validar_DatosDeFechaValidos();
                else
                    FormOK = DateOrFrecuencySelector_Program.validar_DatosDeFrecuenciaValidos();

                //Si no hay problemas en el formulario y están los datos de programación OK
                Dictionary<DateTime, DateTime> FechasAInsertar;
                if (FormOK)
                {
                    FechasAInsertar = DateOrFrecuencySelector_Program.ObtenerFechasDeEjecuciones();

                    //Para cada fecha generada se inserta un registro.        
                    foreach (DateTime FechaInicio in FechasAInsertar.Keys)
                    {
                        //Creamos la fila a insertar
                        DataSet_GestorTareas.EjecucionInsertRow NuevaEjecucion = TablaInsertar.NewEjecucionInsertRow();

                        //Llenamos los datos de la acción y ejecucion.
                        NuevaEjecucion.AccionID = Accion.Key;
                        NuevaEjecucion.AccionNombre = Accion.Value;
                        NuevaEjecucion.Detalles = TextBox_Detalles.Text;
                        NuevaEjecucion.FrecuenciaTipo = DateOrFrecuencySelector_Program.TipoFrecuencia;

                        //Datos del Ejecutor, Responsable y Otros Implicados.
                        NuevaEjecucion.EjecutaID = Ejecutor.Key.ToString();
                        NuevaEjecucion.EjecutaNombre = Ejecutor.Value.ToString();
                        NuevaEjecucion.ResponsableID = Responsable.NID;
                        NuevaEjecucion.ResponsableNombre = Responsable.Nombre;
                        NuevaEjecucion.OtrosImplicados = TextBox_OtrosImplicados.Text;

                        //Datos de la programación
                        NuevaEjecucion.FrecuenciaTipo = DateOrFrecuencySelector_Program.TipoFrecuencia;
                        NuevaEjecucion.FechasEjecucion = FechaInicio;
                        NuevaEjecucion.FechaVencimiento = FechasAInsertar[FechaInicio];

                        if (NuevaEjecucion.FechasEjecucion != NuevaEjecucion.FechaVencimiento)
                            NuevaEjecucion.Dia = "Por rango";
                        else
                            NuevaEjecucion.Dia = CultInfo.DateTimeFormat.GetDayName(FechaInicio.DayOfWeek);

                        //Intentamos insertar.
                        short Counter = 0;
                        try
                        {
                            DataSet_Ejecucion.Tables["EjecucionInsert"].Rows.Add(NuevaEjecucion);
                        }
                        catch (Exception)
                        {
                            Counter++;
                            continue;
                        }

                        //Mostrar Mensajes de resultados.
                        if (Counter == 0)
                        {
                            Label_Msg.Visible = true;
                            Label_Error.Visible = false;
                        }
                        else
                        {
                            Label_Msg.Visible = false;
                            Label_Error.Visible = true;
                        }
                    }
                }
            }
        }

        #endregion

        //Terminamos mostramos en el listado.
        GridView_ProgramInsert.DataBind();

        //Reiniciamos el formulario de Programación
        ReiniciarFormularioProgramarCompleto();

        //Guardamos en SESSION
        if (Session["DataSet_Ejecucion"] == null)
            Session.Add("DataSet_Ejecucion", DataSet_Ejecucion);
        else
            Session["DataSet_Ejecucion"] = DataSet_Ejecucion;
    }

    //Cargamos los valores del GridView desde el Session o los creamos.
    private void CargarGridViewDesdeDataSet()
    {
        if (Session["DataSet_Ejecucion"] == null)
        {
            DataSet_Ejecucion = new DataSet();
            TablaInsertar = new DataSet_GestorTareas.EjecucionInsertDataTable();
            DataSet_Ejecucion.Tables.Add(TablaInsertar);
        }
        else
        {
            DataSet_Ejecucion = (DataSet)Session["DataSet_Ejecucion"];
            TablaInsertar = (DataSet_GestorTareas.EjecucionInsertDataTable)DataSet_Ejecucion.Tables["EjecucionInsert"];
        }
        
        GridView_ProgramInsert.DataSource = DataSet_Ejecucion;
        GridView_ProgramInsert.DataBind();
    }

    #region ON LOAD, del encabezado del WIZARD, muestra datos.

    protected void Label_Nombre_Load(object sender, EventArgs e)
    {
        Label lbl_Nombre = sender as Label;
        if (lbl_Nombre != null) { lbl_Nombre.Text = Nombre; }
    }
    protected void Label_Desde_Load(object sender, EventArgs e)
    {
        Label lbl_Desde = sender as Label;
        if (lbl_Desde != null) { lbl_Desde.Text = Desde.ToShortDateString(); }
    }
    protected void Label_Hasta_Load(object sender, EventArgs e)
    {
        Label lbl_Hasta = sender as Label;
        if (lbl_Hasta != null) { lbl_Hasta.Text = Hasta.ToShortDateString(); }
    }

    #endregion        
    
    //Al cancelar liberamos la memoria de los objetos usados.
    protected void Wizard_Add_CancelButtonClick(object sender, EventArgs e)
    {
        LimpiarSession();
    }

    //Limpiamos el SESSION de los objetos que se utilizados
    private void LimpiarSession()
    {
        Session.Remove("DataSet_Ejecucion");
        Session.Remove("AccionesSelecc");
    }    
    
    //Borrar la programación que se configuró de la tabla 
    protected void GridView_ProgramInsert_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        TablaInsertar.Rows.RemoveAt(GridView_ProgramInsert.Rows[e.RowIndex].DataItemIndex);
        GridView_ProgramInsert.DataBind();
    }
        
    protected void LinkButton_Reiniciar_Click(object sender, EventArgs e)
    {
        Wizard_Add.ActiveStepIndex = 0;
    }

    private void ReiniciarFormularioProgramarCompleto()
    {
        TextBox_Detalles.Text = "";        

        //Reiniciamos el control de fechas o frecuencias.
        DateOrFrecuencySelector_Program.ReiniciarFormulario();
    }

    //Al cambiar la acción seleccionada, limpiamos los detalles de la ejecución.
    protected void DropDownList_Acciones_SelectedIndexChanged(object sender, EventArgs e)
    {        
        TextBox_Detalles.Text = "";
    }
    
    //al enlazar si la hora es 12:00 am no la muestra; porque esa es la del valor vacio por defecto.
    protected void GridView_ProgramInsert_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex != -1)
        {
            Label lbl_Hora = (Label)e.Row.Cells[8].FindControl("Label_Hora");
            if (lbl_Hora != null)
                if (lbl_Hora.Text == "12:00 a.m.")
                    lbl_Hora.Text = "--:--";                
        }                        
    }
    
    //Al cambiar se actualiza la dirección de la página del popup.
    protected void DropDownList_Tipos_SelectedIndexChanged(object sender, EventArgs e)
    {
        PopupControlAddTarea.ContentUrl = "~/Planning/Tasks.aspx?Type=" + DropDownList_Tipos.SelectedItem.Value;
    }
    protected void DropDownList_Tipos_DataBound(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            if (Request.QueryString["Type"] != null)
                DropDownList_Tipos.SelectedIndex = DropDownList_Tipos.Items.IndexOf(DropDownList_Tipos.Items.FindByValue(Request.QueryString["Type"]));
    }

    //En los controles de lista se selecciona por defecto el usuario conectado.
    protected void ListBox_Ejecuta_DataBound(object sender, EventArgs e)
    {        
        ListBox_Ejecuta.SelectedIndex = ListBox_Ejecuta.Items.IndexOf(ListBox_Ejecuta.Items.FindByValue(Session["NID"].ToString()));        
    }
    
    //Borra la programación actual para configurar otra.
    protected void Button_DeleteAll_Click(object sender, EventArgs e)
    {
        TablaInsertar.Rows.Clear();
        GridView_ProgramInsert.DataBind();         
    }
}
