--Combinación interna (inner join)
--
--Un join es una operación que relaciona dos o más tablas para obtener un resultado que incluya datos (campos y registros) 
--de ambas; las tablas participantes se combinan según los campos comunes a ambas tablas.

--Hay tres tipos de combinaciones:
--combinaciones internas (inner join o join),
--combinaciones externas y
--combinaciones cruzadas.

--También es posible emplear varias combinaciones en una consulta "select", incluso puede combinarse una tabla consigo misma.

--La combinación interna emplea "join", que es la forma abreviada de "inner join". 
--Se emplea para obtener información de dos tablas y combinar dicha información en una salida.

--La sintaxis básica es la siguiente:

 --select CAMPOS
----from TABLA1
----join TABLA2
----on CONDICIONdeCOMBINACION;

--Ejemplo:

 --select * from libros
----join editoriales
----on codigoeditorial=editoriales.codigo;

--Analicemos la consulta anterior.

--- especificamos los campos que aparecerán en el resultado en la lista de selección;

--- indicamos el nombre de la tabla luego del "from" ("libros");

--- combinamos esa tabla con "join" y el nombre de la otra tabla ("editoriales"); se especifica qué tablas se van a combinar y cómo;

--- cuando se combina información de varias tablas, es necesario especificar qué registro de una tabla se combinará con qué registro de la otra tabla, con "on". Se debe especificar la condición para enlazarlas, es decir, el campo por el cual se combinarán, que tienen en común.
--"on" hace coincidir registros de ambas tablas basándose en el valor de tal campo, en el ejemplo, el campo "codigoeditorial" de "libros" y el campo "codigo" de "editoriales" son los que enlazarán ambas tablas. Se emplean campos comunes, que deben tener tipos de datos iguales o similares.

--La condicion de combinación, es decir, el o los campos por los que se van a combinar (parte "on"), se especifica según las claves primarias y externas.

--Note que en la consulta, al nombrar el campo usamos el nombre de la tabla también. Cuando las tablas referenciadas tienen campos con igual nombre, esto es necesario para evitar confusiones y ambiguedades al momento de referenciar un campo. En el ejemplo, si no especificamos "editoriales.codigo" y solamente tipeamos "codigo", SQL Server no sabrá si nos referimos al campo "codigo" de "libros" o de "editoriales" y mostrará un mensaje de error indicando que "codigo" es ambiguo.

--Entonces, si las tablas que combinamos tienen nombres de campos iguales, DEBE especificarse a qué tabla pertenece anteponiendo el nombre de la tabla al nombre del campo, separado por un punto (.).

--Si una de las tablas tiene clave primaria compuesta, al combinarla con la otra, en la cláusula "on" se debe hacer referencia a la clave completa, es decir, la condición referenciará a todos los campos clave que identifican al registro.

--Se puede incluir en la consulta join la cláusula "where" para restringir los registros que retorna el resultado; también "order by", "distinct", etc..

--Se emplea este tipo de combinación para encontrar registros de la primera tabla que se correspondan con los registros de la otra, es decir, que cumplan la condición del "on". Si un valor de la primera tabla no se encuentra en la segunda tabla, el registro no aparece.

--Para simplificar la sentencia podemos usar un alias para cada tabla:

--select l.codigo,titulo,autor,nombre
--from libros as l
--join editoriales as e
--on l.codigoeditorial=e.codigo;

--En algunos casos (como en este ejemplo) el uso de alias es para fines de simplificación y hace más legible la consulta si es larga y compleja, pero en algunas consultas es absolutamente necesario.
--Servidor de SQL Server instalado en forma local.


if object_id('libros') is not null
 drop table libros;
if object_id('editoriales') is not null
 drop table editoriales;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
  codigoeditorial tinyint not null,
  precio decimal(5,2)
);

create table editoriales(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Siglo XXI');

insert into libros values('El aleph','Borges',2,20);
insert into libros values('Martin Fierro','Jose Hernandez',1,30);
insert into libros values('Aprenda PHP','Mario Molina',3,50);
insert into libros values('Java en 10 minutos',default,3,45);

-- Recuperamos los datos de libros:
select * from libros;

-- Realizamos un join para obtener datos de ambas tablas 
-- (titulo, autor y nombre de la editorial):
select titulo, autor, nombre
 from libros
 join editoriales
 on codigoeditorial=editoriales.codigo;

 -- Mostramos el código del libro, título, autor, nombre de la
 -- editorial y e  precio realizando un join y empleando alias:
select l.codigo,titulo,autor,nombre,precio
  from libros as l
  join editoriales as e
  on codigoeditorial=e.codigo;

-- Realizamos la misma consulta anterior agregando un "where" 
-- para obtener solamente los libros de la editorial "Siglo XXI":
select l.codigo,titulo,autor,nombre,precio
  from libros as l
  join editoriales as e
  on codigoeditorial=e.codigo
  where e.nombre='Siglo XXI';

-- Obtenemos título, autor y nombre de la editorial, 
-- esta vez ordenados por título:
select titulo,autor,nombre
  from libros as l
  join editoriales as e
  on codigoeditorial=e.codigo
  order by titulo;
