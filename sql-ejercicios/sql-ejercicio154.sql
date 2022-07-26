/*143 - Disparador de borrado (delete trigger)

Podemos crear un disparador para que se ejecute siempre que una instrucción 
"delete" elimine datos en una tabla.

Sintaxis básica:

create trigger NOMBREDISPARADOR
on NOMBRETABLA
for delete
as 
SENTENCIAS

Analizamos la sintaxis:

"create trigger" junto al nombre del disparador; "on" seguido del nombre 
de la tabla para la cual se establece el trigger.

Luego de "for" se coloca el evento (en este caso "delete"), lo que indica 
que las eliminaciones sobre la tabla activarán el trigger.

Luego de "as" se especifican las condiciones que determinan cuando un 
intento de eliminación causa las acciones que el trigger realizará.

El disparador del siguiente ejemplo se crea para la tabla "ventas",
para que cada vez que se elimine un registro de "ventas",
se actualice el campo "stock" de la tabla "libros" 
(por ejemplo, si el comprador devuelve los libros comprados):

create trigger DIS_ventas_borrar
on ventas
for delete 
as
update libros set stock= libros.stock+deleted.cantidad
from libros
join deleted
on deleted.codigolibro=libros.codigo;

Entonces, creamos el disparador ("create trigger") dándole un nombre 
("DIS_ventas_borrar") sobre ("on") una tabla específica ("ventas") 
para ("for") el evento de borrado ("delete"). Luego de "as" colocamos
las sentencias, las acciones que el trigger realizará cuando se elimine
un registro en "ventas" (en este caso, aumentar el stock de "libros").

Cuando se activa un disparador "delete", los registros eliminados en la
tabla del disparador se agregan a una tabla llamada "deleted".
La tabla "deleted" es una tabla virtual que conserva una copia 
de los registros eliminados; tiene una estructura similar a la
tabla en que se define el disparador, es decir, la tabla en que se intenta la acción.

Dentro del trigger se puede acceder a esta tabla virtual "deleted".

El siguiente disparador se crea para controlar que no se elimine más de
un registro de la tabla "libros". El disparador se activa cada vez que
se elimina un registro o varios, controlando la cantidad de registros 
que se están eliminando; si se está eliminando más de un registro,
el disparador retorna un mensaje de error y deshace la transacción:

create trigger DIS_libros_borrar
on libros
for delete
as
if (select count(*) from deleted) > 1
begin
raiserror('No puede borrar más de un libro',16,1)
rollback transaction
end;

Si se ejecuta un "delete" sobre "libros" que afecte a varios registros, 
se activa el disparador y evita la transacción.

Si se ejecuta el siguiente "delete", que afecta a un solo registro, 
se activa el disparador y permite la transacción:

delete from libros where codigo=5;

La sentencia "truncate table" no puede incluirse en un disparador de borrado (delete trigger).
*/
if object_id('ventas') is not null
  drop table ventas;
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2), 
  stock int,
  constraint PK_libros primary key(codigo)
);

create table ventas(
  numero int identity,
  fecha datetime,
  codigolibro int not null,
  precio decimal (6,2),
  cantidad int,
  constraint PK_ventas primary key(numero),
  constraint FK_ventas_codigolibro
   foreign key (codigolibro) references libros(codigo)
   on delete no action
 );

go

insert into libros values('Uno','Richard Bach','Planeta',15,100);
insert into libros values('Ilusiones','Richard Bach','Planeta',18,50);
insert into libros values('El aleph','Borges','Emece',25,200);
insert into libros values('Aprenda PHP','Mario Molina','Emece',45,200);

set dateformat ymd;

insert into ventas values('2018/01/01',1,15,1);
insert into ventas values('2018/01/01',2,18,2);

go

-- Creamos un disparador para actualizar el campo "stock" de la tabla "libros" 
-- cuando se elimina un registro de la tabla "ventas" 
--(por ejemplo, si el comprador devuelve los libros comprados):
create trigger DIS_ventas_borrar
  on ventas
  for delete 
 as
   update libros set stock= libros.stock+deleted.cantidad
   from libros
   join deleted
   on deleted.codigolibro=libros.codigo;

go

--Eliminamos un registro de "ventas":
delete from ventas where numero=2; 
-- Al ejecutar la sentencia de eliminación anterior, se disparó el trigger, 
--el registro se eliminó de la tabla del disparador ("ventas") y
-- se actualizó el stock en "libros"

-- Verifiquemos que el disparador se ejecutó consultando la tabla "libros"
-- y vemos si el stock aumentó:
select * from libros where codigo=2;

-- Verificamos que el registro se eliminó de "ventas":
select * from ventas;

go

-- Creamos un disparador para controlar que no se elimine más de un registro
-- de la tabla "libros". El disparador se activa cada vez que se ejecuta un "delete" 
-- sobre "libros", controlando la cantidad de registros que se están eliminando;
-- si se está eliminando más de un registro, el disparador retorna un mensaje 
--de error y deshace la transacción:
create trigger DIS_libros_borrar
  on libros
  for delete
  as
   if (select count(*) from deleted) > 1
   begin
    raiserror('No puede eliminar más de un libro',16,1)
    rollback transaction
   end;

go

-- Solicitamos la eliminación de varios registros de "libros" 
-- (Se activa el disparador y deshace la transacción):
delete from libros where editorial='Emece';

-- Solicitamos la eliminación de un solo libro 
-- (Se activa el disparador y permite la transacción):
delete from libros where codigo=4;

-- Consultamos la tabla y vemos que el libro fue eliminado:
select * from libros;