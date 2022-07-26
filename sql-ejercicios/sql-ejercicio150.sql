--139 - Funciones (encriptado)

--Las funciones definidas por el usuario pueden encriptarse,
--para evitar que sean leídas con "sp_helptext".

--Para ello debemos agregar al crearlas la opción "with encryption" antes de "as".

--En funciones escalares:

--create function NOMBREFUNCION
--(@PARAMETRO TIPO) 
--returns TIPO
--with encryption
--as 
--begin
--CUERPO
--return EXPRESION
--end

--En funciones de tabla de varias sentencias se coloca luego del formato de la tabla a retornar:
/* 
 create function NOMBREFUNCION
 (@PARAMETRO TIPO)
 returns @NOMBRETABLARETORNO table-- nombre de la tabla
 --formato de la tabla
 (CAMPO1 TIPO,
  CAMPO2 TIPO,
  CAMPO3 TIPO
 )
 with encryption
 as
 begin
   insert @NOMBRETABLARETORNO
--select CAMPOS from TABLA
-- where campo OPERADOR @PARAMETRO
   RETURN
 end

--En funciones con valores de tabla en línea:

 create function NOMBREFUNCION
 (@PARAMETRO TIPO=VALORPORDEFECTO)
 returns table
 with encryption
 as
 return (SELECT);
*/
--Veamos un ejemplo:

 create function f_libros
 (@autor varchar(30)='Borges')
 returns table
 with encryption
 as
 return (
  select titulo,editorial
  from libros
  where autor like '%'+@autor+'%'
 );

--Si ejecutamos el procedimiento almacenado del sistema "sp_helptext" 
--seguido del nombre de la función creada anteriormente, SQL Server 
--mostrará un mensaje indicando que tal función está encriptada.