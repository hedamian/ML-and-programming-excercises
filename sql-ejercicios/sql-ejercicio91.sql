---- Restricciones foreign key deshabilitar y eliminar (with check - nocheck)

--Sabemos que si agregamos una restricción a una tabla que contiene datos, 
--SQL Server los controla para asegurarse que cumplen con la restricción; 
--es posible deshabilitar esta comprobación.

--Podemos hacerlo al momento de agregar la restricción a una tabla con datos, 
--incluyendo la opción "with nocheck" en la instrucción "alter table"; si se 
--emplea esta opción, los datos no van a cumplir la restricción.

--Se pueden deshabilitar las restricciones "check" y "foreign key", a las
--demás se las debe eliminar.

--La sintaxis básica al agregar la restriccción "foreign key" es la siguiente:

--alter table NOMBRETABLA1
--with OPCIONDECHEQUEO
--add constraint NOMBRECONSTRAINT
--foreign key (CAMPOCLAVEFORANEA)
--references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA)
--on update OPCION
--on delete OPCION;

--La opción "with OPCIONDECHEQUEO" especifica si se controlan los datos existentes 
--o no con "check" y "nocheck" respectivamente. Por defecto, si no se especifica, 
--la opción es "check".

--En el siguiente ejemplo agregamos una restricción "foreign key" que controla que
--todos los códigos de editorial tengan un código válido, es decir, dicho código
--exista en "editoriales". La restricción no se aplica en los datos existentes 
--pero si en los siguientes ingresos, modificaciones y actualizaciones:

--alter table libros
--with nocheck
--add constraint FK_libros_codigoeditorial
--foreing key (codigoeditorial)
--references editoriales(codigo);

--La comprobación de restricciones se puede deshabilitar para modificar, eliminar 
--o agregar datos a una tabla sin comprobar la restricción. La sintaxis general es:

--alter table NOMBRETABLA
--OPCIONDECHEQUEO constraint NOMBRERESTRICCION;

--En el siguiente ejemplo deshabilitamos la restricción creada anteriormente:

--alter table libros
--nocheck constraint FK_libros_codigoeditorial;

--Para habilitar una restricción deshabilitada se ejecuta la misma instrucción
--pero con la cláusula "check" o "check all":

--alter table libros
--check constraint FK_libros_codigoeditorial;

--Si se emplea "check constraint all" no se coloca nombre de restricciones,
--habilita todas las restricciones que tiene la tabla nombrada ("check" y "foreign key").

--Para saber si una restricción está habilitada o no, podemos ejecutar el 
--procedimiento almacenado "sp_helpconstraint" y entenderemos lo que informa 
--la columna "status_enabled".

--Entonces, las cláusulas "check" y "nocheck" permiten habilitar o deshabilitar 
--restricciones "foreign key" (y "check"). Pueden emplearse para evitar la
--comprobación de datos existentes al crear la restricción o para deshabilitar 
--la comprobación de datos al ingresar, actualizar y eliminar algún registro 
--que infrinja la restricción.

--Podemos eliminar una restricción "foreign key" con "alter table". 
--La sintaxis básica es la misma que para cualquier otra restricción:

--alter table TABLA
--drop constraint NOMBRERESTRICCION;

--Eliminamos la restricción de "libros":

--alter table libros
--drop constraint FK_libros_codigoeditorial;

--No se puede eliminar una tabla si una restricción "foreign key" hace referencia a ella.

--Cuando eliminamos una tabla que tiene una restricción "foreign key", la restricción también se elimina.


if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table libros(
  codigo int not null,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint,
  primary key (codigo)
);
create table editoriales(
  codigo tinyint not null,
  nombre varchar(20),
  primary key (codigo)
);

go

insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Paidos');

insert into libros values(1,'Uno','Richard Bach',1);
insert into libros values(2,'El aleph','Borges',2);
insert into libros values(3,'Aprenda PHP','Mario Molina',5);

-- Agregamos una restricción "foreign key" a la tabla "libros" para evitar que se ingresen 
-- códigos de editoriales inexistentes en "editoriales".
-- Incluimos la opción "with nocheck" para evitar la comprobación de la restricción en los
-- datos existentes (note que hay un libro que tiene un código de editorial inválido):
alter table libros
 with nocheck
 add constraint FK_libros_codigoeditorial
 foreign key (codigoeditorial)
 references editoriales(codigo);

-- Para poder ingresar, modificar o eliminar datos a una tabla sin que SQL Server 
-- compruebe la restricción debemos deshabilitarla:
alter table libros
 nocheck constraint FK_libros_codigoeditorial;

-- Veamos si la restricción está habilitada o no:
exec sp_helpconstraint libros;

-- Veamos las restricciones de "editoriales":
exec sp_helpconstraint editoriales;

-- Ahora podemos ingresar un registro en "libros" con código inválido:
insert into libros values(4,'Ilusiones','Richard Bach',6);

-- También podemos modificar:
update editoriales set codigo=8 where codigo=1;

-- También realizar eliminaciones:
delete from editoriales where codigo=2;

-- Habilitamos la restricción:
alter table libros
  check constraint FK_libros_codigoeditorial;

-- Veamos si la restricción está habilitada o no:
exec sp_helpconstraint libros;

-- Eliminamos la restricción:
alter table libros
  drop constraint FK_libros_codigoeditorial;

exec sp_helpconstraint libros;

exec sp_helpconstraint editoriales;