--150 - disparador (deshabilitar y habilitar)

--Se puede deshabilitar o habilitar un disparador específico de una tabla o vista,
--o todos los disparadores que tenga definidos.

--Si se deshabilita un disparador, éste sigue existiendo, pero al ejecutar una instrucción
--"insert", "update" o "delete" en la tabla, no se activa.

--Sintaxis para deshabilitar o habilitar un disparador:

--alter table NOMBRETABLA 
--ENABLE | DISABLE trigger NOMBREDISPARADOR;

--El siguiente ejemplo deshabilita un trigger:

--alter table empleados
--disable trigger dis_empleados_borrar;

--Se pueden deshabilitar (o habilitar) varios disparadores en una sola sentencia,
--separando sus nombres con comas. El siguiente ejemplo deshabilitamos dos
--triggers definidos sobre la tabla empleados:

--alter table empleados
--disable trigger dis_empleados_actualizar, dis_empleados_insertar;

--Sintaxis para habilitar (o deshabilitar) todos los disparadores de una tabla específica:

--alter table NOMBRETABLA 
--ENABLE | DISABLE TRIGGER all;

--La siguiente sentencia habilita todos los triggers de la tabla "empleados":

--alter table empleados
--enable trigger all;

if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  domicilio varchar(30),
  seccion varchar(20),
  constraint PK_empleados primary key(documento),
);

go

insert into empleados values('22222222','Ana Acosta','Bulnes 56','Secretaria');
insert into empleados values('23333333','Bernardo Bustos','Bulnes 188','Contaduria');
insert into empleados values('24444444','Carlos Caseres','Caseros 364','Sistemas');
insert into empleados values('25555555','Diana Duarte','Colon 1234','Sistemas');
insert into empleados values('26666666','Diana Duarte','Colon 897','Sistemas');
insert into empleados values('27777777','Matilda Morales','Colon 542','Gerencia');

go

-- Creamos un disparador para que no permita eliminar más de un registro a la vez
-- de la tabla empleados:
create trigger dis_empleados_borrar
  on empleados
  for delete
 as
  if (select count(*) from deleted)>1
  begin
    raiserror('No puede eliminar más de un 1 empleado', 16, 1)
    rollback transaction
  end;

go

-- Creamos un disparador para que no permita actualizar el campo "documento"
-- de la tabla "empleados":
create trigger dis_empleados_actualizar
  on empleados
  for update
 as
  if update(documento)
  begin
    raiserror('No puede modificar el documento de los empleados', 16, 1)
    rollback transaction
  end;

go

-- Creamos un disparador para que no permita ingresar empleados
-- en la sección "Gerencia":
create trigger dis_empleados_insertar
  on empleados
  for insert
 as
  if (select seccion from inserted)='Gerencia'
  begin
    raiserror('No puede ingresar empleados en la sección "Gerencia".', 16, 1)
    rollback transaction
  end;

go

-- Intentamos borrar varios empleados (El trigger se dispara, muestra el 
-- mensaje y deshace la transacción):
delete from empleados where domicilio like 'Bulnes%';

go
-- Deshabilitamos el trigger para el evento de eliminación:
alter table empleados
  disable trigger dis_empleados_borrar;

go

-- Borramos varios empleados (El trigger no se disparó porque está deshabilitado):
delete from empleados where domicilio like 'Bulnes%';

-- Podemos verificar que los registros de eliminaron recuperando los datos de la tabla:
select * from empleados;

-- Intentamos modificar un documento (El trigger se dispara, muestra el mensaje
-- y deshace la transacción):
update empleados set documento='23030303' where documento='23333333';

-- Intentamos ingresar un nuevo empleado en "Gerencia" (El trigger se dispara, 
-- muestra el mensaje y deshace la transacción.):
insert into empleados values('28888888','Juan Juarez','Jamaica 123','Gerencia');

go

-- Deshabilitamos los disparadores de inserción y actualización definidos sobre "empleados":
alter table empleados
  disable trigger dis_empleados_actualizar, dis_empleados_insertar;

go

-- Ejecutamos la sentencia de actualización del documento (El trigger no se dispara porque
-- está deshabilitado, el documento se actualizó):
update empleados set documento='20000444' where documento='24444444';

-- Verifiquémoslo:
select * from empleados;

-- Ingresar un nuevo empleado en "Gerencia" (El trigger "dis_empleados_insertar"
-- no se dispara porque está deshabilitado):
insert into empleados values('28888888','Juan Juarez','Jamaica 123','Gerencia');

-- Verifiquémoslo:
select * from empleados;

go

-- Habilitamos todos los triggers de la tabla "empleados":
alter table empleados
  enable trigger all;

go
-- Ya no podemos eliminar más de un registro, actualizar un documento
-- ni ingresar un empleado en la sección "Gerencia"; lo intentamos 
-- (El trigger se dispara (está habilitado), muestra el mensaje y deshace la transacción):
update empleados set documento='30000000' where documento='28888888';