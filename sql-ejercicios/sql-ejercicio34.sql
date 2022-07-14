if object_id ('empleados') is not null
  drop table empleados;

create table empleados(
  nombre varchar(30) not null,
  apellido varchar(20) not null,
  documento char(8),
  fechanacimiento datetime,
  fechaingreso datetime,
  sueldo decimal(6,2),
  primary key(documento)
 );

 insert into empleados values('Ana','Acosta','22222222','1970/10/10','1995/05/05',228.50);
 insert into empleados values('Carlos','Caseres','25555555','1978/02/06','1998/05/05',309);
 insert into empleados values('Francisco','Garcia','26666666','1978/10/15','1998/10/02',250.68);
 insert into empleados values('Gabriela','Garcia','30000000','1985/10/25','2000/12/22',300.25);
 insert into empleados values('Luis','Lopez','31111111','1987/02/10','2000/08/21',350.98);

--Muestre nombre y apellido concatenados, con el apellido en letras mayúsculas, el documento 
--precedido por "DNI Nº " y el sueldo precedido por "$ ".

select nombre+space(1)+upper(apellido) as nombre,
  stuff(documento,1,0,'DNI Nº ') as documento,
  stuff(sueldo,1,0,'$ ') as sueldo from empleados;
--Muestre el documento y el sueldo redondeado hacia arriba y precedido por "$ ".

 select documento, stuff(ceiling(sueldo),1,0,'$ ') from empleados;
-- Muestre los nombres y apellidos de los empleados que cumplen años en el mes "october" (3 registros)

 select nombre,apellido from empleados
  where datename(month,fechanacimiento)='october';
--Muestre los nombres y apellidos de los empleados que ingresaron en un determinado año (2 registros).
 select nombre,apellido from empleados
  where datepart(year,fechaingreso)=2000;  


 select nombre+space(1)+lower(apellido)+str(ceiling(sueldo)) as nombreyapellido,
  stuff(sueldo,1,0,'$  ') as sueldofinal from empleados;