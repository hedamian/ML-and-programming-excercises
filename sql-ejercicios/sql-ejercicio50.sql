--restriccion primary key

--Hemos visto las restricciones que se aplican a los campos, "default" y "check".

--Ahora veremos las restricciones que se aplican a las tablas, que aseguran valores únicos para cada registro.

--Hay 2 tipos: 1) primary key y 2) unique. 

--Cada vez que establecíamos la clave primaria para la tabla, SQL Server creaba automáticamente una restricción 
--"primary key" para dicha tabla. Dicha restricción, a la cual no le dábamos un nombre, recibía un nombre dado por 
--SQL Server que comienza con "PK" (por primary key), seguido del nombre de la tabla y una serie de letras y números aleatorios.

--Podemos agregar una restricción "primary key" a una tabla existente con la sintaxis básica siguiente:

--alter table NOMBRETABLA
--add constraint NOMBRECONSTRAINT
--primary key (CAMPO,...);

--En el siguiente ejemplo definimos una restricción "primary key" para nuestra tabla "libros" para asegurarnos que cada libro 
--tendrá un código diferente y único:

--alter table libros
--add constraint PK_libros_codigo
--primary key(codigo);

--Con esta restricción, si intentamos ingresar un registro con un valor para el campo "codigo" que ya existe o el valor "null",
--aparece un mensaje de error, porque no se permiten valores duplicados ni nulos. Igualmente, si actualizamos.

--Por convención, cuando demos el nombre a las restricciones "primary key" seguiremos el formato "PK_NOMBRETABLA_NOMBRECAMPO".

--Sabemos que cuando agregamos una restricción a una tabla que contiene información, SQL Server controla los datos existentes 
--para confirmar que cumplen las exigencias de la restricción, si no los cumple, la restricción no se aplica y aparece un mensaje 
--error. Por ejemplo, si intentamos definir la restricción "primary key" para "libros" y hay registros con códigos repetidos 
--o con un valor "null", la restricción no se establece.

--Cuando establecíamos una clave primaria al definir la tabla, automáticamente SQL Server redefinía el campo como "not null"; 
--pero al agregar una restricción "primary key", los campos que son clave primaria DEBEN haber sido definidos "not null" 
--(o ser implícitamente "not null" si se definen identity).

--SQL Server permite definir solamente una restricción "primary key" por tabla, que asegura la unicidad de cada registro
--de una tabla.

--Si ejecutamos el procedimiento almacenado "sp_helpconstraint" junto al nombre de la tabla, podemos ver las restricciones
--"primary key" (y todos los tipos de restricciones) de dicha tabla.

--Un campo con una restricción "primary key" puede tener una restricción "check".

--Un campo "primary key" también acepta una restricción "default" (excepto si es identity),
--pero no tiene sentido ya que el valor por defecto solamente podrá ingresarse una vez; si intenta ingresarse cuando 
--otro registro ya lo tiene almacenado, aparecerá un mensaje de error indicando que se intenta duplicar la clave.

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int not null,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  primary key (codigo)
);

go

-- Veamos la restricción "primary key" que creó automáticamente SQL Server:
exec sp_helpconstraint libros;

-- Vamos a eliminar la tabla y la crearemos nuevamente, sin establecer la 
-- clave primaria:
drop table libros;

create table libros(
  codigo int not null,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15)
);

go

-- Definimos una restricción "primary key" para nuestra tabla "libros" 
-- para asegurarnos que cada libro tendrá un código diferente y único:
alter table libros
 add constraint PK_libros_codigo
 primary key(codigo);

-- Veamos la información respecto a ella:
exec sp_helpconstraint libros;