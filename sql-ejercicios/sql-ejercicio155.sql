/*144 - Disparador de actualización (update trigger)

Podemos crear un disparador para que se ejecute siempre que una instrucción 
"update" actualice los datos de una tabla.

Sintaxis básica:

create trigger NOMBREDISPARADOR
on NOMBRETABLA
for update
as 
SENTENCIAS

Analizamos la sintaxis:

"create trigger" junto al nombre del disparador; "on" seguido del nombre de
la tabla para la cual se establece el trigger.

Luego de "for" se coloca el evento (en este caso "update"), lo que indica
que las actualizaciones sobre la tabla activarán el trigger.

Luego de "as" se especifican las condiciones y acciones, es decir, 
las condiciones que determinan cuando un intento de modificación 
provoca las acciones que el trigger realizará.

El siguiente disparador de actualización se crea para evitar que 
se modifiquen los datos de la tabla "libros":

create trigger DIS_libros_actualizar
on libros
for update
as
raiserror('Los datos de la tabla "libros" no pueden modificarse', 10, 1)
rollback transaction

Entonces, creamos el disparador ("create trigger") dándole un nombre ("DIS_libros_actualizar") 
sobre una tabla específica ("libros") para ("for") el suceso de actualización ("update").
Luego de "as" colocamos las sentencias, las acciones que el trigger realizará cuando
se intente actualizar uno o varios registros en "libros" (en este caso, impedir las modificaciones).

Cuando se ejecuta una instrucción "update" en una tabla que tiene definido un disparador,
los registros originales (antes de ser actualizados) se mueven a la tabla virtual "deleted"
y los registros actualizados (con los nuevos valores) se copian a la tabla virtual "inserted".
Dentro del trigger se puede acceder a estas tablas.

En el cuerpo de un trigger se puede emplear la función "update(campo)" que recibe un campo 
y retorna verdadero si el evento involucra actualizaciones (o inserciones) en ese campo; 
en caso contrario retorna "false".

Creamos un disparador que evite que se actualice el campo "precio" de la tabla "libros":

create trigger DIS_libros_actualizar_precio
on libros
for update
as
if update(precio)
begin
raiserror('El precio de un libro no puede modificarse.', 10, 1)
rollback transaction
end;

Empleamos "if update()" para que el trigger controle la actualización del campo "precio";
así, cuando el disparador detecte una actualización en tal campo, realizará las acciones
apropiadas (mostrar un mensaje y deshacer la actualización); en caso que se actualice 
otro campo, el disparador se activa, pero permite la transacción.

Creamos un disparador de actualización que muestra el valor anterior y nuevo valor de 
los registros actualizados:

create trigger DIS_libros_actualizar2
on libros
for update
as
if (update(titulo) or update(autor) or update(editorial)) and
not (update(precio) or update(stock))
begin
select d.codigo,
(d.titulo+'-'+ d.autor+'-'+d.editorial) as 'registro anterior',
(i.titulo+'-'+ i.autor+'-'+i.editorial) as 'registro actualizado'
    from deleted as d
    join inserted as i
    on d.codigo=i.codigo
end
else
begin
raiserror('El precio y stock no pueden modificarse. La actualización no se realizó.', 10, 1)
rollback transaction
end;

Empleamos "if update" para que el trigger controle si la actualización se realiza en 
ciertos campos permitidos (titulo, autor y editorial) y no en los campos prohibidos 
(precio y stock)); si se modifican los campos permitidos y ninguno de los no permitidos,
mostrará los antiguos y nuevos valores consultando las tablas "deleted" e "inserted", 
en caso que se actualice un campo no permitido, el disparador muestra un mensaje y deshace la transacción.

Note que el disparador no controla los intentos de actualización sobre el campo "codigo",
esto es porque tal campo, no puede modificarse porque está definido "identity",
si intentamos modificarlo, SQL Server muestra un mensaje de error y el trigger no llega a dispararse.
*/

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

