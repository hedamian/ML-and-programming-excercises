--Integridad de los datos

--Es importante, al diseñar una base de datos y las tablas que contiene, tener en cuenta la integridad 
--de los datos, esto significa que la información almacenada en las tablas debe ser válida, coherente y exacta.
--SQL Server ofrece más alternativas, además de las aprendidas, para restringir y validar los datos,
-- las veremos ordenadamente y al finalizar haremos un resumen de las mismas.

--Las restricciones (constraints) son un método para mantener la integridad de los datos, asegurando que 
--los valores ingresados sean válidos y que las relaciones entre las tablas se mantenga. Se establecen a los campos y las tablas.

--Pueden definirse al crear la tabla ("create table") o agregarse a una tabla existente (empleando "alter table") y se pueden aplicar 
--a un campo o a varios. Se aconseja crear las tablas y luego agregar las restricciones.

--Se pueden crear, modificar y eliminar las restricciones sin eliminar la tabla y volver a crearla.

--El procedimiento almacenado del sistema "sp_helpconstraint" junto al nombre de la tabla, nos muestra información 
--acerca de las restricciones de dicha tabla.

--La restricción "default" especifica un valor por defecto para un campo cuando no se inserta explícitamente en un comando "insert".
--Cada vez que establecíamos un valor por defecto para un campo de una tabla, SQL Server creaba automáticamente una restricción "default" para ese campo de esa tabla.

--Dicha restricción, a la cual no le dábamos un nombre, recibía un nombre dado por SQL Server que consiste "DF" (por default),
--seguido del nombre de la tabla, el nombre del campo y letras y números aleatorios.

--En la sentencia siguiente agregamos una restricción "default" al campo autor de la tabla existente "libros", 
--que almacena el valor "Desconocido" en dicho campo si no ingresamos un valor en un "insert":

 --alter table libros
 --add constraint DF_libros_autor
 --default 'Desconocido'
 --for autor;


--Por convención, cuando demos el nombre a las restricciones "default" emplearemos un formato similar al que le da SQL Server: 
--"DF_NOMBRETABLA_NOMBRECAMPO".

--Solamente se permite una restricción "default" por campo y no se puede emplear junto con la propiedad "identity".
--Una tabla puede tener varias restricciones "default" para sus distintos campos.

--La restricción "default" acepta valores tomados de funciones del sistema, por ejemplo, podemos establecer que el 
--valor por defecto de un campo de tipo datetime sea "getdate()".

--Podemos ver información referente a las restriciones de una tabla con el procedimiento almacenado "sp_helpcontraint":

 --exec sp_helpconstraint libros;

--Entonces, la restricción "default" especifica un valor por defecto para un campo cuando no se inserta explícitamente 
--en un "insert", se puede establecer uno por campo y no se puede emplear junto con la propiedad "identity".

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
  editorial varchar(15),
  precio decimal(6,2)
);

go

insert into libros (titulo,editorial) values('Martin Fierro','Emece');
insert into libros (titulo,editorial) values('Aprenda PHP','Emece');

-- Veamos que SQL Server creó automáticamente una restricción "default"
-- para el campo "autor":
exec sp_helpconstraint libros;

drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(6,2)
);

go

-- Agregamos una restricción "default" empleando "alter table" 
-- para que almacene el valor "Desconocido" en el campo "autor":
alter table libros
  add constraint DF_libros_autor
  default 'Desconocido'
  for autor;

-- Veamos la restrición agregada anteriormente con el procedimiento 
-- almacenado "sp_helpcontraint":
exec sp_helpconstraint libros;

insert into libros (titulo,editorial) values('Martin Fierro','Emece');
insert into libros default values;

-- Veamos cómo se almacenaron los registros sin valor explícito
-- para el campo con restricción "default":
select * from libros;

-- Agregamos otra restricción "default" para el campo "precio" 
-- para que almacene el valor 0 en dicho campo:
alter table libros
  add constraint DF_libros_precio
  default 0
  for precio;

exec sp_helpconstraint libros;