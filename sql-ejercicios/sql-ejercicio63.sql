--Para crear índices empleamos la instrucción "create index".

--La sintaxis básica es la siguiente:

--create TIPODEINDICE index NOMBREINDICE
--on TABLA(CAMPO);

--"TIPODEINDICE" indica si es agrupado (clustered) o no agrupado (nonclustered). Si no especificamos crea uno No agrupado. 
--Independientemente de si es agrupado o no, también se puede especificar que sea "unique", es decir, no haya valores repetidos.
--si se intenta crear un índice unique para un campo que tiene valores duplicados, SQL Server no lo permite.

--En este ejemplo se crea un índice agrupado único para el campo "codigo" de la tabla "libros":

--create unique clustered index I_libros_codigo
--on libros(codigo);

--Para identificar los índices fácilmente, podemos agregar un prefijo al nombre del índice, por ejemplo "I" y 
--luego el nombre de la tabla y/o campo.

--En este ejemplo se crea un índice no agrupado para el campo "titulo" de la tabla "libros":

--create nonclustered index I_libros_titulo
--on libros(titulo);

--Un índice puede tener más de un campo como clave, son índices compuestos. Los campos de un índice compuesto 
--tienen que ser de la misma tabla (excepto cuando se crea en una vista - tema que veremos posteriormente).

--Creamos un índice compuesto para el campo "autor" y "editorial":

--create index I_libros_autoreditorial
--on libros(autor,editorial);

--SQL Server crea automáticamente índices cuando se establece una restricción "primary key" o "unique" en una tabla. 
--Al crear una restricción "primary key", si no se especifica, el índice será agrupado (clustered) a menos que ya exista
-- un índice agrupado para dicha tabla. Al crear una restricción "unique", si no se especifica, 
--el índice será no agrupado (non-clustered).

--Ahora podemos entender el resultado del procedimiento almacenado "sp_helpconstraint" cuando en la columna "constraint_type"
-- mostraba el tipo de índice seguido de las palabras "clustered" o "non_clustered".

--Puede especificarse que un índice sea agrupado o no agrupado al agregar estas restricciones.
--Agregamos una restricción "primary key" al campo "codigo" de la tabla "libros" especificando 
--que cree un índice NO agrupado:

--alter table libros
--add constraint PK_libros_codigo
--primary key nonclustered (codigo);

--Para ver los indices de una tabla:

--exec sp_helpindex libros;

--Muestra el nombre del índice, si es agrupado (o no), primary (o unique) y el campo por el cual se indexa.

--Todos los índices de la base de datos activa se almacenan en la tabla del sistema "sysindexes",
-- podemos consultar dicha tabla tipeando:

--select name from sysindexes;

--Para ver todos los índices de la base de datos activa creados por nosotros podemos tipear la siguiente consulta:

--select name from sysindexes
--where name like 'I_%';


if object_id('libros') is not null
  drop table libros;
  
 create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15)
);

go

-- Creamos un índice agrupado único para el campo "codigo" de la tabla "libros":
create unique clustered index I_libros_codigo
 on libros(codigo);

-- Creamos un índice no agrupado para el campo "titulo":
create nonclustered index I_libros_titulo
 on libros(titulo);

-- Veamos los indices de "libros":
exec sp_helpindex libros;

-- Creamos una restricción "primary key" al campo "codigo" especificando
-- que cree un índice NO agrupado:
alter table libros
  add constraint PK_libros_codigo
  primary key nonclustered (codigo);

-- Verificamos que creó un índice automáticamente:
exec sp_helpindex libros;

-- Analicemos la información que nos muestra "sp_helpconstraint":
exec sp_helpconstraint libros;

-- Creamos un índice compuesto para el campo "autor" y "editorial":
create index I_libros_autoreditorial
 on libros(autor,editorial);

-- Consultamos la tabla "sysindexes":
select name from sysindexes;

-- Veamos los índices de la base de datos activa creados por nosotros
-- podemos tipear la siguiente consulta:
select name from sysindexes
  where name like 'I_%';