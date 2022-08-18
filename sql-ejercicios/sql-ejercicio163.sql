--152 - Disparador (condicionales)

--Una instrucción "insert", "update" o "delete" que invoque a un disparador
--puede afectar a varios registros. En tales casos, un trigger rechaza o 
--acepta cada transacción de modificación como una totalidad. Podemos optar por:

--1) procesar todos los registros: todos los registros afectados deberán cumplir
--los criterios del disparador para que se produzca la acción, o

--2) permitir acciones condicionales: puede definir un disparador que controle 
--si cada registro afectado cumple con la condición; si algún registro no la cumple,
--la acción no se produce para tal registro pero si para los demás que si la cumplen.

--Veamos un ejemplo. Tenemos la tabla "libros". Creamos un disparador de actualización 
--sobre la tabla "libros". Se permite actualizar el stock de varios libros a la vez; 
--pero ningún "stock" debe tener un valor negativo. Entonces, si algún "stock" queda
--con un valor negativo, no debe cambiar, los demás si:

--create trigger dis_libros_actualizar
--on libros
--after update
--as
--if exists (select *from inserted where stock<0)
--begin
--update libros set stock=deleted.stock
--from libros
--join deleted
--on deleted.codigo=libros.codigo
--join inserted
--on inserted.codigo=libros.codigo
--where inserted.stock<0;
--end;

--No podemos revertir la transacción con "rollback transaction" porque en ese caso TODOS los registros 
--modificados volverían a los valores anteriores, y lo que necesitamos es que solamente aquellos 
--que quedaron con valor negativo vuelvan a su valor original.

--Tampoco podemos evitar que se actualicen todos los registros porque se actualizan
--antes que las acciones del trigger se ejecuten.

--Lo que hacemos es, en el cuerpo del trigger, averiguar si alguno de los registros
--actualizados tiene stock negativo; si es así, volvemos a actualizarlo al valor anterior a la transacción.

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  stock int,
  constraint pk_libros primary key (codigo)
); 

go

insert into libros values('Uno','R. Bach','Planeta',50);
insert into libros values('Ilusiones','R. Bach','Planeta',15);
insert into libros values('El aleph','Borges','Emece',10);
insert into libros values('Aprenda PHP','M. Molina','Nuevo siglo',5);

go

-- Creamos un disparador de actualización sobre la tabla "libros". 
-- Se permite actualizar el stock de varios libros a la vez; pero ningún "stock"
-- debe tener un valor negativo. Si algún "stock" queda con un valor negativo,
-- no debe cambiar, los demás si:
create trigger dis_libros_actualizar
 on libros
 after update
 as
  if exists (select *from inserted where stock<0)
  begin
   update libros set stock=deleted.stock
   from libros
   join deleted
   on deleted.codigo=libros.codigo
   join inserted
   on inserted.codigo=libros.codigo
   where inserted.stock<0
  end;

-- Actualizamos el stock de todos los libros, restándoles 15:
update libros set stock=stock-15;

-- Veamos el resultado:
select * from libros;
-- Solamente se actualizaron los 2 primeros libros, cuyo valor
-- de stock era igual o superior a 15; los otros libros no se actualizaron.

