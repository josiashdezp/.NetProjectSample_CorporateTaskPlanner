<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ObjetivFormac.aspx.cs" Inherits="Lists_ObjetivFormac" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Objetivos de Formación</title>
    <link href="../Styles/WebPlanner_Styles.css" rel="stylesheet" type="text/css" />    
</head>
<body>
    <form id="form1" runat="server">
    <div id="Content">
    <h3>Objetivos de formación:</h3>
        <asp:Label ID="Label_Mnsg" runat="server" ForeColor="Tomato"></asp:Label>
    <br />
    
        <table style="width:100%">
            <tr>
                <td valign="top">
                        <asp:DetailsView runat="server" AutoGenerateRows="False" 
                        DataKeyNames="ObjetivoID" DefaultMode="Insert" GridLines="Horizontal" 
                        DataSourceID="SqlDataSource_ObjetivosFormac_Detalles" CssClass="Listados" 
                        Height="50px" Width="75%" ID="DetailsView_Objetivos" 
                        HeaderText="Insertar objetivo de formación" 
                            oniteminserted="DetailsView_Objetivos_ItemInserted">
                            <HeaderStyle CssClass="Encabezado" />
<AlternatingRowStyle CssClass="Altern"></AlternatingRowStyle>
<Fields>
<asp:BoundField DataField="ObjetivoID" HeaderText="ObjetivoID" ReadOnly="True" 
        InsertVisible="False" SortExpression="ObjetivoID" Visible="False"></asp:BoundField>
<asp:BoundField DataField="Objetivo" HeaderText="Objetivo" 
        SortExpression="Objetivo">
<ControlStyle Width="80%"></ControlStyle>

<HeaderStyle Width="20%"></HeaderStyle>
</asp:BoundField>
    <asp:CommandField ShowInsertButton="True" EditText="" />
</Fields>
</asp:DetailsView>

                <asp:SqlDataSource ID="SqlDataSource_ObjetivosFormac_Detalles" runat="server"
                    
        ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" DeleteCommand="DELETE FROM [ObjetivosFormacion] WHERE [ObjetivoID] = @original_ObjetivoID AND AreaID = @original_AreaID"
                    
        
        
        
        
                        InsertCommand="INSERT INTO [ObjetivosFormacion] ([Objetivo], [AreaID]) VALUES (@Objetivo, @AreaID)" OldValuesParameterFormatString="original_{0}"
                    SelectCommand="SELECT [ObjetivoID], [Objetivo], [AreaID] FROM [ObjetivosFormacion] where AreaID = @AreaID and ObjetivoID = @ObjetivoID"
                    
        
        
                        UpdateCommand="UPDATE [ObjetivosFormacion] SET [Objetivo] = @Objetivo WHERE [ObjetivoID] = @original_ObjetivoID AND [Objetivo] = @original_Objetivo AND (([AreaID] = @original_AreaID) OR ([AreaID] IS NULL AND @original_AreaID IS NULL))">
                    <SelectParameters>
                        <asp:SessionParameter Name="AreaID" SessionField="AreaID" />
                        <asp:ControlParameter ControlID="GridView_Objetivos" Name="ObjetivoID" 
                            PropertyName="SelectedValue" />
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
                <br />
                </td>
            </tr>
            <tr>
                <td style="width: 55%" valign="top">
    <asp:GridView ID="GridView_Objetivos" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" CssClass="Listados" 
        DataKeyNames="ObjetivoID" DataSourceID="SqlDataSource_ObjetivosFormac"
                    GridLines="Horizontal" Width="98%" PageSize="15" 
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
                                    CommandName="Edit" Text="Modificar"></asp:LinkButton>
                                <asp:LinkButton ID="LinkButton_Borrar" runat="server" CausesValidation="False" 
                                    CommandName="Delete" 
                                    onclientclick="return confirm('¿Está seguro desea borrar este objetivo? \n Esta operación no se puede deshacer.');" 
                                    Text="Borrar"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ObjetivoID" HeaderText="C&#243;digo ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="ObjetivoID" Visible="False" />
                        <asp:TemplateField HeaderText="Objetivo de formaci&#243;n" SortExpression="Objetivo">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Objetivo") %>' 
                                    Width="95%"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Objetivo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="75%" />
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
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
