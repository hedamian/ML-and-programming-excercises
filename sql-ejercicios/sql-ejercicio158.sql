--147 - Disparador (eliminar)

--Los triggers se eliminan con la instrucción "drop trigger":

--drop trigger NOMBREDISPARADOR;

--Si el disparador que se intenta eliminar no existe, aparece un mensaje indicándolo,
--para evitarlo, podemos verificar su existencia antes de solicitar su eliminación

--(como con cualquier otro objeto):

--if object_id('NOMBREDISPARADOR') is not null
--drop trigger NOMBREDISPARADOR;

--Eliminamos, si existe, el trigger "dis_libros_insertar":

--if object_id('dis_libros_insertar') is not null
--drop trigger dis_libros_insertar; 

--Cuando se elimina una tabla o vista que tiene asociados triggers,
--todos los triggers asociados se eliminan automáticamente.

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

-- Eliminamos trigger
drop trigger DIS_ventas_insertar;

insert into ventas values('2018/04/01',1,15,1);

-- Verifiquemos las tabla "ventas" y "libros":
select * from ventas;
select * from libros where codigo=1;