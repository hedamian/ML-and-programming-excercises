--122 - Procedimientos almacenados (parámetros de entrada)

--Los procedimientos almacenados pueden recibir y devolver información;
--para ello se emplean parámetros, de entrada y salida, respectivamente.

--Veamos los primeros. Los parámetros de entrada posibilitan pasar información a un procedimiento.
--Para que un procedimiento almacenado admita parámetros de entrada se deben declarar variables
--como parámetros al crearlo. La sintaxis es:

--create proc NOMBREPROCEDIMIENTO
--@NOMBREPARAMETRO TIPO =VALORPORDEFECTO
--as SENTENCIAS; 

--Los parámetros se definen luego del nombre del procedimiento, comenzando el nombre con un signo 
--arroba (@). Los parámetros son locales al procedimiento, es decir, existen solamente dentro 
--del mismo. Pueden declararse varios parámetros por procedimiento, se separan por comas.

--Cuando el procedimiento es ejecutado, deben explicitarse valores para cada uno de los parámetros
--(en el orden que fueron definidos), a menos que se haya definido un valor por defecto,
--en tal caso, pueden omitirse. Pueden ser de cualquier tipo de dato (excepto cursor).

--Luego de definir un parámetro y su tipo, opcionalmente, se puede especificar un valor por defecto;
--tal valor es el que asume el procedimiento al ser ejecutado si no recibe parámetros. 
--Si no se coloca valor por defecto, un procedimiento definido con parámetros no puede ejecutarse
--sin valores para ellos. El valor por defecto puede ser "null" o una constante,
--también puede incluir comodines si el procedimiento emplea "like".

--Creamos un procedimiento que recibe el nombre de un autor como parámetro para mostrar todos los libros del autor solicitado:

--create procedure pa_libros_autor
--@autor varchar(30) 
--as
--select titulo, editorial,precio
--from libros
--where autor= @autor;

--El procedimiento se ejecuta colocando "execute" (o "exec") seguido del nombre del procedimiento
--y un valor para el parámetro:

--exec pa_libros_autor 'Borges';

--Creamos un procedimiento que recibe 2 parámetros, el nombre de un autor y el de una editorial:

--create procedure pa_libros_autor_editorial
--@autor varchar(30),
--@editorial varchar(20) 
--as
--select titulo, precio
--from libros
--where autor= @autor and
--editorial=@editorial;

--El procedimiento se ejecuta colocando "execute" (o "exec") seguido del nombre del procedimiento y los valores para los parámetros separados por comas:

--exec pa_libros_autor_editorial 'Richard Bach','Planeta';

--Los valores de un parámetro pueden pasarse al procedimiento mediante el nombre del parámetro o por su posición. La sintaxis anterior ejecuta el procedimiento pasando valores a los parámetros por posición. También podemos emplear la otra sintaxis en la cual pasamos valores a los parámetros por su nombre:

--exec pa_libros_autor_editorial @editorial='Planeta', @autor='Richard Bach';

--Cuando pasamos valores con el nombre del parámetro, el orden en que se colocan puede alterarse.

--No podríamos ejecutar el procedimiento anterior sin valores para los parámetros. Si queremos ejecutar un procedimiento que permita omitir los valores para los parámetros debemos, al crear el procedimiento, definir valores por defecto para cada parámetro:

--create procedure pa_libros_autor_editorial2
--@autor varchar(30)='Richard Bach',
--@editorial varchar(20)='Planeta' 
--as
--select titulo, autor,editorial,precio
--from libros
--where autor= @autor and
--editorial=@editorial;

--Podemos ejecutar el procedimiento anterior sin enviarle valores, usará los predeterminados.

--Si enviamos un solo parámetro a un procedimiento que tiene definido más de un parámetro sin especificar a qué parámetro corresponde (valor por posición), asume que es el primero. Es decir, SQL Server asume que los valores se dan en el orden que fueron definidos, no se puede interrumpir la secuencia.

--Si queremos especificar solamente el segundo parámetro, debemos emplear la sintaxis de paso de valores a parámetros por nombre:

--exec pa_libros_autor_editorial2 @editorial='Paidos';

--Podemos emplear patrones de búsqueda en la consulta que define el procedimiento almacenado
--y utilizar comodines como valores por defecto:

--create proc pa_libros_autor_editorial3
--@autor varchar(30) = '%',
--@editorial varchar(30) = '%'
--as 
--select titulo,autor,editorial,precio
--from libros
--where autor like @autor and
--editorial like @editorial;

--La sentencia siguiente ejecuta el procedimiento almacenado "pa_libros_autor_editorial3"
--enviando un valor por posición, se asume que es el primero.

--exec pa_libros_autor_editorial3 'P%';

