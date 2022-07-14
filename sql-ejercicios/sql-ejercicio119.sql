----Vistas modificar (alter view)

--Para modificar una vista puede eliminarla y volver a crearla o emplear "alter view".

--Con "alter view" se modifica la definición de una vista sin afectar los procedimientos 
--almacenados y los permisos. Si elimina una vista y vuelve a crearla, debe reasignar
-- los permisos asociados a ella.

--Sintaxis básica para alterar una vista:

-- alter view NOMBREVISTA
--  with encryption--opcional
-- as SELECT
--En el ejemplo siguiente se altera vista_empleados para agregar el campo "domicilio":

-- alter view vista_empleados
--  with encryption
-- as
--  select (apellido+' '+e.nombre) as nombre,sexo,
--   s.nombre as seccion, cantidadhijos,domicilio
--   from empleados as e
--   join secciones as s
--   on codigo=seccion
--Si creó la vista con "with encryption" y quiere modificarla manteniendo la encriptación, 
--debe colocarla nuevamente, en caso de no hacerlo, desaparece.

--Si crea una vista con "select *" y luego agrega campos a la estructura de las tablas 
--involucradas, los nuevos campos no aparecerán en la vista; esto es porque los campos 
--se seleccionan al ejecutar "create view"; debe alterar la vista.

if object_id('empleados') is not null
  drop table empleados;
if object_id('secciones') is not null
  drop table secciones;

create table secciones(
  codigo tinyint identity,
  nombre varchar(20),
  constraint PK_secciones primary key (codigo)
);

create table empleados(
  legajo int identity,
  documento char(8),
  nombre varchar(30),
  domicilio varchar(30),
  seccion tinyint not null,
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo)
   on update cascade,
  constraint PK_empleados
   primary key (documento)
);

go

insert into secciones values('Administracion');
insert into secciones values('Contaduría');
insert into secciones values('Sistemas');

insert into empleados values('22222222','Lopez Ana','Colon 123',1);
insert into empleados values('23333333','Lopez Luis','Sucre 235',1);
insert into empleados values('24444444','Garcia Marcos','Sarmiento 1234',2);
insert into empleados values('25555555','Gomez Pablo','Bulnes 321',3);
insert into empleados values('26666666','Perez Laura','Peru 1254',3);

if object_id('vista_empleados') is not null
  drop view vista_empleados;

go
-- Creamos la vista "vista_empleados" encriptada que muestre algunos campos 
-- de los empleados de la sección 1 y colocamos "with check option":
create view vista_empleados
  with encryption
 as
  select documento,nombre,seccion
  from empleados
  where seccion=1
  with check option;

go

select * from vista_empleados;

-- Veamos el texto de la vista (No lo permite porque está encriptada):
exec sp_helptext vista_empleados;

go

-- Modificamos la vista para que muestre el domicilio y no colocamos
-- la opción de encriptación ni "with check option":
alter view vista_empleados
 as
  select documento,nombre,seccion, domicilio
  from empleados
  where seccion=1;

go

select * from vista_empleados;

-- Veamos el texto de la vista(Lo permite porque ya no está encriptada):
exec sp_helptext vista_empleados;

-- Actualizamos la sección de un empleado:
update vista_empleados set seccion=2 where documento='22222222';

select * from vista_empleados;

if object_id('vista_empleados2') is not null
  drop view vista_empleados2;

go

-- Creamos la vista "vista_empleados2" que muestre todos los campos
-- de la tabla "empleados":
create view vista_empleados2
 as
  select * from empleados;

go

select * from vista_empleados2;

-- Agregamos un campo a la tabla "empleados":
alter table empleados
 add sueldo decimal(6,2);

-- Consultamos la vista "vista_empleados2" (Note que el nuevo campo
-- agregado a "empleados" no aparece):
select * from vista_empleados2;

go

-- Alteramos la vista para que se muestre el campo sueldo:
alter view vista_empleados2
 as
  select * from empleados;

go

select * from vista_empleados2; 
