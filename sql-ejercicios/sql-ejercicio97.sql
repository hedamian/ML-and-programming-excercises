-- Campos calculados

-- Un campo calculado es un campo que no se almacena físicamente en la tabla. 
--SQL Server emplea una fórmula que detalla el usuario al definir dicho campo 
--para calcular el valor según otros campos de la misma tabla.

-- Un campo calculado no puede:

-- - definirse como "not null".

-- - ser una subconsulta.

-- - tener restricción "default" o "foreign key".

-- - insertarse ni actualizarse.

-- Puede ser empleado como llave de un índice o parte de restricciones "primary key" o "unique"
-- si la expresión que la define no cambia en cada consulta.

-- Creamos un campo calculado denominado "sueldototal" que suma al sueldo básico de cada 
--empleado la cantidad abonada por los hijos (100 por cada hijo):

-- create table empleados(
-- documento char(8),
-- nombre varchar(10),
-- domicilio varchar(30),
-- sueldobasico decimal(6,2),
-- cantidadhijos tinyint default 0,
-- sueldototal as sueldobasico + (cantidadhijos*100)
-- );

-- También se puede agregar un campo calculado a una tabla existente:

-- alter table NOMBRETABLA
-- add NOMBRECAMPOCALCULADO as EXPRESION;

-- alter table empleados
-- add sueldototal as sueldo+(cantidadhijos*100);

-- Los campos de los cuales depende el campo calculado no pueden eliminarse, 
--se debe eliminar primero el campo calculado.
if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  documento char(8),
  nombre varchar(10),
  domicilio varchar(30),
  sueldobasico decimal(6,2),
  hijos tinyint not null default 0,
  sueldototal as sueldobasico + (hijos*100)
);

go

-- No puede ingresarse valor para el campo sueldototal:
insert into empleados values('22222222','Juan Perez','Colon 123',300,2);
insert into empleados values('23333333','Ana Lopez','Sucre 234',500,0);

select * from empleados;

-- Actualizamos un registro:
update empleados set hijos=1 where documento='23333333';

select * from empleados;

-- Agregamos un campo calculado:
alter table empleados
  add salariofamiliar as hijos*100;

exec sp_columns empleados;

select * from empleados;