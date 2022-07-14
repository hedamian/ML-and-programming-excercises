--campo con atributo identity
--un campo numerico puede tener un atributo extra identity. los valores de un campo con estre
-- atributo genera valores secuenciales que se inician en 1 y se incrementan en 1 automaticamente.
--se utilizan generalmente en campos correspondientes a codigos de identificacion para generar
--valores unicos para cada nuevo registro que se inserta. solo puede haber un campo identity por tabla
--para que el campo sea del tipo identity ,debe ser entero o suptipo de entero o decimal con escala 0

if object_id('libros') is not null
	drop table libros;

create table libros(
codigo integer identity,
titulo varchar(30) not null,
autor varchar(30),
editorial varchar(20),
precio float);


--cuando un campo tiene el atributo identity, no se pueden registrar valores para el, porque se insertan
--automaticamente tomando el ultimo valor como referencia o 1 si es el primero
--no se deben ingresar valores en el campo identity, se debe omitir 

insert into libros(titulo,autor,editorial,precio) values ('el aleph', 'borges','emece',23);
insert into libros(titulo,autor,editorial,precio) values ('maquina del tiempo', 'hg wells','planeta',50);
insert into libros(titulo,autor,editorial,precio) values ('hojarasca', 'gabo','emece',60);
insert into libros(titulo,autor,editorial,precio) values ('fantasma de canterville', 'oscar wilde','siglo xxi',35);


delete from libros
	where autor='oscar wilde';
--no se puede aplicar update
select * from libros;