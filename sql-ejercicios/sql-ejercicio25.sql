if object_id('empleados') is not null
	drop table empleados;



create table empleados(
name varchar(30),
document char(8),
date_a datetime
);


go 

--formato de fecha. day month year. date formar 'm.d.y', m/d/y, 'm-d-y'
set dateformat dmy;

insert into empleados(name, document,date_a) values ('ana gomez', '22222222', '12-01-1980');
insert into empleados(name, document,date_a) values ('bernardo huerta', '23333333', '15-03-81');
insert into empleados(name, document,date_a) values ('carla juarez', '24444444', '20/05/1983');
insert into empleados(name, document,date_a) values ('daniel lopez', '25555555', '2.5.1990');


select * from empleados
	where date_a <'01-01-1985';

select * from empleados;

update empleados set name='maria carla juarez'
	where date_a='20.5.83';

select * from empleados;

delete from empleados	
	where date_a <>'20/05/1983';