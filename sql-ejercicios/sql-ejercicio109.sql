----Subconsulta (insert)

----Aprendimos que una subconsulta puede estar dentro de un "select", "update" y "delete"; 
--también puede estar dentro de un "insert".

----Podemos ingresar registros en una tabla empleando un "select".

----La sintaxis básica es la siguiente:

----insert into TABLAENQUESEINGRESA (CAMPOSTABLA1)
----select (CAMPOSTABLACONSULTADA)
----from TABLACONSULTADA;

----Un profesor almacena las notas de sus alumnos en una tabla llamada "alumnos".
-- Tiene otra tabla llamada "aprobados", con algunos campos iguales a la tabla "alumnos" 
--pero en ella solamente almacenará los alumnos que han aprobado el ciclo.

----Ingresamos registros en la tabla "aprobados" seleccionando registros de la tabla "alumnos":

----insert into aprobados (documento,nota)
----select (documento,nota)
----from alumnos;

----Entonces, se puede insertar registros en una tabla con la salida devuelta por una consulta
--a otra tabla; para ello escribimos la consulta y le anteponemos "insert into" junto al nombre
 --de la tabla 
--en la cual ingresaremos los registros y los campos que se cargarán (si se ingresan todos los campos 
--no es necesario listarlos).

----La cantidad de columnas devueltas en la consulta debe ser la misma que la cantidad de campos a
 --cargar en el "insert".

----Se pueden insertar valores en una tabla con el resultado de una consulta que incluya cualquier
-- tipo de "join".

if object_id('alumnos') is not null
  drop table alumnos;
if object_id('aprobados') is not null
  drop table aprobados;

create table alumnos(
  documento char(8) not null,
  nombre varchar(30),
  nota decimal(4,2)
   constraint CK_alumnos_nota_valores check (nota>=0 and nota <=10),
  primary key(documento),
);

create table aprobados(
  documento char(8) not null,
  nota decimal(4,2)
   constraint CK_aprobados_nota_valores check (nota>=0 and nota <=10),
  primary key(documento),
);

go


insert into alumnos values('30000000','Ana Acosta',8);
insert into alumnos values('30111111','Betina Bustos',9);
insert into alumnos values('30222222','Carlos Caseros',2.5); 
insert into alumnos values('30333333','Daniel Duarte',7.7);
insert into alumnos values('30444444','Estela Esper',3.4);

-- Ingresamos registros en la tabla "aprobados" seleccionando 
-- registros de la tabla "alumnos":
insert into aprobados 
  select documento,nota
   from alumnos
   where nota>=4;

select * from aprobados;
