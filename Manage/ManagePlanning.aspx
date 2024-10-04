<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="ManagePlanning.aspx.cs" Inherits="Manage_ManagePlanning" Title="Cumplimiento de Tareas Por Trabajador" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"  Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<dxcp:aspxcallbackpanel id="ASPxCallbackPanel1" runat="server" width="100%"><PanelCollection>
<dxp:PanelContent runat="server"><TABLE style="WIDTH: 100%"><TBODY><TR><TD align=right><h2>Ejecución de tareas por trabajador:</h2><br /></TD><td align="right"><asp:CheckBox ID="CheckBox_WeekEnd" runat="server" AutoPostBack="True" 
            EnableTheming="False" Font-Bold="False" Text="Ver fines de semana" />
 </td></TR><TR><TD align="left" colspan="2">Año:&nbsp;<asp:DropDownList ID="DropDownList_Anio" 
            runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="Input" 
            DataSourceID="SqlDataSourceAnio" DataTextField="Anio" DataValueField="Anio" 
            OnDataBound="DropDownList_Anio_DataBound" 
            OnSelectedIndexChanged="DropDownList_Anio_SelectedIndexChanged"></asp:DropDownList>
 &nbsp;Mes:&nbsp;<asp:DropDownList ID="DropDownList_Mes" runat="server" 
            AutoPostBack="True" CssClass="Input" OnLoad="DropDownList_Mes_Load" 
            OnSelectedIndexChanged="DropDownList_Mes_SelectedIndexChanged"><asp:ListItem Value="0">-Seleccionar-</asp:ListItem>
<asp:ListItem Value="1">Enero</asp:ListItem>
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
 &nbsp;Subordinado:&nbsp;<asp:DropDownList ID="DropDownList_Subordinados" runat="server" 
            AppendDataBoundItems="True" AutoPostBack="True" CssClass="Input" 
            DataSourceID="SqlDataSource_Subordinados" DataTextField="NombreCompleto" 
            DataValueField="NID" OnDataBound="DropDownList_Subordinados_DataBound" 
            OnSelectedIndexChanged="DropDownList_Subordinados_SelectedIndexChanged"><asp:ListItem Value="11111111111">Todos mis subordinados</asp:ListItem>
</asp:DropDownList>
 &nbsp;Plan:&nbsp;<asp:DropDownList ID="DropDownList_Plan" runat="server" 
            AutoPostBack="True" CssClass="Input" DataSourceID="SqlDataSource_Planes" 
            DataTextField="Nombre" DataValueField="PlanNro" 
            OnDataBound="DropDownList_Plan_DataBound" 
            OnSelectedIndexChanged="DropDownList_Plan_SelectedIndexChanged"><asp:ListItem Value="0">- No hay planes -</asp:ListItem>
</asp:DropDownList>
 &nbsp;&nbsp;<asp:HyperLink ID="HyperLink_Imprimir" runat="server" CssClass="Input" 
            NavigateUrl="~/Manage/ManagePrintPlan.aspx?Anio=xxxx&amp;Mes=XX&amp;NID=xxxxxxxxxxx&amp;Wk=x&amp;Plan=" 
            Target="_blank">Imprimir</asp:HyperLink>
 <asp:SqlDataSource ID="SqlDataSource_Subordinados" runat="server" 
            ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
            SelectCommand="stp_MostrarTrabajadoresSubordinados" 
            SelectCommandType="StoredProcedure"><SelectParameters>
<asp:SessionParameter Name="NIDJefe" SessionField="NID" Type="String" />
<asp:Parameter DefaultValue="false" Name="IncluirJefe" Type="Boolean" />
</SelectParameters>
</asp:SqlDataSource>
 <asp:SqlDataSource ID="SqlDataSourceAnio" runat="server" 
            ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
            SelectCommand="SELECT DISTINCT Anio FROM PlanAcciones"></asp:SqlDataSource>
 <asp:SqlDataSource ID="SqlDataSource_Planes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
            SelectCommand="stp_MostrarPlanesDelUsuario" SelectCommandType="StoredProcedure"><SelectParameters>
<asp:ControlParameter ControlID="DropDownList_Anio" Name="Anio" 
                    PropertyName="SelectedValue" Type="String" />
<asp:ControlParameter ControlID="DropDownList_Subordinados" Name="NID" 
                    PropertyName="SelectedValue" Type="String" />
