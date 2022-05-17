-- ejercicio 1
/*Hallar el salario medio para cada grupo de empleados con igual comisión y para los que no la tengan, pero solo nos interesan 
aquellos grupos de comisión en los que haya más de un empleado.
*/
select avg(salarem)
from empleados
where comisem = (select comisem 
					from empleados) and comisem is null
group by empleados.comisem 
having count(*)>1;

-- ejercicio 2
/*Para cada extensión telefónica, hallar cuantos empleados la usan y
 el salario medio de éstos. Solo nos interesan aquellos grupos en los que hay entre 1 y 3 empleados.
*/
select avg(salarem) as salario_medio, count(empleados.extelem)
from empleados
group by empledos.extelem 
having count(*)>=1 and count(*)<=3;

-- ejercicio 3
/*
Prepara un procedimiento que, dada un código de promoción obtenga un listado con el nombre de las categorías
 que tienen al menos dos productos incluidos en dicha promoción.
 */
use ventapromoscompleta 
 delimiter $$
 drop procedure if exists ejercicio3_R6_7 $$
 create procedure ejercicio3_R6_7(in codigo int)
 begin
	select categorias.nomcat
    from articulos join catalogospromo on articulos.refart = catalogospromo.refart
    where articulos.codcat = categorias.codcat
    group by catalogospromo.refart
    having cout(catalogospromo.refart)>2;
end $$
delimiter ;
 
 call  ejercicio3_R6_7(1);
-- ejercicio 4 
/* Prepara un procedimiento que, dado un precio, obtenga un listado con el nombre de las categorías 
en las que el precio  medio de sus productos supera a dicho precio.
*/
 
 
 
 /*5.Prepara un procedimiento que muestre el importe total de las ventas por meses de un año dado.
6.Como el ejercicio anterior, pero ahora solo nos interesa mostrar aquellos meses en los que se ha superado a 
la media del año.
*/
-- ejercicio 5

delimiter $$
drop procedure if exists  ejercicio_5 $$
create procedure ejercicio_5
			(in anio int)
begin
		select count(detalleventa.precioventa)
        from detalleventa join ventas on detalleventa.codventa = ventas.codventa
        where anio = ventas.fecventa
        group by year(ventas.fecventa);
        
end $$
delimiter ;
        
-- call ejerccio_5(2012)   

--  ejercicio 5 correjido sin procedimiento
select  monthname(fecventa), sum(precioventa*cant)
    from ventas left join detalleventa
		on ventas.codventa = detalleventa.codventa
	where year(fecventa) = year(curdate())
    group by monthname(fecventa);

     
        
-- ejercicio 6
delimiter $$
drop procedure if exists ejercicio_6 $$
create procedure ejercicio_6
				(in anio int)
begin
		select avg(count(detalleventa.precioventa))
		from detalleventa join ventas on detalleventa.codventa = ventas.codventa
        where anio = ventas.fecventa
        group by year(ventas.fecventa)
        having month(ventas.fecventa)> year(avg(count(detalleventa.precioventa)));
end $$
delimiter ;
                
 -- call ejecicio_6  (2012)      
 
 -- ejercicio 6 corregido sin procedimmiento
 
  select  month(fecventa), sum(precioventa*cant)
    from ventas left join detalleventa
		on ventas.codventa = detalleventa.codventa
	where year(fecventa) = year(curdate())
    group by month(fecventa)
     having sum(precioventa*cant)> (select avg(precioventa*cant)
									from ventas join detalleventa
                                    on ventas.codventa = detalleventa.codventa
                                    where year(fecventa) = year(curdate())
                                    );	
 
                