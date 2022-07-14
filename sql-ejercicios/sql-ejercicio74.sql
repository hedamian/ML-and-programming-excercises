--Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
--"provincias" donde registra los nombres de las provincias.
--1- Elimine las tablas "clientes" y "provincias", si existen y cree las tablas:
  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
   drop table provincias;

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

-- Ingrese algunos registros para ambas tablas:
 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','La Plata',4);
 insert into clientes values ('Garcia Luis','Sucre 475','Santa Rosa',5);

-- Muestre todos los datos de los clientes, incluido el nombre de la provincia:
 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo;

-- Realice la misma consulta anterior pero alterando el orden de las tablas:
 select c.nombre,domicilio,ciudad, p.nombre
  from provincias as p
  left join clientes as c
  on codigoprovincia = p.codigo;

-- Muestre solamente los clientes de las provincias que existen en "provincias" (5 registros):
 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo
  where p.codigo is not null;

-- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
--nombre del cliente (2 registros):
 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo
  where p.codigo is null
  order by c.nombre;

--Obtenga todos los datos de los clientes de "Cordoba" (3 registros):
 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo
  where p.nombre='Cordoba';