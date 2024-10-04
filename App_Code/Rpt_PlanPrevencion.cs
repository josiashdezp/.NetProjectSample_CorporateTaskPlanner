using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

/// <summary>
/// Summary description for Rpt_PlanPrev
/// </summary>
public class Rpt_PlanPrevencion : DevExpress.XtraReports.UI.XtraReport
{
    #region Controles del Reporte
    private DevExpress.XtraReports.UI.DetailBand Detail;
    private DataSet_Planificador_Informes dataSet_Planificador_Informes1;
    private DataSet_Planificador_InformesTableAdapters.view_PlanAccionesPrevencionTableAdapter view_PlanAccionesPrevencionTableAdapter1;
    private XRLabel xrLabel30;
    private XRLabel xrLabel25;
    private XRLabel xrLabel13;
    private PageFooterBand PageFooter;
    private XRPageInfo xrPageInfo2;
    private XRPageInfo xrPageInfo1;
    private XRLabel xrLabel1;
    private PageHeaderBand PageHeader;
    private XRControlStyle Title;
    private XRControlStyle FieldCaption;
    private XRControlStyle PageInfo;
    private XRControlStyle DataField;
    private ReportHeaderBand reportHeaderBand1; 
    #endregion
    private XRLabel xrLabel2;
    private XRTable xrTable1;
    private XRTableRow xrTableRow2;
    private XRTableCell xrTableCell4;
    private XRTableCell xrTableCell5;
    private XRTableCell xrTableCell6;
    private XRTableCell xrTableCell8;
    private XRTableCell xrTableCell10;
    private XRTableCell xrTableCell12;
    private XRTableCell xrTableCell14;
    private XRTable xrTable2;
    private XRTableRow xrTableRow3;
    private XRTableCell xrTableCell15;
    private XRTableCell xrTableCell16;
    private XRTableCell xrTableCell17;
    private XRTableCell xrTableCell18;
    private XRTableCell xrTableCell19;
    private XRTableCell xrTableCell20;
    private XRTableCell xrTableCell21;
	/// <summary>
	/// Required designer variable.
	/// </summary>
	private System.ComponentModel.IContainer components = null;

	public Rpt_PlanPrevencion()
	{
		InitializeComponent();
		//
		// TODO: Add constructor logic here
		//
	}
	
	/// <summary> 
	/// Clean up any resources being used.
	/// </summary>
	/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
	protected override void Dispose(bool disposing) {
		if (disposing && (components != null)) {
			components.Dispose();
		}
		base.Dispose(disposing);
	}

