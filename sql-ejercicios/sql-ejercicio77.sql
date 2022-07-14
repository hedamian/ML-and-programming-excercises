--combinaciones cruzadas 

--Vimos que hay tres tipos de combinaciones:
--1) combinaciones internas (join), 2) combinaciones externas (left, right y full join) y 
--3) combinaciones cruzadas.

--Las combinaciones cruzadas (cross join) muestran todas las combinaciones de todos los registros
-- de las tablas combinadas. Para este tipo de join no se incluye una condición de enlace. 
--Se genera el producto cartesiano en el que el número de filas del resultado es igual al número de 
--registros de la primera tabla multiplicado por el número de registros de la segunda tabla, es decir, 
--si hay 5 registros en una tabla y 6 en la otra, retorna 30 filas.

--La sintaxis básica es ésta:

--select CAMPOS
--from TABLA1
--cross join TABLA2;

--Veamos un ejemplo. Un pequeño restaurante almacena los nombres y precios de sus comidas en una 
--tabla llamada "comidas" y en una tabla denominada "postres" los mismos datos de sus postres.

--Si necesitamos conocer todas las combinaciones posibles para un menú, cada comida con cada postre, --empleamos un "cross join":

--select c.nombre as 'plato principal', p.nombre as 'postre'
--from comidas as c
--cross join postres as p;

--La salida muestra cada plato combinado con cada uno de los postres.

--Como cualquier tipo de "join", puede emplearse una cláusula "where" que condicione la salida.


if object_id('comidas') is not null
  drop table comidas;
if object_id('postres') is not null
  drop table postres;

create table comidas(
  codigo tinyint identity,
  nombre varchar(30),
  precio decimal(4,2)
);

create table postres(
  codigo tinyint identity,
  nombre varchar(30),
  precio decimal(4,2)
);

go

insert into comidas values('ravioles',5);
insert into comidas values('tallarines',4);
insert into comidas values('milanesa',7);
insert into comidas values('cuarto de pollo',6);

insert into postres values('flan',2.5);
insert into postres values('porcion torta',3.5);

-- Combinar los registros de ambas tablas para mostrar 
-- los distintos menúes que ofrece. Lo hacemos usando un "cross join":
select c.nombre as 'plato principal',
  p.nombre as 'postre',
  c.precio+p.precio as 'total'
  from comidas as c
  cross join postres as p;