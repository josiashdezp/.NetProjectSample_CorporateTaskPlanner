using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Hosting;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GestorTareas : System.Web.UI.MasterPage
{
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            if (Session.Count == 0)
            {
                Session.Abandon();
                FormsAuthentication.SignOut();
                Response.Redirect("~/Index.aspx",true);
            }
        }
    }
    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            //Buscamos los controles.
            Label lbl_UserRole = (Label)LoginViewUser.FindControl("Label_Role");
            Label lbl_UserArea = (Label)LoginViewUser.FindControl("Label_Area");

            //Asignamos los datos del usuario.
            lbl_UserRole.Text = Roles.GetRolesForUser(Page.User.Identity.Name)[0].ToString();
            lbl_UserArea.Text = Session["AreaNombre"].ToString();
        }

        //TODO: No redirecciona si no está autenticado, hay que ver si esto tiene que ver con la configuración de seguridad
        //if (Page.User.Identity.IsAuthenticated)
        //{
        //    if (Session.Count != 0)
        //    {
        //        //Buscamos los controles.
        //        Label lbl_UserRole = (Label)LoginViewUser.FindControl("Label_Role");
        //        Label lbl_UserArea = (Label)LoginViewUser.FindControl("Label_Area");

        //        //Asignamos los datos del usuario.
        //        lbl_UserRole.Text = Roles.GetRolesForUser(Page.User.Identity.Name)[0].ToString();
        //        lbl_UserArea.Text = Session["AreaNombre"].ToString();
        //    }
        //    else
        //    {
        //        Session.Abandon();
        //        FormsAuthentication.SignOut(); 
        //        Response.Redirect("~/Index.aspx");
        //    }
        //}        
    }

    protected void LoginStatus1_LoggedOut(object sender, EventArgs e)
    {        
        Session.Abandon();
    }    
}
