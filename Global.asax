<%@ Application Language="C#" %>

<script runat="server">
    
    //TODO Crear un LOG de instalación del sistema para uso del administrador de red.
        
    // Código que se ejecuta al iniciarse la aplicación.
    void Application_Start(object sender, EventArgs e) 
    {
        //Cargamos el archivo de configuración de la aplicación
        System.Configuration.Configuration AppWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);
        
        //Revisamos si la BD no se ha inicializado.
        System.Configuration.KeyValueConfigurationElement BaseDeDatosInicializada = AppWebConfig.AppSettings.Settings["BaseDeDatosInicializada"];
        
        if (!(bool.Parse(BaseDeDatosInicializada.Value)))
        {
            try
            {
                //Insertamos en la BD del MembershipProvider los Roles existentes en mi sistema.
                Roles.CreateRole("Jefe");
                Roles.CreateRole("Administrador");
                Roles.CreateRole("Trabajador");

                //Actualizamos la variable
                BaseDeDatosInicializada.Value = true.ToString(); ;

                AppWebConfig.Save(ConfigurationSaveMode.Modified);
            }
            catch(Exception) 
            {
                //TODO : Escribir en los logs de instalación.
            }            
        }        
        
        //Vamos a revisar que esté configurados los campos que identifican el lugar (los obligatorios) 
        // donde está instalado el sistema. Si no es así lo especificamos variable de Application: ApplicationConfigured
        System.Configuration.KeyValueConfigurationElement InstitucionNombre = AppWebConfig.AppSettings.Settings["InstitucionNombre"];
        System.Configuration.KeyValueConfigurationElement DependenciaNombre = AppWebConfig.AppSettings.Settings["DependenciaNombre"];
        System.Configuration.KeyValueConfigurationElement DependenciaDireccion = AppWebConfig.AppSettings.Settings["DependenciaDireccion"];
        System.Configuration.KeyValueConfigurationElement SuperUsuario = AppWebConfig.AppSettings.Settings["SuperUsuario"];

        Application.Add("ApplicationConfigured", ((InstitucionNombre.Value != "") && (DependenciaNombre.Value != "") && (DependenciaDireccion.Value != "") && (SuperUsuario.Value != "")));        
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Código que se ejecuta cuando se cierra la aplicación
    }
        
    void Application_Error(object sender, EventArgs e) 
    {
        // Código que se ejecuta al producirse un error no controlado
        // TODO: Insertar esto en el LOG de instalación del sistema.
    }

   
    void Session_Start(object sender, EventArgs e) 
    {
         // Código que se ejecuta cuando se inicia una nueva sesión
    }

    void Session_End(object sender, EventArgs e) 
    {
        // Código que se ejecuta cuando finaliza una sesión. 
        // Nota: El evento Session_End se desencadena sólo con el modo sessionstate
        // se establece como InProc en el archivo Web.config. Si el modo de sesión se establece como StateServer 
        // o SQLServer, el evento no se genera.

    }    
</script>