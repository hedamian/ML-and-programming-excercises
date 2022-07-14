--Alterar campos (alter table - alter)

--Hemos visto que "alter table" permite modificar la estructura de una tabla. 
--También podemos utilizarla para modificar campos de una tabla.

--La sintaxis básica para modificar un campo existente es la siguiente:

--alter table NOMBRETABLA
--alter column CAMPO NUEVADEFINICION;

--Modificamos el campo "titulo" extendiendo su longitud y para que NO admita valores nulos:

--alter table libros
--alter column titulo varchar(40) not null;

--En el siguiente ejemplo alteramos el campo "precio" de la tabla "libros" que fue definido
-- "decimal(6,2) not null" para que acepte valores nulos:

--alter table libros
--alter column precio decimal(6,2) null;

--SQL Server tiene algunas excepciones al momento de modificar los campos. No permite modificar:

--- campos de tipo text, image, ntext y timestamp.

--- un campo que es usado en un campo calculado.

--- campos que son parte de índices o tienen restricciones, a menos que el cambio no afecte al
--índice o a la restricción, por ejemplo, se puede ampliar la longitud de un campo de tipo caracter.

--- agregando o quitando el atributo "identity".

--- campos que afecten a los datos existentes cuando una tabla contiene registros 
--(ejemplo: un campo contiene valores nulos y se pretende redefinirlo como "not null"; 
--un campo int guarda un valor 300 y se pretende modificarlo a tinyint, etc.).

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(30),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(6,2) not null default 0
);

go

insert into libros
  values('El aleph','Borges','Planeta',20);
insert into libros
  values('Java en 10 minutos',null,'Siglo XXI',30);
insert into libros
  values('Uno','Richard Bach','Planeta',15);
insert into libros
  values('Martin Fierro','Jose Hernandez',null,30);
insert into libros
  values('Aprenda PHP','Mario Molina','Emece',25);

-- Modificamos el campo "titulo" para que acepte una cadena más larga y 
-- no admita valores nulos:
alter table libros
  alter column titulo varchar(40) not null;

exec sp_columns libros;

-- Eliminamos registro que tienen en el campo autor el valor null
-- y realizamos la modificación del campo:
delete from libros where autor is null;
alter table libros
  alter column autor varchar(30) not null;

exec sp_columns libros;

-- Intentamos quitar el atributo "identity" del campo "codigo" y
-- lo redefinimos como "smallint" (no se produce el cambio):
alter table libros
  alter column codigo smallint;

exec sp_columns libros;

alter table libros
  alter column precio decimal(6,2) null;

exec sp_columns libros;

