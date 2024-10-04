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

        //Si es la primera vez que se carga 
        if ((!Page.IsPostBack) && (!Page.IsCallback))
        {
            //Establecemos valores predeteminados desde el 1ro al fin de mes.
            DateField_Desde.SelectedDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            DateField_Hasta.SelectedDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month));

            //Mostrar vista de detalles o normal. Es decir GridView o Datalist.
            CheckBox_vistaDetallada_CheckedChanged(sender, e);
        }
    }

    ////Seleccionar el año actual por defecto o el que estaba antes de cargar la página
    //protected void DropDownList_Anio_DataBound(object sender, EventArgs e)
    //{
    //    if (!Page.IsPostBack)
    //    {
    //        if (DropDownList_Anio.Items.Count > 0)
    //            if (Request.QueryString.Count != 0)
    //                if (Request.QueryString["Goto"] != null)
    //                    DropDownList_Anio.SelectedValue = Convert.ToDateTime(Request.QueryString["Goto"]).Year.ToString();
    //                else
    //                    DropDownList_Anio.SelectedValue = Request.QueryString["Anio"].ToString();
    //            else
    //                DropDownList_Anio.SelectedValue = DateTime.Now.Year.ToString();
    //        else
    //            DropDownList_Anio.Items.Add(DateTime.Now.Year.ToString());
    //    }
    //}


    //Este procedimiento conforma los valores que van en el filtro.
    private void FiltrarEventos()
    {
        //Asignamos el valor o vaciío según o que esté seleccionado
        string TipoAccionValue = (DropDownList_Tipo.SelectedIndex == 0) ? "" : DropDownList_Tipo.SelectedValue;
        string EstadoValue = "";

        //Conformamos la cadena de filtrado  y asignamos la nueva cadena al objeto.
        ObjectDataSource_Ejecuciones.FilterExpression = String.Format("TipoAccion like '%{0}%' and Estado like '%{1}%'", TipoAccionValue, EstadoValue);
    }

    //Al cambiar los valores seleccionados refrescamos los filtros de SQLDataSourcePlanMes.
    protected void DropDownList_Estado_SelectedIndexChanged(object sender, EventArgs e)
    {
        //MonthView.DataBind();
        //MonthView.Update(CallBackUpdateType.EventsOnly);
    }
   

    protected void ASPxCallback_Resultados_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
    {
        switch(e.Parameter)
        {
            case "cargar":
                ObjectDataSource_Ejecuciones.Select();
                //GridView_Resultados.DataBind();
                //DataList_Detalles.DataBind();
                break;
            case "detalles":
                DataList_Detalles.DataBind();
                DataList_Detalles.Visible = CheckBox_vistaDetallada.Checked;
                GridView_Resultados.Visible = !DataList_Detalles.Visible;
                break;            
        }        
    }

    // Pintamos la celda según el estado de la tarea.
    protected void GridView_Resultados_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex > -1)
        {
            DataRowView FilaDatos = (DataRowView)e.Row.DataItem;
            e.Row.Cells[8].Style.Add(HtmlTextWriterStyle.BackgroundColor, FilaDatos["EstadoColor"].ToString());
        }           
    }
    
    //Mostrar u ocultar el gridview o el datalist para ver todos los campos 
    protected void CheckBox_vistaDetallada_CheckedChanged(object sender, EventArgs e)
    {
        DataList_Detalles.Visible = CheckBox_vistaDetallada.Checked;
        GridView_Resultados.Visible = !DataList_Detalles.Visible;
    }

    //Poner item vacía cuando no haya nada 
    protected void DropDownList_Nombre_DataBound(object sender, EventArgs e)
    {
        if (DropDownList_Nombre.Items.Count == 0)
        {
            ListItem ItemVacia = new ListItem("- No existen acciones registradas -", "0");
            DropDownList_Nombre.Items.Add(ItemVacia);
        }
    }    
}