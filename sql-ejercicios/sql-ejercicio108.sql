
----Subconsulta (update - delete)

----Dijimos que podemos emplear subconsultas en sentencias "insert", "update", "delete", 
-----además de "select".

--La sintaxis básica para realizar actualizaciones con subconsulta es la siguiente:

--update TABLA set CAMPO=NUEVOVALOR
--where CAMPO= (SUBCONSULTA);

--Actualizamos el precio de todos los libros de editorial "Emece":

--update libros set precio=precio+(precio*0.1)
--where codigoeditorial=
--(select codigo
--from editoriales
--where nombre='Emece');

--La subconsulta retorna un único valor. También podemos hacerlo con un join.

--La sintaxis básica para realizar eliminaciones con subconsulta es la siguiente:

--delete from TABLA
--where CAMPO in (SUBCONSULTA);

--Eliminamos todos los libros de las editoriales que tiene publicados libros de "Juan Perez":

--delete from libros
--where codigoeditorial in
--(select e.codigo
--from editoriales as e
--join libros
--on codigoeditorial=e.codigo
--where autor='Juan Perez');

--La subconsulta es una combinación que retorna una lista de valores que la consulta 
--externa emplea al seleccionar los registros para la eliminación.

if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table editoriales(
  codigo tinyint identity,
  nombre varchar(30),
  primary key (codigo)
);
 
create table libros (
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint,
  precio decimal(5,2),
  primary key(codigo)
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Paidos');
insert into editoriales values('Siglo XXI');

insert into libros values('Uno','Richard Bach',1,15);
insert into libros values('Ilusiones','Richard Bach',2,20);
insert into libros values('El aleph','Borges',3,10);
insert into libros values('Aprenda PHP','Mario Molina',4,40);
insert into libros values('Poemas','Juan Perez',1,20);
insert into libros values('Cuentos','Juan Perez',3,25);
insert into libros values('Java en 10 minutos','Marcelo Perez',2,30);


-- Actualizamos el precio de todos los libros de editorial "Emece"
-- incrementándolos en un 10%:
update libros set precio=precio+(precio*0.1)
  where codigoeditorial=
   (select codigo
     from editoriales
     where nombre='Emece');

-- Eliminamos todos los libros de las editoriales que tiene 
-- publicados libros de "Juan Perez":
delete from libros
  where codigoeditorial in
   (select e.codigo
    from editoriales as e
    join libros
    on codigoeditorial=e.codigo
    where autor='Juan Perez');