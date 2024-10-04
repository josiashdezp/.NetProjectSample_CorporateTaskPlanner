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

public partial class Lists_Scholarship : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        try
        {
            SqlDataSource_NivelEscolar.DeleteParameters["NivelID"].DefaultValue = e.Keys["NivelID"].ToString();
            SqlDataSource_NivelEscolar.Delete();
        }
        catch (SqlException)
        {
            Label_Error.Text = "No es posible borrar el registro seleccionado. Es posible se encuentre relacionado con algún trabajador.";
            Label_Error.Visible = true;            
        }
    }
}
