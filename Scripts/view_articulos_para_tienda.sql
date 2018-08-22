USE [VENTAS]
GO
/****** Object:  View [dbo].[View_ARTICULOS_PARA_TIENDA]    Script Date: 01/08/2012 19:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[View_ARTICULOS_PARA_TIENDA]
AS
SELECT AR_CCODIGO AS CODIGO, AR_CDESCRI AS DESCRI, AR_CUNIDAD AS UNI, AR_NPRECI1 AS LISTA1, AR_NPRECI2 AS LISTA2, AR_NPRECI3 AS LISTA3, 
               AR_CMONVTA AS MONEDA, AR_NIGVPOR AS IGV
FROM  RSFACCAR.dbo.AL0012ARTI
WHERE (AR_CESTADO = 'v') AND (AR_CFSTOCK = 's') AND (AR_CCUENTA = '211101') AND (AR_CMARCA IN ('MAIDENF', 'EL MODEL', 'EBERJEY', 'JACFER', 'KAYSER')) OR
               (AR_CESTADO = 'v') AND (AR_CFSTOCK = 's') AND (AR_CCUENTA = '211101') AND (AR_CFAMILI IN ('JF', 'IN'))
