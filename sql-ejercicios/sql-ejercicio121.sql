--Lenguaje de control de flujo (if)

--Existen palabras especiales que pertenecen al lenguaje de control de flujo que
-- controlan la ejecución de las sentencias, los bloques de sentencias y procedimientos almacenados.

--Tales palabras son: begin... end, goto, if... else, return, waitfor, while, break y continue.

--- "begin... end" encierran un bloque de sentencias para que sean tratados como unidad.

--- "if... else": testean una condición; se emplean cuando un bloque de sentencias debe ser 
--ejecutado si una condición se cumple y si no se cumple, se debe ejecutar otro bloque de
-- sentencias diferente.

--- "while": ejecuta repetidamente una instrucción siempre que la condición sea verdadera.

--- "break" y "continue": controlan la operación de las instrucciones incluidas en el bucle "while".

--Veamos un ejemplo. Tenemos nuestra tabla "libros"; queremos mostrar todos los 
--títulos de los cuales no hay libros disponibles (cantidad=0), si no hay, 
--mostrar un mensaje indicando tal situación:

-- if exists (select * from libros where cantidad=0)
--  (select titulo from libros where cantidad=0)
-- else
--  select 'No hay libros sin stock';
--SQL Server ejecuta la sentencia (en este caso, una subconsulta) luego del "if" si la 
--condición es verdadera; si es falsa, ejecuta la sentencia del "else" (si existe).

--Podemos emplear "if...else" en actualizaciones. Por ejemplo, queremos hacer un descuento 
--en el precio, del 10% a todos los libros de una determinada editorial; si no hay, mostrar un mensaje:

-- if exists (select * from libros where editorial='Emece')
-- begin
--  update libros set precio=precio-(precio*0.1) where editorial='Emece'
--  select 'libros actualizados'
-- end
-- else
--  select 'no hay registros actualizados';
--Note que si la condición es verdadera, se deben ejecutar 2 sentencias. 
--Por lo tanto, se deben encerrar en un bloque "begin...end".

--En el siguiente ejemplo eliminamos los libros cuya cantidad es cero; si no hay,
-- mostramos un mensaje:

-- if exists (select * from libros where cantidad=0)
--  delete from libros where cantidad=0
-- else
--  select 'No hay registros eliminados;
--Dentro de los comandos SQL select, update y delete no podemos hacer uso de la 
--sentencia de control de flujo if, debemos utilizar la sentencia case que vimos 
--en el concepto anterior.

--A partir de la versión 2012 de SQL Server disponemos de la función integrada iif:

--select titulo,costo=iif(precio<38,'barato','caro') from libros;

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  cantidad tinyint,
  primary key (codigo)
);

go

insert into libros values('Uno','Richard Bach','Planeta',15,100);
insert into libros values('El aleph','Borges','Emece',20,150);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',50,200);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,0);
insert into libros values('Java en 10 minutos','Mario Molina','Emece',40,200);

-- Mostramos los títulos de los cuales no hay libros disponibles (cantidad=0); 
-- en caso que no haya, mostramos un mensaje:
if exists (select * from libros where cantidad=0)
  (select titulo from libros where cantidad=0)
else
  select 'No hay libros sin stock';

-- Hacemos un descuento del 10% a todos los libros de editorial "Emece";
-- si no hay, mostramos un mensaje:
if exists (select * from libros where editorial='Emece')
begin
  update libros set precio=precio-(precio*0.1) where editorial='Emece'
  select 'libros actualizados'
end
else
  select 'no hay registros actualizados';

-- Veamos si se actualizaron:
select * from libros where editorial='Emece';

-- Eliminamos los libros de los cuales no hay stock (cantidad=0); 
-- si no hay, mostramos un mensaje:
if exists (select * from libros where cantidad=0)
  delete from libros where cantidad=0
else
  select 'No hay registros eliminados';

-- Ejecutamos nuevamente la sentencia anterior (Ahora se ejecuta la sentencia
-- del "else" porque no hay registros que cumplieran la condición.):
if exists (select * from libros where cantidad=0)
  delete from libros where cantidad=0
 else
  select 'No hay registros eliminados';

select titulo,costo=iif(precio<38,'barato','caro') from libros;