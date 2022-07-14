if Object_ID('usuarios') is not null
    drop table usuarios;

create table usuarios(nombre varchar(100), clave varchar(10));

go

exec sp_columns usuarios;

insert into usuarios (nombre, clave ) values ('marcelo','clave');
insert into usuarios (nombre, clave) values ('juan perez','juanito');
insert into usuarios (nombre, clave) values ('susana', 'river');
insert into usuarios (nombre,clave) values ('luis', 'river');


--recuperar el usuario cuyo nombre es leonardo

select * from usuarios
    where nombre ='leonardo';

--recuperamos el nombre de los usuarios cuya clave es river 
select * from usuarios  
    where clave = 'river';

--recuperamos el nombre de los usuarios cuya clave es santi

select * from usuarios  
    where clave = 'santi'