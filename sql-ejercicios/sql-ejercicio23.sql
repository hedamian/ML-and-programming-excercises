if object_id('visitantes') is not null
	drop table visitantes;

create table visitantes(
nombre varchar(30),
edad integer,
	sexo char(1),
	domicilio varchar(30),
	ciudad varchar(30),
	telefono varchar(11)
);


go 

insert into visitantes(nombre,edad,sexo,domicilio,ciudad,telefono) values ('marcela morales',39,'f','avellanada 1234','cordoba',4567890);

select * from visitantes;


