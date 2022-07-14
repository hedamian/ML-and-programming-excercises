--Tipos de datos text, ntext y image (remplazados por varchar(max), nvarchar(max) y varbinary(max))


--Los tipos de datos text, ntext e image se eliminarán en versiones futuras de SQL Server.
-- Evite utilizar estos tipos de datos en nuevos proyectos de desarrollo y planee modificar
-- las aplicaciones que los utilizan actualmente. Se debe utilizar los tipos varchar (max), 
--nvarchar (max) y varbinary (max) en su lugar.

--Los tipos de datos "ntext", "text" e "image" representan tipos de datos de longitud fija 
--y variable en los que se pueden guardar gran cantidad de información, caracteres unicode 
--y no unicode y datos binarios.

--"ntext" almacena datos unicode de longitud variable y el máximo es de aproximadamente
-- 1000000000 caracteres, en bytes, el tamaño es el doble de los caracteres ingresados (2 GB).

--"text" almacena datos binarios no unicode de longitud variable, el máximo es de 2000000000 
--caracteres aprox. (2 GB). No puede emplearse en parámetros de procedimientos almacenados.

--"image" es un tipo de dato de longitud variable que puede contener de 0 a 2000000000 bytes 
--(2 GB) aprox. de datos binarios. Se emplea para almacenar gran cantidad de información o gráficos.

--Se emplean estos tipos de datos para almacenar valores superiores a 8000 caracteres.
--Ninguno de estos tipos de datos admiten argumento para especificar su longitud, 
--como en el caso de los tipos "char", o "varchar".

--Como estos tipos de datos tiene gran tamaño, SQL Server los almacena fuera de los registros, 
--en su lugar guarda un puntero (de 16 bytes) que apunta a otro sitio que contiene los datos.

--Para declarar un campo de alguno de estos tipos de datos, colocamos el nombre del campo 
--seguido del tipo de dato:

-- ...
-- NOMBRECAMPO text
-- ....
--Otras consideraciones importantes:

--- No pueden definirse variables de estos tipos de datos.

--- Los campos de estos tipos de datos no pueden emplearse para índices.

--- La única restricción que puede aplicar a estos tipos de datos es "default".

--- Se pueden asociar valores predeterminados pero no reglas a campos de estos tipos de datos.

--- No pueden alterarse campos de estos tipos con "alter table".

if object_id('libros') is not null
  drop table libros;

create table libros(
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2),
  sinopsis text
);

go

insert into libros values
 ('Ilusiones','Richard Bach','Planeta',15,null);
insert into libros values
 ('Aprenda PHP','Mario Molina','Nuevo Siglo',45,'Trata todos los temas necesarios 
 	para el aprendizaje de PHP');
insert into libros (titulo,autor,editorial) values
 ('Uno','Richard Bach','Planeta');
insert into libros values
 ('El aleph','Borges','Emece',18,'Uno de los más célebres libros de este autor');

-- La siguiente consulta muestra la cantidad de libros que tienen sinopsis:
select count(*)
  from libros
  where sinopsis is not null;

-- Agregamos una restricción "default" al campo "sinopsis" (es la única restricción que
-- puede aplicarse a campos de tipo "text"):
alter table libros
 add constraint DF_libros_sinopsis
 default 'No hay datos'
 for sinopsis;

-- Ingresamos un registro con valores por defecto:
insert into libros default values;

-- Recuperamos los registros y vemos que se almacenó el valor por defecto:
select * from libros;

if object_id('libros') is not null
  drop table libros;

-- Creamos ahora la tabla con el campo sinopsis con la nueva sintaxis propuesta
-- para SQL Server
create table libros(
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2),
  sinopsis varchar(max)
);

go

insert into libros values
 ('Ilusiones','Richard Bach','Planeta',15,null);
insert into libros values
 ('Aprenda PHP','Mario Molina','Nuevo Siglo',45,'Trata todos los temas necesarios
  para el aprendizaje de PHP');
insert into libros (titulo,autor,editorial) values
 ('Uno','Richard Bach','Planeta');
insert into libros values
 ('El aleph','Borges','Emece',18,'Uno de los más célebres libros de este autor');

-- La siguiente consulta muestra la cantidad de libros que tienen sinopsis:
select count(*)
  from libros
  where sinopsis is not null;

-- Agregamos una restricción "default" al campo "sinopsis" (es la única restricción que
-- puede aplicarse a campos de tipo "text"):
alter table libros
 add constraint DF_libros_sinopsis
 default 'No hay datos'
 for sinopsis;

-- Ingresamos un registro con valores por defecto:
insert into libros default values;

-- Recuperamos los registros y vemos que se almacenó el valor por defecto:
select * from libros;