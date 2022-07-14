--funcion grouping

--La función "grouping" se emplea con los operadores "rollup" y "cube" para distinguir los valores de detalle
--y de resumen en el resultado. Es decir, permite diferenciar si los valores "null" que aparecen en el resultado
 --son valores nulos de las tablas o si son una fila generada por los operadores "rollup" o "cube".

--Con esta función aparece una nueva columna en la salida, una por cada "grouping"; retorna el valor 1 
--para indicar que la fila representa los valores de resumen de "rollup" o "cube" y el valor 0 para 
--representar los valores de campo.
--Sólo se puede emplear la función "grouping" en los campos que aparecen en la cláusula "group by".

if object_id('visitantes') is not null
  drop table visitantes;

create table visitantes(
  nombre varchar(30),
  sexo char(1),
  ciudad varchar(20)
);

go 

insert into visitantes values('Susana Molina', 'f', 'Cordoba');
insert into visitantes values('Marcela Mercado', 'f','Cordoba');
insert into visitantes values('Roberto Perez','f',null);
insert into visitantes values('Alberto Garcia','m','Cordoba');
insert into visitantes values('Teresa Garcia','f','Alta Gracia');

-- Contamos la cantidad de visitantes agrupando por ciudad y empleando "rollup":
select ciudad,
  count(*) as cantidad
  from visitantes
  group by ciudad
  with rollup;

-- Contamos la cantidad de visitantes agrupando por ciudad y empleando "rollup"
-- empleando grouping:
select ciudad,
  count(*) as cantidad,
  grouping(ciudad) as resumen
  from visitantes
  group by ciudad
  with rollup;

  --Entonces, si emplea los operadores "rollup" y "cube" y los campos por los cuales agrupa 
  --admiten valores nulos, utilice la función "grouping" para distinguir los valores de detalle y de resumen en el resultado.