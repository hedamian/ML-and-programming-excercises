if object_id('medicamentos') is not null
  drop table medicamentos;

  create table medicamentos(
  codigo int identity,
  nombre varchar(20) not null,
  laboratorio varchar(20),
  precio float,
  cantidad integer
 );

 exec sp_columns medicamentos;


 insert into medicamentos (nombre, laboratorio,precio,cantidad)
   values('Sertal','Roche',5.2,100);
 insert into medicamentos (nombre, laboratorio,precio,cantidad)
  values('Buscapina','Roche',4.10,200);
 insert into medicamentos (nombre, laboratorio,precio,cantidad)
  values('Amoxidal 500','Bayer',15.60,100);


 select * from medicamentos;



 --insert into medicamentos (codigo,nombre, laboratorio,precio,cantidad)
  --values(4,'Amoxilina 500','Bayer',15.60,100);

 --update medicamentos set codigo=5
  --where nombre='Bayaspirina';

 delete from medicamentos
  where codigo=3;

 insert into medicamentos (nombre, laboratorio,precio,cantidad)
  values('Amoxilina 500','Bayer',15.60,100);

 select * from medicamentos;
