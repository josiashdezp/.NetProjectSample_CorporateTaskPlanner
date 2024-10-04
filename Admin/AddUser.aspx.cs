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

public partial class Lists_AddUser : System.Web.UI.Page
{
    //Variables que se usan en la clase
    DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter Trabajador_TableAdapt; 
    DataSet_GestorTareas.TrabajadorDataTable TrabajadorTable;    

    protected void Page_Load(object sender, EventArgs e)
    {
        //Si es la primera vez que se carga la página
        if (!Page.IsPostBack)
        {
            //Llenamos la lista de ROLES.
            string[] RolesDelSistema = Roles.GetAllRoles();
            foreach (string RoleName in RolesDelSistema)
            {
                DropDownList_Roles.Items.Add(RoleName);
            }

            //Habilitamos o no los controles de los subordinados 
            CheckBox_Filtrar.Enabled = CheckBox_Planifica.Checked;
            ListBox_TrabajadoresSubordinados.Enabled = CheckBox_Planifica.Checked;

            //Llevamos el Wizard al Step 0
            Wizard_AddUser.ActiveStepIndex = 0;
        }
        else
        {
            if (Wizard_AddUser.ActiveStepIndex == 0)
            {
                //Reinicializamos las etiquetas de mensajes de error
                Label_User.Text = "";
                Label_Password.Text = "";
                Label_Email.Text = "";
                Label_SegPregunt.Text = "";
                Label_SegRespuest.Text = "";
                Label_General.Text = "";

                Label_UsuarioCreado.Visible = false;
            }
        }

        Trabajador_TableAdapt = new DataSet_GestorTareasTableAdapters.TrabajadorTableAdapter();
    }                         

    //Devuelve los mensaje de error que genera el Membership Provider
    private void MostrarMensajesDeValidacion(MembershipCreateStatus status)
    {
        switch (status)
        {
            case MembershipCreateStatus.DuplicateUserName:
                Label_User.Text = "El nombre de usuario ya existe. Por favor escriba otro diferente.";

                break;
            case MembershipCreateStatus.DuplicateEmail:
                Label_Email.Text = "Ya existe un usuario para esa dirección de correo electrónico. Por favor escriba una dirección diferente";

                break;
            case MembershipCreateStatus.InvalidPassword:
                Label_Password.Text = "La contraseña especificada no es válida. Por favor escriba una contraseña que cumpla las reglas de seguridad.";

                break;
            case MembershipCreateStatus.InvalidEmail:
                Label_Email.Text = "La dirección de correo electrónico no es válida. Por favor revise el valor e intente nuevamente.";

                break;
            case MembershipCreateStatus.InvalidAnswer:
                Label_SegRespuest.Text = "La respuesta de recuperación de contraseña no es válida. Por favor revise el valor e intente nuevamente.";

                break;
            case MembershipCreateStatus.InvalidQuestion:
                Label_SegPregunt.Text = "La pregunta de recuperación de contraseña no es válida. Por favor revise el valor e intente nuevamente.";

                break;
            case MembershipCreateStatus.InvalidUserName:
                Label_User.Text = "El nombre de usuario provisto no es válido.";

                break;
            case MembershipCreateStatus.ProviderError:
                Label_General.Text = "El proveedor de acceso devuelve un error. Por favor verifique sus datos e intente nuevamente. Si el problema persiste, contacte su administrador del sistema";

                break;
            case MembershipCreateStatus.UserRejected:
                Label_General.Text = "Se ha cancelado el proceso de creación del usuario. Por favor verifique sus datos e intente nuevamente. Si el problema persiste, contacte su administrador del sistema";

                break;
            default:
                Label_General.Text = "Ha ocurrido un error desconocido. Por favor verifique sus datos e intente nuevamente. Si el problema persiste, contacte su administrador del sistema";

                break;
        }
    }

    //Si planifica o no se activan los controles para estos fines.
    protected void CheckBox_Planifica_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox_Filtrar.Enabled = CheckBox_Planifica.Checked;
        ListBox_TrabajadoresSubordinados.Enabled = CheckBox_Planifica.Checked;

