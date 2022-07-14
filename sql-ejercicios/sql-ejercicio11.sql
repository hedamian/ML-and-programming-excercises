if Object_ID ('articulos') is not null
	drop table articulos;


create table articulos(
codigo integer, nombre varchar(30), 
descripcion varchar(40), precio float, 
cantidad integer);

insert into articulos(codigo, nombre, descripcion, precio, cantidad) values (1,'impresora','epson c45', 400.80,20);
insert into articulos(codigo, nombre, descripcion, precio, cantidad) values (2,'impresora','epson c85', 500,30);
insert into articulos(codigo, nombre, descripcion, precio, cantidad) values (3,'monitor','samsung 14', 800,10);
insert into articulos(codigo, nombre, descripcion, precio, cantidad) values (4,'teclado','ingles biswal', 400.80,50);
insert into articulos(codigo, nombre, descripcion, precio, cantidad) values (5,'teclado','español biswal', 400.80,50);


delete from articulos
	where precio >=500;


delete from articulos
	where nombre='impresora';

delete from articulos
	where codigo<>4;

select * from articulos;
