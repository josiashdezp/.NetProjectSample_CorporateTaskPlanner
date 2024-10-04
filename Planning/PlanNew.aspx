<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanNew.aspx.cs" Inherits="Planning_PlanNew" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1"    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="Coolite.Ext.Web" Namespace="Coolite.Ext.Web" TagPrefix="ext" %>
<%@ Register Assembly="DevExpress.Web.v8.2, Version=8.2.3.0, Culture=neutral, PublicKeyToken=9b171c9fd64da1d1" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Registro de tareas a programar.</title>
    <link href="../Styles/WebPlanner_Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form2" runat="server">
    <div id="Content">
        <h2>Mis Planes de Trabajo:</h2><br />
        <center>
            <ext:scriptmanager id="ScriptManager_NewPlan" runat="server"></ext:scriptmanager>
            <asp:FormView ID="FormView_Insert" runat="server" CssClass="LoginForm" DataKeyNames="PlanID,Anio"
                DataSourceID="SqlDataSource_Details" DefaultMode="Insert" EmptyDataText="Seleccione el plan a visualizar." Width="80%" Height="60%">
                <HeaderStyle CssClass="Encabezado" />
                <InsertItemTemplate>
                    <table cellpadding="6" cellspacing="6" width="95%">
                        <tbody>
                            <tr>
                                <td align="right" style="width: 20%">
                                    Año:
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="DropDownList_Anio" runat="server" AutoPostBack="True" CssClass="Input"
                                        DataSourceID="SqlDataSource_PlansList" DataTextField="Anio" DataValueField="Anio"
                                        OnDataBound="DropDownList_Anio_DataBound">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource_PlansList" runat="server" ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>"
                                        SelectCommand="SELECT distinct [Anio] FROM [PlanAcciones] ORDER BY [Anio]"></asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 20%">
                                    Nombre:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="NombreTextBox" runat="server" CssClass="Input" Text='<%# Bind("Nombre") %>'
                                        ValidationGroup="Insertar" Width="80%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NombreTextBox"
                                        ErrorMessage="El nombre es necesario para identificar el plan." ForeColor="Tomato"
                                        ValidationGroup="Insertar">*</asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 20%">
                                    Observaciones:
                                    <br />
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="ObservacionesTextBox" runat="server" CssClass="Input" Font-Names="Verdana, Tahoma, San-serif"
                                        Text='<%# Bind("Observaciones") %>' TextMode="MultiLine" Width="95%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 20%">
                                    Desde:</td>
                                <td align="left">
                                    &nbsp;<ext:datefield id="DateField_Desde" runat="server" validationgroup="Insertar"></ext:datefield>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DateField_Desde"
                                        Display="Dynamic" ErrorMessage="Falta la fecha de inicio del plan de trabajo"
                                        ForeColor="Tomato" ValidationGroup="Insertar">*</asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 20%">
                                    Hasta:</td>
                                <td align="left">
                                    &nbsp;<ext:datefield id="DateField_Hasta" runat="server" validationgroup="Insertar"></ext:datefield>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="DateField_Hasta"
                                        Display="Dynamic" ErrorMessage="Campo obligatorio" ForeColor="Tomato" ValidationGroup="Insertar">*</asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="DateField_Desde"
                                        ControlToValidate="DateField_Hasta" Display="Dynamic" ErrorMessage="Valor incorrecto"
                                        ForeColor="Tomato" Operator="GreaterThan" ValidationGroup="Insertar">*</asp:CompareValidator></td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 20%">
                                </td>
                                <td align="left">
                                    <asp:CheckBox ID="CheckBox_Tipo" runat="server" Checked='<%# Bind("EsPrivado") %>'
                                        Text="Este plan es privado" /></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 25px" valign="middle">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List"
                                        ForeColor="Tomato" ValidationGroup="Insertar" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="height: 16px">
                                    <asp:LinkButton ID="Button_Insertar" runat="server" CausesValidation="True" CommandName="Insert"
                                        OnClientClick="return confirm('La modificación de las fechas de un plan en el futuro, puede afectar la programación que se realize. \n ¿Está seguro desea crear el plan con los datos especificados?.');"
                                        Text="Insertar" ValidationGroup="Insertar"></asp:LinkButton></td>
                            </tr>
                        </tbody>
                    </table>
                </InsertItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSource_Details" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:BDPlanificadorConnectionString %>" InsertCommand="INSERT INTO PlanAcciones(Anio, Nombre, FechaInicio, Observaciones, FechaCierre, NID, EsPrivado) VALUES (YEAR(CONVERT (smalldatetime, @FechaInicio, 103)), @Nombre, CONVERT (smalldatetime, @FechaInicio, 103), @Observaciones, CONVERT (smalldatetime, @FechaCierre, 103), @NID, @EsPrivado)"
                OldValuesParameterFormatString="original_{0}" OnInserting="SqlDataSource_Details_Inserting">
                <InsertParameters>
                    <asp:Parameter Name="Nombre" Type="String" />
                    <asp:Parameter Name="Observaciones" Type="String" />
                    <asp:Parameter Name="FechaInicio" />
                    <asp:Parameter Name="FechaCierre" />
                    <asp:SessionParameter Name="NID" SessionField="NID" />
                    <asp:Parameter Name="EsPrivado" />
                </InsertParameters>
            </asp:SqlDataSource>
        </center>
    
    
    
    </div>
    </form>
</body>
</html>
