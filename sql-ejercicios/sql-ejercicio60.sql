-- Desasociar y eliminar valores predeterminados

----Un valor predeterminado no puede eliminarse si no se ha desasociado previamente.


--Para deshacer una asociación empleamos el procedimiento almacenado 
--"sp_unbindefault" seguido de la tabla y campo al que está asociado:

-- exec sp_unbindefault 'TABLA.CAMPO';

--Quitamos la asociación al campo "sueldo" de la tabla "empleados":

-- exec sp_unbindefault 'empleados.sueldo';

--Con la instrucción "drop default" podemos eliminar un valor predeterminado:

-- drop default NOMBREVALORPREDETERMINADO;

--Eliminamos el valor predeterminado llamado "VP_cero":

-- drop default VP_cero;

--Si eliminamos una tabla, las asociaciones de valores predeterminados de sus campos desaparecen,
-- pero los valores predeterminados siguen existiendo.

if object_id ('empleados') is not null
  drop table empleados;

if object_id ('VP_cero') is not null
   drop default VP_cero;
if object_id ('VP_datodesconocido') is not null
   drop default VP_datodesconocido;

create table empleados(
  nombre varchar(30),
  domicilio varchar(30),
  barrio varchar(15),
  sueldo decimal(6,2)
);

go

-- Creamos un valor predeterminado que inserta el valor "0":
create default VP_cero
  as 0;

go

-- Lo asociamos al campo "sueldo":
exec sp_bindefault VP_cero, 'empleados.sueldo';

go

-- Creamos un valor predeterminado con el valor "Desconocido":
create default VP_datodesconocido
  as 'Desconocido';

go
 
-- Lo asociamos al campo "domicilio" y al campo "barrio":
exec sp_bindefault VP_datodesconocido, 'empleados.domicilio';
exec sp_bindefault VP_datodesconocido, 'empleados.barrio';

-- Veamos los valores predeterminados asociados a los campos de la tabla "empleados":
exec sp_helpconstraint empleados;

-- Quitamos la asociación al campo "barrio":
exec sp_unbindefault 'empleados.barrio';

exec sp_helpconstraint empleados;

exec sp_help;

-- Aun no podemos eliminarlo porque está asociado al campo "domicilio",
-- quitamos la asociación y luego lo eliminamos:
exec sp_unbindefault 'empleados.domicilio';

drop default VP_datodesconocido;