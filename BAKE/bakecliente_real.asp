<%@ Language=VBScript %>
<%TDA = Request.Cookies("TIENDA")("POS")%>
<%Response.Buffer = TRUE %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<link REL="stylesheet" TYPE="text/css" HREF="../ventas.CSS" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>

<body style="margin-top:0; margin-right:0">

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
TDA = ucase(TRIM(Request.QueryString("pos")))
INI = ucase(TRIM(Request.QueryString("INI")))
FIN = ucase(TRIM(Request.QueryString("FIN")))

CAD =   " SET DATEFORMAT DMY;                                                   " & _
	    " SELECT DISTINCT M1.cliente, NOMBRE                                    " & _
	    " FROM MOVIMCAB  AS M1                                                  " & _
	    " INNER JOIN CLIENTES AS C1 ON M1.CLIENTE = C1.CLIENTE                  " & _
	    " WHERE	FECdoc between '"&INI&"'  AND DateAdd(day,1,'"&FIN&"')          " & _
	    " AND CONTA = ''  and M1.TIENDA =ltrim(rtrim('"&TDA&"'))                " & _
	    " and tipmov = 'S' AND NOT PVP IS NULL                                  " & _
	    " AND case when len(ltrim(RTRIM(M1.CLIENTE))) > 8 then                  " & _
        " SUBSTRING(M1.CLIENTE,3,8) COLLate Modern_Spanish_CI_AS                " & _
        " else ltrim(RTRIM(M1.CLIENTE)) COLLate Modern_Spanish_CI_AS end not IN " & _
	    " (SELECT ACODANE FROM RSCONCAR..CT0012ANEX  )                          " & _
        " AND case when len(ltrim(RTRIM(M1.CLIENTE))) = 11 then                 " & _
        " ltrim(RTRIM(M1.CLIENTE)) COLLate Modern_Spanish_CI_AS  end            " & _
        " not IN (SELECT LTRIM(RTRIM(ACODANE)) FROM RSCONCAR..CT0012ANEX )      " & _
	    " AND RIGHT(M1.CLIENTE,8) NOT IN (SELECT '000000'+'"&TDA&"')            " 
 
 rs.open cad, cnn
' RESPONSE.Write(CAD)
IF rs.recordcount > 0 THEN
   cli = rs("cliente")
   des = rs("NOMBRE")
   crea = 1
ELSE
    RS.CLOSE
    CAD =   " SET DATEFORMAT DMY;                                                   " & _
	        " SELECT DISTINCT M1.cliente, NOMBRE                                    " & _
	        " FROM MOVIMCAB  AS M1                                                  " & _
	        " INNER JOIN CLIENTES AS C1 ON M1.CLIENTE = C1.CLIENTE                  " & _
	        " WHERE	FECdoc between '"&INI&"'  AND DateAdd(day,1,'"&FIN&"')          " & _
	        " AND CONTA = ''  and M1.TIENDA =ltrim(rtrim('"&TDA&"'))                " & _
	        " and tipmov = 'S' AND NOT PVP IS NULL                                  " 
    RS.OPEN CAD,CNN
    crea = 0
END IF	
' RESPONSE.Write(CAD)
'regresa a la p�gina de donde fu� llamado, para que vea que agreg� el registro
%>

<%if crea = 1 then %>
<table align="right" cellpadding="2" cellspacing="1" bordercolor='<%=application("color1") %>' border="1" id="MSG" name="MSG" >
  <tr><td colspan="3"  class="Estilo3">Para poder Continuar debe crear los siguientes clientes en el Realsoft....</td></tr>
  <%rs.movefirst%>
  <%do while not rs.eof %>
    <tr>
        <td align="center" class="Estilo0"><%=rs("cliente")%></td>
        <td align="center" class="Estilo0">&nbsp;-&nbsp;</td>
        <td align="left" class="Estilo0"><%=rs("nombre")%></td>
    </tr>
    <%rs.movenext %>
<%loop %>
</table>
<script language="javascript" type="text/jscript">
    // window.parent.document.all.ok1.style.display = 'none'
    alert("Proceso Cancelado")
   
 </script>

<%else%>
<table align="right" cellpadding="2" cellspacing="0" border="1">

   <tr> <td align="center" class="Estilo3" colspan="3 ">CLIENTES OK EN EL REAL</td>
   </tr>
   <%if rs.recordcount > 0 then rs.movefirst%>
  <%do while not rs.eof %>
    <tr>
        <td align="center" class="Estilo0"><%=rs("cliente")%></td>
        <td align="center" class="Estilo0">&nbsp;-&nbsp;</td>
        <td align="left" class="Estilo0"><%=rs("nombre")%></td>
    </tr>
    <%rs.movenext %>
<%loop %>

</table>
<script language="javascript" type="text/jscript">
    window.parent.document.all.espera2.style.display = 'none'
    window.parent.document.all.ok2.style.display = 'block'
    parent.window.documentos()    
</script>
<%end if%>




</BODY>
</HTML>
