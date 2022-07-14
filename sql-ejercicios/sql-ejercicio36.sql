--operadores logicos 

--and 'y'
--or 'y/o'
-- not 'no', invierte el resultado
--() parentesis

--not before and 
--and before or 

--null
--not null

--between (entre 2 valores) numericos, valor monetario y fechas

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


select * from libros
	where autor='borges' or editorial='planeta' and precio<=20;


select * from libros
 where not editorial ='planeta';


select * from libros 
where (autor='borges') or (editorial='paidos' and precio<20);

select * from libros
where editorial is null;

select * from libros
where editorial is not null;

select * from libros 
where precio between 20 and 40;

select * from libros	
where precio not between 20 and 35;


--operador in
--se usa para averiguar si el valor  de un campo esta incluido en una lista de valores especificada 

select * from libros where autor in ('jorge luis borges','george orwell' );

select * from libros where autor not in ('jorge luis borges','george orwell' );