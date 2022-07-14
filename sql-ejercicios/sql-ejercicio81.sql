----combinancion de mas de 2 tablas 

--Podemos hacer un "join" con más de dos tablas.

--Cada join combina 2 tablas. Se pueden emplear varios join para enlazar varias tablas.
-- Cada resultado de un join es una tabla que puede combinarse con otro join.

--La librería almacena los datos de sus libros en tres tablas: libros, editoriales y autores.
--En la tabla "libros" un campo "codigoautor" hace referencia al autor y un campo "codigoeditorial" 
--referencia la editorial.

--Para recuperar todos los datos de los libros empleamos la siguiente consulta:

--select titulo,a.nombre,e.nombre
--from autores as a
--join libros as l
--on codigoautor=a.codigo
--join editoriales as e  on codigoeditorial=e.codigo;

--Analicemos la consulta anterior. Indicamos el nombre de la tabla luego del "from" ("autores"), 
--combinamos esa tabla con la tabla "libros" especificando con "on" el campo por el cual se combinarán; 
--luego debemos hacer coincidir los valores para el enlace con la tabla "editoriales" enlazándolas por 
--los campos correspondientes. Utilizamos alias para una sentencia más sencilla y comprensible.

--Note que especificamos a qué tabla pertenecen los campos cuyo nombre se repiten en las tablas, 
--esto es necesario para evitar confusiones y ambiguedades al momento de referenciar un campo.

--Note que no aparecen los libros cuyo código de autor no se encuentra en "autores" y cuya editorial
-- no existe en "editoriales", esto es porque realizamos una combinación interna.

--Podemos combinar varios tipos de join en una misma sentencia:

--select titulo,a.nombre,e.nombre
--from autores as a
--right join libros as l
--on codigoautor=a.codigo
--left join editoriales as e  on codigoeditorial=e.codigo;

--En la consulta anterior solicitamos el título, autor y editorial de todos los libros que encuentren o no coincidencia con "autores" ("right join") y a ese resultado lo combinamos con "editoriales", encuentren o no coincidencia.

--Es posible realizar varias combinaciones para obtener información de varias tablas. Las tablas deben tener claves externas relacionadas con las tablas a combinar.

--En consultas en las cuales empleamos varios "join" es importante tener en cuenta el orden de las
--tablas y los tipos de "join"; recuerde que la tabla resultado del primer join es la que se combina
-- con el segundo join, no la segunda tabla nombrada. En el ejemplo anterior, el "left join" 
-- no se realiza entre las tablas "libros" y "editoriales" sino entre el resultado del "right join" 
-- y la tabla "editoriales".

if object_id('libros') is not null
  drop table libros;
if object_id('autores') is not null
  drop table autores;
if object_id('editoriales') is not null
  drop table editoriales;

create table libros(
  codigo int identity,
  titulo varchar(40),
  codigoautor int not null,
  codigoeditorial tinyint not null,
  precio decimal(5,2),
  primary key(codigo)
);

create table autores(
  codigo int identity,
  nombre varchar(20),
  primary key (codigo)
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
insert into editoriales values('Plaza');
 
insert into autores values ('Richard Bach');
insert into autores values ('Borges');
insert into autores values ('Jose Hernandez');
insert into autores values ('Mario Molina');
insert into autores values ('Paenza');
 
insert into libros values('El aleph',2,2,20);
insert into libros values('Martin Fierro',3,1,30);
insert into libros values('Aprenda PHP',4,3,50);
insert into libros values('Uno',1,1,15);
insert into libros values('Java en 10 minutos',0,3,45);
insert into libros values('Matematica estas ahi',0,0,15);
insert into libros values('Java de la A a la Z',4,0,50);

-- Recuperamos todos los datos de los libros consultando las tres tablas:
select titulo,a.nombre,e.nombre,precio
  from autores as a
  join libros as l
  on codigoautor=a.codigo
  join editoriales as e
  on codigoeditorial=e.codigo;

-- Podemos combinar varios tipos de join en una misma sentencia:
select titulo,a.nombre,e.nombre,precio
  from autores as a
  right join libros as l
  on codigoautor=a.codigo
  left join editoriales as e
  on codigoeditorial=e.codigo;