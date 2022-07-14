-- la funcion truncate table elimina todos los registros de una tabla (vacia la tabla), sin borrar la estructura de la tabla
--al borrar datos con truncate table de una tabla con campo identity, reinicia el contador, mientras que con delete table , 
-- el valor de campo identity se mantiene intacto	

---el atributo identity permite indicar el valor inicial y el incremento

if object_id('libros') is not null
	drop table libros;

create table libros(
codigo integer identity(100,2),
titulo varchar(30) not null,
autor varchar(30),
editorial varchar(20),
precio float);

go 

insert into libros(titulo,autor,editorial,precio) values ('el aleph', 'borges','emece',23);
insert into libros(titulo,autor,editorial,precio) values ('maquina del tiempo', 'hg wells','planeta',50);
insert into libros(titulo,autor,editorial,precio) values ('hojarasca', 'gabo','emece',60);
insert into libros(titulo,autor,editorial,precio) values ('fantasma de canterville', 'oscar wilde','siglo xxi',35);

--truncamos la tabla

truncate table libros;
--insertamos de nuevos valores
insert into libros(titulo,autor,editorial,precio) values ('el aleph', 'borges','emece',23);
insert into libros(titulo,autor,editorial,precio) values ('maquina del tiempo', 'hg wells','planeta',50);
insert into libros(titulo,autor,editorial,precio) values ('hojarasca', 'gabo','emece',60);
insert into libros(titulo,autor,editorial,precio) values ('fantasma de canterville', 'oscar wilde','siglo xxi',35);



select * from libros;


--borramos los registros 

delete from libros;


--volvemso a insertar valores

insert into libros(titulo,autor,editorial,precio) values ('el aleph', 'borges','emece',23);
insert into libros(titulo,autor,editorial,precio) values ('maquina del tiempo', 'hg wells','planeta',50);
insert into libros(titulo,autor,editorial,precio) values ('hojarasca', 'gabo','emece',60);
insert into libros(titulo,autor,editorial,precio) values ('fantasma de canterville', 'oscar wilde','siglo xxi',35);

select * from libros;

