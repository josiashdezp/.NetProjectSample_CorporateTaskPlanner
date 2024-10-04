<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="PlanMain.aspx.cs" Inherits="Planning_PlanMain" Title="Planes de Trabajo" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">

   <ext:ScriptManager ID="ScriptManager1" runat="server"></ext:ScriptManager>
       <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Administrar Planes de Trabajo:</h3>
       <br />
       <center>
             <dxcp:ASPxCallbackPanel ID="CallbackPanel" runat="server" ClientInstanceName="ClientCallbackPanel"
        OnCallback="CallbackPanel_Callback" Width="90%">
        <PanelCollection>
            <dxp:PanelContent runat="server">
    <table style="width: 100%;margin:auto;">
        <tr>
            <td align="left">
    Ver planes del año:
    <asp:DropDownList ID="DropDownList_Anio" runat="server" AutoPostBack="True" CssClass="Input"
        DataSourceID="SqlDataSource_PlansList" DataTextField="Anio" DataValueField="Anio"
        OnDataBound="DropDownList_Anio_DataBound" OnSelectedIndexChanged="DropDownList_Anio_SelectedIndexChanged">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_PlansList" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
        SelectCommand="SELECT distinct [Anio] FROM [PlanAcciones] ORDER BY [Anio]"></asp:SqlDataSource>
            </td>
            <td align="right">
                <input id="Button_Plan" class="Button" type="button" value="Nuevo plan" />&nbsp;
                <asp:HyperLink ID="HyperLink_Imprimir" runat="server" CssClass="Input" NavigateUrl="~/Planning/PlanPrint.aspx" Enabled="false">Imprimir</asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                &nbsp;&nbsp;
    <asp:GridView ID="GridView_Planes" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CssClass="Listados" DataKeyNames="PlanID,Anio" DataSourceID="SqlDataSource_PlanesPropios"
        EmptyDataText="No hay planes registrados para esta etapa." GridLines="Horizontal"
        Width="100%">
        <EmptyDataRowStyle CssClass="Empty" Font-Bold="True" />
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                        Text="Actualizar"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="Cancelar"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                        Text="Editar"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm(" Al borrar un plan de trabajo se eliminarán automáticamente todas las tareas programadas en él. \n ¿ Desea continuar con la operación?");'
                        Text="Eliminar"></asp:LinkButton>
                </ItemTemplate>
                <HeaderStyle Width="10%" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="20%" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Nombre" SortExpression="Nombre">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="Input" Rows="4" Text='<%# Bind("Nombre") %>'
                        TextMode="MultiLine" Width="237px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Nombre") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Width="25%" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Observaciones" SortExpression="Observaciones">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="Input" Rows="4" Text='<%# Bind("Observaciones") %>'
                        TextMode="MultiLine" Width="95%"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Observaciones") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" Width="25%" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Inicia" SortExpression="FechaInicio">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaInicio", "{0:d}") %>'></asp:Label>&nbsp;
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaInicio", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" Width="10%" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Cierra" SortExpression="FechaCierre">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("FechaCierre", "{0:d}") %>'></asp:Label>&nbsp;
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("FechaCierre", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" Width="10%" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:CheckBoxField DataField="EsPrivado" HeaderText="Es privado" 
                SortExpression="EsPrivado">
                <HeaderStyle Width="15%" />
            </asp:CheckBoxField>
        </Columns>
        <SelectedRowStyle BackColor="#C0FFC0" Font-Bold="False" />
        <HeaderStyle CssClass="Encabezado" />
        <AlternatingRowStyle CssClass="Altern" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_PlanesPropios" runat="server" ConflictDetection="CompareAllValues"
        ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" DeleteCommand="DELETE FROM PlanAcciones WHERE (PlanID = @original_PlanID) AND (Anio = @original_Anio) AND (Nombre = @original_Nombre)"
        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT PlanID, Anio, Nombre, FechaInicio, Observaciones, FechaCierre, NID, EsPrivado FROM PlanAcciones WHERE (Anio = @Anio) AND (NID = @NID)"
        
                    UpdateCommand="UPDATE PlanAcciones SET Nombre =@Nombre, Observaciones =@Observaciones, EsPrivado = @EsPrivado where PlanID = @original_PlanID and Anio = @original_Anio">
        <DeleteParameters>
            <asp:Parameter Name="original_PlanID" Type="Int16" />
            <asp:Parameter Name="original_Anio" Type="String" />
            <asp:Parameter Name="original_Nombre" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PlanID" Type="Int16" />
            <asp:ControlParameter ControlID="DropDownList_Anio" Name="Anio" PropertyName="SelectedValue"
                Type="String" />
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="FechaInicio" Type="DateTime" />
            <asp:Parameter Name="Observaciones" Type="String" />
            <asp:Parameter Name="FechaCierre" Type="String" />
            <asp:Parameter Name="EstaAprobado" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Anio" Name="Anio" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="NID" SessionField="NID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="Observaciones" Type="String" />
            <asp:Parameter Name="original_PlanID" Type="Int16" />
            <asp:Parameter Name="original_Anio" Type="String" />
            <asp:Parameter Name="EsPrivado" />
        </UpdateParameters>
    </asp:SqlDataSource>
            </td>
        </tr>
    </table>
            </dxp:PanelContent>
        </PanelCollection>
    </dxcp:ASPxCallbackPanel>    
       </center>
    <dxcb:aspxcallback id="Callback_PlanTrabajo" runat="server" clientinstancename="CallbackPlanTrabajo"
                            oncallback="Callback_PlanTrabajo_Callback">
                            <ClientSideEvents CallbackComplete="function(s, e) {
	window.open(e.result,'_blank','');
	PopupImprimir.HideWindow(PopupImprimir.GetWindow(1));}" />
                        </dxcb:aspxcallback>
    <h3>
    <!--onclick="PopupImprimir.ShowWindow(PopupImprimir.GetWindow(##))" -->
    <!--onclick="PopupImprimir.ShowWindow(PopupImprimir.GetWindow(1))"-->
    <!--onclick="PopupImprimir.ShowWindow(PopupImprimir.GetWindow(##))"-->
    <!-- onclick="PopupImprimir.ShowWindow(PopupImprimir.GetWindow(0))" -->
    <dxpc:ASPxPopupControl ID="PopupControl_AddPlan" runat="server" ClientInstanceName="PopupControl_AddPlan"
        HeaderText="" Height="480px" PopupElementID="Button_Plan" PopupHorizontalAlign="WindowCenter"
        PopupVerticalAlign="WindowCenter" Width="576px" AllowResize="True" 
            Modal="True" FooterText="Cambie el tamaño de esta ventana según su necesidad" 
            ShowFooter="True" ShowSizeGrip="True">
        <ContentCollection>
            <dxpc:PopupControlContentControl runat="server">
            </dxpc:PopupControlContentControl>
        </ContentCollection>
        <ModalBackgroundStyle Opacity="35">
        </ModalBackgroundStyle>
        <ClientSideEvents CloseUp="function(s, e) {
	ClientCallbackPanel.PerformCallback('');
}" />
    </dxpc:ASPxPopupControl>
        &nbsp;</h3>
   
</asp:Content>

