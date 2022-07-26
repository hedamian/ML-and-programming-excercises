-- 135 - Funciones escalares (crear y llamar)

-- Una función escalar retorna un único valor. Como todas las funciones, 
-- se crean con la instrucción "create function". La sintaxis básica es:

-- create function NOMBRE
-- (@PARAMETRO TIPO=VALORPORDEFECTO)
-- returns TIPO
-- begin
-- INSTRUCCIONES
-- return VALOR
-- end;

-- Luego del nombre se colocan (opcionalmente) los parámetros de entrada con su tipo.

-- La cláusula "returns" indica el tipo de dato retornado.

-- El cuerpo de la función, se define en un bloque "begin...end" que contiene
-- las instrucciones que retornan el valor. El tipo del valor retornado puede 
-- ser de cualquier tipo, excepto text, ntext, image, cursor o timestamp.

-- Creamos una simple función denominada "f_promedio" que recibe 2 valores
-- y retorna el promedio:

-- create function f_promedio
-- (@valor1 decimal(4,2),
-- @valor2 decimal(4,2)
-- )
-- returns decimal (6,2)
-- as
-- begin 
-- declare @resultado decimal(6,2)
-- set @resultado=(@valor1+@valor2)/2
-- return @resultado
-- end;

-- Entonces, luego de "create function" y el nombre de la función,
----  se deben especificar los parámetros de entrada con sus tipos de datos
----  (entre paréntesis), el tipo de dato que retorna luego de "returns", 
----  luego de "as" comienza el bloque "begin...end" dentro del cual se encuentran
----  las instrucciones de procesamiento y el valor retornado luego de "return".

-- En el ejemplo anterior se declara una variable local a la función
-- (desaparece al salir de la función) que calcula el resultado que se retornará.

-- Al hacer referencia a una función escalar, se debe especificar el
-- propietario y el nombre de la función:

-- select dbo.f_promedio(5.5,8.5);

-- Cuando llamamos a funciones que tienen definidos parámetros de entrada
-- DEBEMOS suministrar SIEMPRE un valor para él.

-- Si llamamos a la función anterior sin enviarle los valores para los parámetros:

-- select dbo.f_promedio();

-- SQL Server muestra un mensaje de error indicando que necesita argumentos.

-- Creamos una función a la cual le enviamos una fecha y nos retorna 
-- el nombre del mes en español:

-- create function f_nombreMes
-- (@fecha datetime='2007/01/01')
-- returns varchar(10)
-- as
-- begin
-- declare @nombre varchar(10)
-- set @nombre=
-- case datename(month,@fecha)
-- when 'January' then 'Enero'
-- when 'February' then 'Febrero'
-- when 'March' then 'Marzo'
-- when 'April' then 'Abril'
-- when 'May' then 'Mayo'
-- when 'June' then 'Junio'
-- when 'July' then 'Julio'
-- when 'August' then 'Agosto'
-- when 'September' then 'Setiembre'
-- when 'October' then 'Octubre'
-- when 'November' then 'Noviembre'
-- when 'December' then 'Diciembre'
-- end--case
-- return @nombre
-- end;

-- Analicemos: luego de "create function" y el nombre de la función, 
-- especificamos los parámetros de entrada con sus tipos de datos (entre paréntesis).
----  El parámetro de entrada tiene definido un valor por defecto.

-- Luego de los parámetros de entrada se indica el tipo de dato que retorna luego de "returns";
-- luego de "as" comienza el bloque "begin...end" dentro del cual se encuentran las 
-- instrucciones de procesamiento y el valor retornado luego de "return".

-- Las funciones que retornan un valor escalar pueden emplearse en cualquier consulta 
-- donde se coloca un campo.

-- Recuerde que al invocar una función escalar, se debe especificar el propietario
-- y el nombre de la función:

-- select nombre,
-- dbo.f_nombreMes(fechaingreso) as 'mes de ingreso'
-- from empleados;

-- No olvide que cuando invocamos funciones que tienen definidos parámetros 
-- de entrada DEBEMOS suministrar SIEMPRE un valor para él.

-- Podemos colocar un valor por defecto al parámetro, pero al invocar la función,
-- para que tome el valor por defecto DEBEMOS especificar "default".
-- Por ejemplo, si llamamos a la función anterior sin enviarle un valor:

-- select dbo.f_nombreMes();

-- SQL Server muestra un mensaje de error indicando que necesita argumento.

-- Para que tome el valor por defecto debemos enviar "default" como argumento:

-- select dbo.f_nombreMes(default);

-- La instrucción "create function" debe ser la primera sentencia de un lote.

-- Especificamos el entorno de idioma para la sesión. 
-- El idioma de la sesión determina los formatos de fecha y hora
--  y los mensajes del sistema.
set language us_english; 

-- Una empresa tiene almacenados los datos de sus empleados en una tabla denominada "empleados".
--Eliminamos la tabla, si existe y la creamos con la siguiente estructura:
if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  documento char(8) not null,
  nombre varchar(30),
  fechaingreso datetime,
  mail varchar(50),
  telefono varchar(12)
);

go

-- Fijamos el formato de la fecha
set dateformat ymd;

insert into empleados values('22222222', 'Ana Acosta','1985/10/10','anaacosta@gmail.com','4556677');
insert into empleados values('23333333', 'Bernardo Bustos', '1986/02/15',null,'4558877');
insert into empleados values('24444444', 'Carlos Caseros','1999/12/02',null,null);
insert into empleados values('25555555', 'Diana Dominguez',null,null,'4252525');

-- Eliminamos, si existe, la función "f_fechaCadena":
if object_id('dbo.f_fechaCadena') is not null
  drop function dbo.f_fechaCadena;

go

-- Creamos una función a la cual le enviamos una fecha (de tipo varchar),
-- en el cuerpo de la función se analiza si el dato enviado corresponde a una fecha, 
-- si es así, se almacena en una variable el mes (en español) y se le concatenan el día 
-- y el año y se retorna esa cadena; en caso que el valor enviado no corresponda a una fecha,
-- la función retorna la cadena 'Fecha inválida':
create function f_fechaCadena
 (@fecha varchar(25))
  returns varchar(25)
  as
  begin
    declare @nombre varchar(25)
    set @nombre='Fecha inválida'   
    if (isdate(@fecha)=1)
    begin
      set @fecha=cast(@fecha as datetime)
      set @nombre=
      case datename(month,@fecha)
       when 'January' then 'Enero'
       when 'February' then 'Febrero'
       when 'March' then 'Marzo'
       when 'April' then 'Abril'
       when 'May' then 'Mayo'
       when 'June' then 'Junio'
       when 'July' then 'Julio'
       when 'August' then 'Agosto'
       when 'September' then 'Setiembre'
       when 'October' then 'Octubre'
       when 'November' then 'Noviembre'
       when 'December' then 'Diciembre'
      end--case
      set @nombre=rtrim(cast(datepart(day,@fecha) as char(2)))+' de '+@nombre
      set @nombre=@nombre+' de '+ rtrim(cast(datepart(year,@fecha)as char(4)))
    end--si es una fecha válida
    return @nombre
 end;

go

-- Recuperamos los registros de "empleados", mostrando el nombre y la fecha
-- de ingreso empleando la función creada anteriormente:
select nombre, dbo.f_fechaCadena(fechaingreso) as ingreso from empleados;

-- Empleamos la función en otro contexto:
select dbo.f_fechaCadena(getdate());