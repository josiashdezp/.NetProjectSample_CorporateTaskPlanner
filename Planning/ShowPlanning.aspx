<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowPlanning.aspx.cs" Inherits="Planning_ShowPlanning" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Mostrrr Planificación</title>
    <style type="text/css" media="screen" >
    *{
    margin:0;
    padding:0;
    }
    
    body{
    background-color: #ffffe1;	
    }
    #Content
    {
        font-family:Verdana, Tahoma, Sans-serif;
        font-size: 0.7em;
	    text-align: center;	    
	    color: #024b86;
	    background-color: #ffffe1;	    	    
	    width:300px;	    
    }
    
    #Content .Input
{
	background-color: #ffffff;	
	color: #93BADB;
	font-weight:600;
	font-size: 8pt;
	border: #d3d3d3 1px solid;  
	padding:3px;	
}

#Content .Listados
{
	font-size: 7.5pt;
	line-height: 15pt;
	border: #d3d3d3 1px solid;	
	background-color:#ffffff;
}

#Content .Listados a
{
	border: none;
	background: none;
	color: #ff9933; 
	font-weight:bold;
	padding-left: 3px;
	text-align:right
}

#Content .Listados .Encabezado
{
	background-color: #fcd067;
	font-weight: bold;
	font-size:9pt;
	color: #ffffe1;	
}
	
#Content .Listados .Encabezado a
{
	color:#ffffe1;
	}
	
#Content .Listados .Altern
	{
		background-color:#B8D1E5;
		}
		
#Content .Listados .Empty
{
	color:#FFFFE1;
	background-color:#FCD067;
	}
    </style>    
</head>
<body>
    <center>
        <form id="form1" runat="server">
        <div id="Content">
    
        </div>
        </form>
    </center>
    
</body>
</html>
