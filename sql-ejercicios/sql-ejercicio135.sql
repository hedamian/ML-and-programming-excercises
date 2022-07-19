-- 124 - Procedimientos almacenados (return)
use ejercicios
-- La instrucción "return" sale de una consulta o procedimiento y todas las instrucciones posteriores
-- no son ejecutadas.

-- Creamos un procedimiento que muestre todos los libros de un autor determinado que se 
-- ingresa como parámetro. Si no se ingresa un valor, o se ingresa "null", se muestra un 
-- mensaje y se sale del procedimiento:

-- create procedure pa_libros_autor
-- @autor varchar(30)=null
-- as 
-- if @autor is null
-- begin 
-- select 'Debe indicar un autor'
-- return
-- end;
-- select titulo from  libros where autor = @autor;

-- Si al ejecutar el procedimiento enviamos el valor "null" o no pasamos valor, 
-- con lo cual toma el valor por defecto "null", se muestra un mensaje y se sale;
-- en caso contrario, ejecuta la consulta luego del "else".

-- "return" puede retornar un valor entero.

-- Un procedimiento puede retornar un valor de estado para indicar si se ha ejecutado correctamente o no.

-- Creamos un procedimiento almacenado que ingresa registros en la tabla "libros". 
-- Los parámetros correspondientes al título y autor DEBEN ingresarse con un valor 
-- distinto de "null", los demás son opcionales. El procedimiento retorna "1" 
-- si la inserción se realiza, es decir, si se ingresan valores para título y autor y "0", 
-- en caso que título o autor sean nulos:

-- create procedure pa_libros_ingreso
-- @titulo varchar(40)=null,
-- @autor varchar(30)=null,
-- @editorial varchar(20)=null,
-- @precio decimal(5,2)=null
-- as 
-- if (@titulo is null) or (@autor is null)
-- return 0
-- else 
-- begin
-- insert into libros values (@titulo,@autor,@editorial,@precio)
-- return 1
-- end;

-- Para ver el resultado, debemos declarar una variable en la cual se almacene el valor devuelto
-- por el procedimiento; luego, ejecutar el procedimiento asignándole el valor devuelto a la variable,
-- finalmente mostramos el contenido de la variable:

-- declare @retorno int
-- exec @retorno=pa_libros_ingreso 'Alicia en el pais...','Lewis Carroll'
-- select 'Ingreso realizado=1' = @retorno
-- exec @retorno=pa_libros_ingreso
-- select 'Ingreso realizado=1' = @retorno;

-- También podríamos emplear un "if" para controlar el valor de la variable de retorno:

-- declare @retorno int;
-- exec @retorno=pa_libros_ingreso 'El gato con botas','Anónimo'
-- if @retorno=1 select 'Registro ingresado'
-- else select 'Registro no ingresado porque faltan datos';


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

-- Eliminamos el procedimiento llamado "pa_libros_autor", si existe:
if object_id('pa_libros_autor') is not null
  drop procedure pa_libros_autor;

go

-- Creamos un procedimiento que muestre todos los libros de un autor determinado 
-- que se ingresa como parámetro. Si no se ingresa un valor, o se ingresa "null",
-- se muestra un mensaje y se sale del procedimiento:
create procedure pa_libros_autor
  @autor varchar(30)=null
 as 
 if @autor is null
 begin 
  select 'Debe indicar un autor'
  return
 end
 select titulo from  libros where autor = @autor;

go

-- Ejecutamos el procedimiento con parámetro:
exec pa_libros_autor 'Borges';

-- Ejecutamos el procedimiento sin parámetro:
exec pa_libros_autor;

-- Eliminamos el procedimiento "pa_libros_ingreso", si existe:
if object_id('pa_libros_ingreso') is not null
  drop procedure pa_libros_ingreso;

go

-- Creamos un procedimiento almacenado que ingresa registros en la tabla "libros".
-- Los parámetros correspondientes al título y autor DEBEN ingresarse con un valor 
-- distinto de "null", los demás son opcionales. 
-- El procedimiento retorna "1" si la inserción se realiza (si se ingresan valores
-- para título y autor) y "0", en caso que título o autor sean nulos:
create procedure pa_libros_ingreso
  @titulo varchar(40)=null,
  @autor varchar(30)=null,
  @editorial varchar(20)=null,
  @precio decimal(5,2)=null
 as 
 if (@titulo is null) or (@autor is null)
  return 0
 else 
 begin
  insert into libros values (@titulo,@autor,@editorial,@precio)
  return 1
 end;

go

-- Declaramos una variable en la cual almacenaremos el valor devuelto, 
-- ejecutamos el procedimiento enviando los dos parámetros obligatorios
-- y vemos el contenido de la variable:
declare @retorno int
exec @retorno=pa_libros_ingreso 'Alicia en el pais...','Lewis Carroll'
select 'Ingreso realizado=1' = @retorno;

select * from libros;

go

-- Ejecutamos los mismos pasos, pero esta vez no enviamos valores al procedimiento
-- (El procedimiento retornó "0", lo cual indica que el registro no fue ingresado.):
declare @retorno int
exec @retorno=pa_libros_ingreso
select 'Ingreso realizado=1' = @retorno;

select * from libros;

go

-- Empleamos un "if" para controlar el valor de la variable de retorno. 
-- Enviando al procedimiento valores para los parámetros obligatorios:
declare @retorno int
exec @retorno=pa_libros_ingreso 'El gato con botas','Anónimo'
if @retorno=1 select 'Registro ingresado'
 else select 'Registro no ingresado porque faltan datos';

select * from libros;

go

declare @retorno int
exec @retorno=pa_libros_ingreso
if @retorno=1 select 'Registro ingresado'
 else select 'Registro no ingresado porque faltan datos';

select * from libros;