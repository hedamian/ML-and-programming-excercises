133 - Funciones


SQL Server ofrece varios tipos de funciones para realizar distintas operaciones.
Hemos visto y empleado varias de ellas.

Se pueden emplear las funciones del sistema en cualquier lugar en el que se permita
una expresión en una sentencia "select".

Las funciones pueden clasificarse en:

- deterministicas: siempre retornan el mismo resultado si se las invoca enviando 
el mismo valor de entrada. Todas las funciones de agregado y string son deterministicas,
excepto "charindex" y "patindex".

- no deterministicas: pueden retornar distintos resultados cada vez que se invocan con
el mismo valor de entrada. Las siguientes son algunas de las funciones no deterministicas:
getdate, datename, textptr,
textvalid, rand. Todas las funciones de configuración, cursor, meta data, seguridad 
y estadísticas
del sistema son no deterministicas.

SQL Server provee muchas funciones y además permite que el usuario pueda definir sus propias funciones.

Sabemos que una función es un conjunto de sentencias que operan como una unidad lógica, una rutina 
que retorna un valor. Una función tiene un nombre, acepta parámetros de entrada y retorna
un valor escalar o una tabla.

Los parámetros de entrada pueden ser de cualquier tipo, excepto timestamp, cursor y table.

Las funciones definidas por el usuario no permiten parámetros de salida.

No todas las sentencias SQL son válidas dentro de una función. NO es posible emplear en ellas
funciones no deterministicas (como getdate()) ni sentencias de modificación o actualización 
de tablas o vistas. Si podemos emplear sentencias de asignación, de control de flujo (if), 
de modificación y eliminación de variables locales.

SQL Server admite 3 tipos de funciones definidas por el usuario clasificadas según el valor retornado:

1) escalares: retornan un valor escalar;

2) de tabla de varias instrucciones (retornan una tabla) y

3) de tabla en línea (retornan una tabla).

Las funciones definidas por el usuario se crean con la instrucción "create function" 
y se eliminan con "drop function".
