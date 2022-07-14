--Valores predeterminados (create default)

--Los valores predeterminados se asocian con uno o varios campos (o tipos de datos definidos por el usuario); se definen una sola vez y se pueden usar muchas veces.

--Si no se coloca un valor cuando se ingresan datos, el valor predeterminado especifica el valor del campo al que está asociado.

--Sintaxis básica:

--create default NOMBREVALORPREDETERMINADO
--as VALORPREDETERMINADO;

--"VALORPREDETERMINADO" no puede hacer referencia a campos de una tabla (u otros objetos) y debe ser compatible con el tipo de datos y longitud del campo al cual se asocia; si esto no sucede, SQL Server no lo informa al crear el valor predeterminado ni al asociarlo, pero al ejecutar una instrucción "insert" muestra un mensaje de error.

--En el siguiente ejemplo creamos un valor predeterminado llamado "VP_datodesconocido' con el valor "Desconocido":

--create default VP_datodesconocido
--as 'Desconocido'

--Luego de crear un valor predeterminado, debemos asociarlo a un campo (o a un tipo de datos definido por el usuario) ejecutando el procedimiento almacenado del sistema "sp_bindefault":

--exec sp_bindefault NOMBRE, 'NOMBRETABLA.CAMPO';

--La siguiente sentencia asocia el valor predeterminado creado anteriormente al campo "domicilio" de la tabla "empleados":

--exec sp_bindefault VP_datodesconocido, 'empleados.domicilio';

--Podemos asociar un valor predeterminado a varios campos. Asociamos el valor predeterminado "VP_datodesconocido" al campo "barrio" de la tabla "empleados":

--exec sp_bindefault VP_datodesconocido, 'empleados.barrio';

--La función que cumple un valor predeterminado es básicamente la misma que una restricción "default", las siguientes características explican algunas semejanzas y diferencias entre ellas:

--- un campo solamente puede tener definida UNA restricción "default", un campo solamente puede tener UN valor predeterminado asociado a él,

--- una restricción "default" se almacena con la tabla, cuando ésta se elimina, las restricciones también. Los valores predeterminados son objetos diferentes e independientes de las tablas, si eliminamos una tabla, las asociaciones desaparecen, pero los valores predeterminados siguen existiendo en la base de datos.

--- una restricción "default" se establece para un solo campo; un valor predeterminado puede asociarse a distintos campos (inclusive, de diferentes tablas).

--- una restricción "default" no puede establecerse sobre un campo "identity", tampoco un valor predeterminado.

--No se puede asociar un valor predeterminado a un campo que tiene una restricción "default".

--Un campo con un valor predeterminado asociado puede tener reglas asociadas a él y restricciones "check". Si hay conflicto entre ellas, SQL Server no lo informa al crearlas y/o asociarlas, pero al intentar ingresar un valor que alguna de ellas no permita, aparece un mensaje de error.

--La sentencia "create default" no puede combinarse con otra sentencia en un mismo lote.

--Si asocia a un campo que ya tiene asociado un valor predeterminado otro valor predeterminado, la nueva asociación reemplaza a la anterior.



if object_id ('empleados') is not null
  drop table empleados;

if object_id ('VP_cero') is not null
   drop default VP_cero;
if object_id ('VP_100') is not null
   drop default VP_100;
if object_id ('VP_datodesconocido') is not null
   drop default VP_datodesconocido;
if object_id ('VP_telefono') is not null
   drop default VP_telefono;

create table empleados(
  nombre varchar(30),
  domicilio varchar(30),
  barrio varchar(15),
  telefono char(14),
  sueldo decimal(6,2)
);

go

insert into empleados default values;

select * from empleados;

go

-- Creamos un valor predeterminado con el valor "Desconocido":
create default VP_datodesconocido
  as 'Desconocido';

go

-- Lo asociamos al campo "domicilio":
exec sp_bindefault VP_datodesconocido, 'empleados.domicilio';

-- Lo asociamos al campo "barrio":
exec sp_bindefault VP_datodesconocido, 'empleados.barrio';

insert into empleados default values;

select * from empleados;

go

-- Creamos un valor predeterminado que inserta el valor "0":
create default VP_cero
  as 0;

go

-- Lo asociamos al campo "sueldo":
exec sp_bindefault VP_cero, 'empleados.sueldo';

insert into empleados default values;

select * from empleados;

go

-- Creamos un valor predeterminado que inserta el valor "100":
create default VP_100
  as 100;

go

-- Lo asociamos al campo "sueldo"
-- Recuerde que si asociamos a un campo que ya tiene asociado un valor
-- predeterminado otro valor predeterminado, la nueva asociación reemplaza a la anterior 
exec sp_bindefault VP_100, 'empleados.sueldo';

insert into empleados default values;

select * from empleados;

exec sp_helpconstraint empleados;

exec sp_help;

go

-- Creamos un valor predeterminado que inserta ceros con el formato válido
-- para un campo número de teléfono:
create default VP_telefono
 as '(0000)0-000000';

go

-- La asociamos al campo "telefono" de la tabla "empleados":
exec sp_bindefault VP_telefono,'empleados.telefono';

insert into empleados default values;

select * from empleados;

exec sp_helpconstraint empleados;