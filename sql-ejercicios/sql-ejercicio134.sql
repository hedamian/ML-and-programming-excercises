-- 123 - Procedimientos almacenados (parámetros de salida)
use ejercicios
-- Dijimos que los procedimientos almacenados pueden devolver información;
-- para ello se emplean parámetros de salida. El valor se retorna a quien
-- realizó la llamada con parámetros de salida. Para que un procedimiento 
-- almacenado devuelva un valor se debe declarar una variable con la palabra
-- clave "output" al crear el procedimiento:

-- create procedure NOMBREPROCEDIMIENTO
-- @PARAMETROENTRADA TIPO =VALORPORDEFECTO,
-- @PARAMETROSALIDA TIPO=VALORPORDEFECTO output
-- as 
-- SENTENCIAS
-- select @PARAMETROSALIDA=SENTENCIAS;

-- Los parámetros de salida pueden ser de cualquier tipo de datos, excepto text, ntext e image.

-- Creamos un procedimiento almacenado al cual le enviamos 2 números y retorna el promedio:

-- create procedure pa_promedio
-- @n1 decimal(4,2),
-- @n2 decimal(4,2),
-- @resultado decimal(4,2) output
-- as 
-- select @resultado=(@n1+@n2)/2;

-- Al ejecutarlo también debe emplearse "output":

-- declare @variable decimal(4,2)
-- execute pa_promedio 5,6, @variable output
-- select @variable;

-- Declaramos una variable para guardar el valor devuelto por el procedimiento; 
-- ejecutamos el procedimiento enviándole 2 valores y mostramos el resultado.

-- La instrucción que realiza la llamada al procedimiento debe contener un nombre 
-- de variable para almacenar el valor retornado.

-- Creamos un procedimiento almacenado que muestre los títulos, editorial y precio 
-- de los libros de un determinado autor (enviado como parámetro de entrada)
-- y nos retorne la suma y el promedio de los precios de todos los libros del autor enviado:

-- create procedure pa_autor_sumaypromedio
-- @autor varchar(30)='%',
-- @suma decimal(6,2) output,
-- @promedio decimal(6,2) output
-- as 
-- select titulo,editorial,precio
-- from libros
-- where autor like @autor
-- select @suma=sum(precio)
-- from libros
-- where autor like @autor
-- select @promedio=avg(precio)
-- from libros
-- where autor like @autor;

-- Ejecutamos el procedimiento y vemos el contenido de las variables en las 
-- que almacenamos los parámetros de salida del procedimiento:

-- declare @s decimal(6,2), @p decimal(6,2)
-- execute pa_autor_sumaypromedio 'Richard Bach', @s output, @p output
-- select @s as total, @p as promedio;


-- Eliminamos el procedimiento almacenado "pa_promedio", si existe:
if object_id('pa_promedio') is not null
  drop proc pa_promedio;

go

-- Creamos un procedimiento almacenado al cual le enviamos
-- 2 números decimales y retorna el promedio:
create procedure pa_promedio
  @n1 decimal(4,2),
  @n2 decimal(4,2),
  @resultado decimal(4,2) output
  as 
   select @resultado=(@n1+@n2)/2;

go

-- Lo ejecutamos enviando diferentes valores:
declare @variable decimal(4,2)
exec pa_promedio 5,6, @variable output
select @variable

exec pa_promedio 5.3,4.7, @variable output
select @variable

exec pa_promedio 9,10, @variable output
select @variable;

-- Trabajamos con la tabla "libros" de una librería.
-- Eliminamos la tabla si existe y la creamos nuevamente:
if object_id('libros') is not null
  drop table libros;

go

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

-- Eliminamos el procedimiento almacenado "pa_autor_sumaypromedio", si existe:
if object_id('pa_autor_sumaypromedio') is not null
  drop proc pa_autor_sumaypromedio;

go

-- Creamos un procedimiento almacenado que muestre los títulos, editorial y precio
-- de los libros de un determinado autor (enviado como parámetro de entrada)
-- y nos retorne la suma y el promedio de los precios de todos los libros del autor enviado:
create procedure pa_autor_sumaypromedio
  @autor varchar(30)='%',
  @suma decimal(6,2) output,
  @promedio decimal(6,2) output
  as 
   select titulo,editorial,precio
   from libros
   where autor like @autor
  select @suma=sum(precio)
   from libros
   where autor like @autor
  select @promedio=avg(precio)
   from libros
   where autor like @autor;

go

-- Ejecutamos el procedimiento enviando distintos valores:
declare @s decimal(6,2), @p decimal(6,2)
exec pa_autor_sumaypromedio 'Richard Bach', @s output, @p output
select @s as total, @p as promedio

exec pa_autor_sumaypromedio 'Borges', @s output, @p output
select @s as total, @p as promedio

exec pa_autor_sumaypromedio 'Mario Molina', @s output, @p output
select @s as total, @p as promedio;

go

-- Ejecutamos el procedimiento sin pasar el parámetro para autor.
-- Recuerde que en estos casos debemos colocar los nombres de las variables.
declare @s decimal(6,2), @p decimal(6,2)
exec pa_autor_sumaypromedio @suma=@s output,@promedio= @p output
select @s as total, @p as promedio;