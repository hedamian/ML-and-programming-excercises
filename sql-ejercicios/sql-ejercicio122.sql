--Variables de usuario

--Las variables nos permiten almacenar un valor y recuperarlo más
-- adelante para emplearlos en otras sentencias.

--Las variables de usuario son específicas de cada conexión y son
-- liberadas automáticamente al abandonar la conexión.

--Las variables de usuario comienzan con "@" (arroba) seguido del 
--nombre (sin espacios), dicho nombre puede contener cualquier caracter.

--Una variable debe ser declarada antes de usarse. Una variable local
-- se declara así:

-- declare @NOMBREVARIABLE TIPO
--colocando "declare" el nombre de la variable que comienza con el
-- símbolo arroba (@) y el tipo de dato. Ejemplo:

-- declare @nombre varchar(20)
--Puede declarar varias variables en una misma sentencia:

-- declare @nombre varchar(20), @edad int
--No existen variables globales en SQL Server.

--Una variable declarada existe dentro del entorno en que se declara; 
--debemos declarar y emplear la variable en el mismo lote de sentencias, 
--porque si declaramos una variable y luego, en otro bloque de sentencias 
--pretendemos emplearla, dicha variable ya no existe.

--Una variable a la cual no se le ha asignado un valor contiene "null".

--Se le asigna un valor inicial con "set":

-- set @edad=45
--Para almacenar un valor en una variable se coloca el signo igual (=) 
--entre la variable y el valor a asignar.

--Si le asignamos un valor resultado de una consulta, la sintaxis es:

-- select @nombre = autor from libros where titulo='Uno'
--Podemos ver el contenido de una variable con:

-- select @nombre;
--Una variable puede tener comodines:

-- declare @patron varchar(30)
-- set @patron='B%';
-- select autor
-- from libros
--  where autor like @patron;
--La utilidad de las variables consiste en que almacenan valores para
-- utilizarlos en otras consultas.

--Por ejemplo, queremos saber todos los datos del libro con mayor precio
-- de la tabla "libros" de una librería. Para ello podemos emplear una 
-- variable para almacenar el precio más alto:

-- declare @mayorprecio decimal(5,2)
-- select @mayorprecio=max(precio) from libros;
--y luego mostrar todos los datos de dicho libro empleando la variable anterior:

-- select *from libros
--  where precio=@mayorprecio;
--Es decir, declaramos la variable y guardamos en ella el precio más alto y
-- luego, en otra sentencia, mostramos los datos de todos los libros cuyo precio 
-- es igual al valor de la variable.

--Una variable puede ser definida con cualquier tipo de dato, excepto text, ntext 
--e image; incluso de un tipo de dato definido por el usuario.

if object_id('libros') is not null
  drop table libros;

create table libros(
  titulo varchar(30),
  autor varchar(25),
  editorial varchar(20),
  precio decimal(5,2)
);

go

insert into libros values('Uno','Bach Richard','Planeta',15);
insert into libros values('El aleph','Borges J. L.','Emece',25);
insert into libros values('Matematica estas ahi','Paenza Adrian','Siglo XXI',15);
insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI',35);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI',35);

-- Declare una variable llamada "@valor" de tipo "int" y vea su contenido:
declare @valor int
select @valor;

-- Declare una variable llamada "@nombre" de tipo "varchar(20)", 
-- asígnele un valor y vea su contenido:
declare @nombre varchar(20)
set @nombre='Juan';
select @nombre;

-- Queremos saber todos los datos de los libros con mayor precio de la tabla "libros".
-- Declare una variable de tipo decimal, busque el precio más alto de "libros"
-- y almacénelo en una variable, 
-- luego utilice dicha variable para mostrar todos los datos del libro:
declare @mayorprecio  decimal(5,2)
select @mayorprecio=max(precio) from libros
select * from libros where precio=@mayorprecio;