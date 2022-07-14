
--Crear y asociar reglas (create rule - sp_bindrule)

--RESTRICCIONES (constraints), que se establecen en tablas y campos y son controlados automáticamente por SQL Server. 
--Hay 3 tipos:

--I) DE LOS CAMPOS (hace referencia a los valores válidos para un campo determinado). Pueden ser:

--a) DEFAULT: especifica un valor por defecto para un campo cuando no se inserta explícitamente en un comando "insert".

--b) CHECK: especifica un rango de valores que acepta un campo, se emplea en inserciones y actualizaciones ("insert" y "update").

--II) DE LA TABLA (asegura un identificador único para cada registro de una tabla). Hay 2 tipos:

--a) PRIMARY KEY: identifica unívocamente cada uno de los registros; asegura que no haya valores duplicados ni valores nulos. 
--Se crea un índice automáticamente.

--b) UNIQUE: impide la duplicación de claves alternas (no primarias). Se permiten valores nulos. 
--Se crea un índice automáticamente.

--III) REFERENCIAL: lo veremos más adelante.
--REGLAS (rules) y
--VALORES PREDETERMINADOS (defaults).

--veamos las reglas.

--Las reglas especifican los valores que se pueden ingresar en un campo, asegurando que los datos se encuentren 
--en un intervalo de valores específico, coincidan con una lista de valores o sigan un patrón.

--Una regla se asocia a un campo de una tabla (o a un tipo de dato definido por el usuario, 
--	tema que veremos posteriormente).

--Un campo puede tener solamente UNA regla asociado a él.

--Sintaxis básica es la siguiente:

 --create rule NOMBREREGLA
 --as @VARIABLE CONDICION

--Entonces, luego de "create rule" se coloca el nombre de la regla, luego la palabra clave "as" seguido de una variable
-- (a la cual la precede el signo arroba) y finalmente la condición.

--Por convención, nombraremos las reglas comenzando con "RG", el nombre del campo al que se asocia y alguna palabra
-- que haga referencia a la condición.

--La variable puede tener cualquier nombre, pero debe estar precedido por el signo arroba (@), dicha variable será 
--reemplazada por el valor del campo cuando se asocie.

--La condición se refiere a los valores permitidos para inserciones y actualizaciones y puede contener cualquier 
--expresión válida para una cláusula "where"; no puede hacer referencia a los campos de una tabla.


--Luego de crear la regla, debemos asociarla a un campo ejecutando un procedimiento almacenado del sistema empleando 
--la siguiente sintaxis básica:

-- exec sp_bindrule NOMBREREGLA, 'TABLA.CAMPO';

--Asociamos la regla creada anteriormente al campo "sueldo" de la tabla "empleados":

 --exec sp_bindrule RG_sueldo_intervalo, 'empleados.sueldo';

--Si intentamos agregar (o actualizar) un registro con valor para el campo "sueldo" que no esté en el
-- intervalo de valores especificado en la regla, aparece un mensaje de error indicando que hay conflicto
--con la regla y la inserción (o actualización) no se realiza.

--SQL Server NO controla los datos existentes para confirmar que cumplen con la regla como lo hace al 
--aplicar restricciones; si no los cumple, la regla se asocia igualmente; pero al ejecutar una instrucción
-- "insert" o "update" muestra un mensaje de error, es decir, actúa en inserciones y actualizaciones.

--La regla debe ser compatible con el tipo de datos del campo al cual se asocia; si esto no sucede,
-- SQL Server no lo informa al crear la regla ni al asociarla, pero al ejecutar una instrucción "insert" o "update"
-- muestra un mensaje de error.

--No se puede crear una regla para campos de tipo text, image, o timestamp.

--Si asocia una nueva regla a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la
-- asociación anterior; pero la primera regla no desaparece, solamente se deshace la asociación.

--La sentencia "create rule" no puede combinarse con otras sentencias en un lote.

--La función que cumple una regla es básicamente la misma que una restricción "check",
-- las siguientes características explican algunas diferencias entre ellas:

--podemos definir varias restricciones "check" sobre un campo, un campo solamente puede tener una regla asociada a él;

--una restricción "check" se almacena con la tabla, cuando ésta se elimina, las restricciones también se borran.
-- Las reglas son objetos diferentes e independientes de las tablas, si eliminamos una tabla, las asociaciones desaparecen,
-- pero las reglas siguen existiendo en la base de datos;

--una restricción "check" puede incluir varios campos; una regla puede asociarse a distintos campos
-- (incluso de distintas tablas);

--una restricción "check" puede hacer referencia a otros campos de la misma tabla, una regla no.

--Un campo puede tener reglas asociadas a él y restricciones "check". Si hay conflicto entre ellas,
-- SQL Server no lo informa al crearlas y/o asociarlas, pero al intentar ingresar un valor que alguna de ellas 
--no permita, aparece un mensaje de error.

--Con "sp_helpconstraint" podemos ver las reglas asociadas a los campos de una tabla.

