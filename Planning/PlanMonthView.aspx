<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="PlanMonthView.aspx.cs" Inherits="Planning_PlanMes" Title="Planes de Trabajo. Planificador Online." MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"   Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"   Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<%@ Register assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" namespace="DevExpress.Web.ASPxTimer" tagprefix="dxt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<table width="100%" style="margin: auto">
    <tr>
        <td align="center" colspan="2" valign="middle" style="width: 549px">                        
            <ext:ScriptManager ID="ScriptManager1" runat="server">
            </ext:ScriptManager>
         </td>
    </tr>
    <tr>    
        <td align="left" style="width: 40%;" valign="middle">
            <h2>Ver tareas planificadas:</h2>
        </td>
        <td align="right" style="width: 60%;" valign="middle">
            <asp:CheckBox ID="CheckBox_WeekEnd" runat="server" AutoPostBack="True" 
                Text="Ver fines de semana   " EnableTheming="True" Font-Bold="False" 
                Checked="True" TextAlign="Left" 
                oncheckedchanged="CheckBox_WeekEnd_CheckedChanged" />&nbsp;
            &nbsp;<input id="Button_Menu" class="Input" type="button" value="Opciones ..." />
            <dxm:ASPxPopupMenu
                ID="PopupMenuOpciones" runat="server" ItemLinkMode="TextOnly"
                PopupAction="LeftMouseClick" PopupElementID="Button_Menu" PopupHorizontalAlign="OutsideLeft"
                PopupVerticalAlign="Middle" RenderIFrameForPopupElements="False" Font-Bold="False" ShowPopOutImages="False">
                <Items>
                    <dxm:MenuItem NavigateUrl="~/Printing/PlanPrintMonthly.aspx" Text="Imprimir vista de plan mensual" Target="_blank"> </dxm:MenuItem>                    
                    <dxm:MenuItem NavigateUrl="~/Printing/PlanPrintPersonalView.aspx" Text="Imprimir vista de plan individual" Target="_blank"> </dxm:MenuItem>                    
                    <dxm:MenuItem NavigateUrl="../Printing/PlanPrintDetailsView.aspx" Text="Imprimir vista de detalles" Target="_blank" Enabled ="false"></dxm:MenuItem>                    
                    <dxm:MenuItem NavigateUrl="~/Printing/PlanPrint.aspx" Target="_self" Text="Imprimir otros planes" Enabled="False"> </dxm:MenuItem>
                    <dxm:MenuItem NavigateUrl="~/Printing/PlanPrintGenView.aspx" Text="Imprimir vista plan general" Target="_blank" Enabled="false"></dxm:MenuItem>                    
                    <dxm:MenuItem NavigateUrl="../Printing/PlanPrevencPrint.aspx" Text="Imprimir plan de prevención" Enabled="false"></dxm:MenuItem>
                    <dxm:MenuItem Text="Administrar mis planes" Target="_self"> </dxm:MenuItem>
                    <dxm:MenuItem NavigateUrl="~/Planning/TasksSearch.aspx" Text="Buscar tareas programadas" Enabled="true"></dxm:MenuItem>
                    <dxm:MenuItem NavigateUrl="../Printing/ReportPrintEstadistics.aspx" Text="Imprimir resumen del cumplimiento" Enabled="true" Target="_blank"></dxm:MenuItem>
                </Items>
                <ItemStyle CssClass="Input" Font-Bold="True" Font-Underline="False" HorizontalAlign="Center" ImageSpacing="0px" PopOutImageSpacing="0px" >
                    <HoverStyle BackColor="White">
                    </HoverStyle>
                </ItemStyle>
                <DisabledStyle ForeColor="#DFDFDF">
                </DisabledStyle>
            </dxm:ASPxPopupMenu>
            </td>
    </tr>
    <tr>
        <td align="left" colspan="2" valign="middle" style="height: 25px; ">
            <br />
            Año:&nbsp;<asp:DropDownList ID="DropDownList_Anio" runat="server" CssClass="Input" AutoPostBack="True" DataSourceID="SqlDataSourceAnio" DataTextField="Anio" DataValueField="Anio" AppendDataBoundItems="True" OnDataBound="DropDownList_Anio_DataBound" OnSelectedIndexChanged="DropDownList_Anio_SelectedIndexChanged">
            </asp:DropDownList>&nbsp;&nbsp;Mes:&nbsp;<asp:DropDownList ID="DropDownList_Mes" runat="server" CssClass="Input" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_Mes_SelectedIndexChanged" OnLoad="DropDownList_Mes_Load">
            <asp:ListItem Value="1" Selected="True">Enero</asp:ListItem>
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
        </asp:DropDownList>&nbsp;&nbsp;Plan:&nbsp;<asp:DropDownList ID="DropDownList_Plan" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Planes" DataTextField="Nombre" DataValueField="PlanNro" AutoPostBack="True" OnDataBound="DropDownList_Plan_DataBound" OnSelectedIndexChanged="DropDownList_Plan_SelectedIndexChanged">
                <asp:ListItem Value="0">- No hay planes  -</asp:ListItem>
            </asp:DropDownList>&nbsp;&nbsp;Tareas:&nbsp;<asp:DropDownList ID="DropDownList_Filter" runat="server"
        AutoPostBack="True" CssClass="Input" DataSourceID="SqlDataSource_TiposTareas"
        DataTextField="TipoNombre" DataValueField="TipoNombre" OnDataBound="DropDownList_Filter_DataBound" OnSelectedIndexChanged="DropDownList_Filter_SelectedIndexChanged">
                            <asp:ListItem Value="Todos">-Todos los tipos-</asp:ListItem>
    </asp:DropDownList>&nbsp;&nbsp;Estado:&nbsp;<asp:DropDownList ID="DropDownList_Estado"
                runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="Input"
                DataSourceID="SqlDataSource_estados" DataTextField="EstadoNombre" DataValueField="EstadoNombre" OnSelectedIndexChanged="DropDownList_Estado_SelectedIndexChanged">
                <asp:ListItem Selected="True" Value="Todos">- Todos -</asp:ListItem>
            </asp:DropDownList>&nbsp;&nbsp;<asp:HyperLink ID="HyperLink_AddTask" runat="server" CssClass="Button" NavigateUrl="~/Planning/PlanAddEvent.aspx">Adicionar tarea</asp:HyperLink>
            <asp:SqlDataSource ID="SqlDataSourceAnio" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                SelectCommand="SELECT DISTINCT Anio FROM PlanAcciones WHERE (NID = @NID)&#13;&#10; UNION&#13;&#10; SELECT AnioID AS Anio FROM Ejecucion WHERE ((NID_Ejecuta = @NID) or (NID_Responsable = @NID))">
                <SelectParameters>
                    <asp:SessionParameter Name="NID" SessionField="NID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource_Planes" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" SelectCommand="stp_MostrarPlanesDelUsuario" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList_Anio" Name="Anio" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:SessionParameter Name="NID" SessionField="NID" Type="String" />
                    <asp:Parameter Name="EsPrivado" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
         <asp:SqlDataSource ID="SqlDataSource_TiposTareas" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
        SelectCommand="IF (@PlanID > 0 ) BEGIN &#13;&#10;Select '- Todos los tipos -' as TipoNombre, 0 as TipoID  &#13;&#10;union&#13;&#10;SELECT DISTINCT TipoAccion.TipoAccion AS TipoNombre, TipoAccion.TipoID FROM Acciones INNER JOIN TipoAccion ON Acciones.TipoID = TipoAccion.TipoID INNER JOIN Ejecucion ON Acciones.AccionID = Ejecucion.AccionID WHERE (Ejecucion.AnioID = @Anio) AND (Ejecucion.NID_Ejecuta = @NID) AND (Ejecucion.PlanID = @PlanID) AND (MONTH(Ejecucion.FechaPlanificada) = @Mes) OR (Ejecucion.AnioID = @Anio) AND (Ejecucion.NID_Responsable = @NID) AND (Ejecucion.PlanID = @PlanID) AND (MONTH(Ejecucion.FechaPlanificada) = @Mes) OR (Ejecucion.AnioID = @Anio) AND (Ejecucion.NID = @NID) AND (Ejecucion.PlanID = @PlanID) AND (MONTH(Ejecucion.FechaPlanificada) = @Mes) END &#13;&#10;ELSE &#13;&#10;BEGIN&#13;&#10;Select '- Todos los tipos -' as TipoNombre,0 as TipoID  &#13;&#10;union&#13;&#10; SELECT DISTINCT TipoAccion.TipoAccion AS TipoNombre, TipoAccion.TipoID FROM Acciones INNER JOIN TipoAccion ON Acciones.TipoID = TipoAccion.TipoID INNER JOIN Ejecucion ON Acciones.AccionID = Ejecucion.AccionID WHERE (Ejecucion.AnioID = @Anio) AND (Ejecucion.NID_Ejecuta = @NID) AND (MONTH(Ejecucion.FechaPlanificada) = @Mes) OR (Ejecucion.AnioID = @Anio) AND (Ejecucion.NID_Responsable = @NID) AND (MONTH(Ejecucion.FechaPlanificada) = @Mes) OR (Ejecucion.AnioID = @Anio) AND (Ejecucion.NID = @NID) AND (MONTH(Ejecucion.FechaPlanificada) = @Mes) END">
             <SelectParameters>
                 <asp:ControlParameter ControlID="DropDownList_Plan" Name="PlanID" PropertyName="SelectedValue"
                     Type="Int32" />
                 <asp:ControlParameter ControlID="DropDownList_Anio" Name="Anio" PropertyName="SelectedValue" />
                 <asp:SessionParameter Name="NID" SessionField="NID" />
                 <asp:ControlParameter ControlID="DropDownList_Mes" Name="Mes" PropertyName="SelectedValue"
                     Type="Int32" />
             </SelectParameters>
    </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource_estados" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                SelectCommand="SELECT [EstadoNombre] FROM [Estado] ORDER BY [EstadoNombre]">
            </asp:SqlDataSource>
            <br />
        </td>
    </tr>
    <tr>
        <td align="left" valign="middle" style="height: 25px; width: 549px;">
            Observaciones:
                        <asp:Label ID="Label_Observaciones" runat="server" Font-Bold="True" ForeColor="ForestGreen"></asp:Label>
                        <br />
        </td>
        <td align="right" style="width: 549px; height: 25px" valign="middle">
                        <asp:Label ID="Label_msg" runat="server" Font-Bold="True" ForeColor="Tomato"
                            Visible="False">Para adicionar tareas seleccione un plan específico</asp:Label></td>
    </tr>
