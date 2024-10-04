using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

/// <summary>
/// Summary description for XR_PlanMes
/// </summary>
public class XR_PlanMes : DevExpress.XtraReports.UI.XtraReport
{
	public DevExpress.XtraReports.UI.DetailBand Contenido;
	private DevExpress.XtraReports.UI.PageHeaderBand PageHeader;
	private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
    private XRPictureBox xrPictureBox1;
    private XRLabel xrLabel2;
    private XRLabel xrLabel1;
    private DataSet_GestorTareas dataSet_GestorTareas1;
    private XRCheckBox xrCheckBox1;
    private XRLabel xrLabel5;
    private XRLabel xrLabel4;
    private XRLabel xrLabel3;
    private DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter planAccionesTableAdapter1;
	/// <summary>
	/// Required designer variable.
	/// </summary>
	private System.ComponentModel.IContainer components = null;

	public XR_PlanMes()
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
        string resourceFileName = "XR_PlanMes.resx";
        System.Resources.ResourceManager resources = global::Resources.XR_PlanMes.ResourceManager;
        this.Contenido = new DevExpress.XtraReports.UI.DetailBand();
        this.xrCheckBox1 = new DevExpress.XtraReports.UI.XRCheckBox();
        this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
        this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
        this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
        this.xrPictureBox1 = new DevExpress.XtraReports.UI.XRPictureBox();
        this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
        this.dataSet_GestorTareas1 = new DataSet_GestorTareas();
        this.planAccionesTableAdapter1 = new DataSet_GestorTareasTableAdapters.PlanAccionesTableAdapter();
        ((System.ComponentModel.ISupportInitialize)(this.dataSet_GestorTareas1)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
        // 
        // Contenido
        // 
        this.Contenido.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrCheckBox1,
            this.xrLabel5,
            this.xrLabel4,
            this.xrLabel3});
        this.Contenido.Height = 28;
        this.Contenido.Name = "Contenido";
        this.Contenido.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.Contenido.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
        // 
        // xrCheckBox1
        // 
        this.xrCheckBox1.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("CheckState", null, "PlanAcciones.EsPersonal", "")});
        this.xrCheckBox1.Location = new System.Drawing.Point(92, 0);
        this.xrCheckBox1.Name = "xrCheckBox1";
        this.xrCheckBox1.Size = new System.Drawing.Size(100, 25);
        this.xrCheckBox1.Text = "xrCheckBox1";
        // 
        // xrLabel5
        // 
        this.xrLabel5.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "PlanAcciones.Nombre", "")});
        this.xrLabel5.Location = new System.Drawing.Point(350, 0);
        this.xrLabel5.Name = "xrLabel5";
        this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel5.Size = new System.Drawing.Size(242, 25);
        this.xrLabel5.Text = "xrLabel5";
        // 
        // xrLabel4
        // 
        this.xrLabel4.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "PlanAcciones.FechaCierre", "{0:MM/dd/yyyy}")});
        this.xrLabel4.Location = new System.Drawing.Point(208, 0);
        this.xrLabel4.Name = "xrLabel4";
        this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel4.Size = new System.Drawing.Size(142, 25);
        this.xrLabel4.Text = "xrLabel4";
        // 
        // xrLabel3
        // 
        this.xrLabel3.DataBindings.AddRange(new DevExpress.XtraReports.UI.XRBinding[] {
            new DevExpress.XtraReports.UI.XRBinding("Text", null, "PlanAcciones.Anio", "")});
        this.xrLabel3.Location = new System.Drawing.Point(17, 0);
        this.xrLabel3.Name = "xrLabel3";
        this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel3.Size = new System.Drawing.Size(67, 25);
        this.xrLabel3.Text = "xrLabel3";
        // 
        // PageHeader
        // 
        this.PageHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel2,
            this.xrLabel1,
            this.xrPictureBox1});
        this.PageHeader.Height = 117;
        this.PageHeader.Name = "PageHeader";
        this.PageHeader.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.PageHeader.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
        // 
        // xrLabel2
        // 
        this.xrLabel2.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold);
        this.xrLabel2.Location = new System.Drawing.Point(83, 42);
        this.xrLabel2.Name = "xrLabel2";
        this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel2.Size = new System.Drawing.Size(233, 25);
        this.xrLabel2.StylePriority.UseFont = false;
        this.xrLabel2.Text = "Dirección Provincial Cienfuegos";
        // 
        // xrLabel1
        // 
        this.xrLabel1.Font = new System.Drawing.Font("Times New Roman", 14F, System.Drawing.FontStyle.Bold);
        this.xrLabel1.Location = new System.Drawing.Point(83, 17);
        this.xrLabel1.Name = "xrLabel1";
        this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
        this.xrLabel1.Size = new System.Drawing.Size(342, 25);
        this.xrLabel1.StylePriority.UseFont = false;
        this.xrLabel1.Text = "BANCO DE CREDITO Y COMERCIO";
        // 
        // xrPictureBox1
        // 
        this.xrPictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("xrPictureBox1.Image")));
        this.xrPictureBox1.Location = new System.Drawing.Point(0, 0);
        this.xrPictureBox1.Name = "xrPictureBox1";
        this.xrPictureBox1.Size = new System.Drawing.Size(75, 83);
        this.xrPictureBox1.Sizing = DevExpress.XtraPrinting.ImageSizeMode.StretchImage;
        // 
        // PageFooter
        // 
        this.PageFooter.Height = 56;
        this.PageFooter.Name = "PageFooter";
        this.PageFooter.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
        this.PageFooter.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
        // 
        // dataSet_GestorTareas1
        // 
        this.dataSet_GestorTareas1.DataSetName = "DataSet_GestorTareas";
        this.dataSet_GestorTareas1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
        // 
        // planAccionesTableAdapter1
        // 
        this.planAccionesTableAdapter1.ClearBeforeFill = true;
        // 
        // XR_PlanMes
        // 
        this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Contenido,
            this.PageHeader,
            this.PageFooter});
        this.DataAdapter = this.planAccionesTableAdapter1;
        this.DataMember = "PlanAcciones";
        this.DataSource = this.dataSet_GestorTareas1;
        this.Landscape = true;
        this.Margins = new System.Drawing.Printing.Margins(50, 10, 50, 50);
        this.PageHeight = 850;
        this.PageWidth = 1100;
        this.Version = "8.2";
        ((System.ComponentModel.ISupportInitialize)(this.dataSet_GestorTareas1)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

	}

	#endregion
}
