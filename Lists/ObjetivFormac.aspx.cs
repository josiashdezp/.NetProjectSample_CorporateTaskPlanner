using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Lists_ObjetivFormac : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsCallback)
            Label_Mnsg.Visible = false;
    }

    protected void GridView_Objetivos_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            SqlDataSource_ObjetivosFormac.DeleteParameters[0].DefaultValue = e.Keys[0].ToString();
            SqlDataSource_ObjetivosFormac.Delete();
        }
        catch (SqlException Error)
        {
            Label_Mnsg.Text = "No es posible borrar el registro seleccionado. Causa:" + Error.Message;
            Label_Mnsg.Visible = true;
            e.Cancel = true;
        }
    }
    protected void DetailsView_Objetivos_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridView_Objetivos.DataBind();
    }
}
