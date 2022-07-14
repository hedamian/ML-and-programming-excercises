if object_id('libros') is not null
	drop table libros;


create table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30) not null  default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
cantidad tinyint default 0
primary key (codigo));

go 

insert into libros(titulo, autor, editorial,precio) values ('el aleph','borges','emece',25);
insert into libros values('java en 10 minutos','mario molina', 'siglo xxi',50.4,100);
insert into libros(titulo, autor, editorial,precio,cantidad) values ('rebelion en la granja','orwell','emece',15,50);

--queremos saber el monto total en dinero de cada libro, asi se genera una nueva columna con la informacion requerida 

select titulo,precio, cantidad, precio*cantidad from libros;

--queremos conocer el precio con 10% de descuento

select titulo,precio, precio-(precio*0.1) from libros;

select * from libros;

--queremos una columna con el titulo, autor y la editorial de cada libro

select titulo+'-'+autor+'-'+editorial from libros;