--funciones de agrupamiento group by
--count contador de datos (cualquier tipo), no incluye los valores null
--min y max cualquier tipo de dato
--sum y avg datos numericos
--sum() devuelve la suma de los valores del campo seleccionado
--max() valor maximo de un campo
--min() valor minimo de un campo
--avg() devuelve el valor promedio de un campo seleccionado
--todas las funciones de agregado, excepto "count(*) excluyen los valores null de los campos"
--"count (*) cuenta todos los registros , incluidos los null"

if object_id('libros') is not null
drop table libros;

create table libros(
codigo int identity,
titulo varchar(40) not null,
autor varchar (20) default 'Desconocido',
editorial varchar (20),
precio decimal(6,2),
cantidad tinyint,
primary key (codigo));


insert into libros(titulo,autor,editorial,precio,cantidad) values('el aleph','jorge luis borges', 'emece',25.33,null);
insert into libros values('java en 10 minutos','mario molina', 'siglo xxi', 50.65,200);
insert into libros values('1984','george orwell','emece',19.95,120);
insert into libros values('1984','george orwell','planeta',15.00,null);
insert into libros values ('martin fierro', 'jose hernandez', 'paidos',16.80,null);
insert into libros values ('cervantes y el quijote', 'jorge luis borges','paidos',18.40,65);
insert into libros values('fahrenheit 451','bradbury', null,40.34,35);
insert into libros values('la vuelta al mundo en 80 dias','julio verne', 'planeta', 40.50,50);
insert into libros(titulo, autor,cantidad) values ('php de la a a la z',default,0);

--cantidad de libros de la editorial emece

select sum(cantidad) from libros
where editorial='emece';

--obtener el libro mas caro

select max(precio) from libros;

--cononer el precio minimo de los libros de orwell

select min(precio) from libros
where autor like '%orwel_%';

--obtener el precio promedio de los libros referentes a borges

select avg(precio) from libros
where autor like '%borges%';

--agrupar los libros por editorial 

select editorial, count(*) from libros
group by editorial;

--select 'field1','field2',... ,add function from 'tablename'
--group by 'field';

--suma total de los precios, agrupados por editorial
Select editorial, sum(precio) from libros group by editorial;


--valor promedio de los libros agrupado por editorial
select editorial, avg(precio) from libros group by editorial;

--seleccionar solamente los libros cuyo precio es menor a 30

select editorial, count(*) from libros
where precio<30
 group by editorial ;

 --seleccionar todos los libros cuyo precio es menor a 30

select editorial, count(*) from libros
where precio<30
 group by all editorial ;

  --maximo y minimo valor de los precios de los libros 
 select editorial, 
 max(precio) as mayor, 
 min(precio) as menor 
 from libros
 group by editorial;