        //Mostrar todos los del banco.
        SqlDataSource_Subordinados.SelectParameters.Clear();
        SqlDataSource_Subordinados.SelectParameters.Clear();

        ListBox_TrabajadoresSubordinados.DataBind();
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
            SqlDataSource_Subordinados.SelectParameters["CodigoArea"].DefaultValue = DropDownList_Areas.SelectedValue;
        else
            SqlDataSource_Subordinados.SelectParameters.Clear(); //Mostrar todos los del banco.            

        ListBox_TrabajadoresSubordinados.DataBind();
    }

    //Reiniciar para insertar otro.
    private void LimpiarForm()
    {
        //Datos de Acceso
        TextBox_UserName.Text = "";
        TextBox_Email.Text = "";
        TextBox_Password.Text = "";
        TextBox_Password2.Text = "";
        DropDownList_Roles.SelectedIndex = -1;
        TextBox_SeguridadPregunta.Text = "";
        TextBox_SeguridadRespuesta.Text = "";

        //Datos personales
        TextBox_CI.Text = "";
        TextBox_NombreCompleto.Text = "";
        DropDownList_NivelEscolar.SelectedIndex = -1;
        DropDownList_Titulo.SelectedIndex = -1;

        //Datos de trabajo
        DateField_FechaEntrada.SelectedDate = DateTime.MinValue;
        DropDownList_Cargo.SelectedIndex = -1;
        DropDownList_Areas.SelectedIndex = -1;
        ListBox_Cuadros.SelectedIndex = -1;
        CheckBox_EsReserva.Checked = false;
        DateReserva.SelectedDate = DateTime.MinValue;
        CheckBox_Planifica.Checked = false;
    }      

    #region Validaciones en el Servidor y creación del usuario

    //Validar si puso fecha de entreada y la de la reserva de cuadros.
    protected void CustomValidator_Reserva_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (CheckBox_EsReserva.Checked)
            args.IsValid = !(args.Value == DateTime.MinValue.ToString());
    }
    protected void CustomValidator_FechaEntrada_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (DateField_FechaEntrada.SelectedDate != DateTime.MinValue);
    }

    //Validar si seleccionó los subodinados.
    protected void CustomValidator_Sistema_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (CheckBox_Planifica.Checked)
        {
            args.IsValid = !(args.Value == "");
        }
    }

    //Algunas acciones al regresar por el Asistente.
    protected void Wizard_AddUser_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
    {
        //Si va para el segundo paso (Nro 1) no muestra el mensaje: USUARIO CREADO.
        if (e.CurrentStepIndex == 2) Label_UsuarioCreado.Visible = false;
    }
    
    //Al seleccionar NEXT validamos el Active Step del Wizard y CREAMOS USUARIO
    protected void Wizard_AddUser_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        switch (e.CurrentStepIndex)
        {
            case 0:
                #region Validaciones y creación del usuario

                Page.Validate("Acceso");
                try
                {
                    e.Cancel = !Page.IsValid;
                    if (!e.Cancel)
                    {
                        MembershipCreateStatus Estado;
                        MembershipUser NuevoUsuario = Membership.CreateUser(
                            TextBox_UserName.Text,
                            TextBox_Password.Text,
                            TextBox_Email.Text,
                            TextBox_SeguridadPregunta.Text,
                            TextBox_SeguridadRespuesta.Text,
                            true,
                            out Estado);

                        e.Cancel = (NuevoUsuario == null);
                        if (e.Cancel) MostrarMensajesDeValidacion(Estado);
                        else
                            Session.Add("NewUserPassw", TextBox_Password.Text);
                    }                    
                }
                catch
                {
                    e.Cancel = true;
                    Label_General.Text = "No ha ocurrido una excepción, no se puede crear el usuario en este momento. Intente más tarde; si este error persiste contacte su administrador.";
                }
                finally
                {
                    Label_UsuarioCreado.Text = "El usuario:" + TextBox_UserName.Text + " fue creado exitosamente.";
                    Label_UsuarioCreado.Visible = !e.Cancel; 
                }
            
                #endregion
                break;
            case 1:
                #region Validacion que no exista el trabajador
                Page.Validate("Personales");

                e.Cancel = !Page.IsValid;

                if (!e.Cancel)
                {
                    TrabajadorTable = Trabajador_TableAdapt.GetDataBy_NID(TextBox_CI.Text);

                    if (TrabajadorTable.Count > 0) //Si existe el NID no se pasa al siguiente nivel.
                    {
                        Label_CI.Visible = true;
                        e.Cancel = true;
                    }
                    else
                    {
                        Label_CI.Visible = false;
                        e.Cancel = !Page.IsValid;
                    }
                }
                
                #endregion
                break;
            case 2:
                Page.Validate("Trabajo");
                e.Cancel = !Page.IsValid;
                break;
            case 3:
                Page.Validate("Supervision");
                e.Cancel = !Page.IsValid;
                break;
        }
    }

    #endregion    
    
    //Al cambiar el paso si es el 3 (Datos del Sistema) refrescamos la lista a mostrar. Si es el 5 recopilación y almacenamiento de todos los datos del trabajador.
    protected void Wizard_AddUser_ActiveStepChanged(object sender, EventArgs e)
    {
        switch (Wizard_AddUser.ActiveStepIndex)
        {
            case 0: 
            case 1:  
            case 2: 
            case 3: if (CheckBox_Planifica.Checked) RefrescarListadoPersonas(); break;
            case 4: 
            case 5: //salvar trabajador y mostrar logs
                #region Recopilación y almacenamiento de todos los datos del trabajador
                try
                {
                    //Datos del nuevo usuario creado
                    MembershipUser NuevoUsuario = Membership.FindUsersByName(TextBox_UserName.Text)[TextBox_UserName.Text];
                    
                    TextBox_Logs.Text = "RESULTADOS DE LA OPERACIÓN: \n \n El usuario: " + TextBox_UserName.Text + " fue creado exitosamente. \n \n";
                    TextBox_Logs.Text += "Adicionando usuario " + NuevoUsuario.UserName.ToUpper() + " a la función: " + DropDownList_Roles.SelectedItem.Text + "... ";

                    //lo adicionamos al ROL
                    Roles.AddUserToRole(TextBox_UserName.Text, DropDownList_Roles.SelectedValue);

                    TextBox_Logs.Text += "Operación terminada con éxito. \n \n";                    

                    #region Guardar en la BD el trabajador y las relaciones necesarias.

                    try
                    {                       
                     #region Insertamos en la BD.
		   
                        //Muestro LOG de inicio
                        TextBox_Logs.Text += "Registrando en la base de datos ...";                                                                        
                        
                        //Valores de la fecha entrada a la reserva
                        string FechaEntradaReserva;
                        FechaEntradaReserva = (DateReserva.SelectedDate != DateTime.MinValue) ? DateReserva.SelectedDate.ToShortDateString() : "";

                        //Insertamos Trabajador en la BD
                        Trabajador_TableAdapt.InsertarTrabajador(
                            TextBox_CI.Text,
                            TextBox_NombreCompleto.Text,
                            CheckBox_Planifica.Checked,
                            DateField_FechaEntrada.SelectedDate.ToShortDateString(),
                            CheckBox_EsReserva.Checked,
                            FechaEntradaReserva,
                            int.Parse(DropDownList_Cargo.SelectedValue),
                            int.Parse(DropDownList_NivelEscolar.SelectedValue),
                            int.Parse(DropDownList_Titulo.SelectedValue),
                            NuevoUsuario.UserName,
                            new Guid(NuevoUsuario.ProviderUserKey.ToString()),
                            int.Parse(DropDownList_Areas.SelectedValue)                            
                            );
                        
                        //Muestro LOG de terminado
                        TextBox_Logs.Text += "Operación terminada con éxito. \n \n"; 
	#endregion
                        try
                        {
                            #region Relación del Subordinado y jefe

                            TextBox_Logs.Text += "Recopilando datos de los jefes ... ";
                            DataSet_GestorTareasTableAdapters.TrabajadorPlanificaTableAdapter TableAdapt_JefeSubord = new DataSet_GestorTareasTableAdapters.TrabajadorPlanificaTableAdapter();
                            DataSet_GestorTareas.TrabajadorPlanificaDataTable TablaTrabajJefe = new DataSet_GestorTareas.TrabajadorPlanificaDataTable();
                            foreach (ListItem Jefe in ListBox_Cuadros.Items)
                            {
                                if (Jefe.Selected)
                                {
                                    DataSet_GestorTareas.TrabajadorPlanificaRow NuevoJefeSubordinado = TablaTrabajJefe.NewTrabajadorPlanificaRow();
                                    NuevoJefeSubordinado.NID_Responsable = Jefe.Value;
                                    NuevoJefeSubordinado.NID_Subordinado = TextBox_CI.Text;
                                    TablaTrabajJefe.AddTrabajadorPlanificaRow(NuevoJefeSubordinado);
                                }
                            }
                            TextBox_Logs.Text += "Operación terminada con éxito. \n \n";

                            //Guardamos en la BD los datos del Trabajador y sus jefes.
                            TextBox_Logs.Text += "Actualizando base de datos... ";
                            TableAdapt_JefeSubord.Update(TablaTrabajJefe);
                            TextBox_Logs.Text += "Operación terminada con éxito. \n \n";

                            #endregion


                            #region Guardar registros de trabajadores que planifica

                            if (CheckBox_Planifica.Checked)
                            {
                                TextBox_Logs.Text += "Recopilando datos de trabajadores que planifica... ";
                                //No filtramos porque como el trabajador es nuevo no hay registros de él
                                DataSet_GestorTareasTableAdapters.TrabajadorPlanificaTableAdapter TrabajadorPlanificaTableAdapt = new DataSet_GestorTareasTableAdapters.TrabajadorPlanificaTableAdapter();
                                DataSet_GestorTareas.TrabajadorPlanificaDataTable TrabajadorPlanificaTable = new DataSet_GestorTareas.TrabajadorPlanificaDataTable();

                                //Por cada Trabajador seleccionado se adiciona a la tabla.
                                foreach (ListItem TrabajadSubord in ListBox_TrabajadoresSubordinados.Items)
                                {
                                    if (TrabajadSubord.Selected)
                                    {
                                        DataSet_GestorTareas.TrabajadorPlanificaRow NuevoTrabajadorPlanifica = TrabajadorPlanificaTable.NewTrabajadorPlanificaRow();
                                        NuevoTrabajadorPlanifica.NID_Responsable = TextBox_CI.Text;
                                        NuevoTrabajadorPlanifica.NID_Subordinado = TrabajadSubord.Value;

                                        TrabajadorPlanificaTable.AddTrabajadorPlanificaRow(NuevoTrabajadorPlanifica);
                                    }                                    
                                }
                                TextBox_Logs.Text += "Operación terminada con éxito. \n \n";

                                try
                                {
                                    TextBox_Logs.Text += "Actualizando base de datos... ";
                                    TrabajadorPlanificaTableAdapt.Update(TrabajadorPlanificaTable);
                                    TextBox_Logs.Text += "Operación terminada con éxito. \n \n";
                                }
                                catch
                                {
                                    TextBox_Logs.Text += "No se pudo guardar la relación de trabajadores que planifica. \n \n";
                                }
                            }

                            #endregion
                        }
                        catch
                        {
                            //Si no se puede guardar la relación del jefe avisar al administrador
                            TextBox_Logs.Text += "No fue posible guardar la relación de los jefes que lo supervisan. \n Informe de este error a su administrador del sistema. \n \n";
                        }

                        #region Enviar mensaje de cuenta creada.

                        //Lista de Destinatarios, con un Miembro. El nuevo usuario.
                        System.Collections.Generic.List<string> Destinatario = new System.Collections.Generic.List<string>();
                        Destinatario.Add(TextBox_Email.Text);

                        //Conformamos el contenido del mensaje
                        string Cuerpo = "<b>Compañero(a) " + TextBox_NombreCompleto.Text + ":</b><hr />" +
                                        "Usted a sido registrado como usuario del Planificador Online el " + NuevoUsuario.CreationDate + ". Sus datos de conexión son los siguientes: <br />" +
                                        "<b>Nombre de usuario:</b> " + TextBox_UserName.Text + "<br />" +
                                        "<b>Contraseña:</b>" + Session["NewUserPassw"].ToString() +"<br />" +
                                        "<b>Pregunta de Seguridad:</b>" + TextBox_SeguridadPregunta.Text + "<br />" +
                                        "<b>Respuesta de Seguridad:</b>" + TextBox_SeguridadRespuesta.Text + "<br />" +                                        
                                        "Usted puede cambiar estos datos en la opción 'Mis Datos' localizada en la esquina superior derecha de la página principal; una vez que acceda al sistema." + "<br /><hr />" +                                        
                                        "<center>Planificador Online. Departamento de Automatización y Procedimientos. BANDEC. Cienfuegos. 2010.</center>";
                        //Enviamos los EMAILs
                        try
                        {
                            PlanificadorOnline Planificador = new PlanificadorOnline();
                            Planificador.EnviarMensajeCorreo(Destinatario, "Planificador Online. Aviso de cuenta creada", Cuerpo);
                            TextBox_Logs.Text += "Se envió un mensaje al usuario con los datos de acceso. \n" + DateTime.Now.ToString();
                        }
                        catch (Exception Error)
                        {
                            TextBox_Logs.Text += "No fue posible enviar un mensaje al usuario con los datos de acceso. Causa: \n" + Error.Message;
                        }
                        finally
                        {
                            Session.Remove("NewUserPassw");
                        }
                         
                        #endregion
                    }
                    catch (Exception Error)
                    {
                        #region Si ha ocurrido un error al insertar el trabajador, borramos el usuario.
                        TextBox_Logs.Text += TextBox_Logs.Text.Insert(1, "HA OCURRIDO UNA EXCEPCIÓN. \n REVISE LAS LINEAS SIGUIENTES PARA DETECTAR EL ERROR \n SI ESTE PROBLEMA PERSISTE CONTACTE SU ADMINISTRADOR \n.");
                        TextBox_Logs.Text += "No se puede registrar el trabajador en este momento. Se revertirán las operaciones anteriores. \n ";
                        TextBox_Logs.Text += "Causa: " + Error.Message + "\n";

                        Button GoBackButton = (Button)Wizard_AddUser.FindControl("FinishPreviousButton");
                        GoBackButton.Enabled = false;
                        
                        if (Membership.DeleteUser(NuevoUsuario.UserName, true))
                        {
                            TextBox_Logs.Text += "Usuario: " + TextBox_UserName.Text + " borrado del sistema. \n Operación terminada. Intente más tarde. \n \n";
                        }
                        else
                        {
                            TextBox_Logs.Text = "No es posible borrar el usuario" + TextBox_UserName.Text + " . \n Causas: " + Error.Message + " \n Esto puede crear inconsistencias en la base de datos del sistema. \n Informe su administrador. \n Operación terminada. \n";
                        }
                        #endregion
                    }
                    #endregion
                }
                catch (Exception Error) 
                {
                    // Al insertar en el ROLE hubo errores.
                    TextBox_Logs.Text += TextBox_Logs.Text.Insert(1, "Ha ocurrido una excepción: \n" + Error.Message + " \n Intente más tarde, si este error persiste contacte su administrador.\n ");
                } 
                #endregion
                break;
            default: break;                
        }
    }    
    
    // Ir al principio
    protected void NewUser_Button_Click(object sender, EventArgs e)
    {
        LimpiarForm();
        Wizard_AddUser.ActiveStepIndex = 0;
    }

    //Ir a la página de administrar usuarios.
    protected void TerminateButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminUsers.aspx",true);
    }

    //Limpio el formulario.
    protected void Button_Cancel_Click(object sender, EventArgs e)
    {
        LimpiarForm();
    }
    
    //Cuando cambia el área, se refresca el listado de cuadros
    protected void DropDownList_Areas_SelectedIndexChanged(object sender, EventArgs e)
    {
        ListBox_Cuadros.DataBind();
    }
}