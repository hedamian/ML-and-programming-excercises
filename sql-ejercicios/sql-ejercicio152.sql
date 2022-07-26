141 - Disparadores (triggers)

Un "trigger" (disparador o desencadenador) es un tipo de procedimiento 
almacenado que se ejecuta cuando se intenta modificar los datos de una tabla (o vista).

Se definen para una tabla (o vista) específica.

Se crean para conservar la integridad referencial y la coherencia entre 
los datos entre distintas tablas.

Si se intenta modificar (agregar, actualizar o eliminar) datos de una 
tabla en la que se definió un disparador para alguna de estas acciones 
(inserción, actualización y eliminación), el disparador se ejecuta (se dispara) 
en forma automática.

Un trigger se asocia a un evento (inserción, actualización o borrado) sobre una tabla.

La diferencia con los procedimientos almacenados del sistema es que los triggers:

- no pueden ser invocados directamente; al intentar modificar los datos de una
 tabla para la que se ha definido un disparador, el disparador se ejecuta automáticamente.

- no reciben y retornan parámetros.

- son apropiados para mantener la integridad de los datos, no para obtener 
resultados de consultas.

Los disparadores, a diferencia de las restricciones "check", pueden hacer 
referencia a campos de otras tablas. Por ejemplo, puede crearse un trigger
 de inserción en la tabla "ventas" que compruebe el campo "stock" de un artículo 
 en la tabla "articulos"; el disparador controlaría que, cuando el valor de "stock"
  sea menor a la cantidad que se intenta vender, la inserción del nuevo registro en
   "ventas" no se realice.

Los disparadores se ejecutan DESPUES de la ejecución de una instrucción "insert", 
"update" o "delete" en la tabla en la que fueron definidos. Las restricciones 
se comprueban ANTES de la ejecución de una instrucción "insert", "update" o
 "delete". Por lo tanto, las restricciones se comprueban primero, si se 
 infringe alguna restricción, el desencadenador no llega a ejecutarse.

Los triggers se crean con la instrucción "create trigger". Esta instrucción
 especifica la tabla en la que se define el disparador, los eventos para los
  que se ejecuta y las instrucciones que contiene.

Sintaxis básica:

 create trigger NOMBREDISPARADOR
  on NOMBRETABLA
  for EVENTO- insert, update o delete
 as 
  SENTENCIAS

Analizamos la sintaxis:

- "create trigger" junto al nombre del disparador.

- "on" seguido del nombre de la tabla o vista para la cual se establece el trigger.

- luego de "for", se indica la acción (evento, el tipo de modificación)
 sobre la tabla o vista que activará el trigger. Puede ser "insert", "update"
  o "delete". Debe colocarse al menos UNA acción, si se coloca más de una, 
  deben separarse con comas.

- luego de "as" viene el cuerpo del trigger, se especifican las condiciones
 y acciones del disparador; es decir, las condiciones que determinan cuando
  un intento de inserción, actualización o borrado provoca las acciones que
   el trigger realizará.

Consideraciones generales:

- "create trigger" debe ser la primera sentencia de un bloque y sólo se puede 
aplicar a una tabla.

- un disparador se crea solamente en la base de datos actual pero puede hacer
 referencia a objetos de otra base de datos.

- Las siguientes instrucciones no están permitidas en un desencadenador: 
create database, alter database, drop database, load database, 
restore database, load log, reconfigure, restore log, disk init, disk resize.

- Se pueden crear varios triggers para cada evento, es decir,
 para cada tipo de modificación (inserción, actualización o borrado) 
 para una misma tabla. Por ejemplo, se puede crear un "insert trigger"
  para una tabla que ya tiene otro "insert trigger".

A continuación veremos la creación de un disparador para el suceso
 de inserción: "insert trigger".