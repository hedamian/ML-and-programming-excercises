--clausula top
--la palabra clave top se emplea para obtener solamente una cantidad limitada de registros, 
--los primeros n registros de una 	consulta 
--con la siguiente consulta obtenemos los datos de los primeros 2 libros de la tabal
--select top 3 * from libros;

--Cuando se combina con "order by" es posible emplear también la cláusula "with ties". 
--Esta cláusula permite incluir en la selección, todos los registros que tengan el mismo 
--valor del campo por el que se ordena en la última posición. Es decir, si el valor del campo 
--por el cual se ordena el último registro retornado (el número n) está repetido en los siguientes 
--registros (es decir, el n+1 tiene el mismo valor que n, y el n+2, etc.), lo incluye en la selección.

--Veamos un ejemplo:

 --select top 3 with ties * from libros
  --order by autor;

--Esta consulta solicita el retorno de los primeros 3 registros; en caso que el registro número 4 (y los posteriores), 
--tengan el mismo valor en "autor" que el último registro retornado (número 3), también aparecerán en la selección.

--Otro argumento posible cuando utilizamos la cláusula 'top' es 'percent' indicando el porcentaje de registros a recuperar 
--y no la cantidad, por ejemplo:

 --select top 50 percent
  --* from libros
 -- order by autor;

--Se recuperan la mitad de registros de la tabla 'libros'.
--Los valores fraccionarios se redondean al siguiente valor entero.
--Si colocamos un valor para "top" que supera la cantidad de registros de la tabla, SQL Server muestra todos los registros.

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(20),
  editorial varchar(20)
);

go

insert into libros values ('Uno','Richard Bach','Planeta');
insert into libros values ('El aleph','Borges','Emece');
insert into libros values ('Alicia en el pais...','Carroll','Planeta');
insert into libros values ('Aprenda PHP','Mario Molina','Siglo XXI');
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI');
insert into libros values ('Java desde cero','Mario Molina','Emece');
insert into libros values ('Ilusiones','Richard Bach','Planeta');

-- Obtenemos todos los datos de los primeros 2 libros de la tabla:
select top 2 * from libros;

-- Mostramos los títulos y autores de los 3 primeros libros ordenados por autor:
select top 3 titulo,autor 
  from libros
  order by autor;

-- Realizamos la misma consulta anterior pero empleamos la cláusula "with ties", 
-- con lo cual incluiremos en la selección, todos los registros que tengan el
-- mismo autor que el último registro retornado, aunque pasemos de 3:
select top 3 with ties titulo,autor 
  from libros
  order by autor;

-- El 50% de los registros de la tabla libros:
select top 50 percent
  * from libros
  order by autor;