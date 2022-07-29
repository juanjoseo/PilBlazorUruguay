USE [Migracion.Data]
GO

/****** Object:  Table [dbo].[HistorialMigracion]    Script Date: 29/07/2022 8:47:48 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HistorialMigracion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Valida] [nvarchar](50) NULL,
	[Tabla] [nvarchar](100) NULL,
	[CantidadOrigen] [int] NULL,
	[CantidadDestino] [int] NULL,
	[CantidadMigrada] [int] NULL,
	[Tiempo] [nvarchar](100) NULL,
	[Mensaje] [nvarchar](255) NULL,
	[UltimoDiario] [int] NULL
) ON [PRIMARY]
GO


