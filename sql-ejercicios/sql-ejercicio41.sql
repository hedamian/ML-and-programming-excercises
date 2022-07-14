--modificador del group by (with rollup)\
--el operador rollup resume valores de grupos que representan los valores de resumen de la precedente

if object_id('visitantes') is not null
	drop table visitantes;

create table visitantes(
nombre varchar(30),
edad tinyint,
sexo char(1),
domicilio varchar(30),
ciudad varchar(30),
telefono varchar(11),
monto decimal(6,2) not null
);

go

insert into visitantes values('susana molina',28,'f',null,'cordoba',null,45.50);
insert into visitantes values('marcela mercado',36,'f','avellanada 345','cordoba','4545454',22.40);
insert into visitantes values('alberto garcia',35,'m','gral. paz 123','alta garcia','03547123456',25);
insert into visitantes values('teresa garcia',33,'f',default,'alta garcia','03547123456',120);
insert into visitantes values('roberto perez',45,'m','urquiza 335','cordoba','4123456',33.20);
insert into visitantes values('marina torres',22,'f','colon 222','villa dolores','03544112233',95);
insert into visitantes values('julieta gomez',24,'f','san martin 333','alta garcia',null,53.5);
insert into visitantes values('roxana lopez',20,'f','null','alta garcia',null,240);
insert into visitantes values('liliana garcia',50,'f','paso 999','cordoba','4588778',48);
insert into visitantes values('juan torres',43,'m','sarmiento 876' ,'cordoba',null,15.30);

--cantidad de visitantes por ciudad
select ciudad, count(*) as 'cantidad de visitantes' from visitantes
group by ciudad;

--cantidad total de visitantes 
select count(*) as 'visitantes totales' from visitantes;

--para obtener ambos resultados en una sola consulta, se usa roll up
--cantidad de visitantes totales y por ciudad 

select ciudad, count(*) as cantidad from visitantes
group by ciudad with rollup;

--la consulta anterior regresa los registros agrupados por ciudad y una fila extra en la que la primera columna contiene
--null y la columna con la cantidad que muestra la cantidad total.
--la clausula group by permite agregar el modificador roll up,el cual agrega registros extra al resultado de una consulta
--que muestra operaciones de resumen

--agrupar por ciudad y sexo 

select ciudad, sexo, count(*) as cantidad from visitantes
group by ciudad, sexo with rollup;

--para conocer la cantidad de visitantes y la suma  de sus compras agrupados por ciudad y sexo
select ciudad, sexo, count(*) as cantidad, sum(monto) as total from visitantes
group by ciudad, sexo with rollup 

--rollup se puede usar con where y having, pero no con all

select ciudad, sexo, count(*) as cantidad from visitantes
group by ciudad, sexo with cube;
--cube genera filas de resumenes de subgrupos para todas las combinaciones posibles de los valores de campos
--se pueden colocar hasta 10 grupos en el group by 