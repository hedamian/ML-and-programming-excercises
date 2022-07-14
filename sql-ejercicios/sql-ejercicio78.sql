--autocombinacion

--Dijimos que es posible combinar una tabla consigo misma.

--Un pequeño restaurante tiene almacenadas sus comidas en una tabla llamada "comidas" que consta
-- de los siguientes campos:

--- nombre varchar(20),
--- precio decimal (4,2) y
--- rubro char(6)-- que indica con 'plato' si es un plato principal y 'postre' si es postre.

--Podemos obtener la combinación de platos empleando un "cross join" con una sola tabla:

--select c1.nombre as 'plato principal',
--c2.nombre as postre,
--c1.precio+c2.precio as total
--from comidas as c1
--cross join comidas as c2;

--En la consulta anterior aparecen filas duplicadas, para evitarlo debemos emplear un "where":

--select c1.nombre as 'plato principal',
--c2.nombre as postre,
--c1.precio+c2.precio as total
--from comidas as c1
--cross join comidas as c2
--where c1.rubro='plato' and
--c2.rubro='postre';

--En la consulta anterior se empleó un "where" que especifica que se combine "plato" con "postre".

--En una autocombinación se combina una tabla con una copia de si misma. Para ello debemos utilizar
-- 2 alias para la tabla. Para evitar que aparezcan filas duplicadas, debemos emplear un "where".

--También se puede realizar una autocombinación con "join":

--select c1.nombre as 'plato principal',
--c2.nombre as postre,
--c1.precio+c2.precio as total
--from comidas as c1
--join comidas as c2
--on c1.codigo<>c2.codigo
--where c1.rubro='plato' and
--c2.rubro='postre';

--Para que no aparezcan filas duplicadas se agrega un "where".

if object_id('comidas') is not null
  drop table comidas;

create table comidas(
  codigo int identity,
  nombre varchar(30),
  precio decimal(4,2),
  rubro char(6),-- 'plato'=plato principal', 'postre'=postre
  primary key(codigo)
);

go

insert into comidas values('ravioles',5,'plato');
insert into comidas values('tallarines',4,'plato');
insert into comidas values('milanesa',7,'plato');
insert into comidas values('cuarto de pollo',6,'plato');
insert into comidas values('flan',2.5,'postre');
insert into comidas values('porcion torta',3.5,'postre');

-- Realizamos un "cross join"
-- Note que aparecen filas duplicadas, por ejemplo, "ravioles" se
-- combina con "ravioles" y la combinación "ravioles- flan"
-- se repite como "flan- ravioles"
select c1.nombre as 'plato principal',
  c2.nombre as postre,
  c1.precio+c2.precio as total
  from comidas as c1
  cross join comidas as c2;

-- Debemos especificar que combine el rubro "plato" con "postre":
select c1.nombre as 'plato principal',
  c2.nombre as postre,
  c1.precio+c2.precio as total
  from comidas as c1
  cross join comidas as c2
  where c1.rubro='plato' and
  c2.rubro='postre';

-- También se puede realizar una autocombinación con "join":
select c1.nombre as 'plato principal',
  c2.nombre as postre,
  c1.precio+c2.precio as total
  from comidas as c1
  join comidas as c2
  on c1.codigo<>c2.codigo
  where c1.rubro='plato' and
  c2.rubro='postre';    