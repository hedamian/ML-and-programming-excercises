--El procedimiento almacenado "sp_helpconstraint" seguido del nombre de una tabla muestra la información referente a todas las 
--restricciones establecidas en dicha tabla, devuelve las siguientes columnas:

--- constraint_type: tipo de restricción. Si es una restricción de campo (default o check) indica sobre qué campo 
--fue establecida. Si es de tabla (primary key o unique) indica el tipo de índice creado (tema que veremos posteriormente).

--- constraint_name: nombre de la restricción.

--- delete_action: solamente es aplicable para restricciones de tipo "foreign key" (la veremos posteriormente).

--- update_action: sólo es aplicable para restricciones de tipo "foreign key" (la veremos posteriormente).

--- status_enabled: solamente es aplicable para restricciones de tipo "check" y "foreign key". Indica si está habilitada 
--(Enabled) o no (Disabled). Indica "n/a" en cualquier restricción para la que no se aplique.

--- status_for_replication: solamente es aplicable para restricciones de tipo "check" y "foreign key". 
--Indica "n/a" en cualquier restricción para la que no se aplique.

--- constraint_keys: Si es una restricción "check" muestra la condición de chequeo; si es una restricción "default", 
--el valor por defecto; si es una "primary key" o "unique" muestra el/ los campos a los que se aplicaron la restricción.

if object_id('alumnos') is not null
  drop table alumnos;

create table alumnos(
  legajo char(4) not null,
  apellido varchar(20),
  nombre varchar(20),
  documento char(8),
  domicilio varchar(30),
  ciudad varchar(30),
  notafinal decimal(4,2)
);

go

-- Agregamos una restricción "primary" para el campo "legajo":
alter table alumnos
 add constraint PK_alumnos_legajo
 primary key(legajo);

-- Agregamos una restricción "unique" para el campo "documento"
alter table alumnos
 add constraint UQ_alumnos_documento
 unique (documento);

-- Agregamos una restricción "check" para que el campo "notafinal" 
-- admita solamente valores entre 0 y 10:
alter table alumnos
 add constraint CK_alumnos_nota
 check (notafinal>=0 and notafinal<=10);

-- Agregamos una restricción "default" para el campo "ciudad":
alter table alumnos
 add constraint DF_alumnos_ciudad
 default 'Cordoba'
 for ciudad;

 -- Veamos las restricciones:
exec sp_helpconstraint alumnos;

-- Deshabilitamos la restricción "check":
alter table alumnos
  nocheck constraint CK_alumnos_nota;

 -- Veamos las restricciones:
exec sp_helpconstraint alumnos;