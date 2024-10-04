using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Planning_PlanMain : System.Web.UI.Page
{
    DataSet_GestorTareas.TrabajadorDataTable Trabajador;
    DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter TableAdapt_Trabajador;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["Anio"] == null)
                Response.Redirect("~/Index.aspx");
            else
                PopupControl_AddPlan.ContentUrl = "~/Planning/PlanNew.aspx?Anio=" + Request.QueryString["Anio"].ToString();
        }

        TableAdapt_Trabajador = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
        Trabajador = new DataSet_GestorTareas.TrabajadorDataTable();
        TableAdapt_Trabajador.FillBy_NID(Trabajador, Session["NID"].ToString());
    }

    //Asignar valores de las fechas
    //protected void SqlDataSource_Details_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    //{
    //    DateField ValorFechaInicio = (DateField)FormView_Insert.FindControl("DateField_Desde");
    //    DateField ValorFechaCierre = (DateField)FormView_Insert.FindControl("DateField_Hasta");

    //    e.Command.Parameters["@FechaInicio"].Value = ValorFechaInicio.SelectedDate;
    //    e.Command.Parameters["@FechaCierre"].Value = ValorFechaCierre.SelectedDate;
    //}

    // refrescar el listado de planes
    //protected void FormView_Insert_ItemInserted(object sender, FormViewInsertedEventArgs e)
    //{
    //    GridView_Planes.DataBind();
    //}

    //Al cargar el control de Tipo de plan si el usuario no puede planificar a otros no se activa.
    //protected void RadioButtonList_AlcancePlan_Load(object sender, EventArgs e)
    //{
    //    RadioButtonList AlcanceList = sender as RadioButtonList;
    //    if (AlcanceList != null)
    //    {
    //        if (Trabajador.Count != 0)
    //        {
    //            if (!Trabajador[0].Planifica)
    //            {
    //                System.Web.UI.WebControls.ListItem ItemPersonal = AlcanceList.Items.FindByText("Individual");
    //                ItemPersonal.Selected = true;
    //                AlcanceList.Enabled = false;
    //            }
    //            else
    //            {
    //                AlcanceList.Enabled = true;
    //            }
    //        }
    //        else
    //        {
    //            Response.Redirect("~/Planning/PlanMonthView.aspx");
    //        }
    //    }
    //}

    protected void DropDownList_Anio_DataBound(object sender, EventArgs e)
    {
        if (DropDownList_Anio.Items.Count == 0)
            DropDownList_Anio.Items.Add(DateTime.Now.Year.ToString());

        DropDownList_Anio.SelectedValue = Request.QueryString["Anio"].ToString();
        GridView_Planes.DataBind();
    }

    

    //protected void Button_Terminar_Click(object sender, EventArgs e)
    //{
    //    FormView_Insert.Visible = false;
    //}     

    #region Operaciones de los botones para imprimir los Planes
    protected void Button_PlanFormac_Aceptar_Click(object sender, EventArgs e)
    {
        ConformarEnlaceImprimirRedireccionar("frm");
    }
    protected void Button_Prevencion_Click(object sender, EventArgs e)
    {
        ConformarEnlaceImprimirRedireccionar("prv");
    }
    protected void Button_Capacitacion_Click(object sender, EventArgs e)
    {
        ConformarEnlaceImprimirRedireccionar("cps");
    }
    
    private void ConformarEnlaceImprimirRedireccionar(string Destino)
    {
        string UrlDestino = "~/Planning/PlanPrintAll.aspx?"; // Esta es la de todos excepto el plan de trabajo.        

        switch (Destino)
        {
            case "frm": // Formación
                //Response.Redirect(UrlDestino + "type=" + Destino + "&anio=" + DropDownList_Anio.SelectedValue + "&nid=" + DropDownList_Subordinado.SelectedValue + "&planid=" + DropDownList_NombrePlan.SelectedValue, true);
                break;
            case "cps": // Capacitación y Prevención tienen los mismos parámetros                
            case "prv":
                Response.Redirect(UrlDestino + "type=" + Destino + "&anio=" + DropDownList_Anio.SelectedValue, true);
                break;
            case "trb": //Trabajo Mensual                                
                //Response.Redirect( "~/Planning/PlanPrint.aspx?anio=" + DropDownList_Anio.SelectedValue, true);
                break;
        }
    }
    #endregion   
   
    protected void Callback_PlanTrabajo_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
    {
//        e.Result = "PlanPrint.aspx?Anio=" + DropDownList_Anio.SelectedValue + "&Mes=" + DropDownList_Meses.SelectedValue + "&Plan=" + DropDownList_TrabajoListPlanes.SelectedValue;
    }   

    //Al cambiar el año actualizamos el enlace del POPUPCONTROL para adicionar plan.
    protected void DropDownList_Anio_SelectedIndexChanged(object sender, EventArgs e)
    {
        PopupControl_AddPlan.ContentUrl = "~/Planning/PlanNew.aspx?Anio=" + DropDownList_Anio.SelectedValue;
    }
    
    //al invocar el CallBack del Panel refrescamos el GridView.
    protected void CallbackPanel_Callback(object source, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
    {
        GridView_Planes.DataBind();
    }
}
