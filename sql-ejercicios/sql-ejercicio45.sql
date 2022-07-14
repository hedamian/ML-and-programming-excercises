---claves primarias compuestas 	

--Las claves primarias pueden ser simples, formadas por un solo campo o compuestas, más de un campo.
--Recordemos que una clave primaria identifica 1 solo registro en una tabla.
--Para un valor del campo clave existe solamente 1 registro. Los valores no se repiten ni pueden ser nulos.

--Definimos una clave compuesta cuando ningún campo por si solo cumple con la condición para ser clave.
--En este ejemplo, un auto puede ingresar varias veces en un día a la playa, pero siempre será a distinta hora.
--Usamos 2 campos como clave, la patente junto con la hora de llegada, así identificamos unívocamente cada registro.

--Nombramos los campos que formarán parte de la clave separados por comas.

--Al ingresar los registros, SQL Server controla que los valores para los campos establecidos 
--como clave primaria no estén repetidos en la tabla; si estuviesen repetidos,
 --muestra un mensaje y la inserción no se realiza. Lo mismo sucede si realizamos una actualización.
--Entonces, si un solo campo no identifica unívocamente un registro podemos definir una clave primaria compuesta, 
--es decir formada por más de un campo.

if object_id('vehiculos') is not null
  drop table vehiculos;

create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime,
  horasalida datetime,
  primary key(patente,horallegada)
);

go

insert into vehiculos values('AIC124','a','8:05','12:30');
insert into vehiculos values('CAA258','a','8:05',null);
insert into vehiculos values('DSE367','m','8:30','18:00');
insert into vehiculos values('FGT458','a','9:00',null);
insert into vehiculos values('AIC124','a','16:00',null);
insert into vehiculos values('LOI587','m','18:05','19:55');

select * from vehiculos;

-- Si intentamos ingresar un registro con clave primaria repetida: 
--insert into vehiculos values('LOI587','m','18:05',null);
--marca error

-- Si ingresamos un registro repitiendo el valor de uno de los campos
-- que forman parte de la clave, si lo acepta:
insert into vehiculos values('LOI587','m','21:30',null);

-- Si intentamos actualizar un registro repitiendo la clave primaria
-- (se genera un error):
--update vehiculos set horallegada='8:05'
 -- where patente='AIC124' and horallegada='16:00';

-- Recordemos que los campos que forman parte de la clave primaria no 
-- aceptan valores nulos, aunque no se haya aclarado en la definición 
-- de la tabla (genera un error):
--insert into vehiculos values('HUO690','m',null,null);

-- mostramos la estructura de la tabla 
-- (los campos que forman parte de la clave primaria (patente y horallegada)
--  tienen "NO" en la columna "IS_NULLABLE", es decir, no admiten valores nulos.):
exec sp_columns vehiculos;

