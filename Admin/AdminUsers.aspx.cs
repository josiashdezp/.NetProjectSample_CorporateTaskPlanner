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

public partial class AdminUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            RefreshDropDownList();
            Label_Mnsg.Visible = false;
        }

        if (Request.QueryString["UserError"] != null)
        {
            Label_Mnsg.Visible = true;

            switch (Request.QueryString["UserError"].ToString())
            {
                case "0":
                    Label_Mnsg.Text = "Los datos de este trabajador no se pudieron recuperar. Intente más tarde. Si este error persiste contacte su administrador.";
                    break;
                case "1":
                    Label_Mnsg.Text = "El usuario de este trabajador, no existe, o la información de acceso es incorrecta. Contacte su administrador.";
                    break;
            }            
        }
    }  

    private void RefreshDropDownList()
    {
        //Según el tipo de usuario conectado se configura el formulario 
        if (Roles.GetRolesForUser(Page.User.Identity.Name)[0].ToString() != "Administrador")
        {
            DropDownList_Filtrar.SelectedValue = (string)Session["AreaID"].ToString();
            DropDownList_Filtrar.Enabled = false;
            CheckBox_Todos.Enabled = false;
        }
        else
            DropDownList_Filtrar.Enabled = true;
        
        DropDownList_Filtrar.DataBind();
    }    

    // Es para mostrar el listado con todos los trabajadores y inhabilitar los controles de la pagina.
    protected void CheckBox_Todos_CheckedChanged(object sender, EventArgs e)
    {
        if (CheckBox_Todos.Checked)
        {
            //Invalidamos los objetos del formulario
            DropDownList_Filtrar.Enabled = false;
        }
        else
        {
            //Mostramos los objetos del formulario
            DropDownList_Filtrar.Enabled = true;
        }        

        GridView_Trabajadores.DataBind();
    }

    protected void SqlDataSource_Trabajadores_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        if (CheckBox_Todos.Checked)                    
           e.Command.Parameters.Clear();
               
    }

    protected void DropDownList_Filtrar_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView_Trabajadores.DataBind();
    }
    
    protected void SqlDataSource_Trabajadores_Deleting(object sender, SqlDataSourceCommandEventArgs e)
    {
        //Si existe el usuario en el MembershipProvider. (Si no existe es que ha ocurrido un problema porque para cada Trabajador tiene que haber un usuario.)
        if (Membership.GetUser(e.Command.Parameters["@UserID"].Value) != null)
            try
            {
                //Si no logra borrar el usuario de la BD, tampoco borra el Trabajador.
                e.Cancel = !(Membership.DeleteUser(Membership.GetUser(e.Command.Parameters["@UserID"].Value).UserName, true));
            }
            catch (Exception Error)
            {
                e.Cancel = true;
                Label_Mnsg.Text = "No es posible borrar este usuario. Causa: " + Error.Message + " Si este error persiste, contacte su administrador.";
                Label_Mnsg.Visible = true;
            }
    }  
}
