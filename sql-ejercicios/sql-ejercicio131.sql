--120 - Procedimientos almacenados (crear - ejecutar)

--Los procedimientos almacenados se crean en la base de datos seleccionada,
--excepto los procedimientos almacenados temporales, que se crean en la base de datos "tempdb".

--En primer lugar se deben tipear y probar las instrucciones que se incluyen en el procedimiento 
--almacenado, luego, si se obtiene el resultado esperado, se crea el procedimiento.

--Los procedimientos almacenados pueden hacer referencia a tablas, vistas,
--a funciones definidas por el usuario, a otros procedimientos almacenados y a tablas temporales.

--Un procedimiento almacenado pueden incluir cualquier cantidad y tipo de instrucciones, excepto:
--create default, create procedure, create rule, create trigger y create view.
--Se pueden crear otros objetos (por ejemplo índices, tablas), en tal caso deben especificar 
--el nombre del propietario; se pueden realizar inserciones, actualizaciones, eliminaciones, etc.

--Si un procedimiento almacenado crea una tabla temporal, dicha tabla sólo existe dentro del 
--procedimiento y desaparece al finalizar el mismo. Lo mismo sucede con las variables.

--Hemos empleado varias veces procedimientos almacenados del sistema ("sp_help", "sp_helpconstraint", etc.), 
--ahora aprenderemos a crear nuestros propios procedimientos almacenados.

--Para crear un procedimiento almacenado empleamos la instrucción "create procedure".
--La sintaxis básica parcial es:

--create procedure NOMBREPROCEDIMIENTO
--as INSTRUCCIONES;
--Para diferenciar los procedimientos almacenados del sistema de los procedimientos almacenados
--locales use un prefijo diferente a "sp_" cuando les de el nombre.

--Con las siguientes instrucciones creamos un procedimiento almacenado llamado "pa_libros_limite_stock"
--que muestra todos los libros de los cuales hay menos de 10 disponibles:

--create proc pa_libros_limite_stock
--as
--select *from libros
--where cantidad <=10;
--Entonces, creamos un procedimiento almacenado colocando "create procedure" 
--(o "create proc", que es la forma abreviada), luego el nombre del procedimiento y 
--seguido de "as" las sentencias que definen el procedimiento.

--"create procedure" debe ser la primera sentencia de un lote.

--Para ejecutar el procedimiento almacenado creado anteriormente tipeamos:

--exec pa_libros_limite_stock;
--Entonces, para ejecutar un procedimiento almacenado colocamos "execute" (o "exec") 
--seguido del nombre del procedimiento.

--Cuando realizamos un ejercicio nuevo, siempre realizamos las mismas tareas: eliminamos 
--la tabla si existe, la creamos y luego ingresamos algunos registros. Podemos crear un procedimiento
--almacenado que contenga todas estas instrucciones:

create procedure pa_crear_libros
as
if object_id('libros')is not null
drop table libros;
create table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30),
editorial varchar(20),
precio decimal(5,2),
primary key(codigo)
);

insert into libros values('Uno','Richard Bach','Planeta',15);
insert into libros values('Ilusiones','Richard Bach','Planeta',18);
insert into libros values('El aleph','Borges','Emece',25);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45);
insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',12);
insert into libros values('Java en 10 minutos','Mario Molina','Paidos',35);
--Y luego lo ejecutamos cada vez que comenzamos un nuevo ejercicio y así evitamos tipear tantas sentencias:

exec pa_crear_libros;

-- En primer lugar, debemos eliminarlo, si existe (no hemos aprendido aún a eliminar procedimientos
-- almacenados, en próximos capítulos lo veremos):
if object_id('pa_crear_libros') is not null
drop procedure pa_crear_libros;

go

-- Creamos el procedimiento:
create procedure pa_crear_libros 
as
if object_id('libros')is not null
drop table libros

create table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30),
editorial varchar(20),
precio decimal(5,2),
cantidad smallint,
primary key(codigo)
)

insert into libros values('Uno','Richard Bach','Planeta',15,5)
insert into libros values('Ilusiones','Richard Bach','Planeta',18,50)
insert into libros values('El aleph','Borges','Emece',25,9)
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45,100)
insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',12,50)
insert into libros values('Java en 10 minutos','Mario Molina','Paidos',35,300);

go

-- Ejecutamos el procedimiento:
exec pa_crear_libros;

-- Veamos si ha creado la tabla:
select * from libros;

-- Ejecutamos el procedimiento almacenado del sistema "sp_help" 
-- y el nombre del procedimiento almacenado para verificar que existe 
-- el procedimiento creado recientemente:
exec sp_help pa_crear_libros;

-- Necesitamos un procedimiento almacenado que muestre los libros de los cuales 
-- hay menos de 10. En primer lugar, lo eliminamos si existe:
if object_id('pa_libros_limite_stock') is not null
drop procedure pa_libros_limite_stock;

go 

-- Creamos el procedimiento:
create proc pa_libros_limite_stock
as
select *from libros
where cantidad <=10;

go

-- Ejecutamos el procedimiento almacenado del sistema "sp_help" 
-- junto al nombre del procedimiento creado recientemente para verificar que existe:
exec sp_help pa_libros_limite_stock;

-- Lo ejecutamos:
exec pa_libros_limite_stock;

-- Modificamos algún registro y volvemos a ejecutar el procedimiento:
update libros set cantidad=2 where codigo=4;
exec pa_libros_limite_stock;