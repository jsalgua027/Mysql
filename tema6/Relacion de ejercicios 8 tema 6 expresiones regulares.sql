/*
Para la base de datos empresa_clase:
Sabiendo que en la extensión de teléfono que utilizan los empleados, 
el primer dígito corresponde con el edificio, el segundo con la planta y el tercero con la puerta. 
Busca aquellos empleados que trabajan en la misma planta (aunque sea en edificios diferentes) que el empleado 120.
*/
select *
from empleados
where extelem regexp '.4.';

select *
from empleados
where extelem rlike concat( '^.', 
							(select substring(extelem, 2,1)
								from empledos
                                where nuem =120));

							/*Para la base de datos turRural:

Sabiendo que los dos primeros dígitos del código postal se corresponden con la provincia y los 3 siguientes a la población dentro de esa provincia. Busca los clientes (todos sus datos) de las 9 primeras poblaciones de la provincia de Málaga (29001 a 29009).
*/
select *
from clientes
where codpostalcli rlike '^2900[1-9]';

/*
Sabiendo que los dos primeros dígitos del código postal se corresponden con la provincia y 
los 3 siguientes a la población dentro de esa provincia. 
Busca los clientes (todos sus datos) de las 20 primeras poblaciones de la provincia de Málaga (29001 a 29020).
*/
select *
from clientes
where codpostalcli rlike '^290([12]0|[01][1-9])';


/*
Queremos encontrar clientes con direcciones de correo válidas,
 para ello queremos buscar aquellos clientes cuya dirección de email contiene una “@”, 
 y termina en un símbolo punto (.) seguido de “com”, “es”, “eu” o “net”.
 */
 
 select *
from clientes
where codpostalcli rlike '@[a-z]*\\.(com|net|es|eu1it)$';
 
 
 
 
 /*
Queremos encontrar ahora aquellos clientes que no cumplan con la expresión regular anterior.
*/



