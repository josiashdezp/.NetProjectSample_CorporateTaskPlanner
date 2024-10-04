using System;
using System.Data;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Globalization;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Descripción breve de Planificador
/// </summary>
public class PlanificadorOnline
{
    private DataSet_GestorTareasTableAdapters.DiasFeriadosTableAdapter DiasFeriadosTable_Adapt = new DataSet_GestorTareasTableAdapters.DiasFeriadosTableAdapter();
    private DataSet_GestorTareas.DiasFeriadosDataTable DiasFeriadosTable;

    public struct ResultadosCombinados
    {
        public object ObjetoDatos;
        public object ObjetoSumado;
    }
    public PlanificadorOnline()
	{
        DiasFeriadosTable = DiasFeriadosTable_Adapt.GetData();
	}

    #region Funciones de envío del correo electrónico

    public void EnviarMensajeCorreo(List<string> ListaDestinatarios, string Asunto, string Contenido)
    {
        //Abre el archivo Web.config lee la configuración del email.
        System.Configuration.Configuration AppConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);
        System.Net.Configuration.MailSettingsSectionGroup MailSettConfig = (System.Net.Configuration.MailSettingsSectionGroup)AppConfig.SectionGroups["system.net"].SectionGroups["mailSettings"];

        //Mensaje de Correo (se crea con el FROM del Web.config) y prioridad alta.
        MailMessage Mensaje = new MailMessage();
        Mensaje.Priority = MailPriority.High;
        Mensaje.Subject = Asunto;
        Mensaje.SubjectEncoding = System.Text.Encoding.UTF8;
        Mensaje.Body = Contenido;
        Mensaje.BodyEncoding = System.Text.Encoding.UTF8;
        Mensaje.IsBodyHtml = true;
        for (int NroDestinatarios = 0; NroDestinatarios < ListaDestinatarios.Count; NroDestinatarios++)
            Mensaje.To.Add(ListaDestinatarios[NroDestinatarios]);

        //Datos del servidor, autenticación
        SmtpClient ServidorSMTP = new SmtpClient();
        ServidorSMTP.Host = MailSettConfig.Smtp.Network.Host;
        ServidorSMTP.Credentials = new System.Net.NetworkCredential(MailSettConfig.Smtp.Network.UserName, MailSettConfig.Smtp.Network.Password);

