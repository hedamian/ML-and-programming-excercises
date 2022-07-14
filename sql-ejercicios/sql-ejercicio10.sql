if object_id ('agenda') is not null
	drop table agenda;

create table agenda(
apellido varchar(30),
nombre varchar(20),
domicilio varchar(30),
telefono varchar (10));

insert into agenda (apellido, nombre , domicilio,telefono) values ('alvarez', 'alberto', 'colon 123', '4234567');
insert into agenda (apellido, nombre , domicilio,telefono) values ('juarez', 'juan', 'avellanada 135', '4458787');
insert into agenda (apellido, nombre , domicilio,telefono) values ('lopez', 'maria', 'urquiza 333', '4545454');
insert into agenda (apellido, nombre , domicilio,telefono) values ('lopez', 'jose', 'urquiza 333', '4545454');
insert into agenda (apellido, nombre , domicilio,telefono) values ('salas', 'susana', 'gra. paz 1234', '4123456');

--elimina elementos de una tabla 
delete from agenda	
	where nombre='juan';

delete from agenda
	where telefono ='4545454';

select * from agenda;

delete from agenda;

select * from agenda;
