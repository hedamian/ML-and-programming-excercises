--Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
--"provincias" donde registra los nombres de las provincias.
--1- Elimine las tablas "clientes" y "provincias", si existen:
  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
   drop table provincias;

--2- Créelas con las siguientes estructuras:
 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint not null,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

--3- Ingrese algunos registros para ambas tablas:
 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje',1);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','Ibera',3);

--4- Obtenga los datos de ambas tablas, usando alias:
 select c.nombre,domicilio,ciudad,p.nombre
  from clientes as c
  join provincias as p
  on c.codigoprovincia=p.codigo;

--5- Obtenga la misma información anterior pero ordenada por nombre de provincia.
 select c.nombre,domicilio,ciudad,p.nombre
  from clientes as c
  join provincias as p
  on c.codigoprovincia=p.codigo
  order by p.nombre;
--6- Recupere los clientes de la provincia "Santa Fe" (2 registros devueltos)
select c.nombre,domicilio, ciudad, p.nombre
from clientes as c
join provincias as p on c.codigoprovincia=p.codigo
where p.nombre='Santa Fe' order by ciudad;