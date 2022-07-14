--getdate()
--regresa la fecha y hora actuales

select getdate();

--datepart(datepart, date)
--regresa la parte especifica de una fecha (year,quarter,month, day,week,hour,minute,second, millisecond)

select datepart(month,getdate());

select datepart(day, getdate());

select datepart(hour,getdate());

--datename (datepart,date)
--regresa el nombre de una parte especifica de la fecha	

select datename(day,getdate());

--dateadd(datepart,number, date)
--agrega un intervalo a la fecha especificada; regresa una fecha adicionando a la fecha enviada como
--tercer argumento ,el interval de tiempo dado por el primer argumento, tantas veces lo indicado por el segundo argumento
--argumentos (year,quarter,month, day,week,hour,minute,second, millisecond)

set dateformat dmy;

select dateadd(day,3,'02/11/1980');

--return 05/11/1980

select dateadd(month,3,02/11/1980);
--return 02/02/1981

select dateadd(minute,16,02/11/1980);
--return 02/11/1980 00:16:00

--datediff(partdate,date1,date2)
--calcula el intervalo de tiempo (de acuerdo al primer argumento) entre 2 fechas. El resultado es un valor entero que corresponde a la 
--fecha date2-date1

select datediff(day, '28-10-2005','28-10-2006');
--return 365
select datediff(month, '28-10-2005','28-10-2006');
--return 13

--day(date), month(date), year(date)
--regresa el dia, mes y an~o respectivamente de la fecha