</table>
    <DayPilot:DayPilotMonth ID="MonthView" runat="server" BackColor="White" BorderColor="#E0E0E0"
        BorderStyle="Solid" BorderWidth="1px" BubbleID="BubbleMonth" CellHeaderBackColor=""
        CellHeaderFontColor="Navy" CellHeaderFontFamily="Verdana" 
        ClientObjectName="MonthView" CssClass="" DataEndField="FechaCierra" DataSourceID="SqlDataSource_PlanMes"
        DataStartField="FechaPlanificada" DataTagFields="Estado, Descripcion, TipoAccion, EjecutaNombre, EstadoColor, ResponsableNombre, PlanificadorNombre, Observaciones,NID, Detalles, NID_Ejecuta, NID_Responsable, EjecutaUserName,NombrePlan,EsPrincipal"
        DataTextField="NombreAccion" DataValueField="EjecucionID" EventBackColor="White"
        EventBorderColor="Silver" EventEndTime="False" EventFontColor="Black" EventFontFamily="Verdana"
        EventFontSize="8pt" EventHeight="50" 
        EventSortExpression="FechaPlanificada, NombreAccion asc" EventStartTime="False"
        EventTextAlignment="Left" EventTextLayer="Top" EventTimeFontColor="Black" EventTimeFontFamily="Verdana"
        Font-Names="Verdana" HeaderBackColor="White" HeaderFontColor="Navy" InnerBorderColor="#E0E0E0"
        NonBusinessBackColor="White" 
        OnBeforeEventRender="MonthView_BeforeEventRender" ShowToolTip="False"
        WeekStarts="Monday" Width="100%" 
        TimeRangeSelectedJavaScript="alert('Event  clicked.')" OnLoad="MonthView_Load" 
        ShowWeekend="False" EventClickJavaScript="" EventRightClickJavaScript="" 
        OnEventMenuClick="MonthView_EventMenuClick" EventTextLeftIndent="5" 
        OnCommand="MonthView_Command" 
        
        
        CallBackErrorJavaScript="alert(result.substring( result.indexOf('$$$$')+4 ,(result.indexOf('$$$$', result.indexOf('$$$$')+5)   - result.indexOf('$$$$'))));" 
        OnBeforeCellRender="MonthView_BeforeCellRender" 
        EventMoveHandling="CallBack" oneventmove="MonthView_EventMove" 
        EventResizeHandling="CallBack" oneventresize="MonthView_EventResize"
       />
    <asp:SqlDataSource ID="SqlDataSource_PlanMes" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
        SelectCommand="stp_MostrarTareasDelMesPorPlanID" 
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False" 
        OnSelecting="SqlDataSource_PlanMes_Selecting" 
        onselected="SqlDataSource_PlanMes_Selected">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Mes" Name="Mes" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Plan" Name="PlanID" PropertyName="SelectedValue"  Type="Int16" />
            <asp:SessionParameter Name="NID" SessionField="NID" Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Anio" Name="Anio" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
