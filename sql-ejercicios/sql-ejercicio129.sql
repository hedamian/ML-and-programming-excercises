119 - Procedimientos almacenados


Vimos que SQL Server ofrece dos alternativas para asegurar la integridad de datos, la integridad:

1) DECLARATIVA, mediante el uso de restricciones (constraints), valores predeterminados (defaults) y reglas (rules) y

2) PROCEDIMENTAL, mediante la implementación de procedimientos almacenados y desencadenadores (triggers).

Nos detendremos ahora en procedimientos almacenados.

Un procedimiento almacenado es un conjunto de instrucciones a las que se les da un nombre, que se almacena en el servidor. Permiten encapsular tareas repetitivas.

SQL Server permite los siguientes tipos de procedimientos almacenados:

1) del sistema: están almacenados en la base de datos "master" y llevan el prefijo "sp_"; permiten recuperar información de las tablas del sistema y pueden ejecutarse en cualquier base de datos.

2) locales: los crea el usuario (próximo tema).

3) temporales: pueden ser locales, cuyos nombres comienzan con un signo numeral (#), o globales, cuyos nombres comienzan con 2 signos numeral (##). Los procedimientos almacenados temporales locales están disponibles en la sesión de un solo usuario y se eliminan automáticamente al finalizar la sesión; los globales están disponibles en las sesiones de todos los usuarios.

4) extendidos: se implementan como bibliotecas de vínculos dinámicos (DLL, Dynamic-Link Libraries), se ejecutan fuera del entorno de SQL Server. Generalmente llevan el prefijo "xp_". No los estudiaremos.

Al crear un procedimiento almacenado, las instrucciones que contiene se analizan para verificar si son correctas sintácticamente. Si no se detectan errores, SQL Server guarda el nombre del procedimiento almacenado en la tabla del sistema "sysobjects" y su contenido en la tabla del sistema "syscomments" en la base de datos activa. Si se encuentra algún error, no se crea.

Un procedimiento almacenados puede hacer referencia a objetos que no existen al momento de crearlo. Los objetos deben existir cuando se ejecute el procedimiento almacenado.

Ventajas:

- comparten la lógica de la aplicación con las otras aplicaciones, con lo cual el acceso y las modificaciones de los datos se hacen en un solo sitio.

- permiten realizar todas las operaciones que los usuarios necesitan evitando que tengan acceso directo a las tablas.

- reducen el tráfico de red; en vez de enviar muchas instrucciones, los usuarios realizan operaciones enviando una única instrucción, lo cual disminuye el número de solicitudes entre el cliente y el servidor.

