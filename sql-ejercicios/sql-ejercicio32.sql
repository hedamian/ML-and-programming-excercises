--abs(x)
--regresa el valor absoluto de x

select abs(-20);
--return 20

--ceiling(X)
--redondea hacia arriba el valor x
select ceiling(12.36);
--return 13

--floor(x)
--redondea hacia abajo el valor x

select floor(12.36);
--return 12

--% 
--devuelve el resto(residuo) de una division

select 10%3;
--return 1

select 10%2;
--return 0

--power(x,y)
--regresa el valor x elevado a la potencia de y

select (3,2);
--return 9

--round(number, len)
--regresa un numero redondeado a la longitud especificada. longitud debe ser tinyint, smallint o int.
--si la longitud es positivo, el numero de decimales es redondeado segun longitud; si es negativo, el numero es redondeado
-- desde la parte entera segun el valor de longitud

select round(123.456,2);
--return 123.460 redondea desde el segundo decimal

select round(123.456,-1);
--return 120.000, redondea desde el primer valor entero (hacia la izquierda)

--sign (x)
--si el argumento es un valor positivo, da 1; si es negativo da -1 y si es 0, da 0
--square(x)
--regresa el cuadrado de un valor 

select square(8);
--return 64

--sqrt(x)
--devuelve la raiz cuadrada de un valor 

select sqrt(4);
--return 2