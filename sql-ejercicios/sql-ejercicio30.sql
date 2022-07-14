--una funcion es un conjunto de secuencias que operan como unidad logica.
-- una funcion tiene un nombre, retoma un parametro de salida y opcionalmente
--acepta parametros de entrada.

--substring(cadena,inicio, longitud) 
--devuelve una parte de la cadena especificada como primer argumento, empezando desde la posicion
--especificada por el segundo argumento y de tantos caracteres de longitud como indica el tercer
--argumento.
select substring('buenas tardes',8,6);
--return "tardes"

--str(numero, longitud,cantidad de decimales)
--convierte numertos a caracteres. 
--El primer parametro indica el valor numerico a convertir, el segundo da la longitud del resultado
--(debe ser mayor o igual a la parte entera del numero mas el signo si lo tuviese)
--y el tercero son opcionales y deben ser positivos. string=cadena

select str(123.456,7,3);
--default lenght is 10 characters and decimal part is 0

select str (123.456);

--stuff(string1	,inicio,cantidad,string2)
--stuff=rellenar
--inserta la cadena enviada como cuarto argumento, en la posicion
--indicada en el segundo argumento, reemplazando la cantidad de caracteres indicada 
--por el tercer argumento en la cadena que es primer parametro
--los argumentos numericos deben ser positivos y menor or igual a la longitud de la primera cadena,
--si no, regresa null
--si el tercer argumento es mayor  que la primera cadena, se elimina hasta el primer caracter
select stuff('abdce',3,2,'opqrs');
--return 'abopqrse'

--len(string)
--da la longitud de la cadena enviada como argumento
select len('hola');
--return 4

--char(x)
--retorna  un caracter en codigo ascii del entero enviado como argumento
select char(65);
--return "A"

--left(string,len)

--regresa la cantidad (longitud) de caracteres de la cadena comenzado
--desde la izquierda 
select left('buenos dias',8);
--return "buenos d"

--right(string,len)
--regresa la longitud de caracteres de la cadena comenzando por la derecha, ultimo caracter
select right('buenos dias',8);
--return "nos dias"

--lower (string)
--regresa la cadena con todos los caracteres en minusculas
select lower('HOLA ESTUdiante');
--return hola estudiante

--upper(string)
--regresa la cadena con todos los caracteres en mayusculas
select upper('hola estudiante');
--return HOLA ESTUDIANTE

--ltrim(string)
--regresa la cadena con los espacios de la izquierda eliminados. trim=recortar
select ltrim('    hola    ');

--rtrim(string)
--regresa la cadena con los espacios de la derecha eliminados
select rtrim('    hola    ');

--replace(string,replaced string,to replace string)
--regresa la cadena con todas las ocurrencias de la subcadena de reemplazo por la subcadena a reemplazar
select replace('rrr.subway.com','r','w');
--return "www.subway.com"

--reverse(string)
--devuelve la cadena invirtiendo el orden de los caracteres
select reverse('hola');
--return aloh

--patindex(patron,string)
--devuelve la posicion de comienzo (de la primera ocurrencia) del patron especificado en la cadena enviada como segundo argumento
--si no la encuentra , regresa 0

select patindex('%luis%','jorge luis borges');
--return 7

select patindex('%or%','jorge luis borges');
--return 2

select patindex('%ar%','jorge luis borges');
--return 0

--charindex(substring,string, start)
--devuelve la posicion donde el comienzo de la subcadena en la cadena,comenzando la busqueda desde la posicion
--indicada como inicio. si el tercer argumento no se coloca,la busqueda se inicia desde 0. si no la encuentra regresa 0
select charindex('or', 'jorge luis borges',5);
--return 13

select charindex('or','jorge luis borges');
--return 5

select charindex('or','jorge luis borges',14);
--return 0

--replicate(string, value)

--repite una cadena la cantidad de veces especificada
select replicate('hola',3);
--return holaholahola

--space(value)
--regresa una cadena de espacios de longitud indicada por el valor que debe ser positivo.

'hola'+space(1)+'que tal';
--return hola que tal
