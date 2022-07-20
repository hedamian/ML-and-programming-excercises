130 - Procedimientos Almacenados (recompilar)

La compilación es un proceso que consiste en analizar el procedimiento almacenado
y crear un plan de ejecución. Se realiza la primera vez que se ejecuta un procedimiento
almacenado o si el procedimiento almacenado se debe volver a compilar (recompilación).
SQL Server recompila automáticamente un procedimiento almacenado si se realiza algún cambio 
en la estructura de una tabla (o vista) referenciada en el procedimiento (alter table y alter view)
y cuando se modifican las claves (insert o delete) de una tabla referenciada.

Un procedimiento almacenado puede recompilarse explícitamente.
En general se recomienda no hacerlo excepto si se agrega un índice
a una tabla referenciada por el procedimiento o si los datos han variado 
mucho desde la última compilación.

SQL Server ofrece tres métodos para recompilar explícitamente un procedimiento almacenado:

1) Se puede indicar, al crear el procedimiento, que SQL Server no guarde 
en la caché un plan de ejecución para el procedimiento sino que lo compile cada vez que se ejecute.
En este caso la sintaxis es la siguiente:

create procedure NOMBREPROCEDIMIENTO
PARAMETROS
with recompile
as
SENTENCIAS;

2) Podemos especificar "with recompile" al momento de ejecutarlo:

exec NOMBREPROCEDIMIENTO with recompile;

3) Podemos ejecutar el procedimiento almacenado del sistema "sp_recompile". 
Este procedimiento vuelve a compilar el procedimiento almacenado (o desencadenador) 
que se especifica. La sintaxis es:

exec sp_recompile NOMBREOBJETO;

El parámetro enviado debe ser el nombre de un procedimiento, de un desencadenador,
de una tabla o de una vista. Si es el nombre de una tabla o vista,
todos los procedimientos almacenados que usan tal tabla (o vista) se vuelven a compilar.
