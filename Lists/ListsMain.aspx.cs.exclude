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

public partial class Lists_ListsMain : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string[] UserRole = Roles.GetRolesForUser();        

        switch (UserRole[0].ToLower())
        {
            case "administrador":
                HyperLink_Cargos.Enabled = true;
                HyperLink_AreasDptos.Enabled = true;
                HyperLink_Titulos.Enabled = true;
                HyperLink_Tareas.Enabled = false;
                break;
            case "jefe":
                HyperLink_Cargos.Enabled = true;
                HyperLink_AreasDptos.Enabled = true;
                HyperLink_Titulos.Enabled = true;
                HyperLink_Tareas.Enabled = true;
                break;
            case "trabajador":
                HyperLink_Cargos.Enabled = false;
                HyperLink_AreasDptos.Enabled = false;
                HyperLink_Titulos.Enabled = false;
                HyperLink_Tareas.Enabled = true;
                break;
        }
    }
}
