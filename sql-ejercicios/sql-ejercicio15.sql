--null es un valor o elemento vacio ,aclarando si en los elementos de la tabla null<>elemento sin escribir 
--es permitido o no valores nulos

if object_id('libros') is not null
	drop table libros;


create table libros (
titulo varchar(30) is not null,
autor varchar(30)  null,
editorial varchar(30) is not null,
precio float);

--null no lleva comillas. si se pone null en un elemento que no admite null, marca error 
insert into libros(titulo,autor,editorial,precio) values('el aleph', 'borges', 'emece',null);

--insert into libros(titulo,autor,editorial,precio) values ('don quijote de la mancha','cervantes',null, 80);
insert into libros(titulo, autor, editorial,precio) values('','richard bach', 'planeta',22);

exec sp_columns libros;

select * from libros
	where precio is null;

select * from libros
	where precio=0;

select * from libros
	where editorial is null;

select * from libros
	where editorial ='';


select * from libros 
	where precio is not null;
