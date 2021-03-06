set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go




ALTER PROCEDURE [dbo].[SP_TIPODECAMBIO]
--@FECHA SMALLDATETIME,   -- This is the input parameter.
--@REGISTRO  OUTPUT -- This is the output parameter.
AS  

-- Get the sales for the specified title and 
-- assign it to the output parameter.

SELECT TOP 1 XMEIMP AS BAJO, XMEIMP2 AS ALTO,  CONVERT(CHAR(10), XDATE, 103)
AS FECHAS
FROM RSCONCAR..CTCAMB WHERE XCODMON = 'US'
and CONVERT(CHAR(10), XDATE, 103) =  CONVERT(CHAR(10), getdate(), 103)
ORDER BY XFECCAM DESC


RETURN

