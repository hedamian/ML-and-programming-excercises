--checa si hay una tabla de nombre usuarios, si es asi, drop table quita esa tabla

if object_id('usuarios') is not null
	drop table usuarios;

create table usuarios(
nombre varchar(30),clave varchar(10));

insert into usuarios (nombre, clave) values ('marcelo', 'river');
insert into usuarios (nombre, clave) values ('susana', 'chapita');
insert into usuarios (nombre, clave) values ('carlos', 'boca');
insert into usuarios (nombre, clave) values ('federico', 'boca');

select * from usuarios;


--actualiza los elementos de la base de datos, update los actualiza y set selecciona el campo a modificar y despues el elemento a 
--reemplazar 
update usuarios	set clave='realmadrid'
	where nombre ='federico';

select * from usuarios;

update usuarios	set clave='boca'
	where nombre ='federico';


update usuarios	set clave='payaso'
	where nombre ='juana';

select * from usuarios;

--reemplaza multiples valores en la tabla 
update usuarios set nombre='marcelo duarte', clave='marco'
		where nombre='marcelo'

select * from usuarios;