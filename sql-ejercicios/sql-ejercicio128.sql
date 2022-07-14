--118 - Tipo de dato text - ntext e image (funciones)

--Las siguientes son otras funciones que pueden emplearse con estos tipos de datos:

--- datalenght(CAMPO): devuelve el número de bytes de un determinado campo. Retorna 
--"null" si el campo es nulo. Ejemplo:

select titulo, datalength(sinopsis) as longitud
from libros
order by titulo;
--- patindex ('PATRON',CAMPO): retorna el comienzo de la primera ocurrencia de un patrón de la expresión especificada, si el patrón no se encuentra, retorna cero. 
--El patrón es una cadena que puede incluir comodines.
--Ejemplo:

select patindex('%PHP%', sinopsis)
from libros;
--Con este tipo de datos también puede utilizarse "like", pero "like" solamente puede
--incluirse en la cláusula "where".

--- substring (TEXTO,INICIO,LONGITUD): devuelve una parte del texto especificado como primer argumento, empezando desde la posición especificada por el segundo argumento y de tantos caracteres de longitud como indica el tercer argumento.
--Ejemplo:

select titulo,substring(sinopsis,1,20)
from libros;
