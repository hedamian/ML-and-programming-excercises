--Restricciones al crear la tabla

--Hasta el momento hemos agregado restricciones a tablas existentes con "alter table" 
--(manera aconsejada), también pueden establecerse al momento de crear una tabla 
--(en la instrucción "create table").

--Podemos aplicar restricciones a nivel de campo (restricción de campo) o a nivel de tabla
-- (restricción de tabla).

--En el siguiente ejemplo creamos la tabla "libros" con varias restricciones:

 create table libros(
  codigo int identity,
  titulo varchar(40),
  codigoautor int not null,
  codigoeditorial tinyint not null,
  precio decimal(5,2)
   constraint DF_precio default (0),
  constraint PK_libros_codigo
   primary key clustered (codigo),
  constraint UQ_libros_tituloautor
    unique (titulo,codigoautor),
  constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on update cascade,
  constraint FK_libros_autores
   foreign key (codigoautor)
   references autores(codigo)
   on update cascade,
  constraint CK_precio_positivo check (precio>=0)
);

--En el ejemplo anterior creamos:

--- una restricción "default" para el campo "precio" (restricción a nivel de campo);

--- una restricción "primary key" con índice agrupado para el campo "codigo" (a nivel de tabla);

-- una restricción "unique" con índice no agrupado (por defecto) para los campos "titulo" y "codigoautor" (a nivel de tabla);

--una restricción "foreign key" para establecer el campo "codigoeditorial" como clave externa que haga referencia al campo "codigo" de "editoriales y permita actualizaciones en cascada y no eliminaciones (por defecto "no action");

--una restricción "foreign key" para establecer el campo "codigoautor" como clave externa que haga referencia al campo "codigo" de "autores" y permita actualizaciones en cascada y no eliminaciones;

--una restricción "check" para el campo "precio" que no admita valores negativos;

--Si definimos una restricción "foreign key" al crear una tabla, la tabla referenciada debe existir.

if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;
if object_id('autores') is not null
  drop table autores;

create table editoriales(
  codigo tinyint not null,
  nombre varchar(30),
  constraint PK_editoriales primary key (codigo)
);

create table autores(
  codigo int not null
   constraint CK_autores_codigo check (codigo>=0),
  nombre varchar(30) not null,
  constraint PK_autores_codigo
   primary key (codigo),
  constraint UQ_autores_nombre
    unique (nombre),
);

create table libros(
  codigo int identity,
  titulo varchar(40),
  codigoautor int not null,
  codigoeditorial tinyint not null,
  precio decimal(5,2)
   constraint DF_libros_precio default (0),
  constraint PK_libros_codigo
   primary key clustered (codigo),
  constraint UQ_libros_tituloautor
    unique (titulo,codigoautor),
  constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on update cascade,
  constraint FK_libros_autores
   foreign key (codigoautor)
   references autores(codigo)
   on update cascade,
  constraint CK_libros_precio_positivo check (precio>=0)
);

go

exec sp_helpconstraint editoriales;

exec sp_helpconstraint autores;

exec sp_helpconstraint libros;