<%@LANGUAGE="VBSCRIPT"  CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%Session.LCID=2058%>
<%Usuario = Request.Cookies("tienda")("usr")%>
<%tda     = Request.Cookies("tienda")("pos")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>
<% 
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
' codigo / grupo
cod = Request.QueryString("cod")

' precio
pre = Request.QueryString("pre")

' tienda
tda = Request.QueryString("tda")

'**************************************************************************************
' ver si COD tiene 5 o 10 caracteres para determinar si es por art�culo o por grupo
' ver si TDA dice TODAS... o es por una tienda espec�fica
'**************************************************************************************

if len(trim(cod)) = 5  then
    IF  trim(TDA) = "TODAS"  OR  trim(TDA) = "TT" then
        ' update por GRUPO para todas las tiendas
        CAD = "UPDATE ARTICULOS SET LISTA1 = "&PRE&" WHERE LEFT(CODIGO,5) = '"&COD&"'; "
    ELSE
        ' update por GRUPO para  UNA tienda
        CAD = "UPDATE ARTICULOS SET LISTA1 = "&PRE&" WHERE LEFT(CODIGO,5) = '"&COD&"' AND TIENDA = '"&TDA&"'; "
    END IF
else    
    if trim(TDA) = "TODAS" or   trim(TDA) = "TT"  then
        ' update por CODIGO para todas TODAS las tiendas
        CAD = "UPDATE ARTICULOS SET LISTA1 = "&PRE&" WHERE CODIGO = '"&COD&"'; "
    else
        ' update por CODIGO para  UNA  tienda
         CAD = "UPDATE ARTICULOS SET LISTA1 = "&PRE&" WHERE CODIGO = '"&COD&"' AND TIENDA  = '"&TDA&"'; "
    END IF
END IF
' Inicia transacci�n , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)

Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans
end if

precio = formatnumber(pre,2,,,true)
response.write("<br>")
response.write(precio)
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la p�gina de donde fu� llamado, para que vea que agreg� el registro
%>

<script type="text/jscript" language="jscript">
    op = parseInt("<%=Request.QueryString("opc") %>",10)
    precio = "<%=formatnumber(pre,2,,true)%>"   
	eval("parent.window.document.all.CD"+op+".value = ''") 
    eval("parent.window.document.all.LS"+op+".value = precio") 
</script>

</BODY>
</HTML>

