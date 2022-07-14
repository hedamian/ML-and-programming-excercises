----Subconsultas


----Una subconsulta (subquery) es una sentencia "select" anidada en otra sentencia "select", "insert", 
--"update" o "delete" (o en otra subconsulta).

----Las subconsultas se emplean cuando una consulta es muy compleja, entonces se la divide en 
--varios pasos lógicos y se obtiene el resultado con una única instrucción y cuando la consulta 
--depende de los resultados de otra consulta.

----Generalmente, una subconsulta se puede reemplazar por combinaciones y estas últimas son más 
--eficientes.

----Las subconsultas se DEBEN incluir entre paréntesis.

----Puede haber subconsultas dentro de subconsultas, se admiten hasta 32 niveles de anidación.

----Se pueden emplear subconsultas:

----- en lugar de una expresión, siempre que devuelvan un solo valor o una lista de valores.

----- que retornen un conjunto de registros de varios campos en lugar de una tabla o para obtener
--el mismo resultado que una combinación (join).

----Hay tres tipos básicos de subconsultas:

----las que retornan un solo valor escalar que se utiliza con un operador de comparación o en lugar 
--de una expresión.
----las que retornan una lista de valores, se combinan con "in", o los operadores "any", "some" y "all".
----los que testean la existencia con "exists".

----Reglas a tener en cuenta al emplear subconsultas:

----- la lista de selección de una subconsulta que va luego de un operador de comparación puede 
--incluir sólo una expresión o campo (excepto si se emplea "exists" y "in").

----- si el "where" de la consulta exterior incluye un campo, este debe ser compatible con el 
--campo en la lista de selección de la subconsulta.

----- no se pueden emplear subconsultas que recuperen campos de tipos text o image.

----- las subconsultas luego de un operador de comparación (que no es seguido por "any" o "all") 
--no pueden incluir cláusulas "group by" ni "having".

----- "distinct" no puede usarse con subconsultas que incluyan "group by".

----- no pueden emplearse las cláusulas "compute" y "compute by".

----- "order by" puede emplearse solamente si se especifica "top" también.

----- una vista creada con una subconsulta no puede actualizarse.

----- una subconsulta puede estar anidada dentro del "where" o "having" de una consulta externa 
--o dentro de otra subconsulta.

----- si una tabla se nombra solamente en un subconsulta y no en la consulta externa,
--los campos no serán incluidos en la salida (en la lista de selección de la consulta externa).



