--order

--select * from tablename
--		order by field;

--de menor a mayor asc
--de mayor a menor desc
--no funciona para campos de tipo text,ntext o image


if object_id('libros') is not null
	drop table libros;

create table libros(
codigo int identity,
titulo varchar(40) not null,
autor varchar (20) default 'Desconocido',
editorial varchar (20),
precio decimal(6,2),
primary key (codigo));

go   


insert into libros(titulo,autor,editorial,precio) values('el aleph','jorge luis borges', 'emece',25.33);
insert into libros values('java en 10 minutos','mario molina', 'siglo xxi', 50.65);
insert into libros values('1984','george orwell','emece',19.95);
insert into libros values('1984','george orwell','planeta',15.00);

--recuperamos los registros por el titulo

select * from libros
	order by titulo;

--ordenamos los registros  por el campo precio referenciando el campo por su posicion en la lista de seleccion
select titulo, precio, autor from libros
	order by 3;

--ordenamos por editorial de mayor a menor 

select * from libros
	order by editorial desc;

--ordenar en distintos sentidos

select * from libros
	order by titulo asc, editorial desc;

--ordenar un campo que no se lista en la seleccion

select titulo, autor from libros
	order by precio;

--ordenar por un valor calculado

select titulo, autor ,editorial, precio+(precio*0.1) as 'precio con descuento' from libros
 order by 4;