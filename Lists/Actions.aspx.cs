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

public partial class Lists_Actions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Si hay que seleccionar las acciones de formación se selecciona.
        //if (Request.QueryString["TipoAccion"].ToString() == "AF")
        //    DropDownList_Tipos.SelectedIndex = DropDownList_Tipos.Items.IndexOf(DropDownList_Tipos.Items.FindByText("Formación Individual"));

        DropDownList_Tipos_SelectedIndexChanged(sender, e);        
        
        if (!Page.IsCallback) Label_Error.Visible = false;
    }
    
    //Cambiar a modo INSERT el FORMVIEW actual
    protected void LinkButton_Nuevo_Click(object sender, EventArgs e)
    {
        switch (MultiView_Forms.ActiveViewIndex)
        {
            case 0:
                FormView_General.ChangeMode(FormViewMode.Insert);
                break;
            case 1:
                FormView_Prevencion.ChangeMode(FormViewMode.Insert);
                break;
            case 2:
                FormView_Formacion.ChangeMode(FormViewMode.Insert);
                break;
        }    
    }

    //Cambiar a modo EDIT la FORMVIEw actual
    protected void LinkButton_Edit_Click(object sender, EventArgs e)
    {
        switch (MultiView_Forms.ActiveViewIndex)
        {
            case 0:
                FormView_General.ChangeMode(FormViewMode.Edit);
                break;
            case 1:
                FormView_Prevencion.ChangeMode(FormViewMode.Edit);
                break;
            case 2:
                FormView_Formacion.ChangeMode(FormViewMode.Edit);
                break;
        }
    }
    
    //Borrar la acción seleccionada
    protected void LinkButtonDelete_Click(object sender, EventArgs e)
    {
        try
        {
            SqlDataSourceAcciones.Delete();            
        }
        catch (SqlException)
        {
            Label_Error.Text = "La tarea está planificada para ejecutarse. \n No es posible borrarla en este momento.";
            Label_Error.Visible = true;
        }        
    }           
   
    //Son invocados por todos los FORMVIEW y hacen lo mismo: Refrescar GRIDVIEW
    protected void FormView_Acciones_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        int Indice = GridView_Acciones.SelectedIndex;
        GridView_Acciones.DataBind();
        GridView_Acciones.SelectedIndex = Indice;
    }
    protected void FormView_Acciones_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {        
        GridView_Acciones.DataBind();        
    }    
    
    //Al cargar la lista de Acciones, seleccionar -1 y refrescar los FORMSVIEW
    protected void GridView_Acciones_DataBound(object sender, EventArgs e)
    {
        GridView_Acciones.SelectedIndex = -1;    
            
        switch (MultiView_Forms.ActiveViewIndex)
        {
            case 0:
                FormView_General.DataBind();
                break;
            case 1:
                FormView_Prevencion.DataBind();
                break;
            case 2:
                FormView_Formacion.DataBind();
                break;
        }
        LinkButton_Edit.Enabled = false;
        LinkButton_Delete.Enabled = false;        
    }              
   
    protected void DropDownList_Tipos_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList_Tipos.SelectedItem.Text.Contains("Prevención"))
            MultiView_Forms.ActiveViewIndex = 1;
        else if (DropDownList_Tipos.SelectedItem.Text.Contains("Formación"))
            MultiView_Forms.ActiveViewIndex = 2;
        else
            MultiView_Forms.ActiveViewIndex = 0;
    }

    //Seleccionar el tipo que se pida por QUERYSTRING 
    protected void DropDownList_Tipos_DataBound(object sender, EventArgs e)
    {
        if (Request.QueryString["Tipo"] != null)
            DropDownList_Tipos.SelectedValue = Request.QueryString["Tipo"].ToString();
    }

    //protected void SqlDataSource_AccPrevent_Updating(object sender, SqlDataSourceCommandEventArgs e)
    //{
    //    e.Command.Parameters["@TipoID"].Value = DropDownList_Tipos.SelectedValue;
    //}

    // Este procedimiento lo usan dos controles hyperlink que son iguales.
    // Lo que hace es activar el enlace a los Objetivos De Formación si el usuario es jefe.
    protected void HyperLink_Objetivos_Load(object sender, EventArgs e)
    {
        LinkButton LinkObjetivosFormacion = sender as LinkButton;

        //Se habilita el Link si es miembro del role Jefe.
        LinkObjetivosFormacion.Enabled = (Roles.IsUserInRole(Page.User.Identity.Name, "Jefe")) ? true : false;
        
    }

    // Al enlazarse al origen de datos el FORMVIEW revisa el registro para ver si 
    // puede ser modificado por el usuario. Así habilita o no los botones de operaciones
    protected void FormView_Prevencion_DataBound(object sender, EventArgs e)
    {
        if (FormView_Prevencion.DataItemCount > 0)        
        {
            DataRowView FilaSeleccionada = (DataRowView)FormView_Prevencion.DataItem;


            if (FilaSeleccionada["NID"].ToString() != Session["NID"].ToString())
            {
                LinkButton_Delete.Enabled = false;
                LinkButton_Edit.Enabled = false;
                Label_Error.Text = "Esta tarea no fue registrada por usted. No tiene permiso para modificarla.";
                Label_Error.Visible = true;
                FormView_Prevencion.ChangeMode(FormViewMode.ReadOnly);
            }
            else
            {
                LinkButton_Delete.Enabled = true;
                LinkButton_Edit.Enabled = true;
                Label_Error.Text = "";
                Label_Error.Visible = false;
            }        
        }        
    }
    protected void FormView_General_DataBound(object sender, EventArgs e)
    {
        if (FormView_General.DataItemCount > 0)
        {
            DataRowView FilaSeleccionada = (DataRowView)FormView_General.DataItem;

            if (FilaSeleccionada["NID"].ToString() != Session["NID"].ToString())
            {
                LinkButton_Delete.Enabled = false;
                LinkButton_Edit.Enabled = false;
                Label_Error.Text = "Esta tarea no fue registrada por usted. No tiene permiso para modificarla.";
                Label_Error.Visible = true;
                FormView_General.ChangeMode(FormViewMode.ReadOnly);
            }
            else
            {
                LinkButton_Delete.Enabled = true;
                LinkButton_Edit.Enabled = true;
                Label_Error.Text = "";
                Label_Error.Visible = false;
            }
        }            
    }
    protected void FormView_Formacion_DataBound(object sender, EventArgs e)
    {
        if (FormView_Formacion.DataItemCount > 0)
        {
            DataRowView FilaSeleccionada = (DataRowView)FormView_Formacion.DataItem;

            if (FilaSeleccionada["NID"].ToString() != Session["NID"].ToString())
            {
                LinkButton_Delete.Enabled = false;
                LinkButton_Edit.Enabled = false;
                Label_Error.Text = "Esta tarea no fue registrada por usted. No tiene permiso para modificarla.";
                Label_Error.Visible = true;
                FormView_Formacion.ChangeMode(FormViewMode.ReadOnly);
            }
            else
            {
                LinkButton_Delete.Enabled = true;
                LinkButton_Edit.Enabled = true;
                Label_Error.Text = "";
                Label_Error.Visible = false;
            }
        }            
    }

    //Al llamar el CALLBACK lo que hacemos es refrescar el listado de objetivos de formación cuando se recarga la página.
    protected void ASPxCallback_ListaObjetivos_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
    {
        FormView_Formacion.DataBind();        
    }
}
