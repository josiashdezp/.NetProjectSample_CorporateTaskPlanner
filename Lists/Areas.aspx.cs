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

public partial class Lists_Dptos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsCallback)
            Label_Mnsg.Visible = false;
    }  
    
    
    protected void GridView_Areas_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            SqlDataSource_AreasDptos.DeleteParameters[0].DefaultValue = e.Keys[0].ToString();
            SqlDataSource_AreasDptos.Delete();
        }
        catch (SqlException)
        {
            Label_Mnsg.Text = "No es posible borrar el registro seleccionado. Es posible se encuentre relacionado con algún departamento o trabajador.";
            Label_Mnsg.Visible = true;
        }     
    }
}