        try
        {
            ServidorSMTP.Send(Mensaje);
        }
        catch (Exception)
        {
            throw;
        }
        finally
        {
            Mensaje.Dispose();
        }
    }
    #endregion

    #region Funciones del cálculo y generación de las fechas programadas

    #region Este está en desuso
    //public List<DateTime> GenerarFechasPorAnio(int Anio, int Dia, int Semana, int Mes, TimeSpan Hora)
    //{
    //    // Lista que se va a devolver         
    //    List<DateTime> ResultList = new List<DateTime>();

    //    //Datos para realizar la búsqueda                
    //    DateTime MesABuscarInicio = new DateTime(Anio, Mes, 1);
    //    DateTime MesABuscarFinal = MesABuscarInicio.AddDays(DateTime.DaysInMonth(Anio, Mes) - 1);
    //    TimeSpan RangoDeGeneracion = MesABuscarInicio.Subtract(MesABuscarFinal);
    //    Random GeneraDia = new Random();

    //    //Por día exacto se genera la fecha y ya
    //    if (Dia != 0)
    //        ResultList.Add(new DateTime(Anio, Mes, Dia));

    //      //Por semana hay que localizar la semana en el mes y seleccionar el día al azar.
    //    else
    //        if (Semana != 0)
    //        {
    //            //int NuevoDia = GeneraDia.Next(1, 5);

    //            //int DiaInicio =
    //            //TimeSpan RangoDeGeneracion;  //Rango donde se va a generar la fecha

    //            //RangoDeGeneracion = new TimeSpan();
    //            //System.Globalization.Calendar CalendDelMes = new System.Globalization.Calendar();
    //            //CalendDelMes.
    //        }

    //    return ResultList;
    //} 
    #endregion
    public List<DateTime> GenerarFechasPorMes(int Anio,int[] Mes, int DiaNro, int DiaFrec, string DiaNombre,TimeSpan Hora,bool InicioMes,bool FinMes )
    {
        //Lista que vamos a llenar y devolver.
        List<DateTime> Fechas = new List<DateTime>();        
        
        //Generar por nombre del día y frecuencia de aparición en el mes. (Es decir: LOS PRIMEROS, DOMINGOS DE ...) 
        if ((DiaNombre != "") && (DiaFrec > 0))
        {            
            // Busqueda para cada mes seleccionado
            for (int i = 0; i < Mes.Length; i++)
            {
                //Datos para realizar la búsqueda                
                DateTime MesABuscarInicio = new DateTime(Anio, Mes[i], 1);
                DateTime MesABuscarFinal = MesABuscarInicio.AddDays(DateTime.DaysInMonth(Anio, Mes[i]) - 1);

                //Obtenemos el listado de LUNES o MARTES o etc... del mes
                List<DateTime> DiasLocalizados = LocalizarDiaDeSemana(MesABuscarInicio, MesABuscarFinal, DiaNombre);

                //Establecemos la hora de ejecucion
                for (int j = 0; j < DiasLocalizados.Count; j++) DiasLocalizados[j] = DiasLocalizados[j].Add(Hora);

                #region Insertamos en la lista a devolver los días seleccionados SI NO SON FERIADOS

                if (DiaFrec == 5) //El 5 es para tomar el último del mes
                {
                    if (!EsDiaFeriado(DiasLocalizados[DiasLocalizados.Count - 1]))
                        Fechas.Add(DiasLocalizados[DiasLocalizados.Count - 1]);

                }
                else //Los otros son el valor que indica: primero, segundo, tercero o cuarto.                   
                    if (!EsDiaFeriado(DiasLocalizados[DiaFrec - 1]))
                        Fechas.Add(DiasLocalizados[DiaFrec - 1]);

                #endregion                
            }
        }
        // Generar por Número de día específico
        else if (DiaNro != 0)
        {
            for (int k = 0; k < Mes.Length; k++)
            {
                /* ************************************************************************
                 * En este procedimiento hay que validar no sea que haya seleccionado 
                 * los días 31 y alguno de los meses seleccionados no tengan 31 días o 
                 * sea FEBRERO. NO SE INSERTAN LOS FERIADOS. !!!!!
                 **************************************************************************/

                DateTime fechaInsertar;

                if (DiaNro > DateTime.DaysInMonth(Anio, Mes[k]))
                    fechaInsertar = new DateTime(Anio, Mes[k], DiaNro - (DiaNro - DateTime.DaysInMonth(Anio, Mes[k])), Hora.Hours, Hora.Minutes, 0);
                else
                    fechaInsertar = new DateTime(Anio, Mes[k], DiaNro, Hora.Hours, Hora.Minutes, 0);

                if (!EsDiaFeriado(fechaInsertar)) Fechas.Add(fechaInsertar);
            }
        }
        else
        //Generar para inicio o fin de mes
        // El procedimiento BuscarDiaLaborable valida NO SEA FERIADO.
        {
            for (int l = 0; l < Mes.Length; l++)
            {
                DateTime MesABuscarInicio = new DateTime(Anio, Mes[l], 1);
                if (InicioMes)
                {
                    Fechas.Add(BuscarDiaLaborable(MesABuscarInicio,1));                    
                }
                else if (FinMes)
                {
                    DateTime MesABuscarFinal = MesABuscarInicio.AddDays(DateTime.DaysInMonth(Anio, Mes[l]) - 1);
                    Fechas.Add(BuscarDiaLaborable(MesABuscarFinal,-1));                    
                }
            }
        }
                    
        //Se devuelve el listado de fechas localizadas
        return Fechas;       
    }
    public List<DateTime> GenerarFechasPorSemana(DateTime Inicio, DateTime Fin,int Semana, string DiaNombre, TimeSpan Hora)
    {
        //Este es el resultado a devolver
        List<DateTime> DiasAInsertar = new List<DateTime>();
        
        //Esta es la lista con las fechas que se corresponden al día (todos los lunes, o martes, etc.)
        List<DateTime> DiasEncontrados = new List<DateTime>();
        DiasEncontrados = LocalizarDiaDeSemana(Inicio, Fin, DiaNombre);

        //Este índice varía según la cantidad de semanas (cada 2, 3 , 4 o 5 semanas)
        int Indice = 0;        
        
        do
        {
            //se inserta en la lista con la hora precisada SI NO ES FERIADO
            if (!EsDiaFeriado(DiasEncontrados[Indice]))
                DiasAInsertar.Add(DiasEncontrados[Indice].Add(Hora));

            //Saltamos la cantidad de semanas necesaria
            Indice += Semana;            
        }
        //Hasta que se llegue al final del período        
        while (Indice <= DiasEncontrados.Count-1);
        
        return DiasAInsertar; 
    }
    public List<DateTime> GenerarFechasPorDia(DateTime Inicio, DateTime Fin,int NroDias, string[] ListaDias, TimeSpan Hora)
    {
        //Este es el resultado a devolver
        List<DateTime> DiasAInsertar = new List<DateTime>();        
        
        //Si es por días de semana
        if (ListaDias.Length > 0)
        {            
            //Acá guardo los resultados de la búsqueda.
            List<DateTime> DiasEncontrados = new List<DateTime>();

            //Localizamos los días de ese nombre en el período
            for (int i = 0; i < ListaDias.Length; i++)
                DiasEncontrados.AddRange(LocalizarDiaDeSemana(Inicio, Fin, ListaDias[i]));

            //los adicionamos a la lista de resultados con la hora especificada
            for (int j = 0; j < DiasEncontrados.Count; j++)
            {
                //SI NO ES FERIADO.
                if (!EsDiaFeriado(DiasEncontrados[j]))
                    DiasAInsertar.Add(DiasEncontrados[j].Add(Hora)); 
            }               
        }

        //Si es cada una cantidad de días
        else
        {
            //Comenzando por el principio del rango
            DateTime NuevaFecha = Inicio;
            
            //Mientra no llegue al final
            while (NuevaFecha < Fin)
            {
                //Insertamos en la lista con la hora y saltamos la cantidad de días escogidos
                if (!EsDiaFeriado(NuevaFecha))
                    DiasAInsertar.Add(NuevaFecha.Add(Hora));

                NuevaFecha = NuevaFecha.AddDays(NroDias);
            }
        }        
        
        return DiasAInsertar; 
    }
    public Dictionary<DateTime, DateTime> GenerarFechasPorRango(int Anio,byte SemanaNro, byte DiaInicio, byte DiaFin, int[] Meses, bool NoIncluirFinesDeSemana)
    {
        //Este es el resultado a devolver
        Dictionary<DateTime, DateTime> DiasAInsertar = new Dictionary<DateTime, DateTime>(); 
        
        for (int NroMeses = 0; NroMeses < Meses.Length; NroMeses++)
        {
            //Si es por el número de la semana
            if (SemanaNro > 0)
            {
                //Estos serán los valores del rango que se van a insertar.
                DateTime UltimoDiaDeLaSemana;
                DateTime PrimerDiaDeLaSemana;
                
                //Datos del mes para realizar la búsqueda.
                DateTime InicioDelMes = new DateTime(Anio, Meses[NroMeses], 1);
                DateTime FinDelMes = new DateTime(Anio, Meses[NroMeses], DateTime.DaysInMonth(Anio, Meses[NroMeses]));                

                //Lista con los DOMINGOS del mes, que son el primer dia de cada semana
                List<DateTime> ListaIniciosDeSemanas = LocalizarDiaDeSemana(InicioDelMes, FinDelMes, "Domingo");

                //Si el primer dia del mes es una fecha menor que el primer domingo, se inserta al inicio, porque es primer dia de la primera semana pero no es domingo.
                if (InicioDelMes < ListaIniciosDeSemanas[0].Date) ListaIniciosDeSemanas.Insert(0, InicioDelMes);
               
                //Acá comienza la búsqueda
                if (SemanaNro == 1) //Si es la primera semana
                {
                    //Si la semana comienza un día que no es domingo, vamos a localizar el primer y último día de la semana.
                    PrimerDiaDeLaSemana = ListaIniciosDeSemanas[SemanaNro-1];
                    UltimoDiaDeLaSemana = PrimerDiaDeLaSemana;
                                        
                    while (!EsElMismoDiaDeLaSemana("Sábado", UltimoDiaDeLaSemana.DayOfWeek))
                        UltimoDiaDeLaSemana = UltimoDiaDeLaSemana.AddDays(1);

                }
                else if (SemanaNro == 5) //Si es la última semana
                {                    
                    PrimerDiaDeLaSemana = ListaIniciosDeSemanas[ListaIniciosDeSemanas.Count - 1];
                    UltimoDiaDeLaSemana = PrimerDiaDeLaSemana;

                    while (UltimoDiaDeLaSemana < FinDelMes)
                        UltimoDiaDeLaSemana = UltimoDiaDeLaSemana.AddDays(1);
                }
                else // Si es otra.
                {
                    PrimerDiaDeLaSemana = ListaIniciosDeSemanas[SemanaNro-1];
                    UltimoDiaDeLaSemana = ListaIniciosDeSemanas[SemanaNro-1].AddDays(6);
                }
                
                //Validamos que no sean ni sábados ni domingos en caso que así o pidan.
                if (NoIncluirFinesDeSemana)
                {
                    while ((EsElMismoDiaDeLaSemana("Domingo", PrimerDiaDeLaSemana.DayOfWeek)) || (EsElMismoDiaDeLaSemana("Sábado", PrimerDiaDeLaSemana.DayOfWeek)))
                        PrimerDiaDeLaSemana = PrimerDiaDeLaSemana.AddDays(1);

                    while (EsElMismoDiaDeLaSemana("Sábado", UltimoDiaDeLaSemana.DayOfWeek))
                        UltimoDiaDeLaSemana = UltimoDiaDeLaSemana.Subtract(new TimeSpan(24, 0, 0));
                }                
                
                //Finalmente ya localizados los insertamos a la hora seleccionada.
                DiasAInsertar.Add(PrimerDiaDeLaSemana, UltimoDiaDeLaSemana.Add(new TimeSpan(23, 59, 59)));
            }
            else
            {
                #region Por nro de día del mes                
                
                DateTime FechaInicio = new DateTime(Anio, Meses[NroMeses], DiaInicio);
                DateTime FechaFin = new DateTime(Anio, Meses[NroMeses], DiaFin).Add(new TimeSpan(23, 59, 00));

                DiasAInsertar.Add(FechaInicio, FechaFin);

                #endregion
            }
        }

        return DiasAInsertar;
    }

    // Dado un período, devuelve un listado de días que se solicite (los lunes, martes, etc)
    private List<DateTime> LocalizarDiaDeSemana(DateTime BuscarDesde, DateTime BuscarHasta, string NombreDia)
    {
        List<DateTime> ListaDias = new List<DateTime>();
        
        //Este es el rango de días donde se va a buscar.
        TimeSpan Periodo = BuscarHasta.Subtract(BuscarDesde);                                

        for (int i = 0; i <= Periodo.Days ; i++)
        
            //Si el día es igual al que pregunto: lo adiciona
            if (EsElMismoDiaDeLaSemana(NombreDia, BuscarDesde.AddDays(i).DayOfWeek))            
                ListaDias.Add(BuscarDesde.AddDays(i));        

        return ListaDias;
    }

    //Compara una cadena que define el nombre de un día con los valores de DayOfWeek.
    public static bool EsElMismoDiaDeLaSemana(string sDiaDeSemana, DayOfWeek dDiaDeSemana)
    {
        //Esta es la configuración que usamos en el sitio.
        CultureInfo CultInfo = CultureInfo.CurrentCulture;
        return (CultInfo.DateTimeFormat.GetDayName(dDiaDeSemana).ToUpper() == sDiaDeSemana.ToUpper());
    }

    //Localiza un dia laborable a partir de una fecha, ascendente o descendentemente ( 1 o -1)
    private DateTime BuscarDiaLaborable(DateTime aDate, int aIncValue)
    {
        if ((EsDeLunesAViernes(aDate))&&(!EsDiaFeriado(aDate)))
            return aDate;
        else
            return BuscarDiaLaborable(aDate.AddDays(aIncValue),aIncValue);
    }
    
    //Determina si la fecha especificada se corresponde con la semana laborable de Lunes a Viernes.
    private bool EsDeLunesAViernes(DateTime aDay)
    {        
        return (
                        (EsElMismoDiaDeLaSemana("Lunes", aDay.DayOfWeek))
                        ||
                        (EsElMismoDiaDeLaSemana("Martes", aDay.DayOfWeek))
                        ||
                        (EsElMismoDiaDeLaSemana("Miércoles", aDay.DayOfWeek))
                        ||
                        (EsElMismoDiaDeLaSemana("Jueves", aDay.DayOfWeek))
                        ||
                        (EsElMismoDiaDeLaSemana("Viernes", aDay.DayOfWeek))                        
                        );
    }

    //Valida si el día es feriado o no
    private bool EsDiaFeriado(DateTime aDay)
    {
        string BuscarDia = "Dia =" + aDay.Day + " and Mes = " + aDay.Month.ToString();
        DataSet_GestorTareas.DiasFeriadosRow[] DiaEncontrado = (DataSet_GestorTareas.DiasFeriadosRow[])DiasFeriadosTable.Select(BuscarDia);

        return (DiaEncontrado.Length != 0);
    }    

