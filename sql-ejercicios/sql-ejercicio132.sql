 --121 - Procedimientos almacenados (eliminar)

-- Los procedimientos almacenados se eliminan con "drop procedure". Sintaxis:

-- drop procedure NOMBREPROCEDIMIENTO;

-- Eliminamos el procedimiento almacenado llamado "pa_libros_autor":

-- drop procedure pa_libros_autor;

-- Si el procedimiento que queremos eliminar no existe, aparece un mensaje de error,
-- para evitarlo, podemos emplear esta sintaxis:

-- if object_id('NOMBREPROCEDIMIENTO') is not null
-- drop procedure NOMBREPROCEDIMIENTO;

-- Eliminamos, si existe, el procedimiento "pa_libros_autor", si no existe, mostramos un mensaje:

-- if object_id('pa_libros_autor') is not null
-- drop procedure pa_libros_autor
-- else 
-- select 'No existe el procedimiento "pa_libros_autor"';

-- "drop procedure" puede abreviarse con "drop proc".

-- Se recomienda ejecutar el procedimiento almacenado del sistema "sp_depends" para ver 
-- si algún objeto depende del procedimiento que deseamos eliminar.

-- Podemos eliminar una tabla de la cual dependa un procedimiento, SQL Server lo permite,
-- pero luego, al ejecutar el procedimiento, aparecerá un mensaje de error porque la tabla 
-- referenciada no existe.