--eliminar indices

--los índices creados con "create index" se eliminan con "drop index"; la siguiente es la sintaxis básica:

-- drop index NOMBRETABLA.NOMBREINDICE;

--Eliminamos el índice "I_libros_titulo":

 --drop index libros.I_libros_titulo;

--Los índices que SQL Server crea automáticamente al establecer una restricción "primary key" o "unique" no pueden eliminarse con "drop index", se eliminan automáticamente cuando quitamos la restricción.

--Podemos averiguar si existe un índice para eliminarlo, consultando la tabla del sistema "sysindexes":

 --if exists (select name from sysindexes
  --where name = 'NOMBREINDICE')
   --drop index NOMBRETABLA.NOMBREINDICE;

--Eliminamos el índice "I_libros_titulo" si existe:

 --if exists (select *from sysindexes
 -- where name = 'I_libros_titulo')
  -- drop index libros.I_libros_titulo;


if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15)
);

go

-- Creamos un índice para el campo "titulo":
create index I_libros_titulo
 on libros(titulo);

exec sp_helpindex libros;

-- Eliminamos el índice "I_libros_titulo":
drop index libros.I_libros_titulo;

exec sp_helpindex libros;

-- Solicitamos que se elimine el índice "I_libros_titulo" si existe:
if exists (select name from sysindexes
  where name = 'I_libros_titulo')
   drop index libros.I_libros_titulo;