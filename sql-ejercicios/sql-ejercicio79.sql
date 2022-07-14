--Combinaciones y funciones de agrupamiento

--Podemos usar "group by" y las funciones de agrupamiento con combinaciones de tablas.

--Para ver la cantidad de libros de cada editorial consultando la tabla "libros" y "editoriales",
--tipeamos:

--select nombre as editorial,
--count(*) as cantidad
--from editoriales as e
--join libros as l
--on codigoeditorial=e.codigo
--group by e.nombre;

--Note que las editoriales que no tienen libros no aparecen en la salida porque empleamos un "join".

--Empleamos otra función de agrupamiento con "left join". Para conocer el mayor precio de 
--los libros de cada editorial usamos la función "max()", hacemos un "left join" y agrupamos
--por nombre de la editorial:

--select nombre as editorial,
--max(precio) as 'mayor precio'
--from editoriales as e
--left join libros as l
--on codigoeditorial=e.codigo
--group by nombre;

--En la sentencia anterior, mostrará, para la editorial de la cual no haya libros, 
--el valor "null" en la columna calculada.


if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
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
insert into libros values('Aprenda PHP','Mario Molina',3,50);
insert into libros values('Uno','Richard Bach',3,15);
insert into libros values('Java en 10 minutos',default,4,45);

-- Contamos la cantidad de libros de cada editorial consultando ambas tablas:
select nombre as editorial,
  count(*) as cantidad
  from editoriales as e
  join libros as l
  on codigoeditorial=e.codigo
  group by e.nombre;

-- Buscamos el libro más costoso de cada editorial con un "left join":
select nombre as editorial,
  max(precio) as 'mayor precio'
  from editoriales as e
  left join libros as l
  on codigoeditorial=e.codigo
  group by nombre;