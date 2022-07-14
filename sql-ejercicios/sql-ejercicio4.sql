if Object_ID('empleados') is not null
    drop table empleados;

create table empleados(
    nombre varchar(100),
    documento varchar(100),
    sexo varchar(1),
    domicilio varchar(120),
    sueldo float
);

go

exec sp_columns empleados;

insert into empleados(nombre, documento,sexo, domicilio,sueldo) values ('juan perez', '345678765','m','sarmiento 123',500);
insert into empleados(nombre, documento,sexo, domicilio,sueldo) values ('ana acosta', '123456789','f','costa 23',600);
insert into empleados(nombre, documento,sexo, domicilio,sueldo) values ('bartolome barrios', '474752743','m','urquiza 487',800);

select * from  empleados;


--recuperar solo un elemento    
select nombre,documento from empleados;
select nombre, sexo, sueldo from empleados;