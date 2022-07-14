-- Indices



-- SQL Server accede a los datos de dos maneras:

-- 1 recorriendo las tablas; comenzando el principio y extrayendo los registros que cumplen las condiciones de la consulta.
-- 2 empleando índices; recorriendo la estructura de árbol del índice para localizar los registros y extrayendo 
--los que cumplen las condiciones de la consulta.

-- Los índices se emplean para facilitar la obtención de información de una tabla. El indice de una tabla desempeña la 
--misma función que el índice de un libro: permite encontrar datos rápidamente; en el caso de las tablas, localiza registros.

-- Una tabla se indexa por un campo (o varios).

-- Un índice posibilita el acceso directo y rápido haciendo más eficiente las búsquedas. 
--Sin índice, SQL Server debe recorrer secuencialmente toda la tabla para encontrar un registro.

-- El objetivo de un indice es acelerar la recuperación de información. 
--La indexación es una técnica que optimiza el acceso a los datos, mejora el rendimiento acelerando 
--las consultas y otras operaciones. Es útil cuando la tabla contiene miles de registros, 
--cuando se realizan operaciones de ordenamiento y agrupamiento y cuando se combinan varias tablas .

-- La desventaja es que consume espacio en el disco y genera costo de mantenimiento (tiempo y recursos).

-- Los índices más adecuados son aquellos creados con campos que contienen valores únicos.

-- Es importante identificar el o los campos por los que sería útil crear un índice, 
--aquellos campos por los cuales se realizan búsqueda con frecuencia: claves primarias, 
--claves externas o campos que combinan tablas.

-- No se recomienda crear índices por campos que no se usan con frecuencia en consultas o no contienen valores únicos.

-- SQL Server permite crear dos tipos de índices: 1) agrupados y 2) no agrupados.

--1) Indices agrupados y no agrupados (clustered y nonclustered)

--Dijimos que SQL Server permite crear dos tipos de índices: 1) agrupados (clustered) y 2) no agrupados (nonclustered).

--1) Un INDICE AGRUPADO es similar a una guía telefónica, los registros con el mismo valor de campo se agrupan juntos.
--Un índice agrupado determina la secuencia de almacenamiento de los registros en una tabla.
--Se utilizan para campos por los que se realizan busquedas con frecuencia o se accede siguiendo un orden.
--Una tabla sólo puede tener UN índice agrupado.
--El tamaño medio de un índice agrupado es aproximadamente el 5% del tamaño de la tabla.

--2) Un INDICE NO AGRUPADO es como el índice de un libro, los datos se almacenan en un lugar diferente al del índice,
--los punteros indican el lugar de almacenamiento de los elementos indizados en la tabla.
--Un índice no agrupado se emplea cuando se realizan distintos tipos de busquedas frecuentemente,
--con campos en los que los datos son únicos.
--Una tabla puede tener hasta 249 índices no agrupados.

--Si no se especifica un tipo de índice, de modo predeterminado será no agrupado.

--Los campos de tipo text, ntext e image no se pueden indizar.

--Es recomendable crear los índices agrupados antes que los no agrupados, porque los primeros modifican el orden físico de 
--los registros, ordenándolos secuencialmente.

--La diferencia básica entre índices agrupados y no agrupados es que los registros de un índice agrupado están ordenados y 
--almacenados de forma secuencial en función de su clave.

--SQL Server crea automaticamente índices cuando se crea una restricción "primary key" o "unique" en una tabla.
--Es posible crear índices en las vistas.

--Resumiendo, los índices facilitan la recuperación de datos, permitiendo el acceso directo y acelerando las búsquedas,
--consultas y otras operaciones que optimizan el rendimiento general.

