--Tipo de dato text - ntext e image (punteros)

--Los tipos de datos text, ntext e image se eliminarán en versiones futuras de SQL Server. Evite utilizar estos tipos de datos en nuevos proyectos de desarrollo y planee modificar las aplicaciones que los utilizan actualmente. Se debe utilizar los tipos varchar(max), nvarchar(max) y varbinary(max) en su lugar.

--Explicamos anteriormente que como estos tipos de datos tiene gran tamaño, SQL Server almacena los datos fuera de los registros; en el registro guarda un puntero (de 16 bytes) que apunta a otro sitio, que contiene la dirección en la cual se guardan los datos propiamente dichos.

--La función "textptr" devuelve el valor del puntero a texto que corresponde al campo text, ntext o image; tal valor puede emplearse para manipular los datos de este tipo, con las funciones para leer, escribir y actualizar.
--Sintaxis:

-- textptr(CAMPO);
--El campo debe ser tipo text, ntext o image.

--En el campo de tipo "text" no se almacenan los datos sino la dirección en la cual se encuentran los datos. Podemos ver esa dirección tipeando la siguiente sentencia:

-- select titulo, textptr(sinopsis) from libros;
--La función "textptr" retorna un puntero a texto (valor binario de 16). Si el campo no tiene texto, retorna un puntero a null; por ello se debe usar la función "textvalid" para confirmar si el puntero a texto existe.

--Si la consulta retorna más de un registro, "textptr" retorna un puntero a texto del último registro devuelto.

--La funcion "textvalid" controla si un puntero a texto es válido. Sintaxis:

-- textvalid ('TABLA.CAMPO', PUNTEROATEXTO);
--Los argumentos son: el nombre de la tabla y campo y el nombre del puntero a texto que se va a controlar. Retorna 1 si el puntero es válido y 0 si no lo es. No se puede emplear "updatetext", "writetext" y "readtext" si el puntero no es válido.

--La siguiente consulta muestra si los punteros son válidos en cada registro del campo "sinopsis" de la tabla "libros":

-- select titulo,
--  textvalid('libros.sinopsis', textptr(sinopsis)) as 'Puntero valido'
--  from libros;
--En el siguiente ejemplo, declaramos una variable de tipo "varbinary" a la cual le asignamos el valor del puntero a texto de un registro y luego vemos si dicho puntero es válido, empleando la variable:

-- declare @puntero varbinary(16)
-- select @puntero = textptr(sinopsis)
--  from libros
--  where titulo= 'Ilusiones'
-- select textvalid('libros.sinopsis', @puntero);
--Solo disponemos punto y coma al final para que SQL Server ejecute todas las instrucciones en un solo lote y exista la variable @puntero.

--Si al insertar registros se ingresa un valor "null" en un campo "text", "ntext" o "image" o no se ingresa valor, no se crea un puntero válido. Para crear un puntero a texto válido ejecute un "insert" o "update" con datos que no sean nulos para el campo text, ntext o image.