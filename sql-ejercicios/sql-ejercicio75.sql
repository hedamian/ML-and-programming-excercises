--Combinación externa derecha (right join)

--Vimos que una combinación externa izquierda (left join) encuentra registros de la tabla izquierda 
--que se correspondan con los registros de la tabla derecha y si un valor de la tabla izquierda no
--se encuentra en la tabla derecha, el registro muestra los campos correspondientes a la tabla de
--la derecha seteados a "null".

--Una combinación externa derecha ("right outer join" o "right join") opera del mismo modo sólo que 
--la tabla derecha es la que localiza los registros en la tabla izquierda.

--En el siguiente ejemplo solicitamos el título y nombre de la editorial de los libros empleando un "right join":

  --select titulo,nombre
  --from libros as l
  --right join editoriales as e
  --on codigoeditorial = e.codigo;

--El resultado mostrará el título y nombre de la editorial; las editoriales de las cuales no hay libros,
-- es decir, cuyo código de editorial no está presente en "libros" aparece en el resultado,
 -- pero con el valor "null" en el campo "titulo".

--Es FUNDAMENTAL tener en cuenta la posición en que se colocan las tablas en los "outer join". 
--En un "left join" la primera tabla (izquierda) es la que busca coincidencias en la segunda tabla (derecha); 
--en el "right join" la segunda tabla (derecha) es la que busca coincidencias en la primera tabla (izquierda).

--En la siguiente consulta empleamos un "left join" para conseguir el mismo resultado que el "right join" anterior":

 --select titulo,nombre
 -- from editoriales as e
  --left join libros as l
 -- on codigoeditorial = e.codigo;

--Note que la tabla que busca coincidencias ("editoriales") está en primer lugar porque es un "left join"; 
--en el "right join" precedente, estaba en segundo lugar.

--Un "right join" hace coincidir registros en una tabla (derecha) con otra tabla (izquierda);
-- si un valor de la tabla de la derecha no encuentra coincidencia en la tabla izquierda, 
--se genera una fila extra (una por cada valor no encontrado) con todos los campos correspondientes
-- a la tabla izquierda seteados a "null". La sintaxis básica es la siguiente:

 -- select CAMPOS
 -- from TABLAIZQUIERDA
 -- right join TABLADERECHA
  --on CONDICION;

--Un "right join" también puede tener cláusula "where" que restringa el resultado de la consulta 
--considerando solamente los registros que encuentran coincidencia en la tabla izquierda:

 --select titulo,nombre
 -- from libros as l
 -- right join editoriales as e
 -- on e.codigo=codigoeditorial
--  where codigoeditorial is not null;

--Mostramos las editoriales que NO están presentes en "libros", es decir, que NO encuentran coincidencia
-- en la tabla de la derecha empleando un "right join":

 --select titulo,nombre
 -- from libros as l
  --right join editoriales as e
 -- on e.codigo=codigoeditorial
--  where codigoeditorial is null;


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

-- Solicitamos el título y nombre de la editorial de los libros
-- empleando un "right join":
select titulo,nombre
  from libros as l
  right join editoriales as e
  on codigoeditorial = e.codigo;

-- Realizamos la misma consulta anterior agregando un "where" que restringa
-- el resultado considerando solamente los registros que encuentran
-- coincidencia en la tabla izquierda:
 select titulo,nombre
  from libros as l
  right join editoriales as e
  on e.codigo=codigoeditorial
  where codigoeditorial is not null;

-- Mostramos las editoriales que no están presentes en "libros" 
-- (que no encuentran coincidencia en "editoriales"): 
 select titulo,nombre
  from libros as l
  right join editoriales as e
  on e.codigo=codigoeditorial
  where codigoeditorial is null;