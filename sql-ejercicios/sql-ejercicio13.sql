if object_id('agenda') is not null
	drop table agenda;


create table agenda(
	apellido varchar (20), 
	nombre varchar(20),
	domicilio varchar(50),
	telefono varchar(10));


Insert into agenda(apellido,nombre,domicilio,telefono) values ('acosta','alberto','colon 123','4234567');
Insert into agenda(apellido,nombre,domicilio,telefono) values ('juarez','juan','avellanada 135',4458787);
Insert into agenda(apellido,nombre,domicilio,telefono) values ('lopez','maria','urquiza 333','4545454');
Insert into agenda(apellido,nombre,domicilio,telefono) values ('lopez','jose','urquiza 333','4545454');
Insert into agenda(apellido,nombre,domicilio,telefono) values ('suarez','susana','gra. paz 1234','4123456');

select * from agenda;

update agenda set nombre='juan jose'
	where nombre='juan';

update agenda set telefono='4455666'
	where telefono='4545454';

update agenda set nombre='juan jose'
	where nombre='juan';

select * from agenda;