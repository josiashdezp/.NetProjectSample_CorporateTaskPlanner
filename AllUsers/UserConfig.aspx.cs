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

public partial class EditUser : System.Web.UI.Page
{
    DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter Trabajad_TableAdapt = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DataSet_GestorTareas.TrabajadorDataTable Trabajador = Trabajad_TableAdapt.GetDataBy_UserID(new Guid(Membership.GetUser(Page.User.Identity.Name, true).ProviderUserKey.ToString()));
            if (Trabajador.Count == 1)
            {
                //Datos personales
                Label_NID.Text = Trabajador[0].NID;
                TextBox_Nombre.Text = Trabajador[0].NombreCompleto;
                DropDownList_NivelEscolar.SelectedValue = Trabajador[0].NivelID.ToString();
                DropDownList_Titulo.SelectedValue = Trabajador[0].TituloID.ToString();
                TextBox_Email.Text = Membership.GetUser(Page.User.Identity.Name, true).Email;
            }
            else
            {
                //TODO: Administrador local del sistema.
            }
        }        
    }
    
    //Cambiar contraseña
    protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
    {
        if (Membership.GetUser(Page.User.Identity.Name, true).ChangePassword(CurrentPassword.Text, NewPassword.Text))
            FailureText.Text = "<span style=\"color:ForestGreen;\">Su contraseña se cambió exitosamente.</span>";
        else
            FailureText.Text = "<span style=\"color:Tomato;\">No fue posible cambiar su contraseña en este momento.</span>";    
        
    }

    //Cambiar datos de seguridad
    protected void Button_SaveSecData_Click(object sender, EventArgs e)
    {
        if (Membership.GetUser(Page.User.Identity.Name, true).ChangePasswordQuestionAndAnswer(TextBox_SecPassword.Text,TextBox_SecQuestion.Text,TextBox_SecAnsw.Text))
            FailureText_SecData.Text = "<span style=\"color:ForestGreen;\">Sus datos de recuperación de contraseña se cambiaron exitosamente.</span>";
        else
            FailureText_SecData.Text = "<span style=\"color:Tomato;\">No fue posible cambiar su datos de recuperación de contraseña.</span>";            
    }
    
    //Actualizar datos personales
    protected void Button_Personal_Click(object sender, EventArgs e)
    {        
        try
        {
            //Guardamos el correo
            MembershipUser Usuario = Membership.GetUser(Page.User.Identity.Name, true);
            Usuario.Email = TextBox_Email.Text;
            Membership.UpdateUser(Usuario);
            
            //Guardamos los otros datos personales            
            Trabajad_TableAdapt.ActualizarDatosPersonales(Label_NID.Text, TextBox_Nombre.Text, int.Parse(DropDownList_NivelEscolar.SelectedValue), int.Parse(DropDownList_Titulo.SelectedValue));
            Literal_PersonalData.Text = "<span style=\"color:ForestGreen;\">Sus datos personales se actualizaron exitosamente.</span>";
        }
        catch (Exception ErrorActualizar)
        {
            Literal_PersonalData.Text = "<span style=\"color:Tomato;\">No fue posible actualizar sus datos personales. <br> Causa:" + ErrorActualizar.Message + "</span>";
        }
    }    
}
