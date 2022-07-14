if object_id('libros') is not null
	drop table libros;


if object_id('VP_cero') is not null
	drop default VP_cero;
if object_id ('VP_desconocido') is not null
	drop default VP_desconocido;
if object_id ('RG_positivo') is not null
	drop rule RG_positivo;

create table libros(
	codigo int identity,
	titulo varchar(40) not null,
	autor varchar(30),
	editorial varchar(20),
	precio decimal(5,2),
	cantidad smallint
);

go 

--4- Cree una regla para impedir que se ingresen valores negativos, llamada "RG_positivo".
create rule RG_positivo as @valor >=0; 
	go
--5- Asocie la regla al campo "precio".
exec sp_bindrule RG_positivo, 'libros.precio';
go
--6- Asocie la regla al campo "cantidad".
exec sp_bindrule RG_positivo, 'libros.cantidad';
go
--7- Cree un valor predeterminado para que almacene el valor cero, llamado "VP_cero".
create default VP_cero as 0;
go
--8- Asócielo al campo "precio".
exec sp_bindefault VP_cero, 'libros.precio';
go
--9- Asócielo al campo "cantidad".
exec sp_bindefault VP_cero, 'libros.cantidad'
go
--10- Cree un valor predeterminado con la cadena "Desconocido" llamado "VP_desconocido".
create default VP_desconocido as 'Desconocido';
go
--11- Asócielo al campo "autor".
exec sp_bindefault VP_desconocido,'libros.autor';
go
--12- Asócielo al campo "editorial".
exec sp_bindefault VP_desconocido,'libros.editorial';
go
--13- Vea las reglas y valores predeterminados con "sp_help":
exec sp_help libros;
go

--14- Vea las reglas y valores predeterminados asociados a "libros".
exec sp_helpconstraint libros;
go
--Aparecen 6 filas, 2 corresponden a la regla "RG_positivo" asociadas a los campos "precio" y 
--"cantidad"; 2 al valor predeterminado "VP_cero" asociados a los campos "precio" y "cantidad" y 2 al 
--valor predeterminado "VP_desconocido" asociados a los campos "editorial" y "autor".

--15- Ingrese un registro con valores por defecto para todos los campos, excepto "titulo" y vea qué se 
--almacenó.
insert into libros values ('1984',default,default,default,default);
	select * from libros;
exec sp_unbindefault 'libros.precio';

--16- Ingrese otro registro con valor predeterminado para el campo "precio" y vea cómo se almacenó.
insert into libros values ('1984',default,default,50,default);
select * from libros;

--17- Vea las reglas y valores predeterminados asociados a "libros".
exec sp_helpconstraint libros;
--5 filas; el valor predeterminado "VP_cero" ya no está asociado al campo "precio".

--18- Verifique que el valor predeterminado "VP_cero" existe aún en la base de datos.
exec sp_help VP_cero;
--19- Intente eliminar el valor predeterminado "VP_cero".
exec sp_unbindefault 'libros.cantidad';
--No se puede porque está asociado al campo "cantidad".

--20- Quite la asociación del valor predeterminado "VP_cero" al campo "cantidad".

--21- Verifique que ya no existe asociación de este valor predeterminado con la tabla "libros".
--4 filas.
exec sp_help VP_cero;
--22- Verifique que el valor predeterminado "VP_cero" aun existe en la base de datos.

--23- Elimine el valor predeterminado "VP_cero".
drop default VP_cero;
