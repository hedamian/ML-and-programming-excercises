--Vimos que para crear índices empleamos la instrucción "create index".

--Empleando la opción "drop_existing" junto con "create index" permite regenerar un índice, con ello evitamos 
--eliminarlo y volver a crearlo. La sintaxis es la siguiente:

--create TIPODEINDICE index NOMBREINDICE
--on TABLA(CAMPO)
--with drop_existing;

--También podemos modificar alguna de las características de un índice con esta opción, a saber:

--- tipo: cambiándolo de no agrupado a agrupado (siempre que no exista uno agrupado para la misma tabla).
-- No se puede convertir un índice agrupado en No agrupado.

--- campo: se puede cambiar el campo por el cual se indexa, agregar campos, eliminar algún campo de un índice compuesto.

--- único: se puede modificar un índice para que los valores sean únicos o dejen de serlo.

--En este ejemplo se crea un índice no agrupado para el campo "titulo" de la tabla "libros":

--create nonclustered index I_libros
--on libros(titulo);

--Regeneramos el índice "I_libros" y lo convertimos a agrupado:

--create clustered index I_libros
--on libros(titulo)
--with drop_existing;

--Agregamos un campo al índice "I_libros":

--create clustered index I_libros
--on libros(titulo,editorial)
--with drop_existing;

--Esta opción no puede emplearse con índices creados a partir de una restricción "primary key" o "unique".

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15)
);

go

-- Creamos un índice no agrupado para el campo "titulo":
create nonclustered index I_libros_titulo
 on libros(titulo);

exec sp_helpindex libros;

-- Vamos a agregar el campo "autor" al índice "I_libros_titulo"
-- y vemos si se modificó:
create index I_libros_titulo
 on libros(titulo,autor)
 with drop_existing;

exec sp_helpindex libros;

-- Lo convertimos en agrupado:
create clustered index I_libros_titulo
 on libros(titulo,autor)
 with drop_existing;

exec sp_helpindex libros;

-- Quitamos un campo "autor":
create clustered index I_libros_titulo
 on libros(titulo)
 with drop_existing;

exec sp_helpindex libros;