<DayPilot:DayPilotBubble ID="BubbleMonth" runat="server" ClientObjectName="BubbleMonth"
        LoadingText="Cargando descripción de la tarea..." OnRenderContent="BubbleMonth_RenderContent" UseShadow="False" Width="220">
    </DayPilot:DayPilotBubble>
    <dxcb:ASPxCallback ID="ASPCallback" runat="server" ClientInstanceName="callbackMenu" OnCallback="ASPCallback_Callback">
        <ClientSideEvents 
        
        CallbackComplete="function(s, e)
        {		    
    	if (e.result == 'error')    		
		{
		alert('No se pudo cambiar la tarea seleccionada a Principal.');
		}
		else if (e.result != 'ok')		
		{
		  popupEditar.SetContentUrl(e.result);
	      popupEditar.Show();
		}
		}" />
    </dxcb:ASPxCallback>
    <!-- PUEDE CAMBIAR DE FECHA LA TAREA PERO DEBE ACLARAR LAS CAUSAS -->
     <!-- PUEDE CAMBIAR DE FECHA LA TAREA SIN PONER CAUSAS -->
     <DayPilot:DayPilotMenu ID="MenuPlanificaEjecuta_PlanNOAprobado" runat="server" ClientObjectName="MenuPlanificaEjecuta_PlanNOAprobado" CssClassPrefix="ContextMenu_" MenuTitle="Ejecutor: Opciones" MenuTitleBackColor="Transparent" ShowMenuTitle="False">        
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Modificar');" Text="Modificar detalles" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Ejecutada');"  Text="Dar por ejecutada"  />        
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Pendiente');"  Text="Está pendiente"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Reprogramar');" Text="Posponer"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Progreso');" Text="Aclarar progreso"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Suspender');" Text="Suspender tarea"  />        
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Borrar');" Text="Borrar tareas" />        
        <DayPilot:MenuItem Action="CallBack" Command="EsPrincipal" Text="Es principal (S/N)" />
    </DayPilot:DayPilotMenu>    
    
     <!-- Este es el menú del que Ejecuta la tarea.  -->
    <DayPilot:DayPilotMenu ID="MenuEjecuta" runat="server" ClientObjectName="MenuEjecuta" CssClassPrefix="ContextMenu_" MenuTitle="Ejecutor: Opciones" MenuTitleBackColor="Transparent" ShowMenuTitle="False">        
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Ejecutada');"  Text="Dar por ejecutada"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Pendiente');"  Text="Está pendiente"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Reprogramar');" Text="Posponer"  />        
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Progreso');" Text="Aclarar progreso"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Suspender');" Text="Suspender tarea"  />        
        <DayPilot:MenuItem Action="CallBack" Command="EsPrincipal" Text="Es principal (S/N)" />        
    </DayPilot:DayPilotMenu>
    <!-- Este es el menú del que Planifica la tarea.  -->
    <DayPilot:DayPilotMenu ID="MenuPlanifica" runat="server" ClientObjectName="MenuPlanifica" MenuBackColor="#FFFFC0" CssClassPrefix="ContextMenu_" MenuTitle="Planificador: Opciones" MenuTitleBackColor="#BDDDF0" ShowMenuTitle="False">
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Modificar');" Text="Modificar detalles" />
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Notificar');" Text="Notificar implicados" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Suspender');" Text="Suspender tarea"  />        
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Pendiente');"  Text="Está pendiente"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Reprogramar');" Text="Posponer"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Borrar');" Text="Borrar tareas" />
        <DayPilot:MenuItem Action="CallBack" Command="EsPrincipal" Text="Es principal (S/N)" />        
    </DayPilot:DayPilotMenu>
    <!-- Este es el menú del Responsable de la tarea.  -->
    <DayPilot:DayPilotMenu ID="MenuResponsable" runat="server" ClientObjectName="MenuResponsable" MenuBackColor="#FFFFC0" CssClassPrefix="ContextMenu_" MenuTitle="Responsable: Opciones" MenuTitleBackColor="#BDDDF0" ShowMenuTitle="False">
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Modificar');" Text="Modificar detalles" />
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Notificar');" Text="Notificar implicados" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Pendiente');"  Text="Está pendiente"  />
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Reprogramar');" Text="Posponer"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Suspender');" Text="Suspender tarea"  />        
    </DayPilot:DayPilotMenu>    
    <br />
    <br />
    <!-- AHORA ESTOS SON LOS MENÚ DE LAS TAREAS DE RANGO TODO ES LO MISMO SOLO QUE NO REPROGRAMA PORQUE EL FORMULARIO NO ESTÁ APTO PARA ELLO -->    
    <DayPilot:DayPilotMenu ID="MenuPlanificaEjecuta_Rango" runat="server" ClientObjectName="MenuPlanificaEjecuta_Rango" MenuBackColor="#FFFFC0" CssClassPrefix="ContextMenu_" MenuTitle="Ejecutor Rango: Opciones" MenuTitleBackColor="#BDDDF0" ShowMenuTitle="False">
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Modificar');" Text="Modificar detalles" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Ejecutada');" Text="Dar por ejecutada"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Pendiente');"  Text="Está pendiente"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Progreso');" Text="Aclarar progreso"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Suspender');" Text="Suspender tarea"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Borrar');" Text="Borrar tareas" />
        <DayPilot:MenuItem Action="CallBack" Command="EsPrincipal" Text="Es principal (S/N)" />
    </DayPilot:DayPilotMenu>
        <DayPilot:DayPilotMenu ID="MenuEjecutaRango" runat="server" ClientObjectName="MenuEjecutaRango" MenuBackColor="#FFFFC0"         CssClassPrefix="ContextMenu_" MenuTitle="Planificador Rango: Opciones"         MenuTitleBackColor="#BDDDF0" ShowMenuTitle="False">
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Ejecutada');" Text="Dar por ejecutada"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Pendiente');"  Text="Está pendiente"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Progreso');" Text="Aclarar progreso"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Suspender');" Text="Suspender tarea"  />
        <DayPilot:MenuItem Action="CallBack" Command="EsPrincipal" Text="Es principal (S/N)" />
    </DayPilot:DayPilotMenu>
    <DayPilot:DayPilotMenu ID="MenuPlanificadorRango" runat="server" ClientObjectName="MenuPlanificadorRango" MenuBackColor="#FFFFC0"         CssClassPrefix="ContextMenu_" MenuTitle="Planificador Rango: Opciones"         MenuTitleBackColor="#BDDDF0" ShowMenuTitle="False">
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Modificar');" Text="Modificar detalles" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Notificar');" Text="Notificar implicados" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Suspender');" Text="Suspender tarea"  />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Borrar');" Text="Borrar tareas" />
        <DayPilot:MenuItem Action="CallBack" Command="EsPrincipal" Text="Es principal (S/N)" />
    </DayPilot:DayPilotMenu>
    <DayPilot:DayPilotMenu ID="MenuResponsableRango" runat="server"         ClientObjectName="MenuResponsableRango" MenuBackColor="#FFFFC0"         CssClassPrefix="ContextMenu_" MenuTitle="Responsable Rango: Opciones"         MenuTitleBackColor="#BDDDF0" ShowMenuTitle="False">
        <DayPilot:MenuItem Action="JavaScript"  JavaScript="callbackMenu.PerformCallback(e.value() + '|Modificar');" Text="Modificar detalles" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Notificar');" Text="Notificar implicados" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="callbackMenu.PerformCallback(e.value() + '|Suspender');" Text="Suspender tarea"  />                
    </DayPilot:DayPilotMenu>
    <dxm:ASPxPopupMenu ID="MenuImprimir" runat="server" BackColor="#FFFFC0" ClientInstanceName="MenuImprimir"
        EnableAnimation="False" EnableDefaultAppearance="False" Font-Size="8.7pt" ForeColor="#2859AB"
        GutterWidth="3px" ItemLinkMode="TextOnly" PopupAction="LeftMouseClick" PopupElementID="ButtonImprimir"
        PopupHorizontalAlign="OutsideLeft" PopupVerticalAlign="TopSides" ShowSubMenuShadow="False">
        <Items>
            <dxm:MenuItem Name="Item_PlanMensual" Target="_blank" Text="Plan de Trabajo Mensual">
            </dxm:MenuItem>
            <dxm:MenuItem Name="Item_Capacitacion" NavigateUrl="~/Printing/PlanPrintAll.aspx?type=CPS"
                Text="Plan de Capacitaci&#243;n">
            </dxm:MenuItem>
            <dxm:MenuItem Enabled="False" Name="Item_Mantenimiento" Text="Plan de Mantenimientos">
            </dxm:MenuItem>
            <dxm:MenuItem Enabled="False" Name="Item_Vacaciones" Text="Plan de Vacaciones">
            </dxm:MenuItem>
            <dxm:MenuItem Name="Item_Prevencion" NavigateUrl="~/Printing/PlanPrintAll.aspx?type=PRV"
                Text="Plan de Prevenci&#243;n">
            </dxm:MenuItem>
            <dxm:MenuItem Name="Item_Formacion" NavigateUrl="~/Printing/PlanPrintAll.aspx?type=FRM&amp;"
                Text="Plan de Formaci&#243;n Individual">
            </dxm:MenuItem>
            <dxm:MenuItem Enabled="False" Name="Item_Objetivos" Text="Objetivos de Trabajo">
            </dxm:MenuItem>
            <dxm:MenuItem Enabled="False" Name="Item_Temas" Text="Plan de Temas a Discutir/Informar">
            </dxm:MenuItem>
            <dxm:MenuItem Enabled="False" Name="Item_Actos" Text="Plan de Actos o Eventos">
            </dxm:MenuItem>
            <dxm:MenuItem Enabled="False" Name="Item_Visitas" Text="Plan de Visitas">
            </dxm:MenuItem>
            <dxm:MenuItem Enabled="False" Name="Item_Salidas" Text="Plan de Salidas al  Exterior">
            </dxm:MenuItem>
            <dxm:MenuItem Enabled="False" Name="Item_Otras" Text="Otras tareas">
            </dxm:MenuItem>
        </Items>
        <ItemStyle Height="13pt" HorizontalAlign="Left">
            <SelectedStyle BackColor="White">
            </SelectedStyle>
            <Paddings PaddingRight="3px" />
        </ItemStyle>
        <DisabledStyle ForeColor="#CCCCCC">
        </DisabledStyle>
        <Border BorderColor="#ACA899" BorderStyle="Solid" BorderWidth="1px" />
    </dxm:ASPxPopupMenu>
    <dxpc:ASPxPopupControl ID="ASPPopupControl" runat="server" AllowDragging="True"
        AllowResize="True" ClientInstanceName="popupEditar" EnableClientSideAPI="True" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="True" FooterText="Puede modifcar el tamaño de esta ventana según su necesidad." HeaderText="" Height="405px" Width="716px" >
        <ContentCollection>
            <dxpc:PopupControlContentControl runat="server">
           
            </dxpc:PopupControlContentControl>            
        </ContentCollection>
        <ModalBackgroundStyle Opacity="30">
        </ModalBackgroundStyle>
        <ClientSideEvents CloseUp="function(s, e) 
{
MonthView.commandCallBack('refresh');
PanelEstadistica.PerformCallback();
}" />
    </dxpc:ASPxPopupControl>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContenidoOpcional">

    <dxcp:ASPxCallbackPanel ID="PanelEstadistica" runat="server" 
        CssClass="PanelEstadistica" oncallback="PanelEstadistica_Callback" ClientInstanceName="PanelEstadistica"> 
  <PanelCollection>
   <dxp:PanelContent>
      <asp:SqlDataSource ID="SqlDataSource_InformeCuantitativo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
        SelectCommand="stp_EstadisticaDeEjecucionDelMes" 
        SelectCommandType="StoredProcedure" >
        <SelectParameters>
            <asp:FormParameter FormField="DropDownList_MesPrint" Name="Mes" Type="Int32" />
            <asp:FormParameter FormField="DropDownList_AnioPrint" Name="Anio" 
                Type="String" />
            <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int32" />
            <asp:FormParameter FormField="DropDownList_PlanesPrint" Name="PlanID" 
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table cellspacing="1" align="right" id="CajaTexto">
        <tr class="Encabezado">
            <td align="center" colspan="4" style="font-weight:bold;text-align:center;">
                Estadísticas de Ejecución </td>
        </tr>
        <tr>
            <td align="right" width="30%" class="Cuerpo">
                Planificadas:</td>
            <td align="right" width="20%" class="Cuerpo">
                <asp:Label ID="Label_Planificadas" runat="server" Font-Bold="True" 
                    ForeColor="Black">0</asp:Label>
            </td>
            <td align="right" width="30%" class="Cuerpo">
                Cumplidas:</td>
            <td align="right" width="20%" class="Cuerpo">
                <asp:Label ID="Label_Cumplidas" runat="server" Font-Bold="True" 
                    ForeColor="ForestGreen">0</asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right" width="30%" class="Cuerpo">
                Incumplidas:
            </td>
            <td align="right" width="20%" class="Cuerpo">
                <asp:Label ID="Label_Incumplidas" runat="server" Font-Bold="True" 
                    ForeColor="Tomato">0</asp:Label>
            </td>
            <td align="right" width="30%" class="Cuerpo">
                Modificadas:</td>
            <td align="right" width="20%" class="Cuerpo">
                <asp:Label ID="Label_Modificadas" runat="server" Font-Bold="True" 
                    ForeColor="Blue">0</asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right" width="30%" class="Cuerpo">
                &nbsp;Nuevas:</td>
            <td align="right" width="20%" class="Cuerpo">
                <asp:Label ID="Label_Nuevas" runat="server" Font-Bold="True">0</asp:Label>
            </td>
            <td align="left" width="30%" class="Cuerpo">
                &nbsp;</td>
            <td align="left" width="20%" class="Cuerpo">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="4" style="font-weight: bold;" class="Pie">
                Actualizado:
                <asp:Label ID="Label_Hora" runat="server"></asp:Label>
            </td>
        </tr>
    </table>  
   </dxp:PanelContent>
  </PanelCollection>
    </dxcp:ASPxCallbackPanel>
</asp:Content>
<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder_Noticias"> 
</asp:Content>