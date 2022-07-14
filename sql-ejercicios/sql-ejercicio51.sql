-- La restricción "unique" impide la duplicación de claves alternas (no primarias), es decir,
--  especifica que dos registros no puedan tener el mismo valor en un campo. Se permiten valores nulos. 
--  Se pueden aplicar varias restricciones de este tipo a una misma tabla, y pueden aplicarse a uno o 
--  varios campos que no sean clave primaria.

-- Se emplea cuando ya se estableció una clave primaria (como un número de legajo) pero se necesita 
-- asegurar que otros datos también sean únicos y no se repitan (como número de documento).

-- La sintaxis general es la siguiente:

--  alter table NOMBRETABLA
--  add constraint NOMBRERESTRICCION
--  unique (CAMPO);

-- Por convención, cuando demos el nombre a las restricciones "unique" seguiremos la misma estructura: 
-- "UQ_NOMBRETABLA_NOMBRECAMPO". Quizá parezca innecesario colocar el nombre de la tabla, pero cuando
--  empleemos varias tablas verá que es útil identificar las restricciones por tipo, tabla y campo.

-- Recuerde que cuando agregamos una restricción a una tabla que contiene información, SQL Server controla 
-- los datos existentes para confirmar que cumplen la condición de la restricción, si no los cumple, 
-- la restricción no se aplica y aparece un mensaje de error. En el caso del ejemplo anterior, 
-- si la tabla contiene números de documento duplicados, la restricción no podrá establecerse; 
-- si podrá establecerse si tiene valores nulos.

-- SQL Server controla la entrada de datos en inserciones y actualizaciones evitando que se ingresen valores duplicados.

if object_id('alumnos') is not null
  drop table alumnos;

create table alumnos(
  legajo char(4) not null,
  apellido varchar(20),
  nombre varchar(20),
  documento char(8)
);

go

-- Agregamos una restricción "primary" para el campo "legajo":
alter table alumnos
 add constraint PK_alumnos_legajo
 primary key(legajo);

-- Agregamos una restricción "unique" para el campo "documento":
alter table alumnos
 add constraint UQ_alumnos_documento
 unique (documento);

insert into alumnos values('A111','Lopez','Ana','22222222');
insert into alumnos values('A123','Garcia','Maria','23333333');

exec sp_helpconstraint alumnos; 