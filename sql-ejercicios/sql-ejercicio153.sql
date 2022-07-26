 /*   142 - Disparador de inserción (insert trigger)

    Podemos crear un disparador para que se ejecute siempre que una instrucción
    "insert" ingrese datos en una tabla.

    Sintaxis básica:

    create trigger NOMBREDISPARADOR
    on NOMBRETABLA
    for insert
    as 
    SENTENCIAS

    Analizamos la sintaxis:

    "create trigger" junto al nombre del disparador; "on" seguido del nombre de 
    la tabla para la cual se establece el trigger.

    Luego de "for" se coloca el evento (en este caso "insert"), lo que indica que
    las inserciones sobre la tabla activarán el trigger.

    Luego de "as" se especifican las condiciones y acciones, es decir, las condiciones
    que determinan cuando un intento de inserción provoca las acciones que el trigger realizará.

    Creamos un trigger sobre la tabla "ventas" para el evento de inserción.
    Cada vez que se realiza un "insert" sobre "ventas", el disparador se ejecuta.
    El disparador controla que la cantidad que se intenta vender sea menor o igual
    al stock del libro y actualiza el campo "stock" de "libros", restando al valor 
    anterior la cantidad vendida:

    create trigger DIS_ventas_insertar
    on ventas
    for insert
    as
    declare @stock int
    select @stock= stock from libros
            join inserted
            on inserted.codigolibro=libros.codigo
            where libros.codigo=inserted.codigolibro
    if (@stock>=(select cantidad from inserted))
    update libros set stock=stock-inserted.cantidad
        from libros
        join inserted
        on inserted.codigolibro=libros.codigo
        where codigo=inserted.codigolibro
    else
    begin
    raiserror ('Hay menos libros en stock de los solicitados para la venta', 16, 1)
    rollback transaction
    end

    Entonces, creamos el disparador ("create trigger") dándole un nombre ("DIS_ventas_insertar")
    sobre ("on") una tabla específica ("ventas") para ("for") el suceso de inserción ("insert"). 
    Luego de "as" colocamos las sentencias, las acciones que el trigger realizará cuando se 
    ingrese un registro en "ventas" (en este caso, controlar que haya stock y disminuir el stock de "libros").

    Cuando se activa un disparador "insert", los registros se agregan a la tabla del disparador
    y a una tabla denominada "inserted". La tabla "inserted" es una tabla virtual que contiene
    una copia de los registros insertados; tiene una estructura similar a la tabla en que se 
    define el disparador, es decir, la tabla en que se intenta la acción. La tabla "inserted" 
    guarda los valores nuevos de los registros.

    Dentro del trigger se puede acceder a esta tabla virtual "inserted" que contiene 
    todos los registros insertados, es lo que hicimos en el disparador creado anteriormente, 
    lo que solicitamos es que se le reste al "stock" de "libros", la cantidad ingresada en el
    nuevo registro de "ventas", valor que recuperamos de la tabla "inserted".

    "rollback transaction" es la sentencia que deshace la transacción, es decir, borra todas 
    las modificaciones que se produjeron en la última transacción restableciendo todo al estado anterior.

    "raiserror" muestra un mensaje de error personalizado.

    Para identificar fácilmente los disparadores de otros objetos se recomienda usar un prefijo
    y darles el nombre de la tabla para la cual se crean junto al tipo de acción.

    La instrucción "writetext" no activa un disparador.
*/
if object_id('ventas') is not null
  drop table ventas;
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
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
);

go

insert into libros values('Uno','Richard Bach',15,100);
insert into libros values('Ilusiones','Richard Bach',18,50);
insert into libros values('El aleph','Borges',25,200);
insert into libros values('Aprenda PHP','Mario Molina',45,200);

go

-- Creamos un disparador para que se ejecute cada vez que una instrucción "insert" 
-- ingrese datos en "ventas"; el mismo controlará que haya stock en "libros"
-- y actualizará el campo "stock":
create trigger DIS_ventas_insertar
  on ventas
  for insert
  as
   declare @stock int
   select @stock= stock from libros
		 join inserted
		 on inserted.codigolibro=libros.codigo
		 where libros.codigo=inserted.codigolibro
  if (@stock>=(select cantidad from inserted))
    update libros set stock=stock-inserted.cantidad
     from libros
     join inserted
     on inserted.codigolibro=libros.codigo
     where codigo=inserted.codigolibro
  else
  begin
    raiserror ('Hay menos libros en stock de los solicitados para la venta', 16, 1)
    rollback transaction
  end

go

set dateformat ymd;

-- Ingresamos un registro en "ventas":
insert into ventas values('2018/04/01',1,15,1);
-- Al ejecutar la sentencia de inserción anterior, se disparó el trigger, el registro
-- se agregó a la tabla del disparador ("ventas") y disminuyó el valor del campo "stock"
-- de "libros".

-- Verifiquemos que el disparador se ejecutó consultando la tabla "ventas" y "libros":
select * from ventas;
select * from libros where codigo=1;

-- Ingresamos un registro en "ventas", solicitando una cantidad superior al stock 
-- (El disparador se ejecuta y muestra un mensaje, la inserción no se realizó porque
-- la cantidad solicitada supera el stock.):
 insert into ventas values('2018/04/01',2,18,100);

 -- Finalmente probaremos ingresar una venta con un código de libro inexistente
 -- (El trigger no llegó a ejecutarse, porque la comprobación de restricciones 
 -- (que se ejecuta antes que el disparador) detectó que la infracción a la "foreign key"):
 insert into ventas values('2018/04/01',5,18,1);