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
        {
            Label_ErrorDpto.Visible = false;
            Label_ErrorArea.Visible = false;
        }        
    }

    protected void GridView_Dptos_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        try
        {
            SqlDataSource_Dptos.DeleteParameters["DptoID"].DefaultValue = e.Keys["DptoID"].ToString();
            SqlDataSource_Dptos.Delete();
        }
        catch (SqlException)
        {
            Label_ErrorDpto.Text = "No es posible borrar el registro seleccionado. Es posible se encuentre relacionado con algún trabajador.";
            Label_ErrorDpto.Visible = true;
            
        }
    }
    protected void GridView_Areas_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        try
        {
            SqlDataSource_Areas.DeleteParameters["AreaID"].DefaultValue = e.Keys["AreaID"].ToString();
            SqlDataSource_Areas.Delete();
        }
        catch (SqlException)
        {
            Label_ErrorArea.Text = "No es posible borrar el registro seleccionado. Es posible se encuentre relacionado con algún departamento o trabajador.";
            Label_ErrorArea.Visible = true;

        }
    }
    protected void MultiView_Listas_Load(object sender, EventArgs e)
    {
        if (RadioButtonList_Vista.SelectedValue == "Departamentos")
        {
            MultiView_Listas.ActiveViewIndex = 0;
        }
        else
        {
            MultiView_Listas.ActiveViewIndex = 1;
        }
    }
    protected void DetailsView_Dptos_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridView_Dptos.DataBind();
    }
    protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        DropDownList_Areas.DataBind();
        GridView_Areas.DataBind();
    }
    protected void DropDownList_ChangeArea_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList Lista = (DropDownList)sender;
        if (Lista.SelectedValue != "00")
        {
            try
            {
                SqlDataSource_Dptos.UpdateParameters["AreaID"].DefaultValue = Lista.SelectedValue;
                SqlDataSource_Dptos.UpdateParameters["DptoID"].DefaultValue = GridView_Dptos.SelectedDataKey.Value.ToString();
                SqlDataSource_Dptos.UpdateParameters["NombreDpto"].DefaultValue = Server.HtmlDecode(GridView_Dptos.SelectedRow.Cells[2].Text);
                SqlDataSource_Dptos.Update();                
            }
            catch (SqlException Error)
            {
                Label_ErrorDpto.Text = Error.Message;
                Label_ErrorDpto.Visible = true;
            }            
            GridView_Dptos.DataBind();
        }  
    }
    protected void SqlDataSource_Dptos_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        // Si se actualiza desde el Gridview el AreaID es la del DropDown de arriba de la página.
        if (e.Command.Parameters["@AreaID"].Value==null)
        {
            e.Command.Parameters["@AreaID"].Value = DropDownList_Areas.SelectedValue;            
        }        
    }
}
