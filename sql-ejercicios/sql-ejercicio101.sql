--Tipo de dato definido por el usuario (eliminar)

--Podemos eliminar un tipo de dato definido por el usuario con el procedimiento almacenado "sp_droptype":

--exec sp_droptype TIPODEDATODEFINIDOPORELUSUARIO;

--Eliminamos el tipo de datos definido por el usuario llamado "tipo_documento":

--exec sp_droptype tipo_documento;

--Si intentamos eliminar un tipo de dato inexistente, aparece un mensaje indicando que no existe.

--Los tipos de datos definidos por el usuario se almacenan en la tabla del sistema "systypes".
--Podemos averiguar si un tipo de dato definido por el usuario existe para luego eliminarlo:

--if exists (select *from systypes
--where name = 'NOMBRETIPODEDATODEFINIDOPORELUSUARIO')
--exec sp_droptype TIPODEDATODEFINIDOPORELUSUARIO;

--Consultamos la tabla "systypes" para ver si existe el tipo de dato "tipo_documento", 
--si es así, lo eliminamos:

--if exists (select *from systypes
--where name = 'tipo_documento')
--exec sp_droptype tipo_documento;

--No se puede eliminar un tipo de datos definido por el usuario si alguna tabla (u otro objeto) 
--hace uso de él; por ejemplo, si una tabla tiene un campo definido con tal tipo de dato.

--Si eliminamos un tipo de datos definido por el usuario, desaparecen las asociaciones de las 
--reglas y valores predeterminados, pero tales reglas y valores predeterminados, no se eliminan, 
--siguen existiendo en la base de datos.

if object_id('alumnos') is not null
  drop table alumnos;

-- Definimos un nuevo tipo de dato llamado "tipo_documento".
-- Primero debemos eliminarlo, si existe, para volver a crearlo:
if exists (select *from systypes
  where name = 'tipo_documento')
  exec sp_droptype tipo_documento;

--Creamos un tipo de dato definido por el usuario llamado "tipo_documento"
-- basado en el tipo "char" que permita 8 caracteres y valores nulos:
exec sp_addtype tipo_documento, 'char(8)', 'null';

-- Eliminamos la regla "RG_documento" si existe:
if object_id ('RG_documento') is not null
   drop rule RG_documento;

go

-- Creamos la regla que permita 8 caracteres que solamente serán dígitos:
create rule RG_documento
  as @documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';

go

-- Asociamos la regla al tipo de datos "tipo_documento":
exec sp_bindrule RG_documento, 'tipo_documento';

-- Creamos la tabla "alumnos":
create table alumnos(
  nombre varchar(30),
  documento tipo_documento
);

-- No podemos eliminar el tipo de dato "tipo_documento" porque hay una
-- tabla "alumnos" que lo utiliza. Entonces eliminamos la tabla:
drop table alumnos;

-- Ahora podemos eliminar el tipo de datos:
exec sp_droptype tipo_documento;

-- Volvemos a crear el tipo de dato:
exec sp_addtype tipo_documento, 'char(8)', 'null';

-- Note que no tiene reglas asociadas:
exec sp_help tipo_documento;

-- Asociamos la regla nuevamente:
exec sp_bindrule RG_documento, 'tipo_documento';