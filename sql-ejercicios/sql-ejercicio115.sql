--vistas (encriptar)

--Podemos ver el texto que define una vista ejecutando el procedimiento almacenado del
-- sistema "sp_helptext" seguido del nombre de la vista:

--exec sp_helptext NOMBREVISTA;

--Podemos ocultar el texto que define una vista empleando la siguiente sintaxis al crearla:

--create view NOMBREVISTA
--with encryption
--as 
--SENTENCIASSELECT
--from TABLA;

--"with encryption" indica a SQL Server que codifique las sentencias que definen la vista.

--Creamos una vista con su definición oculta:

--create view vista_empleados
--with encryption
--as
--select (apellido+' '+e.nombre) as nombre,sexo,
--s.nombre as seccion, cantidadhijos
--from empleados as e
--join secciones as s
--on codigo=seccion

--Si ejecutamos el procedimiento almacenado del sistema "sp_helptext" seguido del nombre de una 
--vista encriptada, aparece un mensaje indicando tal situación y el texto no se muestra.

if object_id('empleados') is not null
  drop table empleados;
if object_id('secciones') is not null
  drop table secciones;

create table secciones(
  codigo tinyint identity,
  nombre varchar(20),
  sueldo decimal(5,2)
   constraint CK_secciones_sueldo check (sueldo>=0),
  constraint PK_secciones primary key (codigo)
);

create table empleados(
  legajo int identity,
  documento char(8)
   constraint CK_empleados_documento check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  seccion tinyint not null,
  cantidadhijos tinyint
   constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
   constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso datetime,
   constraint PK_empleados primary key (legajo),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo)
   on update cascade,
  constraint UQ_empleados_documento
   unique(documento)
);

go

if object_id('vista_empleados') is not null
  drop view vista_empleados;

go

create view vista_empleados
  with encryption
 as
  select (apellido+' '+e.nombre) as nombre,sexo,
   s.nombre as seccion, cantidadhijos
   from empleados as e
   join secciones as s
   on codigo=seccion;

go

exec sp_helptext vista_empleados;