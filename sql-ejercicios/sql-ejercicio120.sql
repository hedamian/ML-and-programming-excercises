--Lenguaje de control de flujo (case)


--La sentencia "case" compara 2 o más valores y devuelve un resultado.
--La sintaxis es la siguiente:

-- case VALORACOMPARAR
--  when VALOR1 then RESULTADO1
--  when VALOR2 then RESULTADO2
--  ...
--  else RESULTADO3
-- end
--Por cada valor hay un "when" y un "then"; si encuentra un valor coincidente 
--en algún "when" ejecuta el "then" correspondiente a ese "when", si no encuentra
-- ninguna coincidencia, se ejecuta el "else"; si no hay parte "else" retorna "null".
--  Finalmente se coloca "end" para indicar que el "case" ha finalizado.

--Un profesor guarda las notas de sus alumnos de un curso en una tabla llamada "alumnos"
-- que consta de los siguientes campos:

--- nombre (30 caracteres),
--- nota (valor entero entre 0 y 10, puede ser nulo).
--Queremos mostrar los nombres, notas de los alumnos y en una columna extra llamada
-- "resultado" empleamos un case que testee la nota y muestre un mensaje diferente 
-- si en dicho campo hay un valor:

--- 0, 1, 2 ó 3: 'libre';
--- 4, 5 ó 6: 'regular';
--- 7, 8, 9 ó 10: 'promocionado';
--Esta es la sentencia:

-- select nombre,nota, resultado=
-- case nota
--  when 0 then 'libre'
--  when 1 then 'libre'
--  when 2 then 'libre'
--  when 3 then 'libre'
--  when 4 then 'regular'
--  when 5 then 'regular'
--  when 6 then 'regular'
--  when 7 then 'promocionado'
--  when 8 then 'promocionado'
--  when 9 then 'promocionado'
--  when 10 then 'promocionado'
-- end
--from alumnos;
--Note que cada "when" compara un valor puntual, por ello los valores devueltos 
--son iguales para algunos casos. Note que como omitimos la parte "else", 
--en caso que el valor no encuentre coincidencia con ninguno valor "when", 
--retorna "null".

--Podemos realizar comparaciones en cada "when". La sintaxis es la siguiente:

-- case
--  when VALORACOMPARAR OPERADOR VALOR1 then RESULTADO1
--  when VALORACOMPARAR OPERADOR VALOR2 then RESULTADO2
--  ...
--  else RESULTADO3
-- end
--Mostramos los nombres de los alumnos y en una columna extra llamada "resultado" 
--empleamos un case que testee si la nota es menor a 4, está entre 4 y 7 o supera el 7:

--select nombre, nota, condicion=
--  case 
--   when nota<4 then 'libre'
--   when nota >=4 and nota<7 then 'regular'
--   when nota>=7 then 'promocionado'
--   else 'sin nota'
--  end
-- from alumnos;
--Puede utilizar una expresión "case" en cualquier lugar en el que pueda utilizar una expresión.

--También se puede emplear con "group by" y funciones de agrupamiento.

if object_id('alumnos') is not null
  drop table alumnos;

create table alumnos(
  nombre varchar(40),
  nota tinyint,
    constraint CK_alunos_nota check (nota>=0 and nota<=10)
);

go

insert into alumnos values('Ana Acosta',8);
insert into alumnos values('Carlos Caseres',4);
insert into alumnos values('Federico Fuentes',2);
insert into alumnos values('Gaston Guzman',3);
insert into alumnos values('Hector Herrero',5);
insert into alumnos values('Luis Luna',10);
insert into alumnos values('Marcela Morales',7);
insert into alumnos values('Marcela Morales',null);

-- Queremos mostrar el nombre y nota de cada alumno y en una columna
--  extra llamada "condicion" empleamos un case que testee la nota 
-- y muestre un mensaje diferente según la nota:
select nombre,nota, condicion=
 case nota
  when 0 then 'libre'
  when 1 then 'libre'
  when 2 then 'libre'
  when 3 then 'libre'
  when 4 then 'regular'
  when 5 then 'regular'
  when 6 then 'regular'
  when 7 then 'promocionado'
  when 8 then 'promocionado'
  when 9 then 'promocionado'
  when 10 then 'promocionado'
 end
 from alumnos;

-- Obtenemos la misma salida pero empleando el "case" con operadores de comparación:
select nombre, nota, condicion=
  case 
   when nota<4 then 'libre'
   when nota >=4 and nota<7 then 'regular'
   when nota>=7 then 'promocionado'
   else 'sin nota'
  end
 from alumnos;

-- Vamos a agregar el campo "condicion" a la tabla:
alter table alumnos
  add condicion varchar(20);

go

select * from alumnos;

-- Recordemos que se puede emplear una expresión "case" en cualquier lugar en el 
-- que pueda utilizar una expresión. 
-- Queremos actualizar el campo "condicion" para guardar la condición de cada 
-- alumno según su nota:
update alumnos set condicion=
  case
   when nota<4 then 'libre'
   when nota between 4 and 7 then 'regular'
   when nota >7 then 'promocionado'
  end;

 select * from alumnos;

 -- Mostramos la cantidad de alumnos libres, regulares y aprobados
 -- y en una columna extra mostramos un mensaje, ordenamos por cantidad:
 select condicion, count(*) as cantidad,resultado=
  case condicion
    when 'libre' then 'repitentes'
    when 'regular' then 'rinden final'
    when 'promocionado' then 'no rinden final'
    else 'sin datos'
  end
 from alumnos
 group by condicion
 order by cantidad;