--Con "sp_help" podemos ver todos los objetos de la base de datos activa, incluyendo las reglas,
-- en tal caso en la columna "Object_type" aparece "rule".

if object_id('empleados') is not null
  drop table empleados;

create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  seccion varchar(20),
  fechaingreso datetime,
  fechanacimiento datetime,
  hijos tinyint,
  sueldo decimal(6,2)
);

go

-- Recuerde que las reglas son objetos independientes de las tablas (no se eliminan al 
-- borrar la tabla), así que debemos eliminarlas con las siguientes intrucciones:
if object_id ('RG_documento_patron') is not null
  drop rule RG_documento_patron;
if object_id ('RG_empleados_seccion') is not null
  drop rule RG_empleados_seccion;
if object_id ('RG_empleados_fechaingreso') is not null
  drop rule RG_empleados_fechaingreso;
if object_id ('RG_hijos') is not null
  drop rule RG_hijos;
if object_id ('RG_empleados_sueldo') is not null
  drop rule RG_empleados_sueldo;
if object_id ('RG_empleados_sueldo2') is not null
  drop rule RG_empleados_sueldo2;

go

insert into empleados 
   values('22222222','Ana Acosta','Contaduria','1990-10-10','1972-10-10',2,700);
insert into empleados 
   values('23333333','Carlos Costa','Contaduria','1990-12-10','1972-05-04',0,750);
insert into empleados 
   values('24444444','Daniel Duarte','Sistemas','1995-05-05','1975-10-06',1,880);
insert into empleados 
   values('25555555','Fabiola Fuentes','Secretaria','1998-02-11','1978-02-08',3,550);
insert into empleados 
   values('26666666','Gaston Garcia','Secretaria','1999-05-08','1981-01-01',3,670);
insert into empleados 
   values('27777777','Ines Irala','Gerencia','2000-04-10','1985-12-12',0,6000);

go

-- Creamos una regla que establezca un patrón para el documento:
create rule RG_documento_patron
   as @documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';

go

-- Ejecutamos el procedimiento almacenado del sistema "sp_help" para 
-- ver si la regla creada anteriormente fue creada:
exec sp_help;

-- Ejecutamos el procedimiento almacenado del sistema "sp_helpconstraint" para ver si está asociada la regla
-- a algún campo de "empleados" (No aparece porque aún no la asociamos):
exec sp_helpconstraint empleados;

-- Si ingresamos un registro con un documento que no cumpla la regla, SQL Server lo acepta porque la regla
-- aún no está asociada al campo:
insert into empleados values('ab888888','Juan Juarez','Secretaria','2001-04-11','1986-11-12',0,600);

-- Asociamos la regla "RG_documento_patron" al campo "documento":
exec sp_bindrule RG_documento_patron, 'empleados.documento';

-- Volvemos a ejecutar "sp_helpconstraint" (aparece la regla):
exec sp_helpconstraint empleados;

go

-- Creamos una regla para restringir los valores que se pueden ingresar en un campo "seccion":
create rule RG_empleados_seccion
 as @seccion in ('Secretaria','Contaduria','Sistemas','Gerencia');

go

-- La asociamos al campo "seccion":
exec sp_bindrule RG_empleados_seccion, 'empleados.seccion';

go

-- Creamos una regla para restringir los valores que se pueden ingresar en el campo "fechaingreso",
-- para que no sea posterior a la fecha actual:
create rule RG_empleados_fechaingreso
 as @fecha <= getdate();

go

-- Asociamos la regla anteriormente creada a los campos "fechaingreso" y "fechanacimiento":
exec sp_bindrule RG_empleados_fechaingreso, 'empleados.fechaingreso';
exec sp_bindrule RG_empleados_fechaingreso, 'empleados.fechanacimiento';

go

-- Creamos una regla para restringir los valores que se pueden ingresar en el campo "hijos":
create rule RG_hijos
 as @hijos between 0 and 20;

go

-- La asociamos al campo "hijos":
exec sp_bindrule RG_hijos, 'empleados.hijos';

go

-- Creamos una regla para restringir los valores que se pueden ingresar en un campo "sueldo":
create rule RG_empleados_sueldo
 as @sueldo>0 and @sueldo<= 5000;

go

-- La asociamos al campo "sueldo":
exec sp_bindrule RG_empleados_sueldo, 'empleados.sueldo';

go

-- Creamos otra regla para restringir los valores que se pueden ingresar en un campo "sueldo":
create rule RG_empleados_sueldo2
 as @sueldo>0 and @sueldo<= 7000;

go
 
-- La asociamos al campo "sueldo" (la nueva regla reeemplaza la asociación anterior):
exec sp_bindrule RG_empleados_sueldo2, 'empleados.sueldo';

insert into empleados values('29999999','Luis Lopez','Secretaria','2002-03-03','1990-09-09',0,6000);

exec sp_help;

exec sp_helpconstraint empleados;