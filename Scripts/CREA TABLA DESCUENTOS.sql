CREATE TABLE [dbo].[DESCUENTOS](
	[CODIGO] [char](2)  NOT NULL PRIMARY KEY,
	[DESCRIPCION] VARCHAR(50),
	[VALOR]	NUMERIC ,
	[USUARIO] [char](10)  NOT NULL DEFAULT 'SISTEMAS',
	[FECHA] [smalldatetime] NOT NULL DEFAULT (getdate()),
	[ESTADO] [char](1)  NOT NULL  DEFAULT ('A'),
) ON [PRIMARY]
