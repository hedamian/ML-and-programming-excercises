---el atributo identity permite indicar el valor inicial y el incremento

if object_id('libros') is not null
	drop table libros;

create table libros(
codigo integer identity(100,2),
titulo varchar(30) not null,
autor varchar(30),
editorial varchar(20),
precio float);


insert into libros(titulo,autor,editorial,precio) values ('el aleph', 'borges','emece',23);
insert into libros(titulo,autor,editorial,precio) values ('maquina del tiempo', 'hg wells','planeta',50);
insert into libros(titulo,autor,editorial,precio) values ('hojarasca', 'gabo','emece',60);
insert into libros(titulo,autor,editorial,precio) values ('fantasma de canterville', 'oscar wilde','siglo xxi',35);

--la funcion ident_seed() retoma el valor inicial del campo identity de la tabla 
select ident_seed('libros'); 
-- la funcion ident_incr() retoma el valor de incremento del campo identity de la tabla
select ident_incr('libros');
--set identity_insert 'tablename' on; permite ingresar valores en un campo identidad 
set identity_insert libros on;
--en caso de tener esta funcion activa, se deben ingresar los valores del campo correspondiente

insert into libros(codigo,titulo) values (100, 'rebelion en la granja');

--notar que se ingreso un valor existente en el codigo. Esto es permitido porque el atributo identity no implica unicidad 
--desactiva la opcion de insertar valores para campos identity
set identity_insert libros off;

select * from libros
