--Un club dicta clases de distintos deportes. En una tabla llamada "socios" guarda los datos de los 
--socios, en una tabla llamada "deportes" la información referente a los diferentes deportes que se 
--dictan y en una tabla denominada "inscriptos", las inscripciones de los socios a los distintos 
--deportes.
--Un socio puede inscribirse en varios deportes el mismo año. Un socio no puede inscribirse en el 
--mismo deporte el mismo año. Distintos socios se inscriben en un mismo deporte en el mismo año.

--1- Elimine las tablas si existen:
 if object_id('inscriptos') is not null
  drop table inscriptos;
 if object_id('socios') is not null
  drop table socios;
 if object_id('deportes') is not null
  drop table deportes;

--2- Cree las tablas con las siguientes estructuras:
 create table socios(
  documento char(8) not null, 
  nombre varchar(30),
  domicilio varchar(30),
  primary key(documento)
 );
 create table deportes(
  codigo tinyint identity,
  nombre varchar(20),
  profesor varchar(15),
  primary key(codigo)
 );
 create table inscriptos(
  documento char(8) not null, 
  codigodeporte tinyitn not null,
  año char(4),
  matricula char(1),--'s'=paga, 'n'=impaga
  primary key(documento,codigodeporte,año),
  constraint FK_inscriptos_socio
   foreign key (documento)
   references socios(documento)
   on update cascade
   on delete cascade
 );

--3- Ingrese algunos registros en las 3 tablas:
 insert into socios values('22222222','Ana Acosta','Avellaneda 111');
 insert into socios values('23333333','Betina Bustos','Bulnes 222');
 insert into socios values('24444444','Carlos Castro','Caseros 333');
 insert into socios values('25555555','Daniel Duarte','Dinamarca 44');

 insert into deportes values('basquet','Juan Juarez');
 insert into deportes values('futbol','Pedro Perez');
 insert into deportes values('natacion','Marina Morales');
 insert into deportes values('tenis','Marina Morales');

 insert into inscriptos values ('22222222',3,'2006','s');
 insert into inscriptos values ('23333333',3,'2006','s');
 insert into inscriptos values ('24444444',3,'2006','n');
 insert into inscriptos values ('22222222',3,'2005','s');
 insert into inscriptos values ('22222222',3,'2007','n');
 insert into inscriptos values ('24444444',1,'2006','s');
 insert into inscriptos values ('24444444',2,'2006','s');

--4- Realice una consulta en la cual muestre todos los datos de las inscripciones, incluyendo el 
--nombre del deporte y del profesor.
--Esta consulta es un join.


select * from inscriptos as i 
join deportes as d on i.codigodeporte=d.codigo;






--5- Utilice el resultado de la consulta anterior como una tabla derivada para emplear en lugar de una 
--tabla para realizar un "join" y recuperar el nombre del socio, el deporte en el cual está inscripto, 
--el año, el nombre del profesor y la matrícula.


 select s.nombre,td.deporte,td.profesor,td.año,td.matricula
  from socios as s
  join (select i.documento,i.codigodeporte,d.nombre as deporte, año, matricula, d.profesor
    from deportes as d
    join inscriptos as i
    on d.codigo=i.codigodeporte) as td
  on td.documento=s.documento;


 select i.documento,i.codigodeporte,d.nombre as deporte, año, matricula, d.profesor
 from deportes as d
 join inscriptos as i
 on d.codigo=i.codigodeporte;