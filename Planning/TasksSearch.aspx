<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="TasksSearch.aspx.cs" Inherits="Planning_PlanMes" Title="Buscar tareas programadas. Planificador Online." MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"   Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"   Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
    <table width="100%" style="margin: auto">
    <tr>
        <td align="center" valign="middle" style="width: 549px">
            <ext:ScriptManager ID="ScriptManager1" runat="server">
            </ext:ScriptManager>
         </td>
    </tr>
    <tr>
        <td align="left">
            <h2>Buscar tareas programadas:</h2>
            <br />
            </td>
    </tr>
    <tr align="center">
        <td align="center">
        <table style="width: 99%" align="center" cellspacing="5">
                <tr>
                    <td style="width: 5%" align="right" width="4%">
                        Desde:</td>
                    <td width="15%" align="left">
                        <ext:DateField ID="DateField_Desde" runat="server" IDMode="Legacy" MaxDate="" 
                            MinDate="" SelectedDate="" TodayText="Hoy" AllowBlank="False">
                </ext:DateField>
                    </td>
                    <td width="5%" align="right">
                        Hasta:
                    </td>
                    <td width="15%" align="left">
                        <ext:DateField ID="DateField_Hasta" runat="server" IDMode="Legacy" MaxDate="" 
                            MinDate="" SelectedDate="" TodayText="Hoy" AllowBlank="False">
                </ext:DateField>
                    </td>
                    <td width="5%" align="right">
                        Tipo:</td>
                    <td width="20%" align="left">
                        <asp:DropDownList 
                ID="DropDownList_Tipo" runat="server"
        AutoPostBack="True" CssClass="Input" DataSourceID="SqlDataSource_TiposTareas"
        DataTextField="TipoAccion" DataValueField="TipoID">
                            <asp:ListItem Value="0">-Todos los tipos-</asp:ListItem>
    </asp:DropDownList>
                    </td>
                    <td width="30%" align="left">
                        <asp:CheckBox ID="CheckBox_vistaDetallada" runat="server" 
                            Text="Ver resultados de ejecución." 
                            onclick="" 
                            AutoPostBack="True" 
                            oncheckedchanged="CheckBox_vistaDetallada_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 5%" align="right" width="4%">
                        Nombre:</td>
                    <td colspan="6" align="left">
                        <asp:DropDownList ID="DropDownList_Nombre" runat="server" CssClass="Input" DataSourceID="SqlDataSource_Acciones"
        DataTextField="Nombre" DataValueField="AccionID" ondatabound="DropDownList_Nombre_DataBound">
                            <asp:ListItem Value="0">-Todos los tipos-</asp:ListItem>
    </asp:DropDownList>
                        &nbsp;<asp:Button ID="Button1" runat="server" CausesValidation="False" 
                            CssClass="Input" onclientclick="Callback_Buscar.PerformCallback('cargar');" 
                            Text="Buscar ..." />
                        <dxcb:ASPxCallback ID="ASPxCallback_Buscar" runat="server" ClientInstanceName="Callback_Buscar" 
                            oncallback="ASPxCallback_Resultados_Callback">
                            <ClientSideEvents CallbackComplete="function(s, e) {

}" />
                        </dxcb:ASPxCallback>
                    </td>
                </tr>
                </table>
        </td>
    </tr>
    </table>
    <asp:GridView ID="GridView_Resultados" runat="server" CssClass="Listados" 
        Width="80%" AutoGenerateColumns="False" 
        DataSourceID="ObjectDataSource_Ejecuciones" 
        EmptyDataText="La tarea seleccionada no se ha planificado." 
        AllowPaging="True" AllowSorting="True" 
        onrowdatabound="GridView_Resultados_RowDataBound" GridLines="Horizontal" 
        PageSize="30"         >
        <EmptyDataRowStyle CssClass="Empty" />
        <Columns>
            <asp:BoundField DataField="EjecucionID" HeaderText="EjecucionID" 
                SortExpression="EjecucionID" Visible="False" />
            <asp:BoundField DataField="PlanID" HeaderText="PlanID" 
                SortExpression="PlanID" Visible="False" />
            <asp:BoundField DataField="AnioID" HeaderText="AnioID" 
                SortExpression="AnioID" Visible="False" />
            <asp:BoundField DataField="NID" HeaderText="NID" SortExpression="NID" 
                Visible="False" />
            <asp:BoundField DataField="AccionID" HeaderText="AccionID" 
                SortExpression="AccionID" Visible="False" />
            <asp:BoundField DataField="FechaPlanificada" HeaderText="Fecha planificada" 
                SortExpression="FechaPlanificada" DataFormatString="{0:d}" />
            <asp:BoundField DataField="FechaCierra" HeaderText="Fecha vencimiento" 
                SortExpression="FechaCierra" DataFormatString="{0:d}" />
            <asp:BoundField DataField="FechaEjecutada" HeaderText="Fecha de ejecución" 
                SortExpression="FechaEjecutada" DataFormatString="{0:d}" />
            <asp:BoundField DataField="Estado" HeaderText="Estado" 
                SortExpression="Estado" />
            <asp:BoundField DataField="EstadoColor" HeaderText="EstadoColor" 
                SortExpression="EstadoColor" Visible="False" />
        </Columns>
        <SelectedRowStyle BackColor="#FFFFCC" />
        <HeaderStyle CssClass="Encabezado" HorizontalAlign="Center" />
        <AlternatingRowStyle CssClass="Altern" />
    </asp:GridView>
        <asp:DataList ID="DataList_Detalles" runat="server" 
        DataSourceID="ObjectDataSource_Ejecuciones" RepeatColumns="1" Width="95%">
            <AlternatingItemTemplate>
                <table align="left" style="width: 100%; background-color: #B8D1E5;" 
                    class="Listados">
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            FechaPlanificada:</td>
                        <td align="left">
                            <asp:Label ID="FechaPlanificadaLabel" runat="server" 
                                Text='<%# Eval("FechaPlanificada", "{0:d}") %>' />
                        </td>
                        <td align="left" style="font-weight: bold;" width="70%">
                            Observaciones/Resultados de ejecución:</td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            &nbsp;FechaCierra:
                        </td>
                        <td align="left">
                            <asp:Label ID="FechaCierraLabel" runat="server" 
                                Text='<%# Eval("FechaCierra") %>' />
                        </td>
                        <td align="left" rowspan="7" valign="top" width="70%">
                            <asp:Label ID="ObservacionesLabel" runat="server" 
                                Text='<%# Eval("Observaciones") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            FechaEjecutada:
                        </td>
                        <td align="left">
                            <asp:Label ID="FechaEjecutadaLabel" runat="server" 
                                Text='<%# Eval("FechaEjecutada") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Planificador:</td>
                        <td align="left">
                            <asp:Label ID="PlanificadorNombreLabel" runat="server" 
                                Text='<%# Eval("PlanificadorNombre") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Ejecutante:</td>
                        <td align="left">
                            <asp:Label ID="EjecutaNombreLabel" runat="server" 
                                Text='<%# Eval("EjecutaNombre") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Responsable:</td>
                        <td align="left">
                            <asp:Label ID="ResponsableNombreLabel" runat="server" 
                                Text='<%# Eval("ResponsableNombre") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Otros implicados:</td>
                        <td align="left">
                            <asp:Label ID="OtrosImplicadosLabel" runat="server" 
                                Text='<%# Eval("OtrosImplicados") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Estado actual:</td>
                        <td align="left">
                            <asp:Label ID="EstadoLabel" runat="server" Text='<%# Eval("Estado") %>' />
                        </td>
                    </tr>
                </table>
            </AlternatingItemTemplate>
            <HeaderTemplate>
               <div class="Listados">
               <h3 class="Encabezado"> Resultado de ejecución de la tarea</h3>
               </div>
               
            </HeaderTemplate>
            <ItemTemplate>
                <table align="left" style="width: 100%" bgcolor="White" class="Listados">
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            FechaPlanificada:</td>
                        <td align="left">
                            <asp:Label ID="FechaPlanificadaLabel" runat="server" 
                                Text='<%# Eval("FechaPlanificada", "{0:d}") %>' />
                        </td>
                        <td align="left" style="font-weight: bold;" width="70%">
                            Observaciones/Resultados de ejecución:</td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            &nbsp;FechaCierra: </td>
                        <td align="left">
                            <asp:Label ID="FechaCierraLabel" runat="server" 
                                Text='<%# Eval("FechaCierra") %>' />
                        </td>
                        <td align="left" rowspan="7" valign="top" width="70%">
                            <asp:Label ID="ObservacionesLabel" runat="server" 
                                Text='<%# Eval("Observaciones") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            FechaEjecutada:
                        </td>
                        <td align="left">
                            <asp:Label ID="FechaEjecutadaLabel" runat="server" 
                                Text='<%# Eval("FechaEjecutada") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Planificador:</td>
                        <td align="left">
                            <asp:Label ID="PlanificadorNombreLabel" runat="server" 
                                Text='<%# Eval("PlanificadorNombre") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Ejecutante:</td>
                        <td align="left">
                            <asp:Label ID="EjecutaNombreLabel" runat="server" 
                                Text='<%# Eval("EjecutaNombre") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Responsable:</td>
                        <td align="left">
                            <asp:Label ID="ResponsableNombreLabel" runat="server" 
                                Text='<%# Eval("ResponsableNombre") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Otros implicados:</td>
                        <td align="left">
                            <asp:Label ID="OtrosImplicadosLabel" runat="server" 
                                Text='<%# Eval("OtrosImplicados") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Estado actual:</td>
                        <td align="left">
                            <asp:Label ID="EstadoLabel" runat="server" Text='<%# Eval("Estado") %>' />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
    </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource_TiposTareas" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
        
        
        SelectCommand="SELECT TipoID, TipoAccion FROM TipoAccion ORDER BY TipoAccion asc">
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Acciones" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" 
                    SelectCommand="stp_MostrarAccionesPorTrabajador" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_Tipo" Name="TipoAccionID" 
                            PropertyName="SelectedValue" Type="Int16" />
                        <asp:SessionParameter Name="NID" SessionField="NID" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource_Ejecuciones" runat="server" 
        OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetDataBy_FechaEjecucion"        
        TypeName="DataSet_Planificador_InformesTableAdapters.view_EjecucionDeTareasTableAdapter" 
        FilterExpression="NID_Ejecuta = '{0}' and AccionID={1}">
        <FilterParameters>
            <asp:SessionParameter Name="NID" SessionField="NID" />
            <asp:ControlParameter ControlID="DropDownList_Nombre" Name="AccionNombre" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Tipo" Name="TipoAccion" 
                PropertyName="SelectedValue" />
        </FilterParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DateField_Desde" Name="FechaInicio" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="DateField_Hasta" Name="FechaFin" 
                PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </asp:Content>

