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

public partial class Planning_Tasks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Al cargar revisamos que la solicitud de la página sea correcta.
        if (Request.QueryString["Type"] == null) Response.Redirect("~/Index.aspx");

        //Si no es un callback, es decir se carga por primera vez la página ocultamos el LABEL de ERROR 
        if (!Page.IsCallback) Label_Error.Visible = false;        
        
        //En función del tipo de acción es el FORMVIEW que se muestra
        DropDownList_Tipos_SelectedIndexChanged(sender, e);        
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
        GridView_Acciones_SelectedIndexChanged(sender, null);
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

    //Habilitar o deshabilitar los botones de operaciones según el dueño de la acción o tarea
    protected void GridView_Acciones_SelectedIndexChanged(object sender, EventArgs e)
    {
        /********************************************************************************
          * Estos son los tipos de acciones que se recogen en cada VIEW y en cada FORMVIEW
          *    MultiView_Forms.ActiveViewIndex 0: FormView_Formación
          *    MultiView_Forms.ActiveViewIndex 1: FormView_Prevención
          *    MultiView_Forms.ActiveViewIndex 2: FormView_General
          * *****************************************************************************/

        if (GridView_Acciones.SelectedIndex != -1)
        {
            DataSet_GestorTareasTableAdapters.DetallesDeAccionTableAdapter TareaTA = new DataSet_GestorTareasTableAdapters.DetallesDeAccionTableAdapter();
            DataSet_GestorTareas.DetallesDeAccionDataTable Tarea = TareaTA.GetData(Convert.ToInt32(GridView_Acciones.SelectedDataKey.Value), Convert.ToInt16(DropDownList_Tipos.SelectedValue), Convert.ToInt16(Session["AreaID"]));

            if (Tarea[0].NID != Session["NID"].ToString())
            {
                LinkButton_Delete.Enabled = false;
                LinkButton_Edit.Enabled = false;
                Label_Error.Text = "Esta tarea no fue registrada por usted. No tiene permiso para modificarla.";
                Label_Error.Visible = true;

                switch (MultiView_Forms.ActiveViewIndex)
                {
                    case 0: FormView_Formacion.ChangeMode(FormViewMode.ReadOnly); break; // Formación
                    case 1: FormView_Prevencion.ChangeMode(FormViewMode.ReadOnly); break; // Prevención
                    case 2: FormView_General.ChangeMode(FormViewMode.ReadOnly); break; // General      
                }
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

    //Al cambiar el tipo de acción a mostrar se cambian los formularios.
    protected void DropDownList_Tipos_SelectedIndexChanged(object sender, EventArgs e)
    {
        MostrarFormView();            
    }

    //Muestra el FORMVIEW según el tipo de acción seleccionada
    private void MostrarFormView()
    {
        if (DropDownList_Tipos.SelectedItem.Text.Contains("Prevención"))
        {
            LinkButton_Nuevo.Enabled = true;
            MultiView_Forms.ActiveViewIndex = 1;
        }
        else
            if (DropDownList_Tipos.SelectedItem.Text.Contains("Formación"))
            {
                LinkButton_Nuevo.Enabled = true;
                MultiView_Forms.ActiveViewIndex = 2;
            }
            else
                if (DropDownList_Tipos.SelectedItem.Text.Contains("- Seleccionar -"))
                {
                    LinkButton_Nuevo.Enabled = false;
                    MultiView_Forms.ActiveViewIndex = 0;
                }
                else
                {
                    LinkButton_Nuevo.Enabled = true;
                    MultiView_Forms.ActiveViewIndex = 0;
                }
    }

    //Seleccionar el tipo que se pida por QUERYSTRING (Se ejecuta solo al principio)
    protected void DropDownList_Tipos_DataBound(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList_Tipos.SelectedIndex = DropDownList_Tipos.Items.IndexOf(DropDownList_Tipos.Items.FindByValue(Request.QueryString["Type"]));
            MostrarFormView();
        }
            
    }
  
    protected void SqlDataSource_AccPrevent_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        e.Command.Parameters["@TipoID"].Value = DropDownList_Tipos.SelectedValue;
    }   
}