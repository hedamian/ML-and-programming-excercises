----125 - Procedimientos almacenados (información)
use ejercicios
--Los procedimientos almacenados son objetos, así que para obtener información de ellos 
--pueden usarse los siguientes procedimientos almacenados del sistema y las siguientes tablas:

--- "sp_help": sin parámetros nos muestra todos los objetos de la base de datos seleccionada, 
--incluidos los procedimientos. En la columna "Object_type" aparece "stored procedure" 
--si es un procedimiento almacenado. Si le enviamos como argumento el nombre de un 
--procedimiento, obtenemos la fecha de creación e información sobre sus parámetros.

--- "sp_helptext": seguido del nombre de un procedimiento almacenado nos muestra el texto 
--que define el procedimiento, excepto si ha sido encriptado.

--- "sp_stored_procedures": muestra todos los procedimientos almacenados, los propietarios,
--etc. Este procedimiento almacenado puede recibir 3 parámetros: @sp_name (nombre, nvarchar, 
--admite comodines para búsqueda de patrones), @sp_owner (propietario, nvarchar, admite comodines) 
--y @qualifier (nombre de la base de datos). Por ejemplo, podemos ver todos los procedimientos 
--almacenados creados por nosotros con esta sentencia:

--exec sp_stored_procedures @sp_name='pa_%';

--- "sp_depends": seguido del nombre de un objeto, nos devuelve 2 resultados: 1) nombre, tipo,
--campos, etc. de los objetos de los cuales depende el objeto enviado y 2) nombre y tipo de los
--objetos que dependen del objeto nombrado. Por ejemplo, ejecutamos "sp_depends" seguido del 
--nombre de un procedimiento:

--exec sp_depends pa_autor_promedio;

--aparecen las tablas (y demás objetos) de las cuales depende el procedimiento, es decir, 
--las tablas referenciadas en el mismo. Podemos ejecutar el procedimiento seguido del nombre de una tabla:

--exec sp_depends libros;

--aparecen los procedimientos (y demás objetos) que dependen de ella.

--- La tabla del sistema "sysobjects": muestra nombre y varios datos de todos
--los objetos de la base de datos actual. La columna "xtype" indica el tipo de objeto.
--Si es un procedimiento almacenado, muestra "P". Ejemplo:

--select * from sysobjects;

--Si queremos ver todos los procedimientos almacenados creados por nosotros, podemos tipear:

--select *from sysobjects
--where xtype='P' and-- tipo procedimiento
--name like 'pa%';--búsqueda con comodín


if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
);

go

insert into libros values ('Uno','Richard Bach','Planeta',15);
insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
insert into libros values ('El aleph','Borges','Emece',25);
insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values ('Puente al infinito','Richard Bach','Sudamericana',14);
insert into libros values ('Antología','J. L. Borges','Paidos',24);
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
insert into libros values ('Antología','Borges','Planeta',34);

if object_id('pa_autor_promedio') is not null
  drop proc pa_autor_promedio;

go

--  Creamos un procedimiento almacenado para que reciba el nombre de un autor
--  y nos retorne el promedio de los precios de todos los libros de tal autor:
create procedure pa_autor_promedio
  @autor varchar(30)='%',
  @promedio decimal(6,2) output
  as 
  select @promedio=avg(precio)
   from libros
   where autor like @autor;

go

exec sp_help pa_autor_promedio;

exec sp_helptext pa_autor_promedio;

exec sp_stored_procedures;

exec sp_stored_procedures 'pa_%';

exec sp_depends pa_autor_promedio;

exec sp_depends libros;

select * from sysobjects;

select * from sysobjects
  where xtype='P' and-- tipo procedimiento
  name like 'pa%'--búsqueda con comodín;

drop proc pa_autor_promedio;

exec sp_depends libros;