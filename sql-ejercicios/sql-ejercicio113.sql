----Vistas

--Una vista es una alternativa para mostrar datos de varias tablas. Una vista es
--como una tabla virtual que almacena una consulta. Los datos accesibles a través
--de la vista no están almacenados en la base de datos como un objeto.

--Entonces, una vista almacena una consulta como un objeto para utilizarse posteriormente.
--Las tablas consultadas en una vista se llaman tablas base. En general, se puede dar un 
--nombre a cualquier consulta y almacenarla como una vista.

--Una vista suele llamarse también tabla virtual porque los resultados que retorna y la
--manera de referenciarlas es la misma que para una tabla.

--Las vistas permiten:

--- ocultar información: permitiendo el acceso a algunos datos y manteniendo oculto el
--resto de la información que no se incluye en la vista. El usuario opera con los datos 
--de una vista como si se tratara de una tabla, pudiendo modificar tales datos.

--- simplificar la administración de los permisos de usuario: se pueden dar al usuario 
--permisos para que solamente pueda acceder a los datos a través de vistas, en lugar de 
--concederle permisos para acceder a ciertos campos, así se protegen las tablas base de 
--cambios en su estructura.

--- mejorar el rendimiento: se puede evitar tipear instrucciones repetidamente almacenando
--en una vista el resultado de una consulta compleja que incluya información de varias tablas.

--Podemos crear vistas con: un subconjunto de registros y campos de una tabla;
--una unión de varias tablas; una combinación de varias tablas; un resumen estadístico de una tabla;
--un subconjunto de otra vista, combinación de vistas y tablas.

--Una vista se define usando un "select".

--La sintaxis básica parcial para crear una vista es la siguiente:

--create view NOMBREVISTA as
--SENTENCIASSELECT
--from TABLA;

--El contenido de una vista se muestra con un "select":

--select *from NOMBREVISTA;

--En el siguiente ejemplo creamos la vista "vista_empleados", que es resultado de una combinación 
--en la cual se muestran 4 campos:

--create view vista_empleados as
--select (apellido+' '+e.nombre) as nombre,sexo,
--s.nombre as seccion, cantidadhijos
--from empleados as e
--join secciones as s
--on codigo=seccion

--Para ver la información contenida en la vista creada anteriormente tipeamos:

--select *from vista_empleados;

--Podemos realizar consultas a una vista como si se tratara de una tabla:

--select seccion,count(*) as cantidad
--from vista_empleados
--group by seccion;

--Los nombres para vistas deben seguir las mismas reglas que cualquier identificador.
--Para distinguir una tabla de una vista podemos fijar una convención para darle nombres, 
--por ejemplo, colocar el sufijo “vista” y luego el nombre de las tablas consultadas en ellas.

--Los campos y expresiones de la consulta que define una vista DEBEN tener un nombre.
--Se debe colocar nombre de campo cuando es un campo calculado o si hay 2 campos con 
--el mismo nombre. Note que en el ejemplo, al concatenar los campos "apellido" y "nombre" 
--colocamos un alias; si no lo hubiésemos hecho aparecería un mensaje de error porque
--dicha expresión DEBE tener un encabezado, SQL Server no lo coloca por defecto.

--Los nombres de los campos y expresiones de la consulta que define una vista DEBEN 
--ser únicos (no puede haber dos campos o encabezados con igual nombre). 
--Note que en la vista definida en el ejemplo, al campo "s.nombre" le colocamos 
--un alias porque ya había un encabezado (el alias de la concatenación) llamado 
--"nombre" y no pueden repetirse, si sucediera, aparecería un mensaje de error.

--Otra sintaxis es la siguiente:

--create view NOMBREVISTA (NOMBRESDEENCABEZADOS)
--as
--SENTENCIASSELECT
--from TABLA;

--Creamos otra vista de "empleados" denominada "vista_empleados_ingreso" que almacena la
--cantidad de empleados por año:

--create view vista_empleados_ingreso (fecha,cantidad)
--as
--select datepart(year,fechaingreso),count(*)
--from empleados
--group by datepart(year,fechaingreso)

--La diferencia es que se colocan entre paréntesis los encabezados de las columnas que
--aparecerán en la vista. Si no los colocamos y empleamos la sintaxis vista anteriormente, 
--se emplean los nombres de los campos o alias (que en este caso habría que agregar) 
--colocados en el "select" que define la vista. Los nombres que se colocan entre paréntesis 
--deben ser tantos como los campos o expresiones que se definen en la vista.

--Las vistas se crean en la base de datos activa.

--Al crear una vista, SQL Server verifica que existan las tablas a las que se hacen referencia en ella.

--Se aconseja probar la sentencia "select" con la cual definiremos la vista antes de crearla 
--para asegurarnos que el resultado que retorna es el imaginado.

--Existen algunas restricciones para el uso de "create view", a saber:

--- no puede incluir las cláusulas "compute" ni "compute by" ni la palabra clave "into";

--- no se pueden crear vistas temporales ni crear vistas sobre tablas temporales.

--- no se pueden asociar reglas ni valores por defecto a las vistas.

--- no puede combinarse con otras instrucciones en un mismo lote.

--Se pueden construir vistas sobre otras vistas.

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

insert into secciones values('Administracion',300);
insert into secciones values('Contaduría',400);
insert into secciones values('Sistemas',500);

insert into empleados values('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-10-10');
insert into empleados values('23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','1990-02-10');
insert into empleados values('24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','1998-07-12');
insert into empleados values('25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','1998-10-09');
insert into empleados values('26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2000-05-09');

-- Eliminamos la vista "vista_empleados" si existe:
if object_id('vista_empleados') is not null
  drop view vista_empleados;

go

-- Creamos la vista "vista_empleados", que es resultado de una combinación 
-- en la cual se muestran 5 campos:
create view vista_empleados as
  select (apellido+' '+e.nombre) as nombre,sexo,
   s.nombre as seccion, cantidadhijos
   from empleados as e
   join secciones as s
   on codigo=seccion;

go

-- Vemos la información de la vista:
select * from vista_empleados;

-- Realizamos una consulta a la vista como si se tratara de una tabla:
select seccion,count(*) as cantidad
  from vista_empleados
  group by seccion;

-- Eliminamos la vista "vista_empleados_ingreso" si existe:
if object_id('vista_empleados_ingreso') is not null
  drop view vista_empleados_ingreso;

go

-- Creamos otra vista de "empleados" denominada "vista_empleados_ingreso" 
-- que almacena la cantidad de empleados por año:
create view vista_empleados_ingreso (fecha,cantidad)
  as
  select datepart(year,fechaingreso),count(*)
   from empleados
   group by datepart(year,fechaingreso);

go

-- Vemos la información de la vista creada:
select * from vista_empleados_ingreso;