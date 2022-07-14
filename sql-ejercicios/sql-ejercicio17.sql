if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int not null,
  titulo varchar(40) not null,
  autor varchar(20),
  editorial varchar(15),
  primary key(codigo)
 );


insert into libros (codigo,titulo,autor,editorial)
  values (1,'El aleph','Borges','Emece');
 insert into libros (codigo,titulo,autor,editorial)
  values (2,'Martin Fierro','Jose Hernandez','Planeta');
 insert into libros (codigo,titulo,autor,editorial)
  values (3,'Aprenda PHP','Mario Molina','Nuevo Siglo');



--4- Ingrese un registro con código repetido (aparece un mensaje de error)

insert into libros (codigo,titulo,autor,editorial)
  values (2,'hojarasca','gabo','Emece');

--5- Intente ingresar el valor "null" en el campo "codigo" (mensaje de error, ya que codigo fue definido para que no acepte valores null)

insert into libros (codigo,titulo,autor,editorial)
  values (null,'hojarasca','gabo','Emece');

--6- Intente actualizar el código del libro "Martin Fierro" a "1" (mensaje de error)
update libros set codigo=1
  where autor='Martin Fierro';