using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class EditUser : System.Web.UI.Page
{
    //Campos necesarios en la clase.
    private MembershipUser Usuario;
    private DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter Trabaj_TableAdapt;
    private DataSet_GestorTareas.TrabajadorDataTable Trabaj_Tabla;

    //Variables para buscar los datos de los trabajadores que planifica
    DataSet_GestorTareasTableAdapters.TrabajadorPlanificaTableAdapter TrabajadPlanif_TableAdapt;
    DataSet_GestorTareas.TrabajadorPlanificaDataTable TrabajadPlanifica;

    protected void Page_Load(object sender, EventArgs e)
    {        
        if (Request.QueryString["ID"] == null)
            Response.Redirect("~/Index.aspx", true);
        else
        {
            if (!Page.IsPostBack)
            {
                //Iniciar Formulario
                LimpiarFormCambiar();
            }


            //Localizar el usuario
            Usuario = Membership.GetUser(new Guid(Request.QueryString["ID"].ToString()));

            if (Usuario != null)
            {
                Trabaj_TableAdapt = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
                Trabaj_Tabla = Trabaj_TableAdapt.GetDataBy_UserID((Guid)Usuario.ProviderUserKey);

                if (Trabaj_Tabla.Rows.Count > 0)
                {
                    // Cargar los datos del usuario.                        
                    DataSet_GestorTareas.TrabajadorRow Trabajador = Trabaj_Tabla[0];

                    //Si es la primera vez que se carga la página
                    if (!Page.IsPostBack)
                    {
                        //Datos personales.
                        Label_NID.Text = Trabajador.NID;
                        TextBox_Nombre.Text = Trabajador.NombreCompleto;
                        DropDownList_NivelEscolar.SelectedValue = Trabajador.NivelID.ToString();
                        DropDownList_Titulo.SelectedValue = Trabajador.TituloID.ToString();

                        //Datos de Trabajo                            
                        DateField_Entrada.SelectedDate = Trabajador.FechaEntrada;
                        DropDownList_Cargo.SelectedValue = Trabajador.CargoID.ToString();
                        DropDownList_Area.SelectedValue = Trabajador.AreaID.ToString();                                               

                        CheckBox_Reserva.Checked = Trabajador.EsReserva;
                        if (Trabajador.EsReserva) DateField_Reserva.SelectedDate = Trabajador.EsReservaDesde;

                        //Datos de Acceso y del sistema.
                        Label_UserName.Text = Usuario.UserName;
                        Label_EstaConectado.Text = Usuario.IsOnline? "Sí" : "No";
                        Label_Acceso.Text = Usuario.IsApproved? "Sí":"No";
                        Label_UltimaConexion.Text = Usuario.LastActivityDate.ToString();
                        Label_Estado.Text = Usuario.IsLockedOut? "Bloqueado":"Desbloqueado";
                        Button_LockOut.Enabled = Usuario.IsLockedOut;
                        TextBox_Email.Text = Usuario.Email;
                        CheckBox_Filtrar.Enabled = Trabajador.Planifica;
                        
                        //Datos de los Roles
                        string[] RolesList = Roles.GetAllRoles();
                        foreach (string Rol in RolesList) DropDownList_Roles.Items.Add(Rol);
                        Label_Role.Text = Roles.GetRolesForUser(Usuario.UserName)[0].ToString();
                        DropDownList_Roles.SelectedValue = Label_Role.Text;                        
                    }

                    //Esto siempre se va a hacer, buscar listado de los Subordinados
                    
                    if (Trabajador.Planifica)
                    {
                        //Mostrar los listado de personas
                        RefrescarListadoPersonas();

                        //Variables para buscar los datos de los trabajadores que planifica
                        TrabajadPlanif_TableAdapt = new DataSet_GestorTareasTableAdapters.TrabajadorPlanificaTableAdapter();
                        TrabajadPlanifica = TrabajadPlanif_TableAdapt.GetDataBy_PlanificadorNID(Label_NID.Text);
                    }
                }
                else
                {
                    // no hay trabajador para ese usuario.
                    Response.Redirect("./AdminUsers.aspx?UserError=0",true);
                }
            }
            else
            {
                //El usuario no existe en el sistema. hay que asignarle otro usuario al trabajador.
                Response.Redirect("./AdminUsers.aspx?UserError=1",true);
            }                       
        }
    }
    
    //Cambiar usuario con que accede el trabajador
    protected void Button_Cambiar_Click(object sender, EventArgs e)
    {        
        //string URLDestino;
        //URLDestino = "~/Admin/EditUser.aspx?ID=" + NuevoUsuario.ProviderUserKey.ToString();


        MembershipUser NuevoUsuario;        
        try  //Primero creamos el usuario
        {
            MembershipCreateStatus Resultado;
            NuevoUsuario = Membership.CreateUser(TextBox_UserName.Text, TextBox_Password.Text, TextBox_Email.Text, TextBox_SegPregunta.Text, TextBox_SegRespuesta.Text, true, out Resultado);

            //Si hay algún error
            if (NuevoUsuario == null)
            {
                Label_Mnsg.Text = PlanificadorOnline.MostrarMensajesDeValidacion(Resultado);
                Label_Mnsg.ForeColor = System.Drawing.Color.Tomato;
            }
            else
            {
                try
                {
                    //Lo adicionamos al Role.
                    Roles.AddUserToRole(NuevoUsuario.UserName, Label_Role.Text);

                    try
                    {
                        #region Asignamos el nuevo usuario al trabajador y borramos el viejo
                        Trabaj_Tabla[0].UserName = NuevoUsuario.UserName;
                        Trabaj_Tabla[0].UserID = new Guid(NuevoUsuario.ProviderUserKey.ToString());
                        Trabaj_TableAdapt.Update(Trabaj_Tabla);

                        if (Membership.DeleteUser(Label_UserName.Text))
                        {
                            Label_Mnsg.Text = "Operación completada con éxito.";
                            Label_Mnsg.ForeColor = System.Drawing.Color.ForestGreen;
                        }
                        else
                        {
                            Label_Mnsg.Text = "El nuevo usuario fue creado y asignado al trabajador exitosamente. No fue posible borrar el usuario anterior. Contacte su administrador";
                            Label_Mnsg.ForeColor = System.Drawing.Color.Tomato;                            
                        }

                        //Asignamos la Propiedad cpID con el nuevo ID del usuario para recargar la página.
                        ASPxPopupControl1.JSProperties.Add("cpID", NuevoUsuario.ProviderUserKey.ToString());
                        #endregion
                        
                    }
                    catch (Exception GuardarTrabajadorError)
                    {
                        //Si no se pudo asignar al trabajador se borra
                        DeshacerCreacionDelUsuario(NuevoUsuario, GuardarTrabajadorError);
                    }
                }
                catch (Exception AddRoleError)
                {
                    //Si no se pudo asignar al Role se borra.
                    DeshacerCreacionDelUsuario(NuevoUsuario, AddRoleError);
                }
            }
        }
        catch (Exception NewUserError)
        {
            //Asignamos la Propiedad cpID con el ID del usuario para recargar la página. En este caso es el mismo, no cambió
            Label_Mnsg.Text = "No se puede cambiar el usuario. Causa:" + NewUserError.Message + ". Si este error persiste contacte su administrador.";
            Label_Mnsg.ForeColor = System.Drawing.Color.Tomato;
            ASPxPopupControl1.JSProperties.Add("cpID", Request.QueryString["ID"]);
        }        
    }

    //Borra el usuario nuevo que se acaba de crear. Se invoca solo en caso de error.
    private void DeshacerCreacionDelUsuario(MembershipUser NuevoUsuario, Exception ErrorMensj)
    {        
        if (Membership.DeleteUser(NuevoUsuario.UserName))
        {
            //Si lo borra bien se muestra este mensaje
            Label_Mnsg.Text = "No se posible cambiar el usuario en este momento. Causa: " + ErrorMensj.Message + ". Si este error persiste contacte su administrador";
            Label_Mnsg.ForeColor = System.Drawing.Color.Tomato;            
        }
        else
        {
            //Si no lo logra borrar.
            Label_Mnsg.Text = "Ha ocurrido una excepción. El nuevo usuario:" + NuevoUsuario.UserName + " fue creado exitosamente, pero no se pudo asignar al trabajador. Contacte su administrador";
            Label_Mnsg.ForeColor = System.Drawing.Color.Tomato;            
        }

        //La Propiedad cpID va con el UserID orginal que no se ha modificado.
        ASPxPopupControl1.JSProperties.Add("cpID", Request.QueryString["ID"]);
    }

    //Desbloquear usuario. //TODO: Terminar esto
    protected void Button_LockOut_Click(object sender, EventArgs e)
    {
        try
        {
            Button_LockOut.Enabled = !Usuario.UnlockUser();
            Label_Estado.Text = Usuario.IsLockedOut ? "Bloqueado" : "Desbloqueado";
        }
        catch 
        {}        
    }
    
    //Conceder o denegar acceso //TODO: Terminar esto
    protected void Button_Bloquear_Click(object sender, EventArgs e)
    {
        Usuario.IsApproved = !Usuario.IsApproved;

        try
        {
            Membership.UpdateUser(Usuario);
            Label_Acceso.Text = Usuario.IsApproved ? "Sí" : "No";
        }
        catch
        {}        
    }

    //Limpia formulario de cambiar
    private void LimpiarFormCambiar()
    {
        TextBox_UserName.Text = "";
        TextBox_SegPregunta.Text = "";
        TextBox_SegRespuesta.Text = "";
    }

    //Guardar datos del trabajo
    protected void Button_Trabajo_Click(object sender, EventArgs e)
    {
        //Datos de la reserva de cuadros
        string EsReservaDesde = (CheckBox_Reserva.Checked) ? DateField_Reserva.SelectedDate.ToShortDateString() : null;

        //Datos del tipo de área.
        char[] Separador = new char[]{'|'};
        string[] DatosArea = DropDownList_Area.SelectedValue.Split(Separador); // El formato es ##|TT donde ## es el código y TT es el tipo

        try
        {
            //Actualizamos la BD
            Trabaj_TableAdapt.ActualizarDatosTrabajo(Label_NID.Text, DateField_Entrada.SelectedDate.ToShortDateString(), CheckBox_Reserva.Checked, EsReservaDesde, int.Parse(DropDownList_Cargo.SelectedValue),Convert.ToInt16(DropDownList_Area.SelectedValue));
            Literal_DatosTrabajo.Text = "<span style=\"color:ForestGreen;font-weight:bold;\">Los datos del trabajador se actualizaron exitosamente.</span>";
        }
        catch (Exception ErrorTrabaj)
        {
            Literal_DatosTrabajo.Text = "<span style=\"color:Tomato;font-weight:bold;\">No fue posible actualizar los datos del trabajador. <br> Causa:" + ErrorTrabaj.Message + "</span>";            
        }
    }
    
    //Guardar datos personales
    protected void Button_Personal_Click(object sender, EventArgs e)
    {
        try
        {
            //Guardamos el correo            
            Usuario.Email = TextBox_Email.Text;
            Membership.UpdateUser(Usuario);

            //Guardamos los otros datos personales            
            Trabaj_TableAdapt.ActualizarDatosPersonales(Label_NID.Text, TextBox_Nombre.Text, int.Parse(DropDownList_NivelEscolar.SelectedValue), int.Parse(DropDownList_Titulo.SelectedValue));
            Literal_DatosPersonales.Text = "<span style=\"color:ForestGreen;font-weight:bold;\">Los datos se guardaron satisfactoriamente.</span>";
        }
        catch (Exception ErrorActualizar)
        {
            Literal_DatosPersonales.Text = "<span style=\"color:Tomato;font-weight:bold;\">No fue posible actualizar los datos del trabajador. <br> Causa:" + ErrorActualizar.Message + "</span>";
        }
    }

    //Mostramos solo los compañeros del departamento.
    protected void CheckBox_Filtrar_CheckedChanged(object sender, EventArgs e)
    {
        RefrescarListadoPersonas();
    }

    //Refresca ListBoxSubordinados por el área o todos los usuarios.
    private void RefrescarListadoPersonas()
    {
        if (CheckBox_Filtrar.Checked)
        {
            //Para seleccionar hay que desglosar porque el SelectedValue tiene el formato XX|YY  donde XX es el nro de área y YY: Si es AA o DP
            char[] charSeparators = new char[] { '|' };
            string[] Datos = DropDownList_Area.SelectedValue.Split(charSeparators);

            SqlDataSource_Trabajadores.SelectParameters["TipoArea"].DefaultValue = Datos[1];
            SqlDataSource_Trabajadores.SelectParameters["CodigoArea"].DefaultValue = Datos[0];
        }
        else
        {
            //Mostrar todos los del banco.
            SqlDataSource_Trabajadores.SelectParameters.Clear();
            SqlDataSource_Trabajadores.SelectParameters.Clear();
        }

        ListBox_Subordinados.DataBind();
    }

    // Validar que haya seleccionado algún valor
    protected void CustomValidator_Sistema_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = !(args.Value == "");
    }

    //Guardar datos del sistema.
    //protected void Button_CambiarSubordinados_Click(object sender, EventArgs e)
    //{
    //    if (CustomValidator_Subordinados.IsValid)
    //    {
    //        try
    //        {
    //            foreach (ListItem Subordinado in ListBox_TrabajadoresSubordinados.Items)
    //            {
    //                if (Subordinado.Selected)
    //                {
    //                    //Si existe se deja, sino se inserta
    //                }
    //                else
    //                {
    //                    //Si existe se borra sino se deja
    //                }
    //            }

    //            TrabajadPlanif_TableAdapt.Update(TrabajadPlanifica);
    //        }
    //        catch (Exception ErrorPlanific)
    //        {                
                
    //        }
    //    }
    //}

    //Al cambiar el nombre del roles se borra el viejo y se guarda el nuevo valor.
    protected void DropDownList_Roles_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Roles.RemoveUserFromRole(Usuario.UserName, Label_Role.Text);
            try
            {
                Roles.AddUserToRole(Usuario.UserName, DropDownList_Roles.SelectedValue);
                Label_Role.Text = DropDownList_Roles.SelectedValue;
                Literal_Sistema.Text = "<span style=\"color:ForestGreen;font-weight:bold;\">La función del usuario se cambió satisfactoriamente.</span>";
            }
            catch (Exception ErrorAddRole)
            {
                Literal_Sistema.Text = "<span style=\"color:Tomato;font-weight:bold;\">El usuario se borró de la función: " + Label_Role.Text.ToUpper() + ", pero ha ocurrido una excepción al asignarle la de "+ DropDownList_Roles.SelectedValue.ToUpper() +" . <br> Causa:" + ErrorAddRole.Message + "</span>";           
            }
        }
        catch (Exception ErrorRemoveRoles)
        {
            Literal_Sistema.Text = "<span style=\"color:Tomato;font-weight:bold;\">Ha ocurrido una excepción al quitar el usuario de la función actual.<br> Causa:" + ErrorRemoveRoles.Message + "</span>";           
        }
    }
    protected void Button_Quitar_Click(object sender, EventArgs e)
    {
        try
        {
            for (int ind = 0; ind < ListBox_Subordinados.Items.Count; ind++)
            {
                if (ListBox_Subordinados.Items[ind].Selected)
                {
                    //Seleccionamos la fila en la tabla y la borramos.
                    TrabajadPlanifica.RemoveTrabajadorPlanificaRow((DataSet_GestorTareas.TrabajadorPlanificaRow)TrabajadPlanifica.Select("NID_Responsable = '" + Label_NID.Text + "' and NID_Subordinado= '" + ListBox_Subordinados.Items[ind].Value + "'")[0]);
                    TrabajadPlanif_TableAdapt.Update(TrabajadPlanifica);

                    Label_MnsgSubord.Text = "Los datos se guardaron exitosamente.";
                    Label_MnsgSubord.ForeColor = System.Drawing.Color.ForestGreen;
                }
            }
        }
        catch (Exception ErrorQuitar)
        {
            Label_MnsgSubord.Text = "Ha ocurrido una excepción no fue posible quitar los trabajadores. Causa: " + ErrorQuitar.Message+ ". Si este error persiste contacte su administrador.";
            Label_MnsgSubord.ForeColor = System.Drawing.Color.Tomato;
        }        
    }

    protected void Button_Adicionar_Click(object sender, EventArgs e)
    {

    }    
}