<%@ Page Language="C#" MasterPageFile="~/GestorTareas.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports_Reports" Title="Untitled Page" %>

<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>
<%@ Register Assembly="obout_Scheduler_NET" Namespace="OboutInc.Scheduler" TagPrefix="osd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <osd:Scheduler ID="Scheduler_MonthPlan" runat="server" CategoriesTableName="" ConnectionString=""
        EventsTableName="" Height="320px" OnClientBeforeCreateCategory="" OnClientBeforeCreateEvent=""
        OnClientBeforeDeleteCategory="" OnClientBeforeDeleteEvent="" OnClientBeforeUpdateCategories=""
        OnClientBeforeUpdateEvent="" OnClientChangeView="" OnClientCreateCategory=""
        OnClientCreateEvent="" OnClientDeleteCategory="" OnClientDeleteEvent="" OnClientLoad=""
        OnClientMessage="" OnClientUpdateCategories="" OnClientUpdateEvent="" ProviderName="<%$ AppSettings:Proveedor_Membresia_Roles %>"
        StyleFolder="" UserSettingsTableName="" Width="640px">
        [Scheduler]</osd:Scheduler>
</asp:Content>

