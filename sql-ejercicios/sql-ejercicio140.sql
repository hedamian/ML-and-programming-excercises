--129 - Procedimientos almacenados (anidados)

--Un procedimiento almacenado puede llamar a otro procedimiento almacenado.
--El procedimiento que es invocado por otro debe existir cuando creamos el
--procedimiento que lo llama. Es decir, si un procedimiento A llama a
--otro procedimiento B, B debe existir al crear A.

--Los procedimientos almacenados pueden anidarse hasta 32 niveles.

--Creamos un procedimiento almacenado que reciba 2 números enteros y nos
--retorne el producto de los mismos:

--create procedure pa_multiplicar
--@numero1 int,
--@numero2 int,
--@producto int output
--as
--select @producto=@numero1*@numero2;

--Creamos otro procedimiento que nos retorne el factorial de un número,
--tal procedimiento llamará al procedimiento "pa_multiplicar":

--create procedure pa_factorial
--@numero int
--as
--declare @resultado int
--declare @num int
--set @resultado=1 
--set @num=@numero 
--while (@num>1)
--begin
--exec pa_multiplicar @resultado,@num, @resultado output
--set @num=@num-1
--end
--select rtrim(convert(char,@numero))+'!='+convert(char,@resultado);


--Cuando un procedimiento (A) llama a otro (B), el segundo (B) tiene acceso a 
--todos los objetos que cree el primero (A).

-- Eliminamos, si existen, los procedimientos almacenados siguientes:
if object_id('pa_multiplicar') is not null
  drop proc pa_multiplicar;
if object_id('pa_factorial') is not null
  drop proc pa_factorial;

go

-- Creamos un procedimiento almacenado que reciba 2 números enteros
-- y nos retorne el producto de los mismos:
create procedure pa_multiplicar
  @numero1 int,
  @numero2 int,
  @producto int output
  as
   select @producto=@numero1*@numero2;

go

-- Probamos el procedimiento anterior:
declare @x int
exec pa_multiplicar 3,9, @x output
select @x as '3*9'
exec pa_multiplicar 50,8, @x output
select @x as '50*8';

go

-- Creamos un procedimiento que nos retorne el factorial de un número,
-- tal procedimiento llamará al procedimiento "pa_multiplicar":
create procedure pa_factorial
  @numero int
 as
  if @numero>=0 and @numero<=12
  begin
   declare @resultado int
   declare @num int
   set @resultado=1 
   set @num=@numero 
   while (@num>1)
   begin
     exec pa_multiplicar @resultado,@num, @resultado output
     set @num=@num-1
   end
   select rtrim(convert(char,@numero))+'!='+convert(char,@resultado)
  end
  else select 'Debe ingresar un número entre 0 y 12';

go

-- Ejecutamos el procedimiento que nos retorna el factorial de un número:
exec pa_factorial 5;
exec pa_factorial 10;

-- Veamos las dependencias del procedimiento "pa_multiplicar":
exec sp_depends pa_multiplicar;

-- Veamos las dependencias del procedimiento "pa_factorial":
exec sp_depends pa_factorial;