if Object_ID('agenda') is not null
    drop table agenda;


create table agenda(
    apellido varchar(50),
    nombre varchar(50),
    domicilio varchar(50),
    telefono varchar(20)
);

go

exec sp_columns usuarios;

insert into agenda(apellido, nombre,domicilio, telefono) values ('acosta','ana','colon 123', '4234527');
insert into agenda(apellido, nombre,domicilio, telefono) values ('bustamante','bedina','avellanada 135', '4458787');
insert into agenda(apellido, nombre,domicilio, telefono) values ('lopez','hector','salta 545', '4887788');
insert into agenda(apellido, nombre,domicilio, telefono) values ('lopez','luis','urquiza 333', '4545454');
insert into agenda(apellido, nombre,domicilio, telefono) values ('lopez','marisa','urquiza 333', '4545454');

select * from agenda;

select * from agenda 
    where nombre = 'marisa';

select nombre,domicilio from agenda 
    where apellido= 'lopez';

select nombre  from agenda
    where telefono='4545454';