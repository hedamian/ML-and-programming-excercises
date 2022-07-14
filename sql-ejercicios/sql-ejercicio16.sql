--una clave primaria es un campo (o varios) que identifica un solo registro (fila) en una tabla
--para un valor clave existe solamente un registro 

--sintaxis
--create table tablename(
--type field ,
--...
--primary key fieldname  )

if object_id('usuarios') is not null
	drop table usuarios;

create table usuarios(
nombre varchar(20),
clave varchar(10),
primary key (nombre)
);

go


exec sp_columns usuarios;

insert into usuarios(nombre,clave) values ('juan perez','boca');
insert into usuarios(nombre, clave) values ('raul garcia','river');


--si se inserta de nuevo un valor de clave primaria, sql marca error 
--insert into usuarios(nombre,clave) values ('juan perez','cornflake');

