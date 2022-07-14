if object_id('libros') is not null
	drop table libros;



create table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30),
editorial varchar(20)
);

go 

--si ingresamos valores para todos los campos, podemos omitir la lista  de campos

insert into libros values('uno','richard bach','Planeta');

select * from libros;


insert into libros(titulo,autor) values ('el aleph','borges');

select * from libros;

