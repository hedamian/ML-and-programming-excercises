148 - Disparador (información)

Los triggers (disparadores) son objetos, así que para obtener 
información de ellos pueden usarse los siguientes procedimientos
 almacenados del sistema y las siguientes tablas:

- "sp_help": sin parámetros nos muestra todos los objetos de la base de 
datos seleccionada, incluidos los triggers. En la columna "Object_type"
 aparece "trigger" si es un disparador.

Si le enviamos como argumento el nombre de un disparador, obtenemos el propietario,
 el tipo de objeto y la fecha de creación.

- "sp_helptext": seguido del nombre de un disparador nos muestra el texto que define
 el trigger, excepto si ha sido encriptado.

- "sp_depends": retorna 2 resultados:

1) el nombre, tipo, campos, etc. de los objetos de los cuales depende el objeto enviado 
(referenciados por el objeto) y

2) nombre y tipo de los objetos que dependen del objeto nombrado (que lo referencian).

Por ejemplo, ejecutamos "sp_depends" seguido del nombre de un disparador:

sp_depends dis_inscriptos_insertar;

Aparece una tabla similar a la siguiente:

name			type		updated	column
-----------------------------------------------------------------
dbo.condicionales	user table	yes	codigocurso
dbo.condicionales	user table	yes	fecha
dbo.inscriptos		user table	yes	numerocurso
dbo.inscriptos		user table	yes	fecha
dbo.condicionales	user table	yes	documento
dbo.cursos		user table	no	numero
dbo.cursos		user table	no	cantidadmaxima
dbo.inscriptos		user table	yes	documento

En la columna "name" nos muestra las tablas (y demás objetos si hubiese)
de las cuales depende el trigger, es decir, las tablas referenciadas en el mismo;
 el tipo de objeto en la columna "type" (en este caso, todas tablas);
  la columna "update" indica si el objeto es actualizado o no 
  (note que la tabla "cursos" no se actualiza, solamente se consulta); 
  la columna "column" muestra el nombre del campo que se referencia.

No aparecen objetos que dependen del trigger porque no existe ningún objeto que lo referencie.

También podemos ejecutar el mismo procedimiento seguido del nombre de una tabla:

sp_depends inscriptos;

aparecen los objetos que dependen de ella (que la referencian). En este ejemplo:
 1 solo objeto, su nombre y tipo (trigger). No aparecen objetos de los cuales 
 depende porque la tabla no los tiene.

- Para conocer los disparadores que hay en una tabla específica y sus acciones respectivas,
 podemos ejecutar el procedimiento del sistema "sp_helptrigger" seguido del nombre de la tabla o vista. Por ejemplo:

sp_helptrigger inscriptos;

Nos muestra la siguiente información:

trigger_name		trigger_owner	isupdate	isdelete	isinsert	isafter	isinsteadof
------------------------------------------------------------------------------------------------------------
dis_inscriptos_insertar	dbo		0		0		1		0	1

El nombre del trigger, su propietario; en las 3 columnas siguientes indica para qué evento 
se ha definido (un valor 1 indica que está definido para tal evento); las 2 últimas columnas
 indican el momento de disparo (un valor 1 se interpreta como verdadero y un 0 como falso). 
 En el ejemplo, el disparador "dis_inscriptos_insertar" está definido para el evento de
  inserción (valor 1 en "isinsert") y es "instead of" (valor 1 en "isinsteadof").

- La tabla del sistema "sysobjects": muestra nombre y varios datos de todos los objetos
 de la base de datos actual. La columna "xtype" indica el tipo de objeto. Si es un trigger muestra "TR".

Si queremos ver el nombre, tipo y fecha de creación de todos los disparadores, podemos tipear:

select name,xtype as tipo,crdate as fecha
from sysobjects
where xtype = 'TR';
