<%@ Page Title="Objetivos de Formación. Planificador Online" Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="ObjetivosFormacion.aspx.cs" Inherits="Lists_ObjetivosFormacion" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" Runat="Server">
<h3>Objetivos de Formación</h3>
<br />
<input id="Button_InsertarObjetivo" class="Input" type="button" 
        value="Adicionar objetivo de formación" />
    &nbsp; &nbsp;
    <asp:Label ID="Label_Mnsg" runat="server" Font-Bold="True" ForeColor="Tomato" Visible="False"></asp:Label>
    <br /><br />
    <asp:GridView ID="GridView_Objetivos" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" CssClass="Listados" 
        DataKeyNames="ObjetivoID" DataSourceID="SqlDataSource_ObjetivosFormac"
                    GridLines="Horizontal" Width="74%" PageSize="15" 
        OnRowDeleting="GridView_Objetivos_RowDeleting" 
        EmptyDataText="No se han registrado objetivos de formación.">
                    <EmptyDataRowStyle CssClass="Empty" />
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                    CommandName="Update" Text="Actualizar"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" Text="Cancelar"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                    CommandName="Edit" Text="Editar"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                    CommandName="Delete" Text="Borrar" 
                                    onclientclick="return confirm('Este objetivo puede estar relacionado con alguna acción de formación individual. \n ¿Está seguro que desea borrarlo? Esta operación no se puede deshacer.');"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ObjetivoID" HeaderText="Código ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="ObjetivoID" Visible="False" />
                        <asp:TemplateField HeaderText="Objetivo de formación" SortExpression="Objetivo">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Objetivo") %>' 
                                    Width="95%"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Objetivo") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="Encabezado" />
                    <AlternatingRowStyle CssClass="Altern" />
        <SelectedRowStyle BackColor="#C0FFC0" CssClass="Selected" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_ObjetivosFormac" runat="server"
                    
        ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" DeleteCommand="DELETE FROM [ObjetivosFormacion] WHERE [ObjetivoID] = @original_ObjetivoID AND AreaID = @original_AreaID"
                    
        
        
        
        InsertCommand="INSERT INTO [ObjetivosFormacion] ([Objetivo], [AreaID]) VALUES (@Objetivo, @AreaID)" OldValuesParameterFormatString="original_{0}"
                    SelectCommand="SELECT [ObjetivoID], [Objetivo], [AreaID] FROM [ObjetivosFormacion] where AreaID = @AreaID"
                    
        
        UpdateCommand="UPDATE [ObjetivosFormacion] SET [Objetivo] = @Objetivo WHERE [ObjetivoID] = @original_ObjetivoID AND [Objetivo] = @original_Objetivo AND (([AreaID] = @original_AreaID) OR ([AreaID] IS NULL AND @original_AreaID IS NULL))">
                    <SelectParameters>
                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="original_ObjetivoID" />
                        <asp:SessionParameter Name="original_AreaID" SessionField="AreaID" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Objetivo" Type="String" />
                        <asp:Parameter Name="AreaID" Type="Int16" />
                        <asp:Parameter Name="original_ObjetivoID" Type="Int16" />
                        <asp:Parameter Name="original_Objetivo" Type="String" />
                        <asp:SessionParameter Name="original_AreaID" SessionField="AreaID" 
                            Type="Int16" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Objetivo" Type="String" />
                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" Type="Int16" />
                    </InsertParameters>
                </asp:SqlDataSource>
    &nbsp;&nbsp;
    <dxpc:aspxpopupcontrol ID="ASPxPopupControl1" runat="server" AllowDragging="True"
        CssClass="Listados" DragElement="Window" HeaderText="" Modal="True" 
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        Width="431px">
        <ContentCollection>
            <dxpc:PopupControlContentControl runat="server">
                </dxpc:PopupControlContentControl>
        </ContentCollection>
        <HeaderStyle CssClass="Encabezado" Font-Bold="True" ForeColor="#FFFFE1" />
        <Windows>
            <dxpc:PopupWindow HeaderText="Adicionar objetivo de formación" PopupElementID="Button_InsertarObjetivo"
                ShowHeader="True" Modal="True">
                <ContentCollection>
                    <dxpc:PopupControlContentControl runat="server">
                        <asp:DetailsView ID="DetailsView_Objetivos" runat="server" 
                            AutoGenerateRows="False" CssClass="Listados"
                    DataKeyNames="ObjetivoID" DataSourceID="SqlDataSource_ObjetivosFormac" DefaultMode="Insert"
                    GridLines="Horizontal" Height="50px" Width="100%">
                    <AlternatingRowStyle CssClass="Altern" />
                    <Fields>
                        <asp:BoundField DataField="ObjetivoID" HeaderText="ObjetivoID" 
                            InsertVisible="False" ReadOnly="True"
                            SortExpression="ObjetivoID" />
                        <asp:BoundField DataField="Objetivo" HeaderText="Objetivo" 
                            SortExpression="Objetivo" >
                        <ControlStyle Width="80%" />
                        <HeaderStyle Width="20%" />
                        </asp:BoundField>
                        <asp:TemplateField ShowHeader="False">
                            <InsertItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                    CommandName="Insert" Text="Insertar"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" Text="Cancelar"></asp:LinkButton>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                    CommandName="New" Text="New"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                </asp:DetailsView>
                    </dxpc:PopupControlContentControl>
                </ContentCollection>
            </dxpc:PopupWindow>
        </Windows>
    </dxpc:aspxpopupcontrol>
</asp:Content>