--La sentencia siguiente ejecuta el procedimiento almacenado "pa_libros_autor_editorial3"
--enviando un valor para el segundo parámetro, para el primer parámetro toma el valor por defecto:

--exec pa_libros_autor_editorial3 @editorial='P%';

--También podríamos haber tipeado:

--exec pa_libros_autor_editorial3 default, 'P%';


-- Trabajamos con la tabla "libros" de una librería.
-- Eliminamos la tabla si existe y la creamos nuevamente:
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
insert into libros values ('Puente al infinito','Bach Richard','Sudamericana',14);
insert into libros values ('Antología','J. L. Borges','Paidos',24);
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
insert into libros values ('Cervantes y el quijote','Borges- Casares','Planeta',34);

-- Eliminamos el procedimiento almacenado "pa_libros_autor" si existe:
if object_id('pa_libros_autor') is not null
  drop procedure pa_libros_autor;

go

-- Creamos el procedimiento para que reciba el nombre de un autor y 
-- muestre todos los libros del autor solicitado:
create procedure pa_libros_autor
  @autor varchar(30) 
 as
  select titulo, editorial,precio
   from libros
   where autor= @autor;

go

-- Ejecutamos el procedimiento:
exec pa_libros_autor 'Richard Bach';

-- Empleamos la otra sintaxis (por nombre) y pasamos otro valor:
exec pa_libros_autor @autor='Borges';

-- Eliminamos, si existe, el procedimiento "pa_libros_autor_editorial":
if object_id('pa_libros_autor_editorial') is not null
  drop procedure pa_libros_autor_editorial;

go

-- Creamos un procedimiento "pa_libros_autor_editorial" que recibe 2 parámetros,
-- el nombre de un autor y el de una editorial:
create procedure pa_libros_autor_editorial
  @autor varchar(30),
  @editorial varchar(20) 
 as
  select titulo, precio
   from libros
   where autor= @autor and
   editorial=@editorial;

go

-- Ejecutamos el procedimiento enviando los parámetros por posición:
exec pa_libros_autor_editorial 'Richard Bach','Planeta';

-- Ejecutamos el procedimiento enviando otros valores y lo hacemos por nombre 
--(Si ejecutamos el procedimiento omitiendo los parámetros, aparecerá un mensaje de error.):
exec pa_libros_autor_editorial @autor='Borges',@editorial='Emece';

-- Eliminamos, si existe, el procedimiento "pa_libros_autor_editorial2":
if object_id('pa_libros_autor_editorial2') is not null
  drop procedure pa_libros_autor_editorial2;

go

-- Creamos el procedimiento almacenado "pa_libros_autor_editorial2" que recibe los mismos
-- parámetros, esta vez definimos valores por defecto para cada parámetro:
create procedure pa_libros_autor_editorial2
  @autor varchar(30)='Richard Bach',
  @editorial varchar(20)='Planeta' 
 as
  select titulo,autor,editorial,precio
   from libros
   where autor= @autor and
   editorial=@editorial;

go

-- Ejecutamos el procedimiento anterior sin enviarle valores para verificar que usa 
-- los valores por defecto (Muestra los libros de "Richard Bach" y editorial
-- "Planeta" (valores por defecto)):
exec pa_libros_autor_editorial2;

-- Enviamos un solo parámetro al procedimiento (SQL Server asume que es el primero,
-- y no hay registros cuyo autor sea "Planeta"):
exec pa_libros_autor_editorial2 'Planeta';

-- Especificamos el segundo parámetro, enviando parámetros por nombre:
exec pa_libros_autor_editorial2 @editorial='Planeta';

-- Ejecutamos el procedimiento enviando parámetros por nombre en distinto orden:
exec pa_libros_autor_editorial2 @editorial='Nuevo siglo',@autor='Paenza';

-- Definimos un procedimiento empleando patrones de búsqueda 
-- (antes verificamos si existe para eliminarlo):
if object_id('pa_libros_autor_editorial3') is not null
  drop procedure pa_libros_autor_editorial3;

go
 
 create proc pa_libros_autor_editorial3
  @autor varchar(30) = '%',
  @editorial varchar(30) = '%'
 as 
  select titulo,autor,editorial,precio
   from libros
   where autor like @autor and
   editorial like @editorial;

go

-- Ejecutamos el procedimiento enviando parámetro por posición, asume que es el primero:
exec pa_libros_autor_editorial3 'P%';

-- Ejecutamos el procedimiento especificando que el valor corresponde al segundo parámetro:
exec pa_libros_autor_editorial3 @editorial='P%';

-- La sentencia siguiente muestra lo mismo que la anterior:
exec pa_libros_autor_editorial3 default, 'P%';
