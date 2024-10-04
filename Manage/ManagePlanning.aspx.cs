using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;

using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Manage_ManagePlanning : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
   
    protected void DropDownList_Anio_DataBound(object sender, EventArgs e)
    {
        //Al cargar la página por primera vez.
        if (!Page.IsPostBack)
        {
            //Si en la lista mostrada no está el año actual, lo adiciono.
            if (!DropDownList_Anio.Items.Contains(DropDownList_Anio.Items.FindByValue(DateTime.Now.Year.ToString())))
                DropDownList_Anio.Items.Add(DateTime.Now.Year.ToString());

            if (Request.QueryString.Count != 0)
                DropDownList_Anio.SelectedValue = Request.QueryString["Anio"].ToString();
            else
                DropDownList_Anio.SelectedValue = DateTime.Now.Year.ToString();

            MonthView.StartDate = new DateTime(Convert.ToInt16(DropDownList_Anio.SelectedValue), Convert.ToInt16(DropDownList_Mes.SelectedValue), 1);
            AsignarFiltroAnio(MonthView.StartDate.Year.ToString());
        }
    }
    protected void DropDownList_Anio_SelectedIndexChanged(object sender, EventArgs e)
    {
        AsignarFiltroAnio(DropDownList_Anio.SelectedValue);
    }

    protected void DropDownList_Mes_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList_Mes.SelectedValue = DateTime.Today.Month.ToString();
            AsignarFiltroMes(DateTime.Today.Month.ToString());
        } 
    }
    protected void DropDownList_Mes_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList_Mes.SelectedValue != "0")
        {
            MonthView.StartDate = new DateTime(Convert.ToInt16(DropDownList_Anio.SelectedValue), Convert.ToInt16(DropDownList_Mes.SelectedValue), 1);
            AsignarFiltroMes(DropDownList_Mes.SelectedValue);
        }
        else
        {
            MonthView.StartDate = new DateTime(Convert.ToInt16(DropDownList_Anio.SelectedValue), DateTime.Today.Month, 1);
            AsignarFiltroMes(DateTime.Today.Month.ToString());
        }

        MonthView.Update(CallBackUpdateType.Full);
    }

    protected void DropDownList_Subordinados_DataBound(object sender, EventArgs e)
    {
        AsignarFiltroSubordinado(DropDownList_Subordinados.SelectedValue);
    }
    protected void DropDownList_Subordinados_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Si selecciona todos los subordinados no se podrá imprimir.
        ConfigurarImpresion();
        AsignarFiltroSubordinado(DropDownList_Subordinados.SelectedValue);
    }

    protected void DropDownList_Plan_DataBound(object sender, EventArgs e)
    {
        ListItem ItemVacia = new ListItem();        

        if ((DropDownList_Plan.Items.Count == 0)&&(DropDownList_Subordinados.SelectedValue != "11111111111"))
        {
            ItemVacia.Text = "- No tiene planes creados -";
            ItemVacia.Value = "-1";            
        }
        else
        {
            ItemVacia.Text = "- Todos los planes -";
            ItemVacia.Value = "0";            
            AsignarFiltroDePlan(ItemVacia.Value);
        }
        DropDownList_Plan.Items.Insert(0,ItemVacia);
        ConfigurarImpresion();
    }
    protected void DropDownList_Plan_SelectedIndexChanged(object sender, EventArgs e)
    {
        AsignarFiltroDePlan(DropDownList_Plan.SelectedValue);
    }

    //Procedimiento para configurar impresión
    private void ConfigurarImpresion()
    {
        HyperLink_Imprimir.Enabled = ((DropDownList_Subordinados.SelectedValue != "11111111111") && (DropDownList_Plan.SelectedValue != "-1"));
    }

    #region Procedimientos del MonthView
    protected void BubbleMonth_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderEventBubbleEventArgs)
        {
            RenderEventBubbleEventArgs re = e as RenderEventBubbleEventArgs;

            string FechaPlanificada, FechaCierra;

            FechaPlanificada = (re.Start.ToLongTimeString() == "11:11:11 a.m.") ? re.Start.ToShortDateString() : re.Start.ToShortDateString() + " " + re.Start.ToShortTimeString();
            FechaCierra = (re.End.ToLongTimeString() == "11:11:11 a.m.") ? re.End.ToShortDateString() : re.End.ToShortDateString() + " " + re.End.ToShortTimeString();
            re.InnerHTML =
                "<b>Plan:</b>&nbsp;" + re.Tag["NombrePlan"].ToString() + "<BR>" +
                "<b>Nombre:</b>&nbsp;" + re.Text +
                "<br><b>Descripción:</b><br />" + re.Tag["Descripcion"].ToString() +
                "<br><b>Detalles:</b><br />" + re.Tag["Detalles"].ToString() +
                "<br><b>Tipo de Tarea:</b>&nbsp;" + re.Tag["TipoAccion"].ToString() +
                "<br><b>Fecha Planificada:</b>&nbsp;" + FechaPlanificada +
                "<br><b>Fecha Vencimiento:</b>&nbsp;" + FechaCierra +
                "<br><b>Planificada por:</b><br />" + re.Tag["PlanificadorNombre"].ToString() +
                "<br><b>Ejecuta:</b><br />" + re.Tag["EjecutaNombre"].ToString() +
                "<br><b>Supervisa:</b><br />" + re.Tag["ResponsableNombre"].ToString() +
                "<br><b>Estado:</b>&nbsp;" + re.Tag["Estado"].ToString() +
                "<br><b>Observaciones:</b><br />" + re.Tag["Observaciones"].ToString() + "<br>";
        }
    }
    protected void MonthView_BeforeEventRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeEventRenderEventArgs e)
    {
        e.BackgroundColor = e.Tag["EstadoColor"];

        //Si se está mostrando todos los subordinados ponemos el nombre al lado de la tarea.
        if (DropDownList_Subordinados.SelectedValue == "11111111111")
            e.InnerHTML = e.Text + "(" + e.Tag["EjecutaUserName"] + ")";
    }
    protected void MonthView_EventMenuClick(object sender, EventMenuClickEventArgs e)
    {
        //Localizamos los trabajadores implicados 
        DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter TAdap_Trab = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
        DataSet_GestorTareas.TrabajadorDataTable Trabajadores = TAdap_Trab.GetDataBy_EjecucionID(Convert.ToInt16(e.Value));
        DataSet_GestorTareas.TrabajadorRow[] TrabajadoresImplicados = (DataSet_GestorTareas.TrabajadorRow[])Trabajadores.Select("NID <> '" + Session["NID"].ToString() + "'");

        //Creamos lista con direcciones de los RESPONSABLES y EJECUTORES
        List<string> Destinatarios = new List<string>();
        foreach (DataSet_GestorTareas.TrabajadorRow Trabajador in TrabajadoresImplicados) Destinatarios.Add(Membership.GetUser(Trabajador.UserID).Email);

        //Conformamos el contenido del mensaje
        string Cuerpo = "<h2>Notificación de Tareas Pendientes:</h2><hr />" +
                        "<b>Nombre de la Tarea:</b>" + e.Text + "<br />" +
                        "<b>Descripción:</b> " +
                        "<p>" + e.Tag["Descripcion"] + "</p>" +
                        "<b>Fecha Planificada:</b>" + e.Start.ToShortDateString() + "<br />" +
                        "<b>Fecha de Vencimiento:</b>" + e.End.ToShortDateString() + "<br />" +
                        "<b>Estado:</b>" + e.Tag["Estado"] + "<br />" +
                        "<b>Planificada por:</b>" + e.Tag["PlanificadorNombre"] + "<br />" +
                        "<b>Ejecutante:</b>" + e.Tag["EjecutaNombre"] + "<br />" +
                        "<b>Responsable:</b>" + e.Tag["ResponsableNombre"] + "<br />" +
                        "<br /><hr />" +
                        "<center>Planificador Online. Departamento de Automatización y Procedimientos. BANDEC. Cienfuegos. 2010.</center>";

        //Enviamos los EMAILs
        try
        {
            PlanificadorOnline Planificador = new PlanificadorOnline();
            Planificador.EnviarMensajeCorreo(Destinatarios, "Planificador Online. Aviso de tareas pendientes", Cuerpo);
            Label_msg.Text = "Mensaje enviado exitosamente. /n" + DateTime.Now.ToString();
            Label_msg.Visible = true;
        }
        catch (Exception Error)
        {
            Label_msg.Text = Error.Message;
            Label_msg.Visible = true;
        }
        finally
        {
            //TODO: Actualizar la página con CALLBACK
        }
    }
    protected void MonthView_Load(object sender, EventArgs e)
    {
        MonthView.ShowWeekend = CheckBox_WeekEnd.Checked;
        AsignarFiltroFinDeSemana();
    } 
    #endregion

    #region Para conformar los parámetros de filtrado de eventos para imprimir.

    private void AsignarFiltroMes(string aMes)
    {
        //Para asegurar que el mes tenga siempre 2 caracteres se rellena con 0 a la izq de ser necesario
        string MesString = (aMes.ToString().Length == 1) ? aMes.PadLeft(2, '0') : aMes;

        //Actualizar enlace del Hyperlink Imprimir Plan Mensual de subordinados
        int PositionDelMes = HyperLink_Imprimir.NavigateUrl.IndexOf("Mes");
        string CadenaDelMes = HyperLink_Imprimir.NavigateUrl.Substring(PositionDelMes, 6); // Buscamos desde ? hasta el final la cadena:  Mes=xx
        HyperLink_Imprimir.NavigateUrl = HyperLink_Imprimir.NavigateUrl.Replace(CadenaDelMes, "Mes=" + MesString); // Sustituimos esa cadena por la nueva.          
    }

    private void AsignarFiltroAnio(string aAnio)
    {
        //Actualizar enlace del Hyperlink Imprimir Plan Mensual de subordinados
        int PositionDelAnio = HyperLink_Imprimir.NavigateUrl.IndexOf("Anio");
        string CadenaDelAnio = HyperLink_Imprimir.NavigateUrl.Substring(PositionDelAnio, 9); // Buscamos Anio y le adicionamos los caracteres para completar hasta Anio=xxxx
        HyperLink_Imprimir.NavigateUrl = HyperLink_Imprimir.NavigateUrl.Replace(CadenaDelAnio, "Anio=" + aAnio); // Sustituimos esa cadena por la nueva.  
    }

    private void AsignarFiltroSubordinado(string aNID)
    {
        //Actualizar enlace del Hyperlink Imprimir Plan Mensual de subordinados
        int PositionDelNID = HyperLink_Imprimir.NavigateUrl.IndexOf("NID");
        string CadenaDelNID = HyperLink_Imprimir.NavigateUrl.Substring(PositionDelNID, 15); // Buscamos la palabra NID y le adicionamos 14 más hasta completar NID=xxxxxxxxxxx
        HyperLink_Imprimir.NavigateUrl = HyperLink_Imprimir.NavigateUrl.Replace(CadenaDelNID, "NID=" + aNID); // Sustituimos esa cadena por la nueva.  
    }

    private void AsignarFiltroDePlan(string aPlanID)
    {
        //Actualizar enlace del Hyperlink Imprimir Plan Mensual de subordinados
        int PositionDelPlanID = HyperLink_Imprimir.NavigateUrl.IndexOf("&Plan");
        string CadenaDelPlanID = HyperLink_Imprimir.NavigateUrl.Substring(PositionDelPlanID); // Buscamos la palabra Plan y se toma hasta el final de la cadena
        HyperLink_Imprimir.NavigateUrl = HyperLink_Imprimir.NavigateUrl.Replace(CadenaDelPlanID, "&Plan=" + aPlanID); // Sustituimos esa cadena por la nueva.  
    }

    private void AsignarFiltroFinDeSemana()
    {
        //True  = 1 y false = 0 
        int ValorBoolean = CheckBox_WeekEnd.Checked ? 1 : 0;
        
        //Actualizar enlace del Hyperlink Imprimir Plan Mensual de subordinados
        int PositionDelWk = HyperLink_Imprimir.NavigateUrl.IndexOf("Wk");
        string CadenaDelWk = HyperLink_Imprimir.NavigateUrl.Substring(PositionDelWk,4); // Buscamos la palabra Plan y se toma hasta el final de la cadena
        HyperLink_Imprimir.NavigateUrl = HyperLink_Imprimir.NavigateUrl.Replace(CadenaDelWk, "Wk=" + ValorBoolean.ToString()); // Sustituimos esa cadena por la nueva.  
    }

    #endregion

    //Si el parámetro es 11111111111 no se filtra, sino se muestran para todos los subordinados
    protected void SqlDataSource_Ejecucion_Filtering(object sender, SqlDataSourceFilteringEventArgs e)
    {
        if (e.ParameterValues["NID"].ToString() == "11111111111")
            e.ParameterValues["NID"] = null;
    }    
}