<asp:Parameter DefaultValue="false" Name="EsPrivado" Type="Boolean" />
</SelectParameters>
</asp:SqlDataSource>
 &nbsp;&nbsp;</TD></TR><tr><td colspan="2"><asp:Label ID="Label_msg" runat="server" Font-Bold="True" 
                ForeColor="ForestGreen" Visible="False"></asp:Label>
 </td></tr></TBODY></TABLE><daypilot:daypilotmonth id="MonthView" runat="server" 
        backcolor="White" bordercolor="Black"
        cellheaderbackcolor="" cellheaderfontcolor="Black" datasourceid="SqlDataSource_ejecucion"
        eventbackcolor="White" eventbordercolor="Black" eventfontcolor="Black" eventtimefontcolor="Gray"
        headerbackcolor="White" headerfontcolor="Black" innerbordercolor="#CCCCCC"
        nonbusinessbackcolor="White" startdate="2010-01-01" weekstarts="Sunday" 
        width="100%" BubbleID="BubbleMonth" DataEndField="FechaCierra" 
        DataStartField="FechaPlanificada" 
        DataTagFields="Estado, Descripcion, TipoAccion, EjecutaNombre, EstadoColor, ResponsableNombre, PlanificadorNombre, Observaciones,NID, Detalles, NID_Ejecuta, EjecutaUserName, NombrePlan" 
        DataTextField="NombreAccion" DataValueField="EjecucionID" EventEndTime="False" 
        EventHeight="50" EventSortExpression="FechaPlanificada, NombreAccion asc" 
        EventStartTime="False" EventTextLeftIndent="5" 
        OnBeforeEventRender="MonthView_BeforeEventRender" ShowToolTip="False" 
        ContextMenuID="MenuContextual" OnEventMenuClick="MonthView_EventMenuClick" 
        CellHeaderFontFamily="Arial" EventTextAlignment="Left" 
        EventTimeFontFamily="Arial" HeaderFontFamily="Arial" 
        OnLoad="MonthView_Load"></daypilot:daypilotmonth>
 <DayPilot:DayPilotBubble ID="BubbleMonth" runat="server" BackColor="#FFFFFF" BorderColor="#000000"
        ClientObjectName="BubbleMonth" HideAfter="500" LoadingText="Cargando descripci&#243;n de la tarea..."
        OnRenderContent="BubbleMonth_RenderContent" ShowAfter="500" ShowLoadingLabel="True"
        UseBorder="True" UseShadow="False" Width="220">
    </DayPilot:DayPilotBubble>
 <DayPilot:DayPilotMenu ID="MenuContextual" runat="server" ClientObjectName="menu" CssClassPrefix="ContextMenu_"
        MenuBackColor="#FFFFC0" MenuBorderColor="#ACA899" MenuFontSize="8.7pt" MenuItemColor="#2859AB"
        MenuTitle="Opciones disponibles:" MenuTitleBackColor="#FFE0C0"><DayPilot:MenuItem Action="JavaScript" Text="Notificar a implicados" JavaScript="PopupControlMensaje.SetContentUrl('ManageSendEmail.aspx?id='+ e.value()); PopupControlMensaje.Show();" />
</DayPilot:DayPilotMenu>
 &nbsp;<asp:SqlDataSource ID="SqlDataSource_Ejecucion" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
        SelectCommand="stp_MostrarEjecucionDeTareasPorTrabajador" 
        SelectCommandType="StoredProcedure" FilterExpression="NID_Ejecuta = '{0}'" 
        OnFiltering="SqlDataSource_Ejecucion_Filtering"><SelectParameters>
<asp:ControlParameter ControlID="DropDownList_Anio" Name="Anio" PropertyName="SelectedValue"
                Type="String" />
<asp:ControlParameter ControlID="DropDownList_Mes" Name="Mes" PropertyName="SelectedValue"
                Type="Int32" />
<asp:ControlParameter ControlID="DropDownList_Plan" Name="PlanID" PropertyName="SelectedValue"
                Type="Int16" />
<asp:ControlParameter ControlID="DropDownList_Subordinados" Name="NID_Trabajador" PropertyName="SelectedValue"
                Type="String" />
<asp:SessionParameter Name="NID_Jefe" SessionField="NID" Type="String" />
</SelectParameters>
<FilterParameters>
<asp:ControlParameter ControlID="DropDownList_Subordinados" Name="NID" PropertyName="SelectedValue" />
</FilterParameters>
</asp:SqlDataSource>
 <dxpc:aspxpopupcontrol id="PopupControlMensaje" runat="server" allowdragging="True"
        allowresize="True" clientinstancename="PopupControlMensaje" enableanimation="False"
        footertext="Puede mover o cambiar el tama&#241;o de esta ventana seg&#250;n su necesidad."
        headertext="Notificar trabajadores implicados" modal="True" showfooter="True" CssClass="LoginForm" Height="250px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="420px" EnableHotTrack="False">
<ModalBackgroundStyle Opacity="35"></ModalBackgroundStyle>
<ContentCollection>
<dxpc:PopupControlContentControl runat="server"></dxpc:PopupControlContentControl>
</ContentCollection>
<HeaderStyle Font-Bold="True" />

</dxpc:aspxpopupcontrol>
 </dxp:PanelContent>
</PanelCollection>
</dxcp:aspxcallbackpanel>
</asp:Content>