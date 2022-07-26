--137 - Funciones con valores de tabla en línea

--Una función con valores de tabla en línea retorna una tabla que 
--es el resultado de una única instrucción "select".

--Es similar a una vista, pero más flexible en el empleo de parámetros. 
--En una vista no se puede incluir un parámetro, lo que hacemos es agregar una cláusula 
--"where" al ejecutar la vista. Las funciones con valores de tabla en línea funcionan
--como una vista con parámetros.

--Sintaxis:

--create function NOMBREFUNCION
--(@PARAMETRO TIPO=VALORPORDEFECTO)
--returns table
--as
--return (
--select CAMPOS
--from TABLA
--where CONDICION
--);

--Como todas las funciones definidas por el usuario, se crea con "create function"
--seguido del nombre que le damos a la función; luego declaramos los parámetros de
--entrada con su tipo de dato entre paréntesis. El valor por defecto es opcional.

--"returns" especifica "table" como el tipo de datos a retornar. No se define el
--formato de la tabla a retornar porque queda establecido en el "select".

--El cuerpo de la función no contiene un bloque "begin...end" como las otras funciones.

--La cláusula "return" contiene una sola instrucción "select" entre paréntesis.
--El resultado del "select" es la tabla que se retorna. El "select" está sujeto 
--a las mismas reglas que los "select" de las vistas.

--Creamos una función con valores de tabla en línea que recibe un valor de autor como parámetro:

--create function f_libros
--(@autor varchar(30)='Borges')
--returns table
--as
--return (
--select titulo,editorial
--from libros
--where autor like '%'+@autor+'%'
--);

--Estas funciones retornan una tabla y se hace referencia a ellas en la cláusula "from", como una vista:

--select *from f_libros('Bach');

--Recuerde a que todas las funciones que tienen definidos parámetros se les
--DEBE suministrar valores para ellos al invocarse.

--Recuerde que para que el parámetro tome el valor por defecto (si lo tiene)
--DEBE enviarse "default" al llamar a la función; si no le enviamos parámetros,
--SQL Server muestra un mensaje de error.

----incorrecto: select *from f_libros();
--select *from f_libros(default);--correcto

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

-- Eliminamos, si existe la función "f_libros":
if object_id('f_libros') is not null
  drop function f_libros;

go

-- Creamos una función con valores de tabla en línea que recibe un valor
-- de autor como parámetro:
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

-- Eliminamos, si existe la función "f_libros_autoreditorial":
if object_id('f_libros_autoreditorial') is not null
  drop function f_libros_autoreditorial;

go

-- Creamos una función con valores de tabla en línea que recibe dos parámetros:
create function f_libros_autoreditorial
 (@autor varchar(30)='Borges',
 @editorial varchar(20)='Emece')
 returns table
 as
 return (
  select titulo,autor,editorial
  from libros
  where autor like '%'+@autor+'%' and
  editorial like '%'+@editorial+'%'
 );

go

-- Llamamos a la función creada anteriormente:
select * from f_libros_autoreditorial('','Nuevo siglo');

-- Llamamos a la función creada anteriormente enviando "default"
-- para que tome los valores por defecto:
select * from f_libros_autoreditorial(default,default);