<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="PlanPrint.aspx.cs" Inherits="Planning_PlanPrint" Title="Imprimir Planes. Planificador Online." %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<script language="javascript" type="text/javascript">

function MostrarMenuImpresion(nombre)
{
    var Inicio = window.document.getElementById("DivInicio");
    var Formac = window.document.getElementById("DivFormacion");        
    var Capacit = window.document.getElementById("DivCapacitacion");
    var Prevenc = window.document.getElementById("DivPrevencion");
    var Trabajo = window.document.getElementById("DivTrabajo");        
    var Mantenim = window.document.getElementById("DivMantenimiento");
    var Vacaciones = window.document.getElementById("DivVacaciones");

  switch(nombre)
  {
   case "formac": 
        Inicio.style.display = 'none';
        Formac.style.display = 'block';      
        Capacit.style.display = 'none';
        Prevenc.style.display = 'none';
        Trabajo.style.display = 'none';      
        Mantenim.style.display = 'none';
        Vacaciones.style.display = 'none';
        
        //var BotonFormac = window.document.getElementById("Button_PlanFormacion");
        //BotonFormac.style.background = '#555555';
   break;
   case "trabaj":
   Inicio.style.display = 'none';
        Formac.style.display = 'none';      
        Capacit.style.display = 'none';
        Prevenc.style.display = 'none';  
        Trabajo.style.display = 'block';      
        Mantenim.style.display = 'none';
        Vacaciones.style.display = 'none';      
         break;
   case "vacaci": 
   Inicio.style.display = 'none';
        Formac.style.display = 'none';      
        Capacit.style.display = 'none';
        Prevenc.style.display = 'none';  
        Trabajo.style.display = 'none';      
        Mantenim.style.display = 'none';
        Vacaciones.style.display = 'block';   
        break;
   case "capaci": 
   Inicio.style.display = 'none';
        Formac.style.display = 'none';      
        Capacit.style.display = 'block';
        Prevenc.style.display = 'none';
        Trabajo.style.display = 'none';      
        Mantenim.style.display = 'none';
        Vacaciones.style.display = 'none';
        break;
   case "preven": 
   Inicio.style.display = 'none';
        Formac.style.display = 'none';      
        Capacit.style.display = 'none';
        Prevenc.style.display = 'block';  
        Trabajo.style.display = 'none';      
        Mantenim.style.display = 'none';
        Vacaciones.style.display = 'none';   
        break;
   case "manten": 
   Inicio.style.display = 'none';
        Formac.style.display = 'none';      
        Capacit.style.display = 'none';
        Prevenc.style.display = 'none';  
        Trabajo.style.display = 'none';      
        Mantenim.style.display = 'block';
        Vacaciones.style.display = 'none';   
        break;  
  }  
}
</script>
    <ext:ScriptManager ID="ScriptManager1" runat="server">
    </ext:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource_PlansList" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
        SelectCommand="SELECT distinct [Anio] FROM [PlanAcciones] ORDER BY [Anio]"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Subordinados" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" SelectCommand="stp_MostrarTrabajadoresSubordinados"
                                    SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="NIDJefe" SessionField="NID" Type="String" />
                                        <asp:Parameter DefaultValue="true" Name="IncluirJefe" Type="Boolean" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
    <br />
    <table cellspacing="5" style="margin: auto;" width="100%">
        <tr>
            <td align="center" style="width: 16%; height: 23px">
                <input id="Button_PlanFormacion" class="Button" onmouseover="MostrarMenuImpresion('formac');"  style="width: 150px" type="button" value="Formación Individual" width="150px" /></td>
            <td align="center" style="width: 16%; height: 23px">                
                <input id="Button_Capacitacion" class="Input" onmouseover="MostrarMenuImpresion('capaci');" type="button" value="Capacitación" style="width: 150px" /></td>
            <td align="center" style="width: 16%; height: 23px">
                <input id="Button_Prevencion" class="Input" onmouseover="MostrarMenuImpresion('preven');" type="button" value="Prevención" style="width: 150px" />                
            </td>
            <td align="center" style="width: 16%; height: 23px">
                <input id="Button1" class="Button" onmouseover="MostrarMenuImpresion('trabaj');" style="width: 150px" type="button" value="Trabajo del Mes" width="150px" /></td>
            <td align="center" style="width: 16%; height: 23px">
                <input id="Button3" runat="server" class="Button" onmouseover="MostrarMenuImpresion('vacaci');" style="width: 150px" type="button" value="Vacaciones" width="150px" /></td>
            <td align="center" style="width: 16%; height: 23px">
                <input id="Button4" runat="server" class="Button" style="width: 150px" type="button" value="Mantenimientos" onmouseover="MostrarMenuImpresion('manten');" width="150px" /></td>
        </tr>
        <tr>
            <td align="center" colspan="6" valign="top">
                <div id="DivInicio" style="padding-right: 10px; display: block; padding-left: 10px;
                    padding-bottom: 10px; width: 99%; padding-top: 10px; height: 200px; ">
                    
    <h3>&nbsp;&nbsp;Escoja el plan de que desea imprimir:</h3>
    <br />
                    <p style="float: left; margin-bottom: 10px; width: 70%; text-align: justify">
                        Seleccione cual de los planes desea imprimir y se le preguntará, si fuera necesario,
                        las opciones de impresión del mismo.
                    </p>
                    <img alt="Plan de Formación Foto." src="../Images/hourglass.jpg" style="clear: right;
                        border-right: 1px solid; padding-right: 5px; border-top: 1px solid; display: block;
                        padding-left: 5px; background: #ffffff; float: right; margin-bottom: 10px; padding-bottom: 5px;
                        border-left: 1px solid; margin-right: 10px; padding-top: 5px; border-bottom: 1px solid" /><br />
                </div>
                <div id="DivFormacion" style="padding-right: 10px; display: none; padding-left: 10px;
                    padding-bottom: 10px; width: 99%; padding-top: 10px; height: 200px; ">
                    <div style="width: 60%;float:left">
                     <br />
                     <h3 style="float:left;">
                        Plan de Formación:&nbsp;
                    </h3>
                    <br />                     
                    <br />
                    <p style="float: left; margin-bottom: 10px; text-align: justify;">
                        Seleccione los trabajadores de los que desea imprimir el plan. Si alguno de estos
                        no tiene plan de formación no se mostrará
                        ningún valor&nbsp;para esa entrada.</p>
                        <table class="LoginForm" style="float: left" width="100%">
                        <tr>
                            <td align="right">
                                Trabajadores subordinados:</td>
                            <td align="left">
                                &nbsp;<asp:ListBox ID="ListBox_Subordinados" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Subordinados"
                                    DataTextField="NombreCompleto" DataValueField="NID"></asp:ListBox>&nbsp;
                            </td>
                            <td align="left">
                                </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Imprimir planificación desde:</td>
                            <td align="left">
                                &nbsp;<ext:datefield id="DateField_Desde" runat="server"></ext:datefield>
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Hasta:</td>
                            <td align="left">
                                &nbsp;<ext:datefield id="DateField_Hasta" runat="server"></ext:datefield>
                            </td>
                            <td align="left">
                                <asp:LinkButton ID="LinkButton_PlanFormacion" runat="server" PostBackUrl="~/Planning/PlanPrintAll.aspx?type=frm">Mostrar</asp:LinkButton>
                                <asp:Button ID="Button2" runat="server" PostBackUrl="~/Planning/PlanPrintAll.aspx?type=frm"
                                    Text="Button" /></td>
                        </tr>
                    </table>
                    </div>
                    <div style="width: 35%;float:right;padding-top:20px;">
                     <img alt="Plan de Formación Foto." src="../Images/PlanFormacion.jpg" style="clear: right;
                        border-right: 1px solid; padding-right: 5px; border-top: 1px solid; display: inline;
                        padding-left: 5px; background: #ffffff; float: right; margin-bottom: 10px; padding-bottom: 5px;
                        border-left: 1px solid; margin-right: 10px; padding-top: 5px; border-bottom: 1px solid; width: 100%; height: 100%;" />
                     </div>                    
                </div>
                <div id="DivCapacitacion" style="padding-right: 10px; display: none; padding-left: 10px;
                    padding-bottom: 10px; width: 99%; color: #000000; padding-top: 10px; height: 200px;
                    ">
                    <br />
                    <h3>
                        Plan de Capacitación:&nbsp;
                    </h3>
                    <p style="float: left; margin-bottom: 10px; width: 70%; text-align: justify">
                        Seleccione el àño para el que desea imprimir el plan de capacitación. Este plan
                        se conforma tomando todas las acciones de capacitacion programadas en los diferentes
                        planes de trabajo creados por usted o asignados por sus superiores.</p>
                    <br />
                    <table class="LoginForm" style="float: left" width="55%">
                        <tr><td align="right">
                            Imprimir plan del año:</td>
                            <td align="left">
                                <asp:DropDownList ID="DropDownList3" runat="server" CssClass="Input" DataSourceID="SqlDataSource_PlansList"
                                    DataTextField="Anio" DataValueField="Anio">
                                </asp:DropDownList>
                            </td>
                            <td align="left" style="height: 11px">
                                <asp:HyperLink ID="HyperLink2" runat="server">Mostrar</asp:HyperLink></td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                            <td align="left">
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                    </table>
                    <img alt="Plan de Formación Foto." src="../Images/hourglass.jpg" style="clear: right;
                        border-right: 1px solid; padding-right: 5px; border-top: 1px solid; display: block;
                        padding-left: 5px; background: #ffffff; float: right; margin-bottom: 10px; padding-bottom: 5px;
                        border-left: 1px solid; margin-right: 10px; padding-top: 5px; border-bottom: 1px solid" />
                    <br />                    
                </div>
                <div id="DivPrevencion" style="padding-right: 10px; display: none; padding-left: 10px;
                    padding-bottom: 10px; width: 99%; padding-top: 10px; height: 200px; ">
                    <br />
                    <h3>
                        Plan de Prevención:&nbsp;
                    </h3>
                    <p style="float: left; margin-bottom: 10px; width: 70%; text-align: justify">
                        as s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf
                        asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf jsafkljsafkjsa fkas
                        s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf
                        jsafkljsafkjsa fkas s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj
                        salkj salkfj sadklf jsafkljsafkjsa fkas s sadk sdak asd asjh asdlfkj ask asdlkjf
                        lsakj sakfj salkfj salkj salkfj sadklf jsafkljsafkjsa fkas s sadk sdak asd jsafkljsafkjsa
                        fkas s sadk sdak asd
                    </p>
                    <br />
                    <img alt="Plan de Formación Foto." src="../Images/hourglass.jpg" style="clear: right;
                        border-right: 1px solid; padding-right: 5px; border-top: 1px solid; display: block;
                        padding-left: 5px; background: #ffffff; float: right; margin-bottom: 10px; padding-bottom: 5px;
                        border-left: 1px solid; margin-right: 10px; padding-top: 5px; border-bottom: 1px solid" />
                    <br />
                    <table class="LoginForm" style="float: left" width="55%">
                        <tr><td align="right">
                            Imprimir plan del año:</td>
                            <td align="left">
                                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="Input" DataSourceID="SqlDataSource_PlansList"
                                    DataTextField="Anio" DataValueField="Anio">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:HyperLink ID="HyperLink3" runat="server">Mostrar</asp:HyperLink></td>
                        </tr>
                    </table>
                </div>
                <div id="DivTrabajo" style="padding-right: 10px; display: none; padding-left: 10px;
                    padding-bottom: 10px; width: 99%; padding-top: 10px; height: 200px; ">
                    <br />
                    <h3>
                        Plan de Trabajo Mensual:&nbsp;
                    </h3>
                    <p style="float: left; margin-bottom: 10px; width: 70%; text-align: justify">
                        as s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf
                        asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf jsafkljsafkjsa fkas
                        s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf
                        jsafkljsafkjsa fkas s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj
                        salkj salkfj sadklf jsafkljsafkjsa fkas s sadk sdak asd asjh asdlfkj ask asdlkjf
                        lsakj sakfj salkfj salkj salkfj sadklf jsafkljsafkjsa fkas s sadk sdak asd jsafkljsafkjsa
                        fkas s sadk sdak asd
                    </p>
                    <br />
                    <img alt="Plan de Formación Foto." src="../Images/hourglass.jpg" style="clear: right;
                        border-right: 1px solid; padding-right: 5px; border-top: 1px solid; display: block;
                        padding-left: 5px; background: #ffffff; float: right; margin-bottom: 10px; padding-bottom: 5px;
                        border-left: 1px solid; margin-right: 10px; padding-top: 5px; border-bottom: 1px solid" />&nbsp;<br />
                    <dxcp:aspxcallbackpanel id="ASPxCallbackPanel1" runat="server" clientinstancename="ClientPanel_PlanMantenimiento"
                        oncallback="Panel_PlanMantenimiento_Callback" width="55%"><PanelCollection>
