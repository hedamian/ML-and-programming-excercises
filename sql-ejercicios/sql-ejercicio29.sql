if object_id('agenda') is not null
	drop table agenda;


create table agenda(
nombre varchar(30),
domicilio varchar(50),
telefono varchar(11));

go

insert into agenda values ('juan perez', 'avellanada 1234','4545454');
insert into agenda values ('martha lopez', 'sucre 123','4556688');
insert into agenda values ('carlos garcia', 'sarmiento 1258	',null);

select nombre as nombreyapellido,domicilio, telefono from agenda;

select nombre as 'nombre y apellido',domicilio, telefono from agenda;


select nombre as 'nombre y apellido',domicilio, telefono from agenda;
