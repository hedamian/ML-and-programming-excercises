--149 - Disparador (modificar)

--Los triggers pueden modificarse y eliminarse.

--Al modificar la definición de un disparador se reemplaza la definición 
--existente del disparador por la nueva definición.

--La sintaxis general es la siguiente:

--alter trigger NOMBREDISPARADOR
--NUEVADEFINICION;

--Asumiendo que hemos creado un disparador llamado "dis_empleados_borrar" 
--que no permitía eliminar más de 1 registro de la tabla empleados; 
--alteramos el disparador, para que cambia la cantidad de eliminaciones permitidas de 1 a 3:

--alter trigger dis_empleados_borrar
--on empleados
--for delete
--as 
--if (select count(*) from deleted)>3--antes era 1
--begin
--raiserror('No puede borrar mas de 3 empleados',16, 1)
--rollback transaction
--end;

--Se puede cambiar el evento del disparador. Por ejemplo, si creó un disparador 
--para "insert" y luego se modifica el evento por "update", el disparador
--se ejecutará cada vez que se actualice la tabla.

if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  domicilio varchar(30),
  constraint PK_empleados primary key(documento),
);

go

insert into empleados values('22000000','Ana Acosta','Avellaneda 56');
insert into empleados values('23000000','Bernardo Bustos','Bulnes 188');
insert into empleados values('24000000','Carlos Caseres','Caseros 364');
insert into empleados values('25555555','Diana Duarte','Colon 1234');
insert into empleados values('26666666','Diana Duarte','Colon 897');
insert into empleados values('27777777','Matilda Morales','Colon 542');

go

-- Creamos un disparador para que no permita eliminar más de un registro a 
-- la vez de la tabla empleados:
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

-- Eliminamos 1 empleado (El trigger se dispara y realiza la eliminación):
delete from empleados where documento ='22000000';

-- Intentamos eliminar varios empleados
-- (El trigger se dispara, muestra un mensaje y deshace la transacción.): 
delete from empleados where documento like '2%';

select * from empleados;

go

-- Alteramos el disparador, para que cambia la cantidad de eliminaciones
-- permitidas de 1 a 3:
alter trigger dis_empleados_borrar
  on empleados
  for delete
  as 
   if (select count(*) from deleted)>3--antes era 1
   begin
    raiserror('No puede borrar más de 3 empleados',16, 1)
    rollback transaction
   end;

go

-- Intentamos eliminar 5 empleados (El trigger se dispara,
-- muestra el nuevo mensaje y deshace la transacción.):
delete from empleados where documento like '2%';

-- Eliminamos 3 empleados (El trigger se dispara y 
-- realiza las eliminaciones solicitadas):
delete from empleados where domicilio like 'Colon%';

select * from empleados;

