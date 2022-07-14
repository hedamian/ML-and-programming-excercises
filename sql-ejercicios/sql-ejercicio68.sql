--Un profesor guarda algunos datos de sus alumnos en una tabla llamada "alumnos".
--1- Elimine la tabla si existe y créela con la siguiente estructura:
 if object_id('alumnos') is not null
  drop table alumnos;

 create table alumnos(
  legajo char(5) not null,
  documento char(8) not null,
  apellido varchar(30),
  nombre varchar(30),
  notafinal decimal(4,2)
 );

go
--2- Cree un índice no agrupado para el campo "apellido".
create index i_apellido on alumnos(apellido);
--3- Establezca una restricción "primary" para el campo "legajo" y especifique que cree un índice "agrupado".

--4- Vea la información que muestra "sp_helpindex":
  exec sp_helpindex alumnos;

--5- Intente eliminar el índice "PK_alumnos_legajo" con "drop index":
 --drop index PK_alumnos_legajo;
--No se puede.

--6- Intente eliminar el índice "I_alumnos_apellido" sin especificar el nombre de la tabla:
 --drop index I_alumnos_apellido;
--Mensaje de error.

--7- Elimine el índice "I_alumnos_apellido" especificando el nombre de la tabla.
drop index alumnos.i_apellido;
--8- Verifique que se eliminó:
 exec sp_helpindex alumnos;

--9- Solicite que se elimine el índice "I_alumnos_apellido" si existe:
 if exists (select name from sysindexes
  where name = 'I_alumnos_apellido')
   drop index alumnos.I_alumnos_apellido;

--10- Elimine el índice "PK_alumnos_legajo" (quite la restricción).

--11- Verifique que el índice "PK_alumnos_legajo" ya no existe:
 exec sp_helpindex alumnos;