--notas sql

--buscar una tabla en una base de datos 
--nombre de la tabla a buscar entre los simbolos de porcentaje
SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '%%'

