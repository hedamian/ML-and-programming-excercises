 --busqueda de patrones like-not like
 --existe un operador relacional que se usa para realizar comparaciones exclusivas de cadenas like  y not like

  --select * from libros 
  --where author like '%borges%'

  --% reemplaza cualquier cantidad de caracteres (incluyendo ningun caracter) . es un caracter comodin
  --like y not like son operadores de comparacion que indican igualdad o diferencia

  --select * from libros
  --where titulo not like 'M%'

  --like , not like se puede usar en tipos de datos char,varchar,nchar,nvarchar, datetime
  --si se emplea like en datos que no son caracteres, sql tratara de convertir los valores a caracteres

  if object_id('libros') is not null
	drop table libros;

create table libros(
codigo int identity,
titulo varchar(40) not null,
autor varchar (20) default 'Desconocido',
editorial varchar (20),
precio decimal(6,2),
primary key (codigo));


insert into libros(titulo,autor,editorial,precio) values('el aleph','jorge luis borges', 'emece',25.33);
insert into libros values('java en 10 minutos','mario molina', 'siglo xxi', 50.65);
insert into libros values('1984','george orwell','emece',19.95);
insert into libros values('1984','george orwell','planeta',15.00);
insert into libros values ('martin fierro', 'jose hernandez', 'paidos',16.80);
insert into libros values ('cervantes y el quijote', 'jorge luis borges','paidos',18.40);
insert into libros values('fahrenheit 451','bradbury', null,40.34);

--recuperamos todos los libros del autor borges

select * from libros
where autor like '%borges%';


--seleccionamos todos los titulos que comienzen con m
select * from libros 
where titulo like 'm%';

--seleccionamos todos los titulos que no comienzen con m
select * from libros 
where titulo not like 'm%';


--si no recordamos si se escribe orwell o orwel, se usa el comodin '_'

select * from libros
where autor like '%orwel_';

--buscamos los libros cuya editorial comienza entre las letras p y s

select * from libros 
where editorial like '[p-s]%';

--buscamos los libros cuya editorial no comienza ni con p ni con s

select * from libros
where editorial like '[^ps]%';

--recuperar todos los libros cuyo precio se encuentra entre 10 y 19

select titulo, precio from libros
where precio like '1_.%';

