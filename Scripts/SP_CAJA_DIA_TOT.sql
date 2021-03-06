USE [VENTAS]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAJA_DIA]    Script Date: 02/12/2014 08:16:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Author:		MABEL MOLINA
-- Create date: 12-02-2014
-- Description:	DEVUELVE LOS TOTALES DATOS PARA CUADRE DE CAJA DIARIO
-- ===============================================================
CREATE PROCEDURE [dbo].[SP_CAJA_DIA_TOT] 
	-- Add the parameters for the stored procedure here
	@tda varchar(2),
	@fec1 VARCHAR(10),
	@fec2 varchar(10),
	@TIP  VARCHAR(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set dateformat DMY;
    -- Insert statements for procedure here
	select TOT =  sum(monto) from caja 
	where fecha between @fec1 and @fec2+' 23:59:59.999' and tienda=@tda and estado='A'
	AND TIPO = @TIP  GROUP BY TIPO
	
END
