    if OBJECT_ID('libros') is not null
	drop table libros;

create table libros(
	titulo varchar(80), 
	autor varchar (40), 
	editorial varchar(30), 
	precio float, 
	cantidad integer
	);

exec sp_columns libros;

insert into libros(titulo, autor, editorial, precio, cantidad) values('el aleph','borges','emece',25.50,200);

select * from libros;

insert into libros(titulo, autor, editorial, precio, cantidad) values('la vuelta al mundo en 80 dias','verne','fce',40,140);

select * from libros;


insert into libros(titulo, autor, editorial, precio, cantidad) values('fahrenheit 451','bradbury','colmena',90,200);

insert into libros(titulo, autor, editorial, precio, cantidad) values('100 a\~nos de soledad','gabo','mundi',60,190);


select * from libros
    where autor = 'borges';

select titulo from libros
    where editorial='colmena';

select editorial from libros 
    where titulo='el aleph';

select * from libros
    where titulo <> 'el aleph'