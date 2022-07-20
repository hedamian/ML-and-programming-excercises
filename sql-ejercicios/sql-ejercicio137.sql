--126 - Procedimientos almacenados (encriptado)

--Dijimos que SQL Server guarda el nombre del procedimiento almacenado en la tabla del sistema
--"sysobjects" y su contenido en la tabla "syscomments".

--Si no quiere que los usuarios puedan leer el contenido del procedimiento podemos 
--indicarle a SQL Server que codifique la entrada a la tabla "syscomments" que contiene el texto.
--Para ello, debemos colocar la opción "with encryption" al crear el procedimiento:

--create procedure NOMBREPROCEDIMIENTO
--PARAMETROS
--with encryption
--as INSTRUCCIONES;

--Esta opción es opcional.

--Creamos el procedimiento almacenado "pa_libros_autor" con la opción de encriptado:

--create procedure pa_libros_autor
--@autor varchar(30)=null
--with encryption
--as
--select *from libros
--where autor=@autor;

--Si ejecutamos el procedimiento almacenado del sistema "sp_helptext" para ver su contenido, no aparece.
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
);

go

-- Eliminamos el procedimiento llamado "pa_libros_autor", si existe:
if object_id('pa_libros_autor') is not null
  drop procedure pa_libros_autor;

go

-- Creamos el procedimiento almacenado "pa_libros_autor" con la opción de encriptado:
create procedure pa_libros_autor
  @autor varchar(30)=null
  with encryption
  as
   select *from libros
    where autor=@autor;

go

-- Ejecutamos el procedimiento almacenado del sistema "sp_helptext" para ver su contenido
-- (no aparece): 
exec sp_helptext pa_libros_autor;