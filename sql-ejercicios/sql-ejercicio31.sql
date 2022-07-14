if object_id('libros') is not null
	drop table libros;

create table libros(
codigo int identity,
titulo varchar(30),
autor varchar(30) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
cantidad tinyint default 0,
primary key (codigo));

insert into libros(titulo,autor, editorial,precio) values ('el aleph','borges', 'emece',25);

insert into libros values ('java en 10 minutos','mario molina', 'siglo xxi',50.40,100);

insert into libros (titulo, autor, editorial,precio,cantidad) values('1984','george orwell','emece',15,50);

--mostrar solo los primeros 12 caracteres de los titulos de los libros y sus autores con substring
select substring(titulo,1,12) as titulo from libros;

--mostrar solo los primeros 12 caracteres de los titulos de libros desde la izquierda
select left(titulo,12) as titulo from libros;

--mostrar los titulos de los libros y sus precios convirtiendo este ultimo a cadena de caracteres con un solo decimal

select titulo,str(precio,6,1) from libros;

select  titulo,str(precio) from libros;

--mostrar todos los titulos, autores y editorial, con el ultimo campo en mayusculas

select titulo, autor, upper(editorial) from libros;