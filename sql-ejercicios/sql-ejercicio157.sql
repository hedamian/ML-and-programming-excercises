--146 - Disparador (Instead Off y after)
use ejercicios
--Hasta el momento hemos aprendido que un trigger se crea sobre una tabla específica 
--para un evento (inserción, eliminación o actualización).

--También podemos especificar el momento de disparo del trigger. 
--El momento de disparo indica que las acciones (sentencias) del trigger 
--se ejecuten luego de la acción (insert, delete o update) que dispara el trigger o en lugar de la acción.

--La sintaxis para ello es:

--create trigger NOMBREDISPARADOR
--on NOMBRETABLA o VISTA
--MOMENTODEDISPARO-- after o instead of
--ACCION-- insert, update o delete
--as 
--SENTENCIAS

--Entonces, el momento de disparo especifica cuando deben ejecutarse 
--las acciones (sentencias) que realiza el trigger. Puede ser "después" (after) o
--"en lugar" (instead of) del evento que lo dispara.

--Si no especificamos el momento de disparo en la creación del trigger, 
--por defecto se establece como "after", es decir, las acciones que el disparador
--realiza se ejecutan luego del suceso disparador. Hasta el momento,
--todos los disparadores que creamos han sido "after".

--Los disparadores "instead of" se ejecutan en lugar de la acción desencadenante, 
--es decir, cancelan la acción desencadenante (suceso que disparó el trigger) reemplazándola por otras acciones.

--Veamos un ejemplo. Una empresa almacena los datos de sus empleados en una tabla 
--"empleados" y en otra tabla "clientes" los datos de sus clientes.
--Se crea una vista que muestra los datos de ambas tablas:

--create view vista_empleados_clientes
--as
--select documento,nombre, domicilio, 'empleado' as condicion from empleados
--union
--select documento,nombre, domicilio,'cliente' from clientes;

--Creamos un disparador sobre la vista "vista_empleados_clientes"
--para inserción, que redirija las inserciones a la tabla correspondiente:

--create trigger DIS_empleadosclientes_insertar
--on vista_empleados_clientes
--instead of insert
--as
--insert into empleados 
--select documento,nombre,domicilio
--from inserted where condicion='empleado'

--insert into clientes
--select documento,nombre,domicilio
--from inserted where condicion='cliente';

--El disparador anterior especifica que cada vez que se ingresen registros en la vista 

--"vista_empleados_clientes", en vez de (instead of) realizar la acción (insertar en la vista), 
--se ejecuten las sentencias del trigger, es decir, se ingresen los registros en las tablas correspondientes.

--Entonces, las opciones de disparo pueden ser:

--a) "after": el trigger se dispara cuando las acciones especificadas (insert, delete y/o update) 
--son ejecutadas; todas las acciones en cascada de una restricción "foreign key" y 
--las comprobaciones de restricciones "check" deben realizarse con éxito antes de ejecutarse el trigger. 
--Es la opción por defecto si solamente colocamos "for" (equivalente a "after").

--La sintaxis es:

--create trigger NOMBREDISPARADOR
--on NOMBRETABLA
--after | for-- son equivalentes
--ACCION-- insert, update o delete
--as 
--SENTENCIAS

--b) "instead of": sobreescribe la acción desencadenadora del trigger. 
--Se puede definir solamente un disparador de este tipo para cada acción 
--(insert, delete o update) sobre una tabla o vista.

--Sintaxis:

--create trigger NOMBREDISPARADOR
--on NOMBRETABLA o VISTA
--instead of
--ACCION-- insert, update o delete
--as 
--SENTENCIAS

--Consideraciones:

--- Se pueden crear disparadores "instead of" en vistas y tablas.

--- No se puede crear un disparador "instead of" en vistas definidas "with check option".

--- No se puede crear un disparador "instead of delete" y "instead of update" 
--sobre tablas que tengan una "foreign key" que especifique una acción "on delete cascade"
--y "on update cascade" respectivamente.

--- Los disparadores "after" no pueden definirse sobre vistas.

--- No pueden crearse disparadores "after" en vistas ni en tablas temporales;
--pero pueden referenciar vistas y tablas temporales.

--- Si existen restricciones en la tabla del disparador, 
--se comprueban DESPUES de la ejecución del disparador "instead of" y 
--ANTES del disparador "after". Si se infringen las restricciones,
--se revierten las acciones del disparador "instead of";
--en el caso del disparador "after", no se ejecuta.

if object_id('empleados') is not null
  drop table empleados;
if object_id('clientes') is not null
  drop table clientes;

create table empleados(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  constraint PK_empleados primary key(documento)
);

create table clientes(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  constraint PK_clientes primary key(documento)
);

-- Eliminamos la siguiente vista:
if object_id('vista_empleados_clientes') is not null
  drop view vista_empleados_clientes;

go

-- Creamos una vista que muestra los datos de ambas tablas:
create view vista_empleados_clientes
 as
  select documento,nombre, domicilio, 'empleado' as condicion from empleados
  union
   select documento,nombre, domicilio,'cliente' from clientes;

go

-- Creamos un disparador sobre la vista "vista_empleados_clientes" para inserción,
-- que redirija las inserciones a la tabla correspondiente:
create trigger DIS_empl_clie_insertar
  on vista_empleados_clientes
  instead of insert
  as
    insert into empleados 
     select documento,nombre,domicilio
     from inserted where condicion='empleado'

    insert into clientes
     select documento,nombre,domicilio
     from inserted where condicion='cliente';

go

-- Ingresamos un empleado y un cliente en la vista:
insert into vista_empleados_clientes values('22222222','Ana Acosta', 'Avellaneda 345','empleado');
insert into vista_empleados_clientes values('23333333','Bernardo Bustos', 'Bulnes 587','cliente');

-- Veamos si se almacenaron en la tabla correspondiente:
select * from empleados;
select * from clientes;

go

-- Creamos un disparador sobre la vista "vista_empleados_clientes" para el evento "update",
-- que redirija las actualizaciones a la tabla correspondiente:
create trigger DIS_empl_clie_actualizar
  on vista_empleados_clientes
  instead of update
  as
   declare @condicion varchar(10)
   set @condicion = (select condicion from inserted)
   if update(documento)
   begin
    raiserror('Los documentos no pueden modificarse', 10, 1)
    rollback transaction
   end
   else
   begin
    if @condicion ='empleado'
    begin
     update empleados set empleados.nombre=inserted.nombre, empleados.domicilio=inserted.domicilio
     from empleados
     join inserted
     on empleados.documento=inserted.documento
    end
    else
     if @condicion ='cliente'
     begin
      update clientes set clientes.nombre=inserted.nombre, clientes.domicilio=inserted.domicilio
      from clientes
      join inserted
      on clientes.documento=inserted.documento
     end
   end;

go

-- Realizamos una actualización sobre la vista, de un empleado:
update vista_empleados_clientes set nombre= 'Ana Maria Acosta' where documento='22222222';

-- Veamos si se actualizó la tabla correspondiente:
select * from empleados;

-- Realizamos una actualización sobre la vista, de un cliente:
update vista_empleados_clientes set domicilio='Bulnes 1234' where documento='23333333';

-- Veamos si se actualizó la tabla correspondiente:
select * from clientes;

