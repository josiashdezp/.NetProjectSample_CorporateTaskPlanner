using Coolite.Ext.Web;
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

public partial class Planning_PlanNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["Anio"] == null)
                Response.Redirect("~/Index.aspx");
            else
            {
                DropDownList ListAnio = (DropDownList)FormView_Insert.FindControl("DropDownList_Anio"); 

            }                
        } 
    }

    //Asignar valores de las fechas
    protected void SqlDataSource_Details_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        DateField ValorFechaInicio = (DateField)FormView_Insert.FindControl("DateField_Desde");
        DateField ValorFechaCierre = (DateField)FormView_Insert.FindControl("DateField_Hasta");

        e.Command.Parameters["@FechaInicio"].Value = ValorFechaInicio.SelectedDate;
        e.Command.Parameters["@FechaCierre"].Value = ValorFechaCierre.SelectedDate;
    }

    protected void DropDownList_Anio_DataBound(object sender, EventArgs e)
    {
        DropDownList List_Anio = sender as DropDownList;
        
        //Si está vacío ponemos el año actual
        if (List_Anio.Items.Count == 0)
            List_Anio.Items.Add(DateTime.Now.Year.ToString());
        
        //Adicionamos el año siguiente para planificaciones futuras..
        List_Anio.Items.Add((DateTime.Now.Year + 1).ToString());

        List_Anio.SelectedValue = Request.QueryString["Anio"].ToString();
    }    
}
