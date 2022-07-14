----Restricciones foreign key en la misma tabla

--La restricción "foreign key", que define una referencia a un campo con una restricción "primary key"
-- o "unique" se puede definir entre distintas tablas (como hemos aprendido) o dentro de la misma tabla.

--Veamos un ejemplo en el cual definimos esta restricción dentro de la misma tabla.

--Una mutual almacena los datos de sus afiliados en una tabla llamada "afiliados". 
--Algunos afiliados inscriben a sus familiares. La tabla contiene un campo que hace referencia
-- al afiliado que lo incorporó a la mutual, del cual dependen.

--La estructura de la tabla es la siguiente:

--create table afiliados(
--numero int identity not null,
--documento char(8) not null,
--nombre varchar(30),
--afiliadotitular int,
--primary key (documento),
--unique (numero)
--);

--En caso que un afiliado no haya sido incorporado a la mutual por otro afiliado,
-- el campo "afiliadotitular" almacenará "null".

--Establecemos una restricción "foreign key" para asegurarnos que el número de afiliado
--- que se ingrese en el campo "afiliadotitular" exista en la tabla "afiliados":

--alter table afiliados
--add constraint FK_afiliados_afiliadotitular
--foreign key (afiliadotitular)
--references afiliados (numero);

--La sintaxis es la misma, excepto que la tabla se autoreferencia.

--Luego de aplicar esta restricción, cada vez que se ingrese un valor en el campo
 --"afiliadotitular", SQL Server controlará que dicho número exista en la tabla, si no existe,
 -- mostrará un mensaje de error.

--Si intentamos eliminar un afiliado que es titular de otros afiliados, no se podrá hacer,
-- a menos que se haya especificado la acción en cascada (próximo tema).

if object_id('afiliados') is not null
  drop table afiliados;

create table afiliados(
  numero int identity not null,
  documento char(8) not null,
  nombre varchar(30),
  afiliadotitular int,
  primary key (documento),
  unique (numero)
);

go

alter table afiliados
  add constraint FK_afiliados_afiliadotitular
  foreign key (afiliadotitular)
  references afiliados (numero);

insert into afiliados values('22222222','Perez Juan',null);
insert into afiliados values('23333333','Garcia Maria',null);
insert into afiliados values('24444444','Lopez Susana',null);
insert into afiliados values('30000000','Perez Marcela',1);
insert into afiliados values('31111111','Morales Luis',1);
insert into afiliados values('32222222','Garcia Maria',2);

delete from afiliados where numero=5;

exec sp_helpconstraint afiliados;