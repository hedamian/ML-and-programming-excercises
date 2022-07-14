 --116 - Tipo de dato text - ntext e image (escribir)

-- Los tipos de datos text, ntext e image se eliminarán en versiones 
-- futuras de SQL Server. Evite utilizar estos tipos de datos en nuevos
-- proyectos de desarrollo y planee modificar las aplicaciones que los 
-- utilizan actualmente. Se debe utilizar los tipos varchar(max), 
-- nvarchar(max) y varbinary(max) en su lugar.

-- La función "writetext" sobreescribe (reemplaza) el texto de un campo 
-- "text", "ntext" o "image".
-- No puede emplearse en vistas.

-- Sintaxis:

--writetext TABLA.CAMPO PUNTEROATEXTO
--DATO;
--Luego de "writetext" se coloca el nombre de la tabla y
--el campo (text, ntext o image) a actualizar. "PUNTEROATEXTO"
--es el valor que almacena el puntero a texto del dato de tipo
--"text", "ntext" o "image", tal puntero debe ser válido. 
--"DATO" es el texto que almacena, puede ser una variable o un literal.

--Este ejemplo coloca el puntero a texto en una variable
--"@puntero" y luego "writetext" almacena el nuevo texto en 
--el registro apuntado por "@puntero":

declare @puntero binary(16)
select @puntero = textptr (sinopsis)
from libros
where codigo=2
writetext libros.sinopsis @puntero 'Este es un nuevo libro acerca de PHP 
escrito por el profesor Molina que aborda todos los temas necesarios 
para el aprendizaje desde cero de este lenguaje.';

--Recuerde que si al insertar registros se ingresa un valor "null" en un campo 
--"text", "ntext" o "image" o no se ingresan datos, no se crea un puntero válido
--y al intentar escribir dicho campo ocurre un error, porque la función
--"writetext" requiere un puntero válido. Para evitarlo podemos chequer
--el puntero antes de pasárselo a la función de escritura:

declare @puntero varbinary(16)
select @puntero=textptr(sinopsis) 
from libros where codigo=1
if (textvalid('libros.sinopsis', @puntero)=1)
writetext libros.sinopsis @puntero 'Trata de una gaviota que vuela más alto que las demas.'
else select 'puntero invalido, no se actualizó el registro';