	#region Designer generated code

	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent() {
        string resourceFileName = "Rpt_PlanPrevencion.resx";
        DevExpress.XtraReports.UI.XRSummary xrSummary1 = new DevExpress.XtraReports.UI.XRSummary();
        this.Detail = new DevExpress.XtraReports.UI.DetailBand();
        this.xrTable1 = new DevExpress.XtraReports.UI.XRTable();
        this.xrTableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
        this.xrTableCell12 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell4 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell5 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell14 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell6 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell8 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell10 = new DevExpress.XtraReports.UI.XRTableCell();
        this.dataSet_Planificador_Informes1 = new DataSet_Planificador_Informes();
        this.view_PlanAccionesPrevencionTableAdapter1 = new DataSet_Planificador_InformesTableAdapters.view_PlanAccionesPrevencionTableAdapter();
        this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
        this.xrLabel30 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel13 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrPageInfo2 = new DevExpress.XtraReports.UI.XRPageInfo();
        this.xrPageInfo1 = new DevExpress.XtraReports.UI.XRPageInfo();
        this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
        this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
        this.xrTable2 = new DevExpress.XtraReports.UI.XRTable();
        this.xrTableRow3 = new DevExpress.XtraReports.UI.XRTableRow();
        this.xrTableCell15 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell16 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell17 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell18 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell19 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell20 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrTableCell21 = new DevExpress.XtraReports.UI.XRTableCell();
        this.xrLabel25 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
        this.Title = new DevExpress.XtraReports.UI.XRControlStyle();
        this.FieldCaption = new DevExpress.XtraReports.UI.XRControlStyle();
        this.PageInfo = new DevExpress.XtraReports.UI.XRControlStyle();
        this.DataField = new DevExpress.XtraReports.UI.XRControlStyle();
        this.reportHeaderBand1 = new DevExpress.XtraReports.UI.ReportHeaderBand();
        ((System.ComponentModel.ISupportInitialize)(this.xrTable1)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.dataSet_Planificador_Informes1)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.xrTable2)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
        // 
        // Detail
        // 
        this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrTable1});
        this.Detail.Height = 25;
        this.Detail.KeepTogether = true;
        this.Detail.Name = "Detail";
        this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
        // 
        // xrTable1
        // 
        this.xrTable1.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top)
                    | DevExpress.XtraPrinting.BorderSide.Right)
                    | DevExpress.XtraPrinting.BorderSide.Bottom)));
        this.xrTable1.Location = new System.Drawing.Point(0, 0);
        this.xrTable1.Name = "xrTable1";
        this.xrTable1.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow2});
        this.xrTable1.Size = new System.Drawing.Size(1017, 25);
        this.xrTable1.StylePriority.UseBorders = false;
        // 
        // xrTableRow2
        // 
        this.xrTableRow2.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell12,
            this.xrTableCell4,
            this.xrTableCell5,
            this.xrTableCell14,
            this.xrTableCell6,
            this.xrTableCell8,
            this.xrTableCell10});
        this.xrTableRow2.Name = "xrTableRow2";
        this.xrTableRow2.Size = new System.Drawing.Size(1017, 25);
        // 
        // xrTableCell12
        // 
        this.xrTableCell12.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.PuntoVulnerable", "")});
        this.xrTableCell12.Location = new System.Drawing.Point(0, 0);
        this.xrTableCell12.Name = "xrTableCell12";
        this.xrTableCell12.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell12.Size = new System.Drawing.Size(167, 25);
        this.xrTableCell12.Text = "xrTableCell12";
        // 
        // xrTableCell4
        // 
        this.xrTableCell4.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.Manifestacion", "")});
        this.xrTableCell4.Location = new System.Drawing.Point(167, 0);
        this.xrTableCell4.Name = "xrTableCell4";
        this.xrTableCell4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell4.Size = new System.Drawing.Size(170, 25);
        this.xrTableCell4.Text = "xrTableCell4";
        // 
        // xrTableCell5
        // 
        this.xrTableCell5.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.Descripcion", "")});
        this.xrTableCell5.Location = new System.Drawing.Point(337, 0);
        this.xrTableCell5.Name = "xrTableCell5";
        this.xrTableCell5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell5.Size = new System.Drawing.Size(170, 25);
        this.xrTableCell5.Text = "xrTableCell5";
        // 
        // xrTableCell14
        // 
        this.xrTableCell14.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.ResponsableNombre", "")});
        this.xrTableCell14.Location = new System.Drawing.Point(507, 0);
        this.xrTableCell14.Name = "xrTableCell14";
        this.xrTableCell14.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell14.Size = new System.Drawing.Size(126, 25);
        this.xrTableCell14.Text = "xrTableCell14";
        // 
        // xrTableCell6
        // 
        this.xrTableCell6.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.EjecutaNombre", "")});
        this.xrTableCell6.Location = new System.Drawing.Point(633, 0);
        this.xrTableCell6.Name = "xrTableCell6";
        this.xrTableCell6.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell6.Size = new System.Drawing.Size(150, 25);
        xrSummary1.FormatString = "{0}";
        xrSummary1.Func = DevExpress.XtraReports.UI.SummaryFunc.Custom;
        this.xrTableCell6.Summary = xrSummary1;
        this.xrTableCell6.Text = "xrTableCell6";
        // 
        // xrTableCell8
        // 
        this.xrTableCell8.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.Cumplimiento", "")});
        this.xrTableCell8.Location = new System.Drawing.Point(783, 0);
        this.xrTableCell8.Name = "xrTableCell8";
        this.xrTableCell8.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell8.Size = new System.Drawing.Size(146, 25);
        this.xrTableCell8.Text = "xrTableCell8";
        // 
        // xrTableCell10
        // 
        this.xrTableCell10.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.FechaPlanificada", "{0:dd/MM/yyyy}")});
        this.xrTableCell10.Location = new System.Drawing.Point(929, 0);
        this.xrTableCell10.Name = "xrTableCell10";
        this.xrTableCell10.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell10.Size = new System.Drawing.Size(88, 25);
        this.xrTableCell10.Text = "xrTableCell10";
        // 
        // dataSet_Planificador_Informes1
        // 
        this.dataSet_Planificador_Informes1.DataSetName = "DataSet_Planificador_Informes";
        this.dataSet_Planificador_Informes1.EnforceConstraints = false;
        this.dataSet_Planificador_Informes1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
        // 
        // view_PlanAccionesPrevencionTableAdapter1
        // 
        this.view_PlanAccionesPrevencionTableAdapter1.ClearBeforeFill = true;
        // 
        // PageFooter
        // 
        this.PageFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel30,
            this.xrLabel13,
            this.xrPageInfo2,
            this.xrPageInfo1});
        this.PageFooter.Height = 78;
        this.PageFooter.Name = "PageFooter";
        this.PageFooter.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.PageFooter.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
        // 
        // xrLabel30
        // 
        this.xrLabel30.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.Observaciones", "")});
        this.xrLabel30.Location = new System.Drawing.Point(33, 25);
        this.xrLabel30.Name = "xrLabel30";
        this.xrLabel30.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel30.Size = new System.Drawing.Size(950, 20);
        this.xrLabel30.StyleName = "DataField";
        // 
        // xrLabel13
        // 
        this.xrLabel13.Location = new System.Drawing.Point(33, 0);
        this.xrLabel13.Name = "xrLabel13";
        this.xrLabel13.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel13.Size = new System.Drawing.Size(225, 18);
        this.xrLabel13.StyleName = "FieldCaption";
        this.xrLabel13.Text = "Observaciones";
        // 
        // xrPageInfo2
        // 
        this.xrPageInfo2.Format = "Page {0} of {1}";
        this.xrPageInfo2.Location = new System.Drawing.Point(575, 50);
        this.xrPageInfo2.Name = "xrPageInfo2";
        this.xrPageInfo2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrPageInfo2.Size = new System.Drawing.Size(438, 23);
        this.xrPageInfo2.StyleName = "PageInfo";
        this.xrPageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopRight;
        // 
        // xrPageInfo1
        // 
        this.xrPageInfo1.Location = new System.Drawing.Point(8, 50);
        this.xrPageInfo1.Name = "xrPageInfo1";
        this.xrPageInfo1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrPageInfo1.PageInfo = DevExpress.XtraPrinting.PageInfo.DateTime;
        this.xrPageInfo1.Size = new System.Drawing.Size(438, 23);
        this.xrPageInfo1.StyleName = "PageInfo";
        // 
        // xrLabel1
        // 
        this.xrLabel1.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrLabel1.Location = new System.Drawing.Point(8, 8);
        this.xrLabel1.Multiline = true;
        this.xrLabel1.Name = "xrLabel1";
        this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.xrLabel1.Size = new System.Drawing.Size(1000, 50);
        this.xrLabel1.StylePriority.UseFont = false;
        this.xrLabel1.StylePriority.UsePadding = false;
        this.xrLabel1.Text = "Medidas adoptadas por el sistema bancario para fortalecer el enfrentamiento, evit" +
            "ar y detectar actividades delictivas, operaciones ilícitas y manifestaciones de " +
            "corrupción.\r\n\r\n";
        // 
        // PageHeader
        // 
        this.PageHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrTable2,
            this.xrLabel25,
            this.xrLabel2,
            this.xrLabel1});
        this.PageHeader.Height = 117;
        this.PageHeader.Name = "PageHeader";
        this.PageHeader.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.PageHeader.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
        // 
        // xrTable2
        // 
        this.xrTable2.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top)
                    | DevExpress.XtraPrinting.BorderSide.Right)
                    | DevExpress.XtraPrinting.BorderSide.Bottom)));
        this.xrTable2.Location = new System.Drawing.Point(0, 92);
        this.xrTable2.Name = "xrTable2";
        this.xrTable2.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow3});
        this.xrTable2.Size = new System.Drawing.Size(1017, 25);
        this.xrTable2.StylePriority.UseBorders = false;
        // 
        // xrTableRow3
        // 
        this.xrTableRow3.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell15,
            this.xrTableCell16,
            this.xrTableCell17,
            this.xrTableCell18,
            this.xrTableCell19,
            this.xrTableCell20,
            this.xrTableCell21});
        this.xrTableRow3.Name = "xrTableRow3";
        this.xrTableRow3.Size = new System.Drawing.Size(1017, 25);
        // 
        // xrTableCell15
        // 
        this.xrTableCell15.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrTableCell15.Location = new System.Drawing.Point(0, 0);
        this.xrTableCell15.Name = "xrTableCell15";
        this.xrTableCell15.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell15.Size = new System.Drawing.Size(167, 25);
        this.xrTableCell15.StylePriority.UseFont = false;
        this.xrTableCell15.Text = "Punto Vulnerable";
        // 
        // xrTableCell16
        // 
        this.xrTableCell16.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrTableCell16.Location = new System.Drawing.Point(167, 0);
        this.xrTableCell16.Name = "xrTableCell16";
        this.xrTableCell16.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell16.Size = new System.Drawing.Size(170, 25);
        this.xrTableCell16.StylePriority.UseFont = false;
        this.xrTableCell16.Text = "Manifestación";
        // 
        // xrTableCell17
        // 
        this.xrTableCell17.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrTableCell17.Location = new System.Drawing.Point(337, 0);
        this.xrTableCell17.Name = "xrTableCell17";
        this.xrTableCell17.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell17.Size = new System.Drawing.Size(170, 25);
        this.xrTableCell17.StylePriority.UseFont = false;
        this.xrTableCell17.Text = "Medidas a tomar";
        // 
        // xrTableCell18
        // 
        this.xrTableCell18.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrTableCell18.Location = new System.Drawing.Point(507, 0);
        this.xrTableCell18.Name = "xrTableCell18";
        this.xrTableCell18.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell18.Size = new System.Drawing.Size(126, 25);
        this.xrTableCell18.StylePriority.UseFont = false;
        this.xrTableCell18.Text = "Responsable";
        // 
        // xrTableCell19
        // 
        this.xrTableCell19.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrTableCell19.Location = new System.Drawing.Point(633, 0);
        this.xrTableCell19.Name = "xrTableCell19";
        this.xrTableCell19.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell19.Size = new System.Drawing.Size(150, 25);
        this.xrTableCell19.StylePriority.UseFont = false;
        this.xrTableCell19.Text = "Ejecutantes";
        // 
        // xrTableCell20
        // 
        this.xrTableCell20.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrTableCell20.Location = new System.Drawing.Point(783, 0);
        this.xrTableCell20.Name = "xrTableCell20";
        this.xrTableCell20.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell20.Size = new System.Drawing.Size(146, 25);
        this.xrTableCell20.StylePriority.UseFont = false;
        this.xrTableCell20.Text = "Cumplimiento";
        // 
        // xrTableCell21
        // 
        this.xrTableCell21.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrTableCell21.Location = new System.Drawing.Point(929, 0);
        this.xrTableCell21.Name = "xrTableCell21";
        this.xrTableCell21.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrTableCell21.Size = new System.Drawing.Size(88, 25);
        this.xrTableCell21.StylePriority.UseFont = false;
        this.xrTableCell21.Text = "Fecha";
        // 
        // xrLabel25
        // 
        this.xrLabel25.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "view_PlanAccionesPrevencion.AnioID", "")});
        this.xrLabel25.Font = new System.Drawing.Font("Times New Roman", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrLabel25.Location = new System.Drawing.Point(550, 59);
        this.xrLabel25.Name = "xrLabel25";
        this.xrLabel25.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.xrLabel25.Size = new System.Drawing.Size(75, 25);
        this.xrLabel25.StyleName = "DataField";
        this.xrLabel25.StylePriority.UseFont = false;
        this.xrLabel25.StylePriority.UsePadding = false;
        // 
        // xrLabel2
        // 
        this.xrLabel2.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
        this.xrLabel2.Location = new System.Drawing.Point(8, 59);
        this.xrLabel2.Name = "xrLabel2";
        this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.xrLabel2.Size = new System.Drawing.Size(542, 25);
        this.xrLabel2.StylePriority.UseFont = false;
        this.xrLabel2.StylePriority.UsePadding = false;
        this.xrLabel2.Text = "DIRECCIÓN PROVINCIAL DPTO DAPRO, CIENFUEGOS - ";
        // 
        // Title
        // 
        this.Title.BackColor = System.Drawing.Color.White;
        this.Title.BorderColor = System.Drawing.SystemColors.ControlText;
        this.Title.Borders = DevExpress.XtraPrinting.BorderSide.None;
        this.Title.BorderWidth = 1;
        this.Title.Font = new System.Drawing.Font("Times New Roman", 24F);
        this.Title.ForeColor = System.Drawing.Color.Black;
        this.Title.Name = "Title";
        // 
        // FieldCaption
        // 
        this.FieldCaption.BackColor = System.Drawing.Color.White;
        this.FieldCaption.BorderColor = System.Drawing.SystemColors.ControlText;
        this.FieldCaption.Borders = DevExpress.XtraPrinting.BorderSide.None;
        this.FieldCaption.BorderWidth = 1;
        this.FieldCaption.Font = new System.Drawing.Font("Times New Roman", 10F, System.Drawing.FontStyle.Bold);
        this.FieldCaption.ForeColor = System.Drawing.Color.Black;
        this.FieldCaption.Name = "FieldCaption";
        // 
        // PageInfo
        // 
        this.PageInfo.BackColor = System.Drawing.Color.White;
        this.PageInfo.BorderColor = System.Drawing.SystemColors.ControlText;
        this.PageInfo.Borders = DevExpress.XtraPrinting.BorderSide.None;
        this.PageInfo.BorderWidth = 1;
        this.PageInfo.Font = new System.Drawing.Font("Times New Roman", 8F);
        this.PageInfo.ForeColor = System.Drawing.Color.Black;
        this.PageInfo.Name = "PageInfo";
        // 
        // DataField
        // 
        this.DataField.BackColor = System.Drawing.Color.White;
        this.DataField.BorderColor = System.Drawing.SystemColors.ControlText;
        this.DataField.Borders = DevExpress.XtraPrinting.BorderSide.None;
        this.DataField.BorderWidth = 1;
        this.DataField.Font = new System.Drawing.Font("Times New Roman", 8F);
        this.DataField.ForeColor = System.Drawing.SystemColors.ControlText;
        this.DataField.Name = "DataField";
        // 
        // reportHeaderBand1
        // 
        this.reportHeaderBand1.Height = 57;
        this.reportHeaderBand1.Name = "reportHeaderBand1";
        // 
        // Rpt_PlanPrevencion
        // 
        this.BackColor = System.Drawing.Color.White;
        this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.PageFooter,
            this.PageHeader,
            this.reportHeaderBand1});
        this.DataAdapter = this.view_PlanAccionesPrevencionTableAdapter1;
        this.DataMember = "view_PlanAccionesPrevencion";
        this.DataSource = this.dataSet_Planificador_Informes1;
        this.Landscape = true;
        this.Margins = new System.Drawing.Printing.Margins(40, 40, 40, 40);
        this.PageHeight = 850;
        this.PageWidth = 1100;
        this.StyleSheet.AddRange(new DevExpress.XtraReports.UI.XRControlStyle[] {
            this.Title,
            this.FieldCaption,
            this.PageInfo,
            this.DataField});
        this.Version = "8.2";
        ((System.ComponentModel.ISupportInitialize)(this.xrTable1)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.dataSet_Planificador_Informes1)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.xrTable2)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

	}

	#endregion
}
