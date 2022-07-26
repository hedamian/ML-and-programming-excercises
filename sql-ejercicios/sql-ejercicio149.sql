--138 - Funciones (modificar)

--Las funciones de SQL Server no pueden ser modificadas, 
--las funciones definidas por el usuario si.

--Las funciones definidas por el usuario pueden modificarse
--con la instrucción "alter function".

--Sintaxis general:

--alter function PROPIETARIO.NOMBREFUNCION
--NUEVADEFINICION;

--Sintaxis para modificar funciones escalares:

--alter function PROPIETARIO.NOMBREFUNCION
--(@PARAMETRO TIPO=VALORPORDEFECTO) 
--returns TIPO
--as
--begin
--CUERPO
--return EXPRESIONESCALAR
--end

--Sintaxis para modificar una función de varias instrucciones que retorna una tabla:

--alter function NOMBREFUNCION
--(@PARAMETRO TIPO=VALORPORDEFECTO) 
--returns @VARIABLE table
--(DEFINICION DE LA TABLA A RETORNAR)
--as
--begin
--CUERPO DE LA FUNCION
--return
--end

--Sintaxis para modificar una función con valores de tabla en línea

--alter function NOMBREFUNCION
--(@PARAMETRO TIPO) 
--returns TABLE
--as
--return (SENTENCIAS SELECT) 

--Veamos un ejemplo. Creamos una función que retorna una tabla en línea:

--create function f_libros
--(@autor varchar(30)='Borges')
--returns table
--as
--return (
--select titulo,editorial
--from libros
--where autor like '%'+@autor+'%'
--);

--La modificamos agregando otro campo en el "select":

--alter table f_libros
--(@autor varchar(30)='Borges')
--returns table
--as
--return (
--select codigo,titulo,editorial
--from libros
--where autor like '%'+@autor+'%'
--);


if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20)
);

go

insert into libros values('Uno','Richard Bach','Planeta');
insert into libros values('El aleph','Borges','Emece');
insert into libros values('Ilusiones','Richard Bach','Planeta');
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo');
insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo');

if object_id('f_libros') is not null
  drop function f_libros;

go

-- Creamos una función que retorna una tabla en línea:
create function f_libros
 (@autor varchar(30)='Borges')
 returns table
 as
 return (
  select titulo,editorial
  from libros
  where autor like '%'+@autor+'%'
 );

go

-- Llamamos a la función creada anteriormente enviando un autor:
select * from f_libros('Bach');

go

-- La modificamos agregando otro campo en el "select":
alter function f_libros
 (@autor varchar(30)='Borges')
 returns table
 as
 return (
  select codigo,titulo,editorial
  from libros
  where autor like '%'+@autor+'%'
 );

go

-- Probamos la función para ver si se ha modificado:
select * from f_libros('Bach');