go

insert into libros values('Uno','Richard Bach','Planeta',15,100);
insert into libros values('Alicia en el pais...','Lewis Carroll','Planeta',18,50);
insert into libros values('El aleph','Borges','Emece',25,200);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45,200);

go

-- Creamos un disparador para evitar que se modifiquen los datos de la tabla "libros":
create trigger DIS_libros_actualizar
  on libros
  for update
  as
    raiserror('Los datos de la tabla "libros" no pueden modificarse', 10, 1)
    rollback transaction;

go

-- Intentamos realizar alguna actualización en "libros":
update libros set titulo='Alicia en el pais de las maravillas' where codigo=2;
-- El disparador se activó, mostró un mensaje y deshizo la actualización.

-- Eliminamos el disparador creado anteriormente:
drop trigger DIS_libros_actualizar;

go

-- Creamos un disparador que evite que se actualice el campo "precio" de la tabla "libros":
create trigger DIS_libros_actualizar_precio
  on libros
  for update
  as
   if update(precio)
   begin
    raiserror('El precio de un libro no puede modificarse.', 10, 1)
    rollback transaction
   end;

go

-- Veamos qué sucede si intentamos actualizar el precio de un libro:
update libros set precio=30 where codigo=2;
-- El disparador se activa, muestra un mensaje y deshace la transacción.

-- Veamos qué sucede al actualizar el campo "titulo":
update libros set titulo='Alicia en el pais de las maravillas' where codigo=2;
-- El disparador se activa y realiza la transacción

-- Lo verificamos consultando la tabla:
select * from libros;

-- Veamos qué sucede si intentamos actualizar el precio y la editorial de un libro:
update libros set precio=30,editorial='Emece' where codigo=1;
-- El disparador se activa, muestra un mensaje y deshace la transacción; 
--el registro no fue actualizado.

-- Lo verificamos consultando la tabla:
select * from libros;

-- Eliminamos el disparador creado anteriormente:
drop trigger DIS_libros_actualizar_precio;

go

-- Creamos un disparador de actualización que muestra el valor anterior y nuevo valor de los
-- registros actualizados. El trigger debe controlar que la actualización se realice en los 
-- campos "titulo", "autor" y "editorial" y no en los demás campos (precio y stock));
-- si se modifican los campos permitidos y ninguno de los no permitidos, mostrará los antiguos
-- y nuevos valores consultando las tablas "deleted" e "inserted", en caso que se actualice
-- un campo no permitido, el disparador muestra un mensaje y deshace la transacción:
create trigger DIS_libros_actualizar2
  on libros
  for update
  as
   if (update(titulo) or update(autor) or update(editorial)) and
    not (update(precio) or update(stock))
   begin
    select (d.titulo+'-'+ d.autor+'-'+d.editorial) as 'registro anterior',
    (i.titulo+'-'+ i.autor+'-'+i.editorial) as 'registro actualizado'
     from deleted as d
     join inserted as i
     on d.codigo=i.codigo
   end
   else
   begin
    raiserror('El precio y stock no pueden modificarse. La actualización no se realizó.', 10, 1)
    rollback transaction
   end;

go

-- Veamos qué sucede si modificamos campos permitidos:
update libros set editorial='Paidos', autor='Desconocido' where codigo>3;
-- El trigger se dispara y muestra los registros modificados, los valores antes 
-- y después de la transacción.

-- Veamos qué sucede si en la sentencia "update" intentamos modificar algún campo no permitido:
update libros set editorial='Paidos', precio=30 where codigo>3;
-- El trigger se dispara y muestra el mensaje de error, la transacción no se realizó.

-- Intentamos modificar el código de un libro:
 update libros set codigo=9 where codigo>=3; 
-- El disparador no llega a dispararse porque SQL Server muestra un mensaje de error ya que el
-- campo "codigo", por ser "identity", no puede modificarse.

