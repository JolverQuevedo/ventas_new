USE VENTAS
GO
SET DATEFORMAT DMY;
UPDATE     movimcab
SET	FECDOC = LEFT(CONVERT(CHAR(50),FECDOC,103),11)+'11:11:11'
WHERE       ({ fn HOUR(FECDOC) } = 0) AND ({ fn MINUTE(FECDOC) } = 0) 
AND ({ fn SECOND(FECDOC) } = 0)

GO