
--117 - Tipo de dato text - ntext e image (actualizar)

--Los tipos de datos text, ntext e image se eliminarán en versiones futuras 
--de SQL Server.
--Evite utilizar estos tipos de datos en nuevos proyectos de desarrollo 
--y planee modificar las aplicaciones que los utilizan actualmente. 
--Se debe utilizar los tipos varchar(max),
--nvarchar(max) y varbinary(max) en su lugar.

--Aprendimos que la función "writetext" sobreescribe,
--reemplaza el contenido completo de un campo
--de tipo "text", "ntext" o "image".

--Para actualizar campos de estos tipos también empleamos "updatetext", 
--que permite cambiar
--una porción del campo (o todo el campo). La sintaxis básica es la siguiente:

--updatetext TABLA.CAMPO PUNTEROATEXTO
--DESPLAZAMIENTODELPUNTERO
--LONGITUDDEBORRADO
--DATOAINSERTAR;
--Analizamos la sintaxis:

--- TABLA.CAMPO: campo y tabla que se va a actualizar.

--- PUNTEROATEXTO: valor del puntero, retornado por la función "textptr", 
--que apunta al dato text, ntext o image que se quiere actualizar.

--- DESPLAZAMIENTODELPUNTERO: indica la posición en que inserta el nuevo dato.
--Especifica la cantidad de bytes (para campos text e image) o caracteres 
--(para campos ntext)
--que debe moverse el puntero para insertar el dato. Los valores pueden ser: 
--0 (el nuevo dato se inserta al comienzo), "null" (coloca el puntero al final), 
--un valor mayor a cero y menor o igual a la longitud total del texto 
--(inserta el nuevo dato en la posición indicada) y un valor mayor a la longitud total
--del campo (genera un mensaje de error).
--Es importante recordar que cada caracter ntext ocupa 2 bytes.

--- LONGITUDDEBORRADO: indica la cantidad de bytes (para text e image) 
--o caracteres (para ntext) a borrar comenzando de la posición indicada
--por el parámetro DESPLAZAMIENTODELPUNTERO. Si colocamos el valor 0 
--(no se borra ningún dato), "null" (borra todos los datos desde la 
--posición indicada por el parámetro DESPLAZAMIENTODELPUNTERO hasta el final),
--un valor mayor que cero y menor o igual a la longitud del texto
--(borra tal cantidad) y un valor inválido, es decir, mayor a la longitud del texto 
--(genera un mensaje de error).
--Es importante recordar que cada caracter "ntext" ocupa 2 bytes.

--- DATOAINSERTAR: el dato que va a ser insertado en el campo. 
--Puede ser char, nchar, varchar, nvarchar, binary, varbinary, text, ntext, image,
--un literal o una variable. Si el dato es un campo text, ntext o image de otra tabla,
--se debe indicar el nombre de la tabla junto con el campo y el valor del
--puntero que apunta al tipo de dato text, ntext o image 
--(retornado por la función "textptr"), de esta forma:
--TABLA.CAMPO PUNTERO;
--Tenemos la tabla libros, con un campo de tipo text llamado "sinopsis";
--hay un registro cargado con el siguiente texto: "Para aprender PHP a paso."
--Necesitamos agregar antes de "a paso" el texto "paso "
--para que el texto completo sea "Para aprender PHP paso a paso", tipeamos:

declare @puntero binary(16)
select @puntero = textptr(sinopsis)
from libros
where titulo='Aprenda PHP'
updatetext libros.sinopsis @puntero
18 0 'paso ';
--Entonces, declaramos una variable llamada "@puntero"; guardamos en la variable 
--el valor del puntero, obtenido con la función "textptr(sinopsis)", tal puntero
--apunta al campo "sinopsis" del libro "Aprenda PHP". Luego actualizamos el campo, 
--colocando el puntero en la posición 18, no borramos ningún byte y colocamos el
--texto a agregar; el campo ahora contendrá "Para aprencer PHP paso a paso".

--Es posible guardar en un campo "text" de una tabla el contenido del campo "text"
--de otra tabla; para ello debemos utilizar 2 punteros, uno para obtener 
--la dirección del campo que queremos actualizar y otro para obtener la dirección 
--del campo del cual extraemos la información.

--En el siguiente ejemplo guardamos en una variable el valor del puntero a
--texto al campo "sinopsis" del libro "Aprenda PHP" de la tabla "libros"; 
--en otra variable guardamos el valor del puntero a texto al campo "sinopsis"
--del libro con código 1 de la tabla "ofertas"; finalmente actualizamos el
--registro de "ofertas" con el texto de "libros".

declare @puntero1 binary(16)
select @puntero1 = textptr(sinopsis)
from libros
where titulo='Aprenda PHP'

declare @puntero2 binary(16)
select @puntero2 = textptr(sinopsis)
from ofertas
where titulo='Aprenda PHP'

updatetext ofertas.sinopsis @puntero2 0 null
libros.sinopsis @puntero1;
--Entonces, se emplea "updatetext" para modificar datos de campos de tipo text,
--ntext e image, pudiendo cambiar una porción del texto.