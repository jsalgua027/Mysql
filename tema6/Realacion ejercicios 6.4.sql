-- Ejercicio1
/*
*Obtener por orden alfabético el nombre y los sueldos de los empleados con más de tres hijos. 
*/
select nomem as nombre ,salarem as sueldo
from empleados 
where numhiem > 3
order by  nomem asc;


-- Ejercicio 2
/*
*Obtener la comisión, el departamento y el nombre de los empleados cuyo salario es inferior a 190.000 u.m., 
clasificados por departamentos en orden creciente y por comisión en orden decreciente dentro de cada departamento. 
select ifnull(comisem,0) as 'Comisión' , numde as 'Departamentos',
        nomem as 'Nombre' 
        from empleados
        where salarem > 190.000
        order by numde and ifnull(comisem,0) desc;
*/

select ifnull(comisem,0) as 'Comisión' , numde as 'Departamentos',
        nomem as 'Nombre' 
from  empleados 
where salarem < 190000
order by numde , ifnull(comisem,0) desc;

-- Ejercicio 3
/*
*Hallar por orden alfabético los nombres de los deptos cuyo
 director lo es en funciones y no en propiedad.

*/
select nomde 





/*
Suponiendo que en los próximos tres años el coste de vida va a aumentar un 6% anual y que se
suben los salarios en la misma proporción. Hallar para los empleados con más de cuatro hijos, su
nombre y sueldo anual, actual y para cada uno de los próximos tres años, clasificados por orden
alfabético.
*/
use empresaclase2
/****************************************************ejercicio10****************************/
delimiter $$
drop procedure if exists subidaSalario $$
create procedure subidaSalario(in numeroHijos int) 
begin
select nomem, salarem as salario_Mensual, salarem*12 as salario_Anual, salarem +(salarem*0.06) as salario_Mensual_Segundo_Anio,
    (salarem +(salarem*0.06))*12 as salario_Anual_Segundo_Anio,  salarem+((salarem +(salarem*0.06))*0.06) as sueldo_Mensual_Tercer_Anio,
    (salarem+((salarem +(salarem*0.06))*0.06))*12 as sueldo_Anual_Tercer_Anio

from empleados

where numhiem = numeroHijos
order by nomem asc ;
end $$
delimiter ;

call subidaSalario(4);


/********************************************************************************************/
/********************************************Ejecicio 7************************************************/
/* 
*Obtener los números de los departamentos en los que haya algún empleado 
cuya comisión supere al 20% de su salario. (Nacho) / segunda parte. Generalizar para que los busque por porcentajes 
y que me lo muestre
*/
delimiter $$
drop procedure if exists Ej_7_Rel6_4 $$
create procedure Ej_7_Rel6_4 (in porcentaje int)
begin
	select   distinct departamentos.numde, count(*)
    from departamentos join empleados on departamentos.numde = empleados.numde
    where comisem< (salarem*(porcentaje/100))
    group by departamentos.numde;
end $$
delimiter ;

call Ej_7_Rel6_4 (20);

/********************************************************************************************/
/*29.Seleccionar los nombres de los  departamentos que no dependan de ningún otro. (Nacho)
*/

select nomde
from departamentos
where depende is null;

/*el nombre de los empleados que su departamento no depende de ninguno;
*/
select nomem as Nombre , ape1em as apellido
from empleados join departamentos on empleados.numde = departamentos.numde
where depende is null;


/* obtener  un listin telefonico con el nombre completo de los empleados (APE1 APE2 NOMBRE), EXTELEM
cada usuario podra ver solo los datos de sus compañeros de departamento*/
delimiter $$
drop view if exists listinTel;
create view listinTel
as
select user()
where substring(user()<'@');

delimiter;




select concat_ws('', ape1em, ape2em, nomem), extelem as 'Número de extension'
from empleados







