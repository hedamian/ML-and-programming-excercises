--Subconsulta simil autocombinación

--Algunas sentencias en las cuales la consulta interna y la externa emplean la misma 
--tabla pueden reemplazarse por una autocombinación.

--Por ejemplo, queremos una lista de los libros que han sido publicados por distintas editoriales.

--select distinct l1.titulo
--from libros as l1
--where l1.titulo in
--(select l2.titulo
--from libros as l2 
--where l1.editorial <> l2.editorial);

--En el ejemplo anterior empleamos una subconsulta correlacionada y las consultas interna y
--externa emplean la misma tabla. La subconsulta devuelve una lista de valores por ello se
--emplea "in" y sustituye una expresión en una cláusula "where".

--Con el siguiente "join" se obtiene el mismo resultado:

--select distinct l1.titulo
--from libros as l1
--join libros as l2
--on l1.titulo=l2.titulo and
--l1.autor=l2.autor 
--where l1.editorial<>l2.editorial;

--Otro ejemplo: Buscamos todos los libros que tienen el mismo precio que "El aleph" empleando
--subconsulta:

--select titulo
--from libros
--where titulo<>'El aleph' and
--precio =
--(select precio
--from libros
--where titulo='El aleph');

--La subconsulta retorna un solo valor.

--Buscamos los libros cuyo precio supere el precio promedio de los libros por editorial:

--select l1.titulo,l1.editorial,l1.precio
--from libros as l1
--where l1.precio >
--(select avg(l2.precio) 
--from libros as l2
--where l1.editorial= l2.editorial);

--Por cada valor de l1, se evalúa la subconsulta, si el precio es mayor que el promedio.

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2)
);

go

insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI',40.00);
insert into libros values('El aleph','Borges','Emece',10.00);
insert into libros values('Ilusiones','Richard Bach','Planeta',15.00);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
insert into libros values('Martin Fierro','Jose Hernandez','Planeta',20.00);
insert into libros values('Martin Fierro','Jose Hernandez','Emece',30.00);
insert into libros values('Uno','Richard Bach','Planeta',10.00);

-- Obtenemos la lista de los libros que han sido publicados por distintas editoriales
--  empleando una consulta correlacionada:
 select distinct l1.titulo
  from libros as l1
  where l1.titulo in
  (select l2.titulo
  from libros as l2 
  where l1.editorial <> l2.editorial);

-- El siguiente "join" retorna el mismo resultado:
select distinct l1.titulo
  from libros as l1
  join libros as l2
  on l1.titulo=l2.titulo
  where l1.editorial<>l2.editorial;

-- Buscamos todos los libros que tienen el mismo precio
-- que "El aleph" empleando subconsulta:
select titulo
  from libros
  where titulo<>'El aleph' and
  precio =
   (select precio
   from libros 
   where titulo='El aleph');

-- Obtenemos la misma salida empleando "join":
select l1.titulo
  from libros as l1
  join libros  as l2
  on l1.precio=l2.precio
  where l2.titulo='el aleph' and
  l1.titulo<>l2.titulo;

-- Buscamos los libros cuyo precio supera el precio promedio 
-- de los libros por editorial:
select l1.titulo,l1.editorial,l1.precio
  from libros as l1
  where l1.precio >
   (select avg(l2.precio) 
   from libros as l2
  where l1.editorial= l2.editorial);

-- Obtenemos la misma salida pero empleando un "join" con "having":
 select l1.editorial,l1.titulo,l1.precio
  from libros as l1
  join libros as l2
   on l1.editorial=l2.editorial
   group by l1.editorial, l1.titulo, l1.precio
   having l1.precio > avg(l2.precio);