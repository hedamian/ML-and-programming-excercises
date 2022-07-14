--count()
--ennumera el numero de datos en una base de datos

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

select count(*) from libros;

select count (*) from libros
where editorial='planeta';

--count_big
--realiza un conteo de los registros para una gran cantidad de registros (bigint)
select count_big(*) from libros;	

--contar todas las editoriales sin repetirse
select count_big(distinct editorial) from libros;