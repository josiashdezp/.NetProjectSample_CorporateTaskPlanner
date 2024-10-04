using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Pruebas_PlanYearViewPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Page.User.Identity.IsAuthenticated) && (Session.Count > 0))
        {
            if (Request.QueryString.Count != 0)
            {
                //Los parámetros que vienen
                int Mes = int.Parse(Request.QueryString["Mes"].ToString());
                int Anio = int.Parse(Request.QueryString["Anio"].ToString());
                short PlanID = short.Parse(Request.QueryString["Plan"].ToString());
                string PlanNombre = "";
                string NID = Session["NID"].ToString();  // ESTE VIENE DE SESSION PORQUE ES EL PLAN DEL USUARIO                

                #region Datos a Mostrar en las etiquetas de arriba

                Label_Mes.Text = Thread.CurrentThread.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(Request.QueryString["Mes"])).ToUpper() + "  " + Request.QueryString["Anio"];

                if (PlanID == 0)
                {
                    PlanNombre = "PLAN DE TRABAJO";
                }
                else
                {
                    DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter TA_Planes = new DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter();
                    DataSet_GestorTareas.PlanAccionesDataTable Plan = TA_Planes.GetDataBy_AnioPlan(PlanID, Anio.ToString());
                    PlanNombre = Plan[0].Nombre.ToUpper();
                }

                Label_Plan.Text = PlanNombre;

                #endregion

            //TODO: Importante: Necesito por cada nombre de tarea, agrupar los días que se ejecuta, Cargo de Responsable y Cargo de Ejecutor.
                
                #region Llenado de la lista

                //Descargar tareas de la BD
                DataSet_Planificador_InformesTableAdapters.MostrarTareasDelMesPorPlanIDTableAdapter Ejec_TableAdap = new DataSet_Planificador_InformesTableAdapters.MostrarTareasDelMesPorPlanIDTableAdapter();
                DataSet_Planificador_Informes.MostrarTareasDelMesPorPlanIDDataTable TareasDelMes = Ejec_TableAdap.GetData(Mes, PlanID, NID, Anio.ToString());

                //Estos son los datos de las tareas del mes ordenados                                
                DataRow[] TareasOrdenadas = TareasDelMes.Select("SUBSTRING(Convert(FechaPlanificada,'System.String'), 4,2) = '" + Request.QueryString["Mes"].ToString() + "'", "NombreAccion asc");

                //Después de agrupar los registros entonces las escribimos en las filas
                for (int j = 0; j < TareasOrdenadas.Length; j++)
                {
                    //DataRow[] TareasFiltradas = PlanificadorOnline.
                    
                    //Creamos la fila nueva
                    TableRow NuevaFila = new TableRow();

                    TableCell[] Celdas = new TableCell[6];

                    Celdas[0] = CrearCeldaNueva((j + 1).ToString());
                    Celdas[0].Width = Table_Month.Rows[0].Cells[0].Width;

                    Celdas[1] = CrearCeldaNueva(TareasOrdenadas[j]["NombreAccion"].ToString());
                    Celdas[1].Width = Table_Month.Rows[0].Cells[1].Width;


                    string TextoAgrupadoCelda = "";

                    #region Agrupamiento y llenado de las celdas de la fecha

                    //Preparamos el parámetro del  listado de campos a comparar
                    string[] CampoAComparar = { "NombreAccion" };
                    
                    //Listado de los días agrupados por el nombre de la tarea seleccionada.
                    List<PlanificadorOnline.ResultadosCombinados> DiasAgrupados = new List<PlanificadorOnline.ResultadosCombinados>();
                    DiasAgrupados = PlanificadorOnline.AgruparCamposPorRegistro(TareasOrdenadas, CampoAComparar, "FechaPlanificada",false);


                    //Si el texto es uno solo entonces lo que se hace es ponerlo y no se usa el ciclo para adicionad comas.
                    if (DiasAgrupados.Count == 1)
                        TextoAgrupadoCelda = Convert.ToDateTime(DiasAgrupados[0].ToString()).Day.ToString();
                    else
                        for (int i = 0; i < DiasAgrupados.Count; i++)
                        {
                            TextoAgrupadoCelda += Convert.ToDateTime(DiasAgrupados[i].ToString()).Day.ToString();

                            //Si no es último valor se pone la coma para separar
                            if (i + 1 < DiasAgrupados.Count)
                                TextoAgrupadoCelda += ",&nbsp;";
                        }

                    Celdas[2] = CrearCeldaNueva(TextoAgrupadoCelda);
                    Celdas[2].Width = Table_Month.Rows[0].Cells[2].Width;
                    #endregion

                    #region Agrupamiento de datos por ResponsableCargo



                    Celdas[3] = CrearCeldaNueva(TareasOrdenadas[j]["ResponsableCargo"].ToString());
                    Celdas[3].Width = Table_Month.Rows[0].Cells[3].Width;
                    #endregion

                    

                    Celdas[4] = CrearCeldaNueva(TareasOrdenadas[j]["EjecutaCargo"].ToString());
                    Celdas[4].Width = Table_Month.Rows[0].Cells[4].Width;

                    Celdas[5] = CrearCeldaNueva(TareasOrdenadas[j]["Observaciones"].ToString());
                    Celdas[5].Width = Table_Month.Rows[0].Cells[5].Width;

                    //Adicionamos las celdas a la fila.                                    
                    NuevaFila.Cells.AddRange(Celdas);
                    Table_Month.Rows.Add(NuevaFila);
                }   
                
                #endregion                
            }
            else            
                Response.Redirect("~/Index.aspx");            
        }
        else
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Index.aspx");
        }
    }

    private static TableCell CrearCeldaNueva(string TextoDeLaCelda)
    {
        //Creamos la celda del día con el formato apropiado
        TableCell NuevaCelda = new TableCell();
        NuevaCelda.BorderColor = System.Drawing.Color.Black;
        NuevaCelda.BorderStyle = BorderStyle.Solid;
        NuevaCelda.BorderWidth = Unit.Pixel(1);
        NuevaCelda.VerticalAlign = VerticalAlign.Top;

        NuevaCelda.Text = TextoDeLaCelda;
        return NuevaCelda;
    }
}