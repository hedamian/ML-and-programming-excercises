----desabilitar  restricciones

--Sabemos que si agregamos una restricción a una tabla que contiene datos, 
--SQL Server los controla para asegurarse que cumplen con la condición de la restricción,
--si algún registro no la cumple, la restricción no se establecece.

--Es posible deshabilitar esta comprobación en caso de restricciones "check".

--Podemos hacerlo cuando agregamos la restricción "check" a una tabla para que SQL Server acepte los valores
--ya almacenados que infringen la restricción. Para ello debemos incluir la opción "with nocheck"
--en la instrucción "alter table":

--alter table libros
--with nocheck
--add constraint CK_libros_precio
--check (precio>=0);

--La restricción no se aplica en los datos existentes, pero si intentamos ingresar un nuevo valor que
--no cumpla la restricción, SQL Server no lo permite.

--Entonces, para evitar la comprobación de datos existentes al crear la restricción, la sintaxis básica es la siguiente:

--alter table TABLA
--with nocheck
--add constraint NOMBRERESTRICCION
--check (CONDICION);

--Por defecto, si no especificamos, la opción es "with check".

--También podemos deshabilitar las restricciones para agregar o actualizar datos sin comprobarla:

--alter table libros
--nocheck constraint CK_libros_precio;
--Para habilitar una restricción deshabilitada se ejecuta la misma instrucción pero con la cláusula "check" o "check all":

--alter table libros
--check constraint CK_libros_precio;

--Si se emplea "check constraint all" no se coloca nombre de restricciones, habilita todas las restricciones 
--que tiene la tabla nombrada.

--Para habilitar o deshabilitar restricciones la comprobación de datos en inserciones o actualizaciones,
--la sintaxis básica es:

--alter table NOMBRETABLA
--OPCIONdeRESTRICCION constraint NOMBRERESTRICCION;

--Para saber si una restricción está habilitada o no, podemos ejecutar el procedimiento almacenado "sp_helpconstraint" y
--fijarnos lo que informa la columna "status_enabled".

--Entonces, las cláusulas "check" y "nocheck" permiten habilitar o deshabilitar restricciones "check"
--(también las restricciones "foreign key" que veremos más adelante), 
--a las demás se las debe eliminar ("default" y las que veremos posteriormente).

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(5,2)
);

go

insert into libros values ('Uno','Bach','Planeta',22);
insert into libros values ('El quijote','Cervantes','Emece',15);
insert into libros values ('Aprenda PHP','Mario Molina','Siglo XXI',-40);

-- Agregamos una restricción "check" para asegurar que los precios no puedan ser 
-- negativos, pero como ya tenemos almacenado un precio que infringe la restricción,
-- vamos a especificar que no haya comprobación de datos existentes:
alter table libros
   with nocheck
   add constraint CK_libros_precio_positivo
   check (precio>=0);

-- Si intentamos ingresar un registro con precio negativo, no lo permite.
-- Para que lo permita, debemos dehabilitar la comprobación:
alter table libros
  nocheck constraint CK_libros_precio_positivo;

-- Ingresemos un registro con precio negativo (si lo permite):
insert into libros values('Java en 10 minutos',default,'Siglo XXI',-1);

-- Veamos si la restricción está o no habilitada:
-- La columna "status_enabled" nos informa que está deshabilitada (Disabled)
exec sp_helpconstraint libros;

-- Habilitamos la restricción.
-- Si ahora intentamos ingresar un precio negativo SQL Server no lo permitirá.
alter table libros
  check constraint CK_libros_precio_positivo;

select * from libros;