<dxp:PanelContent runat="server" _designerRegion="0"><TABLE style="FLOAT: left" class="LoginForm" width="100%"><TBODY><TR><TD align=right>Imprimir plan del año:</TD><TD align=left><asp:DropDownList runat="server" DataTextField="Anio" DataValueField="Anio" DataSourceID="SqlDataSource_PlansList" CssClass="Input" ID="DropDownList1"></asp:DropDownList>
 </TD><TD align=left>&nbsp;</TD></TR><TR><TD align=right>Mes:</TD><TD align=left><asp:DropDownList runat="server" AutoPostBack="True" CssClass="Input" ID="DropDownList_Mes"><asp:ListItem Selected="True" Value="1">Enero</asp:ListItem>
<asp:ListItem Value="2">Febrero</asp:ListItem>
<asp:ListItem Value="3">Marzo</asp:ListItem>
<asp:ListItem Value="4">Abril</asp:ListItem>
<asp:ListItem Value="5">Mayo</asp:ListItem>
<asp:ListItem Value="6">Junio</asp:ListItem>
<asp:ListItem Value="7">Julio</asp:ListItem>
<asp:ListItem Value="8">Agosto</asp:ListItem>
<asp:ListItem Value="9">Septiembre</asp:ListItem>
<asp:ListItem Value="10">Octubre</asp:ListItem>
<asp:ListItem Value="11">Noviembre</asp:ListItem>
<asp:ListItem Value="12">Diciembre</asp:ListItem>
</asp:DropDownList>
</TD><TD align=left><asp:HyperLink runat="server" ID="HyperLink1">Mostrar</asp:HyperLink>
</TD></TR></TBODY></TABLE></dxp:PanelContent>
</PanelCollection>
</dxcp:aspxcallbackpanel>
                </div>
                <div id="DivVacaciones" style="padding-right: 10px; display: none; padding-left: 10px;
                    padding-bottom: 10px; width: 99%; padding-top: 10px; height: 200px; ">
                    <br />
                    <h3>
                        Plan de Vacaciones:&nbsp;
                    </h3>
                    <p style="float: left; margin-bottom: 10px; width: 70%; text-align: justify">
                        as s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf
                        asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf jsafkljsafkjsa fkas
                        s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj salkj salkfj sadklf
                        jsafkljsafkjsa fkas s sadk sdak asd asjh asdlfkj ask asdlkjf lsakj sakfj salkfj
                        salkj salkfj sadklf jsafkljsafkjsa fkas s sadk sdak asd asjh asdlfkj ask asdlkjf
                        lsakj sakfj salkfj salkj salkfj sadklf jsafkljsafkjsa fkas s sadk sdak asd jsafkljsafkjsa
                        fkas s sadk sdak asd
                    </p>
                    <br />
                    <img alt="Plan de Formación Foto." src="../Images/hourglass.jpg" style="clear: right;
                        border-right: 1px solid; padding-right: 5px; border-top: 1px solid; display: block;
                        padding-left: 5px; background: #ffffff; float: right; margin-bottom: 10px; padding-bottom: 5px;
                        border-left: 1px solid; margin-right: 10px; padding-top: 5px; border-bottom: 1px solid" />
                    <br />
                    <table class="LoginForm" style="float: left" width="55%">
                        <tr><td align="right">
                            Imprimir plan del año:</td>
                            <td align="left">
                                <asp:DropDownList ID="DropDownList4" runat="server" CssClass="Input" DataSourceID="SqlDataSource_PlansList"
                                    DataTextField="Anio" DataValueField="Anio">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:HyperLink ID="HyperLink5" runat="server">Mostrar</asp:HyperLink></td>
                        </tr>
                    </table>
                </div>
                <div id="DivMantenimiento" style="padding-right: 10px; display: none; padding-left: 10px;
                    padding-bottom: 10px; width: 99%; padding-top: 10px; height: 200px; ">
                    <br />
                    <h3>
                        Plan de Mantenimientos y Visitas Técnicas:&nbsp;
                    </h3>
                    <p style="float: left; margin-bottom: 10px; width: 70%; text-align: justify">
                        Este plan se imprime anualmente por lo que se pasa solo se escoge el año que se
                        desea imprimir.&nbsp;</p>
                    <br />
                    &nbsp;<img alt="Plan de Formación Foto." src="../Images/hourglass.jpg" style="clear: right;
                        border-right: 1px solid; padding-right: 5px; border-top: 1px solid; display: block;
                        padding-left: 5px; background: #ffffff; float: right; margin-bottom: 10px; padding-bottom: 5px;
                        border-left: 1px solid; margin-right: 10px; padding-top: 5px; border-bottom: 1px solid" />&nbsp;<dxcp:aspxcallbackpanel
                            id="Panel_PlanMantenimiento" runat="server" clientinstancename="ClientPanel_PlanMantenimiento"
                            oncallback="Panel_PlanMantenimiento_Callback" width="55%"><PanelCollection>
<dxp:PanelContent runat="server" _designerRegion="0"><TABLE style="FLOAT: left" class="LoginForm" width="100%"><TBODY><TR><TD align=right>Imprimir plan del año:</TD><TD align=left><asp:DropDownList runat="server" DataTextField="Anio" DataValueField="Anio" DataSourceID="SqlDataSource_PlansList" CssClass="Input" ID="DropDownList_PlanMantenim"></asp:DropDownList>
 </TD><TD align=left><asp:HyperLink runat="server" ID="HyperLink_ShowPlanMantenim">Mostrar</asp:HyperLink>
 </TD></TR></TBODY></TABLE></dxp:PanelContent>
</PanelCollection>
</dxcp:aspxcallbackpanel><br />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>