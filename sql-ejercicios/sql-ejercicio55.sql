 --Para eliminar una regla, primero se debe deshacer la asociación, 
 --ejecutando el procedimiento almacenado del sistema "sp_unbindrule":

 --exec sp_unbindrule 'TABLA.CAMPO';

--No es posible eliminar una regla si está asociada a un campo. Si intentamos hacerlo, aparece un mensaje de error 
--y la eliminación no se realiza.

--Con la instrucción "drop rule" eliminamos la regla:

 --drop rule NOMBREREGLA;

--Quitamos la asociación de la regla "RG_sueldo_intervalo" con el campo "sueldo" de la tabla "empleados" tipeando:

 --exec sp_unbindrule 'empleados.sueldo';

--Luego de quitar la asociación la eliminamos:

 --drop rule RG_sueldo_100a1000;

--Si eliminamos una tabla, las asociaciones de reglas de sus campos desaparecen, pero las reglas siguen existiendo. 

if object_id ('empleados') is not null
  drop table empleados;

if object_id ('RG_sueldo_100a1000') is not null
   drop rule RG_sueldo_100a1000;

create table empleados(
  documento char(8),
  nombre varchar(30) not null,
  seccion varchar(20),
  sueldo decimal(6,2),
  primary key(documento)
);

go

-- Creamos una regla para restringir los valores que se pueden ingresar
-- en un campo "sueldo":
create rule RG_sueldo_100a1000
   as @sueldo between 100 and 1000;

go

-- Asociamos la regla creada anteriormente al campo "sueldo":
exec sp_bindrule RG_sueldo_100a1000, 'empleados.sueldo';

-- Vemos si la regla está asociada a algún campo de "empleados":
exec sp_helpconstraint empleados;

-- Quitamos la asociación:
exec sp_unbindrule 'empleados.sueldo';

-- Ahora que hemos quitado la asociación, podemos ingresar el valor
-- "1200" en el campo "sueldo":
insert into empleados values ('30111222','Pedro Torres','Contaduria',1200);

-- Vemos si la regla está asociada a algún campo de "empleados":
exec sp_helpconstraint empleados;

-- Ejecutamos el procedimiento "sp_help" para verificar que la regla aún existe:
exec sp_help;

-- Ahora si podemos borrar la regla:
drop rule RG_sueldo_100a1000;

