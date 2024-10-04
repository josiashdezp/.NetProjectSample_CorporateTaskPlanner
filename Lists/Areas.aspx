<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="Areas.aspx.cs" Inherits="Lists_Dptos" Title="Clasificador de Áreas y Departamentos" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
                <h2>&nbsp;&nbsp;&nbsp;&nbsp;Areas de trabajo:</h2>
    <input id="Button_InsertarArea" class="Input" type="button" value="Adicionar área" />
    &nbsp; &nbsp;
    <asp:Label ID="Label_Mnsg" runat="server" Font-Bold="True" ForeColor="Tomato" Visible="False"></asp:Label><br />
    &nbsp;<asp:GridView ID="GridView_Areas" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" CssClass="Listados" DataKeyNames="AreaID" DataSourceID="SqlDataSource_AreasDptos"
                    GridLines="Horizontal" Width="60%" PageSize="15" OnRowDeleting="GridView_Areas_RowDeleting">
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
                                    OnClientClick="return confirm( 'Esta operación borrará definitivamente el registro del sistema.  \n ¿Está seguro desea eliminar el área seleccionada.?');"
                                    Text="Eliminar"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="30%" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="AreaID" HeaderText="C&#243;digo" InsertVisible="False"
                            ReadOnly="True" SortExpression="AreaID" />
                        <asp:BoundField DataField="NombreArea" HeaderText="Nombre" SortExpression="NombreArea" >
                            <ItemStyle HorizontalAlign="Left" Width="70%" />
                        </asp:BoundField>
                    </Columns>
                    <HeaderStyle CssClass="Encabezado" />
                    <AlternatingRowStyle CssClass="Altern" />
        <SelectedRowStyle BackColor="#C0FFC0" CssClass="Selected" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_AreasDptos" runat="server"
                    ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" DeleteCommand="DELETE FROM [Areas] WHERE [AreaID] = @original_AreaID"
                    InsertCommand="INSERT INTO [Areas] ([NombreArea]) VALUES (@NombreArea)" OldValuesParameterFormatString="original_{0}"
                    SelectCommand="SELECT [AreaID], [NombreArea] FROM [Areas] ORDER BY [NombreArea]"
                    UpdateCommand="UPDATE [Areas] SET [NombreArea] = @NombreArea WHERE [AreaID] = @original_AreaID AND [NombreArea] = @original_NombreArea">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView_Areas" Name="original_AreaID" PropertyName="SelectedDataKey"
                            Type="Int16" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="NombreArea" Type="String" />
                        <asp:Parameter Name="original_AreaID" Type="Int16" />
                        <asp:Parameter Name="original_NombreArea" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="NombreArea" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
    &nbsp;&nbsp;
    <dxpc:ASPxPopupControl ID="ASPxPopupControl1" runat="server" AllowDragging="True"
        CssClass="Listados" DragElement="Window" HeaderText="" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        Width="300px">
        <ContentCollection>
            <dxpc:PopupControlContentControl runat="server">
                </dxpc:PopupControlContentControl>
        </ContentCollection>
        <HeaderStyle CssClass="Encabezado" Font-Bold="True" ForeColor="#FFFFE1" />
        <Windows>
            <dxpc:PopupWindow HeaderText="Adicionar &#225;rea de trabajo" PopupElementID="Button_InsertarArea"
                ShowHeader="True" Modal="True">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <asp:DetailsView ID="DetailsView_Dptos" runat="server" AutoGenerateRows="False" CssClass="Listados"
                    DataKeyNames="AreaID" DataSourceID="SqlDataSource_AreasDptos" DefaultMode="Insert"
                    GridLines="Horizontal" Height="50px" Width="100%">
                    <AlternatingRowStyle CssClass="Altern" />
                    <Fields>
                        <asp:BoundField DataField="AreaID" HeaderText="AreaID" InsertVisible="False" ReadOnly="True"
                            SortExpression="AreaID" />
                        <asp:BoundField DataField="NombreArea" HeaderText="Nombre:" SortExpression="NombreArea" />
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:PopupWindow>
        </Windows>
    </dxpc:ASPxPopupControl>
</asp:Content>

