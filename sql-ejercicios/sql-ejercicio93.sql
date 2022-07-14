----Unión

--El operador "union" combina el resultado de dos o más instrucciones "select" en un único resultado.

--Se usa cuando los datos que se quieren obtener pertenecen a distintas tablas y 
--no se puede acceder a ellos con una sola consulta.

--Es necesario que las tablas referenciadas tengan tipos de datos similares, la misma cantidad de
-- campos y el mismo orden de campos en la lista de selección de cada consulta.
-- No se incluyen las filas duplicadas en el resultado, a menos que coloque la opción "all".

--Se deben especificar los nombres de los campos en la primera instrucción "select".

--Puede emplear la cláusula "order by".

--Puede dividir una consulta compleja en varias consultas "select" y luego emplear el operador "union" 
--para combinarlas.

--Una academia de enseñanza almacena los datos de los alumnos en una tabla llamada "alumnos" y
-- los datos de los profesores en otra denominada "profesores".
--La academia necesita el nombre y domicilio de profesores y alumnos para enviarles una tarjeta 
--de invitación.

--Para obtener los datos necesarios de ambas tablas en una sola consulta necesitamos realizar una unión:

--select nombre, domicilio from alumnos
--union
--select nombre, domicilio from profesores;

--El primer "select" devuelve el nombre y domicilio de todos los alumnos; el segundo, 
--el nombre y domicilio de todos los profesores.

--Los encabezados del resultado de una unión son los que se especifican en el primer "select"


  if object_id('alumnos') is not null
  drop table alumnos;
if object_id('profesores') is not null
  drop table profesores;

create table profesores(
  documento varchar(8) not null,
  nombre varchar (30),
  domicilio varchar(30),
  primary key(documento)
);
create table alumnos(
  documento varchar(8) not null,
  nombre varchar (30),
  domicilio varchar(30),
  primary key(documento)
);

go

insert into alumnos values('30000000','Juan Perez','Colon 123');
insert into alumnos values('30111111','Marta Morales','Caseros 222');
insert into alumnos values('30222222','Laura Torres','San Martin 987');
insert into alumnos values('30333333','Mariano Juarez','Avellaneda 34');
insert into alumnos values('23333333','Federico Lopez','Colon 987');
insert into profesores values('22222222','Susana Molina','Sucre 345');
insert into profesores values('23333333','Federico Lopez','Colon 987');

-- Nombre y domicilio de profesores y alumnos
select nombre, domicilio from alumnos
  union
    select nombre, domicilio from profesores;
-- Mostrar las filas duplicadas de ambas tablas
-- (existe un profesor que también está presente en la tabla "alumnos")
select nombre, domicilio from alumnos
  union all
    select nombre, domicilio from profesores;

-- Ordenamos por domicilio:
select nombre, domicilio from alumnos
  union
    select nombre, domicilio from profesores
  order by domicilio;

-- agregar una columna extra a la consulta con el encabezado "condicion"
-- en la que aparezca el literal "profesor" o "alumno" según si la persona
-- es uno u otro:
select nombre, domicilio, 'alumno' as condicion from alumnos
  union
    select nombre, domicilio,'profesor' from profesores
  order by condicion;