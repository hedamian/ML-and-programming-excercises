if object_id('cuentas') is not null
  drop table cuentas;

create table cuentas(
numero integer not null,
documento char(8) not null, 
nombre varchar(30),
saldo float,
primary key (numero ));


insert into cuentas(numero,documento,nombre,saldo) values('1234','25666777','Pedro Perez',500000.60);
insert into cuentas(numero,documento,nombre,saldo)  values('2234','27888999','Juan Lopez',-250000);
insert into cuentas(numero,documento,nombre,saldo) values('3344','27888999','Juan Lopez',4000.50);
insert into cuentas(numero,documento,nombre,saldo) values('3346','32111222','Susana Molina',1000);


 -- Note que hay dos cuentas, con distinto número de cuenta, de la misma persona.

--4- Seleccione todos los registros cuyo saldo sea mayor a "4000" (2 registros)

select * from cuentas
  where saldo > 4000;

--5- Muestre el número de cuenta y saldo de todas las cuentas cuyo propietario sea "Juan Lopez" (2 registros)

select * from cuentas 
  where nombre ='Juan Lopez';

--6- Muestre las cuentas con saldo negativo (1 registro)
Select * from cuentas  
  where saldo <0;


--7- Muestre todas las cuentas cuyo número es igual o mayor a "3000" (2 registros):
 select * from cuentas
  where numero>=3000;


