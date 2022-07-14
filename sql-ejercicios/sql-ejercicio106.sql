--Subconsulta en lugar de una tabla

--Se pueden emplear subconsultas que retornen un conjunto de registros de varios campos
-- en lugar de una tabla.

--Se la denomina tabla derivada y se coloca en la cláusula "from" para que la use un "select"
--externo.

--La tabla derivada debe ir entre paréntesis y tener un alias para poder referenciarla.
-- La sintaxis básica es la siguiente:

--select ALIASdeTABLADERIVADA.CAMPO
--from (TABLADERIVADA) as ALIAS;

--La tabla derivada es una subsonsulta.

--Podemos probar la consulta que retorna la tabla derivada y luego agregar el "select" 
--externo:

--select f.*,
--(select sum(d.precio*cantidad)
--from Detalles as d
--where f.numero=d.numerofactura) as total
--from facturas as f;

--La consulta anterior contiene una subconsulta correlacionada; retorna todos los datos de "facturas" y 
--el monto total por factura de "detalles". Esta consulta retorna varios registros y varios campos y 
--será la tabla derivada que emplearemos en la siguiente consulta:

--select td.numero,c.nombre,td.total
--from clientes as c
--join (select f.*,
--(select sum(d.precio*cantidad)
--from Detalles as d
--where f.numero=d.numerofactura) as total
--from facturas as f) as td
--on td.codigocliente=c.codigo;

--La consulta anterior retorna, de la tabla derivada (referenciada con "td") el número de factura y el 
--monto total, y de la tabla "clientes", el nombre del cliente. Note que este "join" no emplea 2 tablas,
--sino una tabla propiamente dicha y una tabla derivada, que es en realidad una subconsulta.

if object_id('detalles') is not null
  drop table detalles;
if object_id('facturas') is not null
  drop table facturas;
if object_id('clientes') is not null
  drop table clientes;

create table clientes(
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  primary key(codigo)
);

create table facturas(
  numero int not null,
  fecha datetime,
  codigocliente int not null,
  primary key(numero),
  constraint FK_facturas_cliente
   foreign key (codigocliente)
   references clientes(codigo)
   on update cascade
);

create table detalles(
  numerofactura int not null,
  numeroitem int not null, 
  articulo varchar(30),
  precio decimal(5,2),
  cantidad int,
  primary key(numerofactura,numeroitem),
   constraint FK_detalles_numerofactura
   foreign key (numerofactura)
   references facturas(numero)
   on update cascade
   on delete cascade,
);

go

insert into clientes values('Juan Lopez','Colon 123');
insert into clientes values('Luis Torres','Sucre 987');
insert into clientes values('Ana Garcia','Sarmiento 576');

set dateformat ymd;

insert into facturas values(1200,'2018-01-15',1);
insert into facturas values(1201,'2018-01-15',2);
insert into facturas values(1202,'2018-01-15',3);
insert into facturas values(1300,'2018-01-20',1);

insert into detalles values(1200,1,'lapiz',1,100);
insert into detalles values(1200,2,'goma',0.5,150);
insert into detalles values(1201,1,'regla',1.5,80);
insert into detalles values(1201,2,'goma',0.5,200);
insert into detalles values(1201,3,'cuaderno',4,90);
insert into detalles values(1202,1,'lapiz',1,200);
insert into detalles values(1202,2,'escuadra',2,100);
insert into detalles values(1300,1,'lapiz',1,300);

-- Recuperar el número de factura, el código de cliente, 
-- la fecha y la suma total de todas las facturas:
 select f.*,
  (select sum(d.precio*cantidad)
    from detalles as d
    where f.numero=d.numerofactura) as total
 from facturas as f;

-- Ahora utilizaremos el resultado de la consulta anterior como una tabla 
-- derivada que emplearemos en lugar de una tabla para realizar un "join" 
-- y recuperar el número de factura, el nombre del cliente y
-- el monto total por factura:
 select td.numero,c.nombre,td.total
  from clientes as c
  join (select f.*,
   (select sum(d.precio*cantidad)
    from detalles as d
    where f.numero=d.numerofactura) as total
  from facturas as f) as td
  on td.codigocliente=c.codigo;