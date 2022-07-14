
--Tipo de dato text - ntext e image (leer)

--Los tipos de datos text, ntext e image se eliminarán en versiones futuras de SQL Server.
--Evite utilizar estos tipos de datos en nuevos proyectos de desarrollo y planee modificar las aplicaciones que los utilizan actualmente. Se debe utilizar los tipos varchar(max),
--nvarchar(max) y varbinary(max) en su lugar.

--La función "readtext" lee valores de un campo text, ntext o image, comenzando 
--desde una posición y leyendo un específico número de bytes. Sintaxis:

--readtext TABLA.CAMPO PUNTEROATEXTO
--DESPLAZAMIENTO CANTIDAD; 
--Analicemos la sintaxis:

--- PUNTEROATEXTO: puntero a texto válido, binary(16).

--- DESPLAZAMIENTO: número de bytes (para text o image) o caracteres (ntext) que 
--se mueve el puntero antes de comenzar a leer.

--- CANTIDAD: número de bytes o caracteres a leer desde la posición indicada por
--DESPLAZAMIENTO. Si es 0, se leen 4KB bytes o hasta el final.

--Leemos la información almacenada en el campo "sinopsis" de "libros" del registro 
--con código 2, desde la posición 9, 50 caracteres:

--declare @puntero varbinary(16)
--select @puntero=textptr(sinopsis) 
--from libros
--where codigo=2
--readtext libros.sinopsis @puntero 9 50;
--Si al insertar registros se ingresa un valor "null" en un campo "text", "ntext" o 
--"image" o no se ingresan datos, no se crea un puntero válido y al intentar leer 
--dicho campo ocurre un error, porque la función "readtext" requiere un puntero válido. 
--Para evitarlo podemos chequear el puntero antes de pasárselo a la función de lectura:

--declare @puntero varbinary(16)
--select @puntero=textptr(sinopsis) 
--from libros where codigo=1
--if (textvalid('libros.sinopsis', @puntero)=1)
--readtext libros.sinopsis @puntero 9 50
--else select 'puntero invalido';