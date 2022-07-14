--Tipo de dato definido por el usuario (crear - informacion)

--Cuando definimos un campo de una tabla debemos especificar el tipo de datos, sabemos que los
--tipos de datos especifican el tipo de información (caracteres, números, fechas) que pueden 
--almacenarse en un campo. SQL Server proporciona distintos tipos de datos del sistema 
--(char, varchar, int, decimal, datetime, etc.) y permite tipos de datos definidos por 
--el usuario siempre que se basen en los tipos de datos existentes.

--Se pueden crear y eliminar tipos de datos definidos por el usuario.
--Se emplean cuando varias tablas deben almacenar el mismo tipo de datos en un campo y se
--quiere garantizar que todas tengan el mismo tipo y longitud.

--Para darle un nombre a un tipo de dato definido por el usuario debe considerar las mismas 
--reglas que para cualquier identificador. No puede haber dos objetos con igual nombre en la 
--misma base de datos.

--Para crear un tipo de datos definido por el usuario se emplea el procedimiento almacenado 
--del sistema "sp_addtype". Sintaxis básica:

--exec sp_addtype NOMBRENUEVOTIPO, 'TIPODEDATODELSISTEMA', 'OPCIONNULL';

--Creamos un tipo de datos definido por el usuario llamado "tipo_documento" que admite valores nulos:

--exec sp_addtype tipo_documento, 'char(8)', 'null';

--Ejecutando el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido
--por el usuario se obtiene información del mismo (nombre, el tipo de dato en que se basa, 
--la longitud, si acepta valores nulos, si tiene valor por defecto y reglas asociadas).

--También podemos consultar la tabla "systypes" en la cual se almacena información de todos
--los tipos de datos:

--select name from systypes;


if object_id('alumnos') is not null
  drop table alumnos;

if exists (select *from systypes
  where name = 'tipo_documento')
  exec sp_droptype tipo_documento;

exec sp_addtype tipo_documento, 'char(8)', 'null';

exec sp_help tipo_documento;

create table alumnos(
  documento tipo_documento,
  nombre varchar(30)
);

go

insert into alumnos values('12345678','Ana Acosta');

select * from alumnos;