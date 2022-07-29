USE [Migracion.Data]
GO
/****** Object:  StoredProcedure [dbo].[sp_CMig_AgregarHistorial]    Script Date: 29/07/2022 7:33:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_CMig_AgregarHistorial](
	@valida nvarchar(max),
	@bddestino nvarchar(max),
	@schemadestino nvarchar(max),
	@tabladestino nvarchar(max),
	@cantidadorigen nvarchar(max),
	@cantidaddestino nvarchar(max),
	@cantidadmigrada nvarchar(max),
	--@ultimodiario nvarchar(max),
	@tiempo nvarchar(max),
	@mensaje nvarchar(max)

)
as

declare 
	@SQL nvarchar(max), 
	@ACCION varchar(max),
	@MENSAJE varchar(max),
	@ultimodiario int

	set @SQL=N'
		select @ultimodiario=max(JRNAL_NO) 
		from '+@bddestino+'.'+@schemadestino+'.'+@tabladestino
	exec sp_executesql @SQL,N'@ultimodiario int output',@ultimodiario=@ultimodiario output 

begin try
	begin transaction
		insert into HistorialMigracion(Fecha,Valida,Tabla,CantidadOrigen,CantidadDestino,CantidadMigrada,Tiempo,Mensaje,UltimoDiario)
		values(getdate(),@valida,@tabladestino,@cantidadorigen,@cantidaddestino,@cantidadmigrada,@tiempo,@mensaje,@ultimodiario)
	commit transaction
	set @ACCION='Exito'
	set @MENSAJE=0
end try
begin catch
	rollback transaction
	set @ACCION=ERROR_MESSAGE()
	set @MENSAJE=ERROR_NUMBER()
end catch

select @ACCION as ACCION,'' as TablaOrigen, @tabladestino as TablaDestino,0 as Cantidad, @MENSAJE as Mensaje
