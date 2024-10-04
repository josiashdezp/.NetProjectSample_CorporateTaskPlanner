using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Lists_Positions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsCallback)
        {
            Label_Error.Visible = false;
        }
    }    
    
    protected void GridView_Cargos_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        try
        {
            SqlDataSource_Cargos.DeleteParameters["CargoID"].DefaultValue = e.Keys["CargoID"].ToString();
            SqlDataSource_Cargos.Delete();
        }
        catch (SqlException)
        {
            Label_Error.Text = "No es posible borrar el registro seleccionado. Es posible se encuentre relacionado con algún trabajador.";
            Label_Error.Visible = true;
            
        }
    }
}
