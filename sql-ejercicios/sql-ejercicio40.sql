--seleccionar grupos having

--la clausula having permite seleccionar o rechazar  un grupo de registros

--la clausula where no es lo mismo que la clausula having . La primera establece condiciones para la seleccion de registros de 
--un select. La segunda establece condiciones para la seleccion de registros de una salida group by

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
insert into libros values('uno','richard bach','Planeta',null,null);	

--cantidad de libros agrupados por editorial, pero considerando solo algunos grupos
--los que devuelven un valor mayor a 2 
select editorial, count(*) from libros
group by editorial 
having count(*)>2;

--promedio de los precios de los libros agrupados por editorial pero solamente de 
--aquellos grupos cuyo promedio supere los 25 pesos

select editorial, avg(precio) from libros
group by editorial 
having avg(precio)>25;

--cantidad de libros sin considerar aquellos que tienen precio nulo (where) agrupados por
--editorial  (group by) , sin considerar la editorial planeta (having)

select editorial,count(*) from libros
group by editorial
having editorial <>'planeta';


--promedio de los precios agrupados por editorial, con mas de 2 libros

select editorial, avg(precio) from libros
group by editorial having count(*)>2;

--mayor valor de los libros agrupados y ordenados por editorial y seleccionamos las filas 
--que tienen un valor 	menor a 100 y mayor a 30

select editorial, max(precio) as 'mayor' from libros
group by editorial having max(precio)<100 and max(precio)>30 
order by editorial;