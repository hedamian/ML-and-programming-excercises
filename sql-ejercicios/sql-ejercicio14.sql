if object_id('libros') is not null
	drop table libros;

create table libros(
titulo varchar(30),
autor varchar(30),
editorial varchar(15),
precio float
);


insert into libros(titulo, autor, editorial, precio) values ('el aleph','borges', 'emece',25.50);
insert into libros(titulo, autor, editorial, precio) values ('martin fierro','jose hernandez', 'planeta',35.50);
insert into libros(titulo, autor, editorial, precio) values ('aprenda php','mario molina', 'emece',45.50);
insert into libros(titulo, autor, editorial, precio) values ('cervantes y el quijote','borges', 'emece',25);
insert into libros(titulo, autor, editorial, precio) values ('matematica estas ahi','paenza', 'siglo xxi',15.50);


select * from libros;

update libros set autor='adrian paenza'
	where autor='paenza';

--al invocar este codigo de nuevo, los elementos de la tabla se mantienen intactos ya que no cumple las condiciones 
update libros set autor='adrian paenza'
	if autor='paenza';

update libros set precio=27.00
	where autor='mario molina';

update libros set editorial='emece sa'
	where editorial='emece';

select * from libros;

