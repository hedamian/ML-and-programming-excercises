----Tipo de dato definido por el usuario (asociación de reglas)

--Se puede asociar una regla a un tipo de datos definido por el usuario.
--Luego de crear la regla se establece la asociación; la sintaxis es la siguiente:

--exec sp_bindrule NOMBREREGLA, 'TIPODEDATODEFINIDOPORELUSUARIO', 'futureonly';

--El parámetro "futureonly" es opcional, especifica que si existen campos (de cualquier tabla) 
--con este tipo de dato, no se asocien a la regla; si creamos una nueva tabla con este tipo de dato,
--si deberán cumplir la regla. Si no se especifica este parámetro, todos los campos de este 
--tipo de dato, existentes o que se creen posteriormente (de cualquier tabla), 
--quedan asociados a la regla.

--Recuerde que SQL Server NO controla los datos existentes para confirmar que cumplen con la regla, 
--si no los cumple, la regla se asocia igualmente; pero al ejecutar una instrucción "insert" o "update" 
--muestra un mensaje de error.

--Si asocia una regla a un tipo de dato definido por el usuario que tiene otra regla asociada,
--esta última la reemplaza.

--Para quitar la asociación, empleamos el mismo procedimiento almacenado que aprendimos
--cuando quitamos asociaciones a campos, ejecutamos el procedimiento almacenado "sp_unbindrule" 
--seguido del nombre del tipo de dato al que está asociada la regla:

--exec sp_unbindrule 'TIPODEDATODEFINIDOPORELUSUARIO';

--Si asocia una regla a un campo cuyo tipo de dato definido por el usuario ya tiene una regla
--asociada, la nueva regla se aplica al campo, pero el tipo de dato continúa asociado a la regla. 
--La regla asociada al campo prevalece sobre la asociada al tipo de dato. Por ejemplo, 
--tenemos un campo "precio" de un tipo de dato definido por el usuario "tipo_precio", 
--este tipo de dato tiene asociada una regla "RG_precio0a99" (precio entre 0 y 99), 
--luego asociamos al campo "precio" la regla "RG_precio100a500" (precio entre 100 y 500); 
--al ejecutar una instrucción "insert" admitirá valores entre 100 y 500, es decir,
--tendrá en cuenta la regla asociada al campo, aunque vaya contra la regla asociada al tipo de dato.

--Un tipo de dato definido por el usuario puede tener una sola regla asociada.

--Cuando obtenemos información del tipo da dato definido por el usuario ejecutando "sp_help", 
--en la columna "rule_name" se muestra el nombre de la regla asociada a dicho tipo de dato;
--muestran "none" cuando no tiene regla asociada.

if object_id('alumnos') is not null
  drop table alumnos;
if object_id('docentes') is not null
  drop table docentes;

if exists (select *from systypes
  where name = 'tipo_documento')
  exec sp_droptype tipo_documento;

-- Creamos un tipo de dato definido por el usuario llamado 
-- "tipo_documento" basado en el tipo "char" que permita 8 caracteres
-- y valores nulos:
exec sp_addtype tipo_documento, 'char(8)', 'null';

exec sp_help tipo_documento;

create table alumnos(
  documento tipo_documento,
  nombre varchar(30)
);

go

if object_id ('RG_documento') is not null
   drop rule RG_documento;

go 

-- Creamos la regla que permita 8 caracteres que solamente pueden ser
-- dígitos del 0 al 5 para el primer dígito y de 0 al 9 para los siguientes:
create rule RG_documento
  as @documento like '[0-5][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';

go

-- Asociamos la regla al tipo de datos "tipo_documento" especificando que 
-- solamente se aplique a los futuros campos de este tipo:
exec sp_bindrule RG_documento, 'tipo_documento', 'futureonly';

exec sp_helpconstraint alumnos;

create table docentes(
  documento tipo_documento,
  nombre varchar(30)
);

-- Verificamos que se aplicó la regla en la nueva tabla:
exec sp_helpconstraint docentes;

-- Ingresamos un registro en "alumnos" con valores para documento que infrinjan la regla,
-- Lo acepta porque en esta tabla no se aplica la regla. 
-- Pero no podríamos ingresar un valor como el anterior en la tabla "docentes"
-- la cual si tiene asociada la regla.
insert into alumnos values('a111111','Ana Acosta');

-- Quitamos la asociación:
exec sp_unbindrule 'tipo_documento';

-- Volvemos a asociar la regla, ahora sin el parámetro "futureonly":
exec sp_bindrule RG_documento, 'tipo_documento';

-- Verificamos que se aplicó la regla en ambas tablas:
exec sp_helpconstraint docentes;
exec sp_helpconstraint alumnos;

-- Eliminamos si existe, la regla "RG_documento2":
if object_id ('RG_documento2') is not null
   drop rule RG_documento2;

go

-- Creamos la regla llamada "RG_documento2" que permita 8 caracteres 
-- que solamente pueden ser dígitos del 0 al 9 para todas las posiciones:
create rule RG_documento2
  as @documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';

go

-- Asociamos la regla al tipo de datos "tipo_documento" (ya tiene una regla asociada):
exec sp_bindrule RG_documento2, 'tipo_documento';

--Veamos si la asociación fue reemplazada en el tipo de datos:
exec sp_help tipo_documento;

-- Veamos si la asociación fue reemplazada en las tablas:
exec sp_helpconstraint alumnos;
exec sp_helpconstraint docentes;

-- Asociamos la regla "RG_documento" al campo "documento" de "alumnos":
exec sp_bindrule RG_documento, 'alumnos.documento';

-- Verificamos que "documento" de "alumnos" tiene asociada la regla "RG_documento":
exec sp_helpconstraint alumnos;

-- Verificamos que el tipo de dato "tipo_documento" tiene asociada la regla "RG_documento2":
exec sp_help tipo_documento;

-- Intentamos ingresar un valor para "documento" aceptado por la regla asociada al
-- tipo de dato pero no por la regla asociada al campo (no lo permite):
insert into alumnos values ('77777777','Juan Lopez');

-- Ingrese un valor para "documento" aceptado por la regla asociada al campo (si lo permite):
insert into alumnos values ('55555555','Juan Lopez');