#endregion    

    #region Otras funciones que son públicas

    public DataSet_GestorTareas.DiasFeriadosRow[] ObtenerDiasFeriados(int Mes)
    {
        string BuscarEnElMEs = "Mes = " + Mes.ToString();
        return (DataSet_GestorTareas.DiasFeriadosRow[])DiasFeriadosTable.Select(BuscarEnElMEs);
    }

    //Dado un  mensaje de validación en Inglés me devuelve su equivalente en español.
    public static string MostrarMensajesDeValidacion(MembershipCreateStatus status)
    {
        switch (status)
        {
            case MembershipCreateStatus.DuplicateUserName:
                return "El nombre de usuario ya existe. Por favor escriba otro diferente.";

            case MembershipCreateStatus.DuplicateEmail:
                return "Ya existe un usuario para esa dirección de correo electrónico. Por favor escriba una dirección diferente";

            case MembershipCreateStatus.InvalidPassword:
                return "La contraseña especificada no es válida. Por favor escriba una contraseña que cumpla las reglas de seguridad.";

            case MembershipCreateStatus.InvalidEmail:
                return "La dirección de correo electrónico no es válida. Por favor revise el valor e intente nuevamente.";

            case MembershipCreateStatus.InvalidAnswer:
                return "La respuesta de recuperación de contraseña no es válida. Por favor revise el valor e intente nuevamente.";
            case MembershipCreateStatus.InvalidQuestion:
                return "La pregunta de recuperación de contraseña no es válida. Por favor revise el valor e intente nuevamente.";

            case MembershipCreateStatus.InvalidUserName:
                return "El nombre de usuario provisto no es válido.";

            case MembershipCreateStatus.ProviderError:
                return "El proveedor de acceso devuelve un error. Por favor verifique sus datos e intente nuevamente. Si el problema persiste, contacte su administrador del sistema";

            case MembershipCreateStatus.UserRejected:
                return "Se ha cancelado el proceso de creación del usuario. Por favor verifique sus datos e intente nuevamente. Si el problema persiste, contacte su administrador del sistema";

            default:
                return "Ha ocurrido un error desconocido. Por favor verifique sus datos e intente nuevamente. Si el problema persiste, contacte su administrador del sistema";
        }
    }
    /// <summary>
    /// Este procedimiento recibe un arreglo de filas de datos. 
    /// Localiza todos los registros que coinciden en el valor del CamposParaComparar y los devuelve en una lista sin repetir .
    /// 
    /// </summary>
    /// <param name="ListadoRegistros">Listado de DataRows que se obtiene al hacer un Select() a un DataTable.</param>
    /// <param name="CampoParaAgrupar">Valor en formato de String con el nombre del campo por donde se comparará.</param>
    /// <returns>Instancia del Struct definido para obtener para un listado de DataRows el valor del CampoParaAgrupar y la suma de otro de los campos.</returns>
    public static List<ResultadosCombinados> AgruparCamposPorRegistro(DataRow[] ListadoRegistros, string CamposParaComparar)
    {
        //Lista con los resultados, por cada registro de datos, los datos combinados
        List<ResultadosCombinados> ListadoResultados = new List<ResultadosCombinados>();

        // Cursor para buscar en la lista. Se toma el primero como referencia para comparar y devolver.
        DataRow CursorBuscarValor = ListadoRegistros[0];
        
        ResultadosCombinados ElementoResultado = new ResultadosCombinados();
        ElementoResultado.ObjetoDatos = ListadoRegistros[0];        

        //Comenzando por el segundo porque no vamos a comparar el primero con él mismo.
        for (int i = 1; i < ListadoRegistros.Length; ++i)
        {         
            //Si es igual ya lo tenemos, pasamos al siguiente
            if (ListadoRegistros[i][CamposParaComparar].ToString() == CursorBuscarValor[CamposParaComparar].ToString())
            {
                continue;
            }
            else //Si el elemento de la lista no coincide con el que estoy comparando
            {                   
                //if (ElementoResultado.ObjetoSumado == "()")

                //Pongo el elemento en la lista de resultados
                ListadoResultados.Add(ElementoResultado);
                
                //Inicializamos una nueva instancia del elemento resultado con el valor actual.
                ElementoResultado = new ResultadosCombinados();
                ElementoResultado.ObjetoDatos = ListadoRegistros[i];                
                
                //Y tomamos el actual como cursor para comparar
                CursorBuscarValor = ListadoRegistros[i];                
            }

            //En caso que sea el último de la lista verificamos acá porque el ciclo no lo alcanza
            if (i == ListadoRegistros.Length - 1)
                ListadoResultados.Add(ElementoResultado);                
        }
        return ListadoResultados;
    }
    /// <summary>
    /// Este procedimiento recibe un arreglo de filas de datos. Los registros están organizados por el campo NombreAccion ascendentemente.
    /// Localiza todos los registros que coinciden en el valor del CampoParaAgrupar y los devuelve sin repetir.    
    /// </summary>
    /// <param name="ListadoRegistros">Listado de DataRows que se obtiene al hacer un Select() a un DataTable.</param>
    /// <param name="CampoParaAgrupar">Valor en formato de String con el nombre del campo por donde se comparará.</param>
    /// <param name="CampoParaSumar">Valor en formato de String con el nombre del campo que se a de sumar.</param>
    /// <param name="SustituirValoresRepetidos"></param>
    /// <returns>Instancia del Struct definido para obtener para un listado de DataRows el valor del CampoParaAgrupar y la suma de otro de los campos.</returns>
    public static List<ResultadosCombinados> AgruparCamposPorRegistro(DataRow[] ListadoRegistros, string[] CamposParaComparar, string CampoParaSumar, bool SustituirValoresRepetidos)
    {
        //Lista con los resultados, por cada registro de datos, los datos combinados
        List<ResultadosCombinados> ListadoResultados = new List<ResultadosCombinados>();
        
        //Si el arreglo de registros solo tiene un elemento ese es el resultado.
        if (ListadoRegistros.Length == 1)        
        {
            //Tomamos el que estamos comparando como resultado
            ResultadosCombinados ElementoResultado = new ResultadosCombinados();
            ElementoResultado.ObjetoDatos = ListadoRegistros[0];
            ElementoResultado.ObjetoSumado = ListadoRegistros[0][CampoParaSumar];
            ListadoResultados.Add(ElementoResultado);        
        }          
        else
        {
            //Hacemos dos ciclos para hacer la comparación de cada elemento con el resto del grupo.
            // El primero con todos, el segundo con todos, el tercero con todos, etc.
            //Acá es desde 0 hasta el final para abarcar todos los elementos.
            for (int ind1 = 0; ind1 < ListadoRegistros.Length; ind1++)
            {
                //Si el valor es nulo saltamos a la siguiente iteración.
                // (Puede ser porque ya se encontró en otro ciclo y se le asignó para no volver a contarlo)
                if (ListadoRegistros[ind1] == null) continue;
                
                //Tomamos el que estamos comparando como resultado
                ResultadosCombinados ElementoResultado = new ResultadosCombinados();
                ElementoResultado.ObjetoDatos = ListadoRegistros[ind1];
                ElementoResultado.ObjetoSumado = ListadoRegistros[ind1][CampoParaSumar];

                //Acá se comienza desde ind1+1 (excepto cuanto ind1 es el último que se toma el mismo ind1 para que no se salga de rango)
                for (int ind2 = (ind1== ListadoRegistros.Length-1)?ind1:ind1+1; ind2 < ListadoRegistros.Length; ind2++)
                {
                    //Si el valor es nulo saltamos a la siguiente iteración.
                    // (Puede ser porque ya se encontró en otro ciclo y se le asignó para no volver a contarlo)
                    if (ListadoRegistros[ind2] == null) continue;
                    
                    //Si es igual sumamos el campo a sumar  
                    if (RegistroTieneDatosIguales(ListadoRegistros[ind1], ListadoRegistros[ind2], CamposParaComparar))
                    {
                        //Si no es una valor vacío se concatena, sino es innecesario hacer la operación.
                        if (!DBNull.Value.Equals(ListadoRegistros[ind2][CampoParaSumar]))
                            //Si ese valor no está en la lista lo pone. Esta verificación es para no repetir valores.
                            if (!ElementoResultado.ObjetoSumado.ToString().Contains(ListadoRegistros[ind2][CampoParaSumar].ToString()))
                                ElementoResultado.ObjetoSumado += ", " + ListadoRegistros[ind2][CampoParaSumar].ToString();

                        //Le asignamos el NULL para cuando avance la secuencia 
                        //no vuelva a encontrar un valor que ya se contó como resultado
                        if (SustituirValoresRepetidos)
                            ListadoRegistros[ind2] = null;
                    }
                }

                //Pongo el resultado en la lista de resultados y pasamos a tomar el actual como patrón para seguir comparando
                ListadoResultados.Add(ElementoResultado);                                
            }            
        }
        return ListadoResultados;
    }
    /// <summary>
    /// Este procedimiento compara entre dos DataRow si coinciden en las columnas que se solicitan.
    /// En caso que no sea igual al menos una de ellas, se interrumpe la comparación y devuelve FALSE.
    /// </summary>
    /// <param name="Registro1">DataRow original</param>
    /// <param name="Registro2">DataRow a comparar</param>
    /// <param name="CamposParaComparar">Arreglo de cadenas con los nombres de los campos a comparar.</param>
    /// <returns></returns>
    private static bool RegistroTieneDatosIguales(DataRow Registro1,DataRow Registro2, string[] CamposParaComparar)
    {
        bool Result = false;

        for (int i = 0; i < CamposParaComparar.Length; i++)
        {
            if ((Registro1 != null) && (Registro2 != null))
                Result = Registro1[CamposParaComparar[i]].Equals(Registro2[CamposParaComparar[i]]);            

            if (!Result) break;
        }

        return Result;
    }
    #endregion
}
