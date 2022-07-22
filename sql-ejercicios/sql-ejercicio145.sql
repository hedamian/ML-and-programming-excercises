Funciones (drop)


Las funciones definidas por el usuario se eliminan con la instrucción "drop function":
Sintaxis:

 drop function NOMBREPPROPIETARIO.NOMBREFUNCION;

Se coloca el nombre del propietario seguido del nombre de la función.

Si la función que se intenta eliminar no existe, aparece un mensaje indicándolo, para evitarlo, 
podemos verificar su existencia antes de solicitar su eliminación (como con cualquier otro objeto):

 if object_id('NOMBREPROPIETARIO.NOMBREFUNCION') is not null
  drop function NOMBREPROPIETARIO.NOMBREFUNCION;

Eliminamos, si existe, la función denominada "f_fechacadena":

 if object_id('dbo.f_fechacadena') is not null
  drop function dbo.f_fechacadena; 
