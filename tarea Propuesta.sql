/*
1. Para la base de datos “TurRural” prepara un procedimiento que muestre un listado con los nombres y apellidos 
de los propietarios en columnas separadas.
Da por hecho que los nombres que tenemos son simples, esto es, nadie tiene un nombre o apellidos compuestos. 
Puedes modificar los datos para comprobar los resultados.
*/
delimiter $$
drop procedure if exists ejer1 $$
create procedure ejer1()
begin
	select nompropietario as "Nombre"
    from porpietarios 
    group by propietarios.codpropietario;
end $$
delimiter ;
    

/*
2. Para la BD empresaclase, prepara un procedimiento que devuelva la contraseña inicial de un empleado. Esta será:
* La primera y la última letra de su nombre+
* La 2ª y 3ª letras de su primer apellido +
* La letra central de su 2º apellido o la z en caso de que no tenga segundo apellido + 
* el último número de su dni sin la letra.
*/
delimiter $$
drop procedure if exists ejer2 $$
create procedure ejer2
		(out clave varchar(6))
begin




/*
3. Dado el código de un empleado, muestra cuando termina el periodo de formación de un empleado 
(6 meses y dos semanas desde la fecha de ingreso). El formato debe ser:
día ? del mes ?? del año ????.
*/

delimiter $$
drop procedure if exists ejer3 $$
create procedure ejer3
	(in codigo int)
begin
	select date_add(fecinem, interval(194)day) as "fin de formacion"
    from empleados 
    where codigo = empleados.numem;
end $$
delimiter ;
    
  call ejer3(510);
    
    
    
-- soluciones
-- ejercicio 2
use empresaclase2;

delimiter $$
create procedure pruebaFunciones2
		( in empleado int, out pass char(6)
        )
begin
	select nomem, ape1em, ape2em, dniem, concat(left (nomem,1),right(noem,1)),
    substring(ape1em, 2,2),
    ifnull(substring(ape2em, (length(ape2em)div 2)+1 ,1), 'z'),
    substring(dniem,length(dniem)-1,1)
    from empleados
    where numem = empleado;
    end $$
    delimiter ;
    
    


