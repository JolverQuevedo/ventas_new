﻿<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.Buffer = true%>
<%Session.LCID=2058%>
<%tienda = Request.Cookies("tienda")("pos")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<link REL="stylesheet" TYPE="text/css" HREF="..\ventas.CSS" >
<!--#include file="../comun/funcionescomunes.asp"-->
<!--#include file="../includes/funcionesVBscript.asp"-->
<!--#include file="../includes/cnn.inc"-->

<SCRIPT language="javascript" src="../includes/cal.js"></SCRIPT>

<script type="text/jscript" language="jscript">
	function calcHeight() {
		//find the height of the internal page
		var the_height = document.getElementById('mirada').contentWindow.document.body.scrollHeight;
		//change the height of the iframe
		document.getElementById('mirada').height = the_height + 20;
	}
</script>

<script type="text/jscript" language="jscript">
function strSQL() {
    if ((document.all.descri.innerText) == '') {
        alert("Por favor ingrese un producto/grupo válido")
        return false;
    }
	tienda = document.all.miRadio.value
	// FAc 20130109 alert(tienda)
	had=''
    if (document.all.miRadio1[0].checked == true)
    	had += document.all.miRadio1[0].value
	if (document.all.miRadio1[1].checked == true)
    	had += document.all.miRadio1[1].value
     cad= "kardexdeta.asp?TDA=" + tienda + '&tipo=' + had + '&ini=' + document.all.ini.value + '&fin=' + document.all.fin.value + '&cod='+ trim(document.all.ARTI.value)

     parent.window.frames[1].window.location.replace(cad)
}
</script>

<script language="jscript" type="text/jscript">
    addCalendar("Calendar1", "Elija una fecha", "ini", "thisForm")
    addCalendar("Calendar2", "Elija una fecha", "fin", "thisForm")
</script>

<% CAD =   " SELECT * FROM TIENDAS WHERE ESTADO ='A' order by descripcion "
          '  response.write(cad)
          '  response.write("<br>")
    RS.OPEN CAD,CNN
    IF rs.recordcount > 0 THEN rs.movefirst
%>

<body onload="top.parent.window.document.getElementById('body0').height = 480">

<form id ="thisForm" name= "thisForm" >

<table width="100%">
    <tr><td align="center" class="Estilo6">Movimiento por Producto :</td></tr>
</table>

<table id="Table1" align="center"  bordercolor="#FFFFFF"  bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="0">
	<tr valign="middle" >
    	<td class="Estilo11" valign="middle" align="right" rowspan="2">
            <label for="Radio">Tiendas:&nbsp;</label></td> 
        <td  class="Estilo12" align="left"  rowspan="2">
            <select  name="miRadio" id="miRadio">
                <option value = "TT" selected>TODAS</option>
                <%do while not rs.eof %>
                    <option value="<%=TRIM(RS("CODIGO"))%>"><%=TRIM(RS("DESCRIPCION")) %></option>
                    <%rs.movenext %>
                <%loop %>
            </select>
        </td>
        <td width="15px;"></td>
        <td class="Estilo11" valign="middle" align="right" rowspan="1">
            <label for="Radio">Rango:&nbsp;</label>
        </td> 
        <td  class="Estilo12" align="left"  rowspan="1">
            <input type="Radio" name="miRadio1" id="miRadio1" value="PG" checked onclick="cambia()">Por Grupo
            <input type="Radio" name="miRadio1" id="miRadio1" value="PP"        onclick="cambia()">Por Producto
        </td>
        <td width="15px">&nbsp;</td>
        
        <td class="Estilo11" align = left  VALIGN=MIDDLE>Inicio : </td> 
        <td class="Estilo11" align = left  VALIGN=MIDDLE>
        	<A href="javascript:showCal('Calendar1')"><img height=16 src="../images/cal.gif" width=16 border=0></A>
        </td>
        <td>
			<INPUT ID="ini" NAME="ini" VALUE ="<%=date()%>" tabindex="-1" class="Estilo21" style="width:70px">
		</td>
        
		<td class="Estilo11" align = left  VALIGN=MIDDLE>Fin : </td> 
        <td class="Estilo11" align = left  VALIGN=MIDDLE>
        	<A href="javascript:showCal('Calendar2')"><img height=16 src="../images/cal.gif" width=16 border=0></A>
        </td>
        <td>
			<INPUT ID="fin" NAME="fin" VALUE ="<%=trim(date())%>" tabindex="-1" class="Estilo21" style="width:70px">
		</td>		
        
        <td><img src="../images/ok.gif" onclick="strSQL()" style="cursor:pointer;"/></td>            
    </tr>
    <tr><td></td>
    <td  id="labb" name="labb"  class="Estilo11" /></td>
    <td ><input id="ARTI" name="ARTI" class="Estilo24" onchange="bake()" ondblclick="hlp()" /></td>
    <td></td>
    <td id="descri" name="descri" class="Estilo12" colspan="7"></td>
    </tr>
</table>

<iframe src="" id="mirada" name="mirada" style="display:none" width="100%"></iframe> 
</form>
</body>
<script language="jscript" type="text/jscript">
    cambia()

function cambia() {
    if (document.all.miRadio1[0].checked == true)
        document.all.labb.innerText = 'Grupo :' 
    else
        document.all.labb.innerText = 'Producto :'

document.all.descri.innerText = ''
document.all.ARTI.value=''
}

function bake() {
cod = trim(document.all.ARTI.value)

    if (document.all.miRadio1[0].checked == true)
    {    if (cod.length > 5) {
        alert("Los grupos no tienen mas de 5 caracteres")
        document.all.ARTI.focus()
            return false
        }
        else
            document.all.mirada.src = '../bake/bakeGRU.asp?pos=' + trim(document.all.ARTI.value)
    }
    else 
    {  
            document.all.mirada.src='../bake/bakeart.asp?pos=' + trim(document.all.ARTI.value)
    }
    return true
}
function hlp() {
if ( document.all.labb.innerText == 'Grupo :' )
    window.open('../help/hlpgrupo.asp')
else
    window.open('../help/hlpart.asp')
}
</script>
</html>
