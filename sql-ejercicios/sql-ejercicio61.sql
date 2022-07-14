----Información de valores predeterminados

----Para obtener información de los valores predeterminados podemos emplear los mismos procedimientos almacenados que usamos para las reglas.

--Si empleamos "sp_help", vemos todos los objetos de la base de datos activa (incluyendo los valores predeterminados); en la columna "Object_type" (tipo de objeto) muestra "default".

--Si al procedimiento almacenado "sp_help" le agregamos el nombre de un valor predeterminado, nos muestra el nombre, propietario, tipo y fecha de creación:

-- exec sp_help NOMBREVALORPREDETERMINADO;

--Con "sp_help", no sabemos si los valores predeterminados existentes están o no asociadas a algún campo.

--"sp_helpconstraint" retorna una lista de todas las restricciones que tiene una tabla. También los valores predeterminados asociados; muestra la siguiente información:

--- constraint_type: indica que es un valor predeterminado con "DEFAULT", nombrando el campo al que está asociado.

--- constraint_name: nombre del valor predeterminado.

--- constraint_keys: muestra el texto del valor predeterminado.

--Con "sp_helptext" seguido del nombre de un valor predeterminado podemos ver el texto de cualquier valor predeterminado:

-- exec sp_helptext NOMBREVALORPREDETERMINADO;

--También se puede consultar la tabla del sistema "sysobjects", que nos muestra el nombre y varios datos de todos los objetos de la base de datos actual. La columna "xtype" indica el tipo de objeto, en caso de ser un valor predeterminado aparece el valor "D":

-- select * from sysobjects;

--Si queremos ver todos los valores predeterminados creados por nosotros, podemos tipear:

-- select * from sysobjects
----where xtype='D' and-- tipo valor predeterminado
----name like 'VP%';--búsqueda con comodín
--go es un batch terminator (separador de grupos de comandos, no es un script de sql, sino de microsoft sql)

if object_id ('empleados') is not null
--drop table empleados;
if object_id ('VP_sueldo') is not null
-- drop default VP_sueldo;
if object_id ('VP_seccion') is not null
-- drop default Vp_seccion;

create table empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  seccion varchar(20),
  sueldo decimal(6,2),
  primary key(documento)
);

go

-- Creamos un valor predeterminado para el campo "sueldo":
create default VP_sueldo
 as 500;

go

-- Asociamos el valor predeterminado creado anteriormente al campo "sueldo":
exec sp_bindefault VP_sueldo, 'empleados.sueldo';

go

-- Creamos un valor predeterminado para "seccion":
create default VP_seccion
 as 'Secretaria';

 go

-- Veamos todos los objetos de la base de datos activa:
exec sp_help;

-- Si agregamos al procedimiento almacenado "sp_help" el nombre
-- del valor predeterminado del cual queremos información:
exec sp_help VP_sueldo;

-- Para ver los valores predeterminados asociados a la tabla "empleados" tipeamos:
exec sp_helpconstraint empleados;

-- Asociamos el valor predeterminado a la tabla:
exec sp_bindefault VP_seccion, 'empleados.seccion';

exec sp_helpconstraint empleados;

exec sp_helptext VP_seccion;

-- Deshacemos la asociación del valor predeterminado "VP_sueldo" y lo eliminamos:
exec sp_unbindefault'empleados.sueldo'; 
drop default VP_sueldo;

exec sp_help VP_sueldo;

-- Vemos si el valor predeterminado "VP_seccion" existe consultando la tabla "sysobjects":
select * from sysobjects
--where xtype='D' and
--name like '%seccion%';
