/* Ejercicio 2 Obtén de la plataforma un script con los datos de una tabla “empleados_temp”.
 En esta tabla los datos de los salarios están actualizados. 
 Realiza las operaciones que consideres oportunas para actualizar,
 en la tabla empleados los salarios de sus empleados por los de la tabla “empleados_temp”.
/*


/* Ejercicio 3 Obtener todos los datos de todos los empleados 
y el nombre del departamento al que pertenecen.
*/

select nomem,empleados.numde,departamentos.numde,nomde 
from empleados join departamentos on empleados.numde = departamentos.numde
order by nomem;

/* Ejercicio 4 Obtener la extensión telefónica 
y el nombre del centro de trabajo de “Juan López”.
*/
select extelem, centros.nomce
from empleados join centros join departamentos on empleados.numde = departamentos.numde
where nomem='JUAN' and ape1em= 'LOPEZ';