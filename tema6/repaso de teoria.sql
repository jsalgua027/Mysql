-- teoria
/*
select -- que colummnas  cuando se usa el group by en el selec hay que especificar los que quieres mostrar y que sea comun a los grupos
from  (join)-- si son varias tablas -- donde estan los datos; ------>1º en ejecutarse 
where -- que filas quiero (filtros sobre filas)2º en ejecutarse
group by -- hacer grupos para un campo o conjunto de campos---->> 3º en ejecutarse
having -- filtra grupos que cumplen una codicion ---->>>>4º en ejecutars 
order by -- para ordenar los resultados
*/


-- count (distinct numde) el distinct hace que cuente el total de departamentos distintos, 
-- coun () cuenta el numero de celdas
-- ifnull(empleados.numhiem,0) que si es null que lo cuente como cero, para que no lo cuente como datos distintos el cero y el null
-- round redondea los decimales

/*----------Operadores cuantificadores (de conjuntos de resulatdos) se usan en el where y en el having--------
some  ----> para la comparacion de algunos se usa con operadores logicos [< <= > >= <> =]
any   ----> para la comparacion de algunos se usa con operadores logicos [< <= > >= <> =]
all   ----> para todos 
in    ----> cuando el valor que comparo esta en el conjunto de resultados
exists ---> cuando se da el resultado
*/
-- las funciones de agrgado no se pueden anidar------> max(sum(empleados.salarem))-----> esto no se puede

-- use database empresaclase2
select  ifnull(empleados.numhiem,0),  count(*)
from empleados join departamentos
	on empleados.numde = departamentos.numde
where empleados.numhiem >=2
group by ifnull(empleados.numhiem,0)
having  count(*)>1; -- filtro para grupo 

--  empleados cuyo salario  sea igual que el salario de algun empleado del depto 120

select *
from empleados 
where salarem =  some (select salarem
					from empleados
                    where numde= 120);


--  empleados cuyo salario  sea idiferente que el salario de los empleados 120

select *
from empleados 
where salarem <>  all  (select salarem
					from empleados
                    where numde= 120)


-- union sirve para unir dos select (completos con su from, where)and
-- union all . une sin la criba
/*
 VISTAS!!
 */
-create view fiestareyes 
-as
/*
 se cree todo el selec completo
 una vez creado el view podemos llamar en otro procedimiento a esa vista creada (ojo no  son datos creados
 solo apuntas a los datso no creas nada nuevo.
 ahora podriamos hacer:

*/
select empleados*
from fiestayeres 


-- funcion del sistema user  select user() ==> te devuelve el nombre de usuario y ip
