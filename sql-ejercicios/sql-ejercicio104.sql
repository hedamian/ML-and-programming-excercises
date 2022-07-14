--Subconsultas con in

--Vimos que una subconsulta puede reemplazar una expresión. Dicha subconsulta debe devolver un valor 
--escalar o una lista de valores de un campo; las subconsultas que retornan una lista de valores
 --reemplazan a una expresión en una cláusula "where" que contiene la palabra clave "in".

--El resultado de una subconsulta con "in" (o "not in") es una lista. Luego que la subconsulta retorna 
--resultados, la consulta exterior los usa.

--La sintaxis básica es la siguiente:

-- ...where EXPRESION in (SUBCONSULTA);

--Este ejemplo muestra los nombres de las editoriales que ha publicado libros de un determinado autor:

-- select nombre
--  from editoriales
--  where codigo in
--   (select codigoeditorial
--     from libros
--     where autor='Richard Bach');

--La subconsulta (consulta interna) retorna una lista de valores de un solo campo (codigo) que la 
--consulta exterior luego emplea al recuperar los datos.

--Podemos reemplazar por un "join" la consulta anterior:

-- select distinct nombre
--  from editoriales as e
--  join libros
--  on codigoeditorial=e.codigo
--  where autor='Richard Bach';

--Una combinación (join) siempre puede ser expresada como una subconsulta; pero una subconsulta no 
--siempre puede reemplazarse por una combinación que retorne el mismo resultado. Si es posible, es 
--aconsejable emplear combinaciones en lugar de subconsultas, son más eficientes.

--Se recomienda probar las subconsultas antes de incluirlas en una consulta exterior, así puede 
--verificar que retorna lo necesario, porque a veces resulta difícil verlo en consultas anidadas.

--También podemos buscar valores No coincidentes con una lista de valores que retorna una subconsulta; 
--por ejemplo, las editoriales que no han publicado libros de un autor específico:

-- select nombre
--  from editoriales
--  where codigo not in
--   (select codigoeditorial
--     from libros
--     where autor='Richard Bach');


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
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on update cascade,
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Paidos');
insert into editoriales values('Siglo XXI');

insert into libros values('Uno','Richard Bach',1);
insert into libros values('Ilusiones','Richard Bach',1);
insert into libros values('Aprenda PHP','Mario Molina',4);
insert into libros values('El aleph','Borges',2);
insert into libros values('Puente al infinito','Richard Bach',2);

-- Queremos conocer el nombre de las editoriales que han publicado 
-- libros del autor "Richard Bach": 
select nombre
  from editoriales
  where codigo in
   (select codigoeditorial
     from libros
     where autor='Richard Bach');

-- Probamos la subconsulta separada de la consulta exterior
-- para verificar que retorna una lista de valores de un solo campo:
select codigoeditorial
  from libros
  where autor='Richard Bach';

-- Podemos reemplazar por un "join" la primera consulta:
select distinct nombre
  from editoriales as e
  join libros
  on codigoeditorial=e.codigo
  where autor='Richard Bach';

-- También podemos buscar las editoriales que no han publicado
-- libros de "Richard Bach":
select nombre
  from editoriales
  where codigo not in
   (select codigoeditorial
     from libros
     where autor='Richard Bach');