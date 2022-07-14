----Agregar y eliminar campos ( alter table - add - drop)

--"alter table" permite modificar la estructura de una tabla.
--Podemos utilizarla para agregar, modificar y eliminar campos de una tabla.

--Para agregar un nuevo campo a una tabla empleamos la siguiente sintaxis básica:

--alter table NOMBRETABLA
--add NOMBRENUEVOCAMPO DEFINICION;

--En el siguiente ejemplo agregamos el campo "cantidad" a la tabla "libros", de tipo tinyint, 
--que acepta valores nulos:

--alter table libros
--add cantidad tinyint;

--Puede verificarse la alteración de la estructura de la tabla ejecutando el procedimiento 
--almacenado "sp_columns".

--SQL Server no permite agregar campos "not null" a menos que se especifique un valor por defecto:

--alter table libros
--add autor varchar(20) not null default 'Desconocido';

--En el ejemplo anterior, se agregó una restricción "default" para el nuevo campo,
-- que puede verificarse ejecutando el procedimiento almacenado "sp_helpconstraint".

--Al agregar un campo puede especificarse que sea "identity" (siempre que no exista otro campo identity).

--Para eliminar campos de una tabla la sintaxis básica es la siguiente:

--alter table NOMBRETABLA
--drop column NOMBRECAMPO;

--En el siguiente ejemplo eliminamos el campo "precio" de la tabla "libros":

--alter table libros
--drop column precio;

--No pueden eliminarse los campos que son usados por un índice o tengan restricciones.
-- No puede eliminarse un campo si es el único en la tabla.

--Podemos eliminar varios campos en una sola sentencia:

--alter table libros
--drop column editorial,edicion;

if object_id('libros') is not null
  drop table libros;

create table libros(
  titulo varchar(30),
  editorial varchar(15),
  edicion datetime,
  precio decimal(6,2)
);

go

insert into libros (titulo,editorial,precio)
  values ('El aleph','Emece',25.50);

-- Agregamos el campo "cantidad" a la tabla "libros", de tipo tinyint,
-- que acepta valores nulos:
alter table libros
  add cantidad tinyint;

exec sp_columns libros;

-- Agregamos un campo "codigo" a la tabla "libros", de tipo int con el 
-- atributo "identity":
alter table libros
  add codigo int identity;

-- Intentamos agregar un campo llamado "autor" de tipo varchar(30) 
-- que NO acepte valores nulos (genera error):
alter table libros
  add autor varchar(30) not null;

-- Agregar un campo llamado "autor" de tipo varchar(20) pero con 
-- un valor por defecto: 
alter table libros
  add autor varchar(20) not null default 'Desconocido';

-- Eliminamos el campo "precio" de la tabla "libros":
alter table libros
  drop column precio;

exec sp_columns libros;

-- Intentamos eliminar un campo con restricciones (genera error) :
alter table libros
  drop column autor;

-- Eliminamos varios campos en una sola sentencia:
alter table libros
  drop column editorial,edicion;