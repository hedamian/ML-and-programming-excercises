140 - Funciones (información)

Las funciones son objetos, así que para obtener información de ellos
pueden usarse los siguientes procedimientos almacenados del sistema y las siguientes tablas:

- "sp_help": sin parámetros nos muestra todos los objetos de la base de 
datos seleccionada, incluidas las funciones definidas por el usuario.
En la columna "Object_type" aparece "scalar function" si es una función escalar,
"table function" si es una función de tabla de varias sentencias y "inline function"
si es una función de tabla en línea.

Si le enviamos como argumento el nombre de una función definida por el usuario, 
obtenemos el propietario, el tipo de función y la fecha de creación; 
si es una función de tabla, los campos de la tabla retornada.

- "sp_helptext": seguido del nombre de una función definida por el usuario
nos muestra el texto que define la función, excepto si ha sido encriptado.

- "sp_stored_procedures": muestra todos los procedimientos almacenados y 
funciones definidas por el usuario.

- "sp_depends": seguido del nombre de un objeto, nos devuelve 2 resultados: 
1) nombre, tipo, campos, etc. de los objetos de los cuales depende el objeto enviado
(referenciados por el objeto) y 2) nombre y tipo de los objetos que dependen 
del objeto nombrado (que lo referencian). Por ejemplo, ejecutamos "sp_depends" 
seguido del nombre de una función definida por el usuario:

exec sp_depends pa_libroslistado;

aparecen las tablas (y demás objetos) de las cuales depende el procedimiento, 
es decir, las tablas (y campos) referenciadas en la misma.
No aparecen objetos que dependan de la función porque no existe ningún
objeto que la referencie.

Podemos ejecutar el procedimiento seguido del nombre de una tabla:

exec sp_depends libros;

aparecen las funciones (y demás objetos) que dependen de ella (que la referencian). 
No aparecen objetos de los cuales depende porque la tabla no los tiene.

- La tabla del sistema "sysobjects": muestra nombre y varios datos de todos 
los objetos de la base de datos actual. La columna "xtype" indica el tipo de objeto.
Si es una función definida por el usuario escalar, muestra "FN", si es una función 
de tabla de varias sentencias, muestra "TF" y si es una función de tabla en linea 
muestra "IF".

Si queremos ver el nombre, tipo y fecha de creación de todas las funciones definidas por 
el usuario, podemos tipear:

select name,xtype as tipo,crdate as fecha
from sysobjects
where xtype in ('FN','TF','IF');
