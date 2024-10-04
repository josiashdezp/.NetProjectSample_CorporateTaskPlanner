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

public partial class Planning_PlanPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Panel_PlanMantenimiento_Callback(object source, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
    {
        HyperLink_ShowPlanMantenim.NavigateUrl = "" + DropDownList_PlanMantenim.SelectedValue;
    }   
}
