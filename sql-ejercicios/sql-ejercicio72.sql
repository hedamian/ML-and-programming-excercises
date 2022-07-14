--Un club dicta clases de distintos deportes. Almacena la información en una tabla llamada 
--"inscriptos" que incluye el documento, el nombre, el deporte y si la matricula esta paga o no y una -
--tabla llamada "inasistencias" que incluye el documento, el deporte y la fecha de la inasistencia.
--1- Elimine las tablas si existen y cree las tablas:

 if (object_id('inscriptos')) is not null
  drop table inscriptos;
 if (object_id('inasistencias')) is not null
  drop table inasistencias;
--tabla a
 create table inscriptos(
  nombre varchar(30),
  documento char(8),
  deporte varchar(15),
  matricula char(1), --'s'=paga 'n'=impaga
  primary key(documento,deporte)
 );
--tabla b
 create table inasistencias(
  documento char(8),
  deporte varchar(15),
  fecha datetime
 );

-- Ingrese algunos registros para ambas tablas:
 insert into inscriptos values('Juan Perez','22222222','tenis','s');
 insert into inscriptos values('Maria Lopez','23333333','tenis','s');
 insert into inscriptos values('Agustin Juarez','24444444','tenis','n');
 insert into inscriptos values('Marta Garcia','25555555','natacion','s');
 insert into inscriptos values('Juan Perez','22222222','natacion','s');
 insert into inscriptos values('Maria Lopez','23333333','natacion','n');

 insert into inasistencias values('22222222','tenis','2006-12-01');
 insert into inasistencias values('22222222','tenis','2006-12-08');
 insert into inasistencias values('23333333','tenis','2006-12-01');
 insert into inasistencias values('24444444','tenis','2006-12-08');
 insert into inasistencias values('22222222','natacion','2006-12-02');
 insert into inasistencias values('23333333','natacion','2006-12-02');

--3- Muestre el nombre, el deporte y las fechas de inasistencias, ordenado por nombre y deporte.
--Note que la condición es compuesta porque para identificar los registros de la tabla "inasistencias" 
--necesitamos ambos campos.
select a.nombre, a.deporte,b.fecha 
from inscriptos as a
join inasistencias as b 
on a.documento=b.documento;

--4- Obtenga el nombre, deporte y las fechas de inasistencias de un determinado inscripto en un 
--determinado deporte (3 registros)
select a.nombre,a.deporte,b.fecha 
from inscriptos as a 
join inasistencias as b 
on a.documento=b.documento and a.deporte=b.deporte where a.nombre='Juan Perez';
--5- Obtenga el nombre, deporte y las fechas de inasistencias de todos los inscriptos que pagaron la 
--matrícula(4 registros)

select a.nombre,a.deporte,b.fecha 
from inscriptos as a 
join inasistencias as b on a.documento=b.documento and a.deporte=b.deporte 
where a.matricula='s';