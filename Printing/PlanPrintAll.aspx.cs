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

public partial class Planning_PlanPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count != 0)
        {
            //Localizamos el ContentPlaceHolder de la página anterior y allí están los controles de la página.
            System.Web.UI.WebControls.ContentPlaceHolder Contenido = (System.Web.UI.WebControls.ContentPlaceHolder)PreviousPage.Form.Controls[7];

            switch (Request.QueryString["type"])
            {
                case "prv": //Prevención
                    Rpt_PlanPrevencion Rpt_Prevencion = new Rpt_PlanPrevencion();
                    ReportViewer_PrintReports.Report = Rpt_Prevencion;
                    break;
                case "VST"://Visitas
                    break;
                case "cpt "://Capacitación
                    //Rpt_PlanCapacitacion Rpt_Capacitacion = new Rpt_PlanCapacitacion();
                    //ReportViewer_PrintReports.Report = Rpt_Capacitacion;
                    break;

                case "frm"://Plan de Formación

                    //Leemos los datos de los controles
                    ListBox Subordinados = (ListBox)Contenido.FindControl("ListBox_Subordinados");
                    Coolite.Ext.Web.DateField Desde = (Coolite.Ext.Web.DateField)Contenido.FindControl("DateField_Desde");
                    Coolite.Ext.Web.DateField Hasta = (Coolite.Ext.Web.DateField)Contenido.FindControl("DateField_Hasta");

                    //Creamos el reporte
                    Rpt_PlanFormacion Rpt_Formacion = new Rpt_PlanFormacion();

                    //Filtrado de datos.
                    Rpt_Formacion.Parameters["Desde"].Value = Desde.SelectedDate.ToString();
                    Rpt_Formacion.Parameters["Hasta"].Value = Hasta.SelectedDate.ToString();
                    
                    //Asignacion al Report Viewer.
                    ReportViewer_PrintReports.Report = Rpt_Formacion;
                    break;
                default:
                    //XR_PlanMes Reporte = new XR_PlanMes();
                    //ReportViewer_PrintReports.Report = Reporte;
                    break;
            }
        }
    }
    protected void ReportViewer_PrintReports_Load(object sender, EventArgs e)
    {
        ReportToolbar1.Width = ReportViewer_PrintReports.Width;
    }
}
