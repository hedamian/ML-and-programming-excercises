--Combinación externa izquierda (left join)
--Vimos que una combinación interna (join) encuentra registros de la primera tabla que se correspondan 
--con los registros de la segunda, es decir, que cumplan la condición del "on" y si un valor de la primera 
--tabla no se encuentra en la segunda tabla, el registro no aparece.

--Si queremos saber qué registros de una tabla NO encuentran correspondencia en la otra, es decir,
--no existe valor coincidente en la segunda, necesitamos otro tipo de combinación, "outer join" (combinación externa).

--Las combinaciones externas combinan registros de dos tablas que cumplen la condición, más los registros de la segunda 
--tabla que no la cumplen; es decir, muestran todos los registros de las tablas relacionadas, aún cuando no haya valores
-- coincidentes entre ellas.

--Este tipo de combinación se emplea cuando se necesita una lista completa de los datos de una de las tablas y 
--la información que cumple con la condición. Las combinaciones externas se realizan solamente entre 2 tablas.

--Hay tres tipos de combinaciones externas: "left outer join", "right outer join" y "full outer join"; se pueden abreviar 
--con "left join", "right join" y "full join" respectivamente.

--Se emplea una combinación externa izquierda para mostrar todos los registros de la tabla de la izquierda.
--Si no encuentra coincidencia con la tabla de la derecha, 
--el registro muestra los campos de la segunda tabla seteados a "null".

--Entonces, un "left join" se usa para hacer coincidir registros en una tabla (izquierda) 
--con otra tabla (derecha); si un valor de la tabla de la izquierda no encuentra coincidencia en la tabla de la derecha, 
--se genera una fila extra (una por cada valor no encontrado) con todos los campos correspondientes a la tabla derecha 
--seteados a "null". La sintaxis básica es la siguiente:

 -- select CAMPOS
 -- from TABLAIZQUIERDA
 -- left join TABLADERECHA
  --on CONDICION;
--Un "left join" puede tener clausula "where" que restringa 
--el resultado de la consulta considerando solamente los registros que encuentran coincidencia en la tabla de la derecha


if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
  codigoeditorial tinyint not null,
  precio decimal(5,2)
);
create table editoriales(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Siglo XXI');

insert into libros values('El aleph','Borges',1,20);
insert into libros values('Martin Fierro','Jose Hernandez',1,30);
insert into libros values('Aprenda PHP','Mario Molina',2,50);
insert into libros values('Java en 10 minutos',default,4,45);

-- Combinación izquierda para obtener los datos de los libros, 
-- incluyendo el nombre de la editorial.
-- Las editoriales de las cuales no hay libros, es decir, cuyo código
-- de editorial no está presente en "libros" aparece en el resultado, 
-- pero con el valor "null" en el campo "titulo":
select titulo,nombre
  from editoriales as e
  left join libros as l
  on codigoeditorial = e.codigo;

-- Realizamos la misma consulta anterior pero cambiamos el orden de las tablas:
select titulo,nombre
  from libros as l
  left join editoriales as e
  on codigoeditorial = e.codigo;

-- Consulta considerando solamente los registros que encuentran coincidencia en la
-- tabla de la derecha, es decir, cuyo valor de código está presente en "libros":
select titulo,nombre
  from editoriales as e
  left join libros as l
  on e.codigo=codigoeditorial
  where codigoeditorial is not null;

-- Mostramos las editoriales que no están presentes en "libros", es decir,
-- que no encuentran coincidencia en la tabla de la derecha:
select titulo,nombre
  from editoriales as e
  left join libros as l
  on e.codigo=codigoeditorial
  where codigoeditorial is null;