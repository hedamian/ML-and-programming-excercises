if OBJECT_ID('peliculas') is not null
	drop table peliculas;

create table peliculas(
	nombre varchar(60),	actor varchar(60), duracion integer, #copias integer);

exec sp_columns peliculas;

insert into peliculas(nombre, actor, duracion, #copias) values ('mision imposible', 'tom cruise', 128,3);
insert into peliculas(nombre, actor, duracion, #copias) values ('mision imposible 2', 'tom cruise', 130,2);
insert into peliculas(nombre, actor, duracion, #copias) values ('mujer bonita','julia roberts', 90,3);
insert into peliculas(nombre, actor, duracion, #copias) values ('elsa y fred', 'china zorrilla', 80,2);

select * from peliculas;

select * from peliculas	
	where duracion <=90;

select * from peliculas
	where actor <> 'tom cruise';

select nombre ,	actor, #copias from peliculas
	where #copias > 2;