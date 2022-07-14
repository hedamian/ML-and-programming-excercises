if Object_ID('articulos ') is not null  
    drop table articulos;

create table articulos(
    codigo integer, 
    nombre varchar(40),
    descripcion varchar(30),
    precio float, 
    cantidad integer
);

go

exec sp_columns articulos;

insert into articulos(codigo,nombre,descripcion,precio, cantidad) values (1, 'impresora', 'epson stylus c450',400.8,20 );

insert into articulos(codigo,nombre,descripcion,precio, cantidad) values (2, 'impresora', 'epson stylus c80',500,30 );

insert into articulos(codigo,nombre,descripcion,precio, cantidad) values (3, 'monitor', 'samsung 14',800,10 );

insert into articulos(codigo,nombre,descripcion,precio, cantidad) values (4, 'teclado', 'ingles biswal',100,50 );

insert into articulos(codigo,nombre,descripcion,precio, cantidad) values (5, 'teclado', 'espanol biswal',90,50 );


select * from articulos ;

select * from articulos
    where nombre='impresora';

select * from articulos 
    where precio >= 400;

select nombre, codigo from articulos   
    where cantidad <= 30;

select  nombre, descripcion from articulos
    where precio <>100;