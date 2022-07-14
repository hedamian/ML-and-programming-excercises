if object_id('libros') is not null  
  drop table libros;

--decimal (digitos,decimales) tinyint int <255
--default genera el valor por defecto en caso de ser valor desconocido pero no nulo
create table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30) not null  default 'Desconocido',
editorial varchar(20),
precio decimal(5,2),
cantidad tinyint default 0);

go 

exec sp_columns libros;

insert into libros(titulo, autor,precio,cantidad) values ('gato con botas',default,default,100);



insert into libros(titulo, editorial,precio) values ('java en 10 minutos','paidos',50.4);


insert into libros(titulo,editorial) values ('aprenda php','siglo xxi');


insert into libros default values;

insert into libros(titulo, autor,cantidad) values ('1984','george orwell',null);

  select * from libros;
