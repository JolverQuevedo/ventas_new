<%@ Language=VBScript %>
<%TDA = Request.Cookies("TIENDA")("POS")%>
<%Response.Buffer = TRUE %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<!--#include file="../comun/comunqry.asp"-->
<link REL="stylesheet" TYPE="text/css" HREF="../ventas.CSS" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>
<script type="text/jscript" language="jscript">
    var oldrow = 1
    var olddata = ''
 
 function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);
        dd(ff);
    }
</script>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
pos = ucase(TRIM(Request.QueryString("pos")))
marka = 0
    CAD =   " SELECT distinct codigo, descri FROM  VIEW_ARTICULOS_TIENDA   WHERE     " & _
            " codigo like '"&POS&"%' and estado = 'A'                   " & _
			" order by codigo; "  ' Fac 20121229
           ' response.write(cad)
           ' response.write("<br>")
    RS.OPEN CAD,CNN
    if rs.recordcount > 0 then%>
    <table width="100%">
	<tr><td  align="center" class="estilo6">Art�culos <%=ucase(destda) %></td></tr>
	<tr><td><hr /></td></tr>
</table>

<table id="TABLA" align="center"  cellpadding="0" cellspacing="0" bordercolor='<%=application("color2") %>' border="0" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<%cont = 1
rs.movefirst %>
    <tr>
	    <td align="center" class="Estilo8">Codigo</td>
        <td align="center" class="Estilo8">Descripcion</td>

    </tr>
    <%IF NOT RS.EOF THEN%>
        <%DO WHILE NOT RS.EOF%>
            <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                    response.write(Application("color1"))
                    else
	                response.write(Application("color2"))
	                end IF%>"
                    onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="selecta('<%=rs("codigo")%>', '<%=rs("descri") %>')">
	            <td class="Estilo5" align="center"><%=rs("codigo") %></td>
                <td class="Estilo5" align="left"><%=ucase(rs("descri")) %></td>

                <%cont =cont +1 %>
            </tr>
            <%rs.movenext %>
        <%loop%>
    <%end if %>
</table>
<%END IF%>
<script language="jscript" type="text/jscript">
rec = parseInt('<%=rs.recordcount%>', 10)
if (rec > 0)
    dd2('1');

function selecta(pos, deta) {
    po = parseInt('<%=op%>',10)
    eval("window.opener.document.all.ARTI.value=pos")
    eval("window.opener.document.all.descri.innerText=deta")
    this.window.close();
}
    

    </script>
</BODY>
</HTML>
