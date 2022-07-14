--Agregar campos y restricciones (alter table)

--Podemos agregar un campo a una tabla y en el mismo momento aplicarle una restricción.
--Para agregar un campo y establecer una restricción, la sintaxis básica es la siguiente:

 --alter table TABLA
 -- add CAMPO DEFINICION
 -- constraint NOMBRERESTRICCION TIPO;

--Agregamos a la tabla "libros", el campo "titulo" de tipo varchar(30) y una restricción "unique" 
--con --índice agrupado:

-- alter table libros
 -- add titulo varchar(30) 
 -- constraint UQ_libros_autor unique clustered;

--Agregamos a la tabla "libros", el campo "codigo" de tipo int identity not null y una restricción 
--"primary key" con índice no agrupado:

 --alter table libros
 -- add codigo int identity not null
 -- constraint PK_libros_codigo primary key nonclustered;

--Agregamos a la tabla "libros", el campo "precio" de tipo decimal(6,2) y una restricción "check":

 --alter table libros
  --add precio decimal(6,2)
  --constraint CK_libros_precio check (precio>=0);

if object_id('libros') is not null
  drop table libros;

create table libros(
  autor varchar(30),
  editorial varchar(15)
);

go

-- Agregamos el campo "titulo" de tipo varchar(30) y una 
-- restricción "unique" con índice agrupado:
alter table libros
  add titulo varchar(30) 
  constraint UQ_libros_autor unique clustered;

exec sp_columns libros;

-- Agregamos el campo "codigo" de tipo int identity not null
-- y en la misma sentencia una restricción "primary key" con índice no agrupado:
alter table libros
  add codigo int identity not null
  constraint PK_libros_codigo primary key nonclustered;

-- Agregamos el campo "precio" de tipo decimal(6,2) y una restricción "check" 
-- que no permita valores negativos para dicho campo:
alter table libros
  add precio decimal(6,2)
  constraint CK_libros_precio check (precio>=0);

exec sp_helpconstraint libros;