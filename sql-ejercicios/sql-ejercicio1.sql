--crea una base de datos
create database db1;

--ver la estructura de la tabla
exec sp_column usuarios;
--ver los elementos de la tabla
exec sp_table usuarios;
--busca si existe un objeto existente, en este caso la tabla usuarios, si existe, el comando drop_table la elimina

if OBJECT_ID('usuarios') is not null
	drop table usuarios;


--crea una tabla
create table usuarios(nombre varchar(30),clave varchar(10));

--inserta una fila 
insert into usuarios(nombre, clave) values('mariano', '123abc');

--recuperar los registros anteriores . * es para recuperar todas las columnas
select * from usuarios;

insert into usuarios(nombre, clave) values('ana', 'hola123');
select * from usuarios;
