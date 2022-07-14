    if Object_ID('usuarios') is not null
        drop table usuarios;

    create table usuarios(nombre varchar(100), clave varchar(10));

    go

    exec sp_columns usuarios;

    insert into usuarios (nombre, clave ) values ('marcelo','clave');
    insert into usuarios (nombre, clave) values ('juan perez','juanito');
    insert into usuarios (nombre, clave) values ('susana', 'river');
    insert into usuarios (nombre,clave) values ('luis', 'river');

    --borrar  el registro marcelo


    delete from usuarios 
        where nombre = 'marcelo';

    select * from usuarios;


    delete from usuarios 
        where nombre = 'marcelo';

    delete from usuarios 
        where clave = 'river';

    select * from usuarios;

    delete from usuarios;

    select * from usuarios ;
