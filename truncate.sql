SELECT
    fk.name AS FKName
    ,OBJECT_NAME(fk.parent_object_id) AS TableName
    ,OBJECT_NAME(fk.referenced_object_id) AS ReferencesTable
    ,COL_NAME(fk.parent_object_id,fkc.parent_column_id) AS ConstraintColumn
    ,COL_NAME(fk.referenced_object_id,referenced_column_id) AS ReferenceColumn
INTO #fk
FROM sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
ORDER BY 1


DECLARE 
    @FKName sysname 
    ,@TableName sysname 
    ,@ReferencesTableName sysname 
    ,@ConstraintColumn sysname 
    ,@ReferenceColumn sysname 
    ,@SQL NVARCHAR(4000) 
 
DECLARE cur CURSOR FOR 
    SELECT FKName, TableName FROM #fk 
OPEN cur 
WHILE 1=1 
BEGIN     
    FETCH NEXT FROM cur INTO @FKName, @TableName 
    IF @@fetch_status !=0 
        BREAK 
 
    SET @SQL = 'alter table ' + @TableName + ' DROP CONSTRAINT ' + @FKName 
    EXEC dbo.sp_executesql @SQL 
END     
CLOSE cur 
DEALLOCATE cur 
GO


exec sp_MSforeachtable 'truncate table ?' 

DECLARE 
    @FKName sysname 
    ,@TableName sysname 
    ,@ReferencesTableName sysname 
    ,@ConstraintColumn sysname 
    ,@ReferenceColumn sysname 
    ,@SQL NVARCHAR(4000) 
 
DECLARE cur CURSOR FOR 
    SELECT * FROM #fk 
OPEN cur 
WHILE 1=1 
BEGIN     
    FETCH NEXT FROM cur INTO @FKName, @TableName, @ReferencesTableName, 
        @ConstraintColumn, @ReferenceColumn 
    IF @@fetch_status !=0 
        BREAK 
 
    SET @SQL = 'alter table ' + @TableName + ' ADD CONSTRAINT ' + @FKName + 
        ' FOREIGN KEY(' + @ConstraintColumn + ') REFERENCES ' 
        + @ReferencesTableName + '(' + @ReferenceColumn + ')' 
    EXEC dbo.sp_executesql @SQL 
END     
CLOSE cur 
DEALLOCATE cur 
GO

 create table #rowcount (tablename varchar(128), rowcnt int) 
 
exec sp_MSforeachtable 'insert into #rowcount select ''?'', count(*) from ?' 
 
select * from #rowcount order by tablename 
 
DROP TABLE #rowcount 