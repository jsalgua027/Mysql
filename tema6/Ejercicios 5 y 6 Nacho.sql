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
                
/*correccion*/
-- ejercico 5 
-- falta meterlo en un procedimiento
	select  monthname(fecventa), sum(precioventa*cant)
    from ventas left join detalleventa
		on ventas.codventa = detalleventa.codventa
	where year(fecventa) = year(curdate())
    group by monthname(fecventa);


-- ejercicio 6
-- falta meterlos en un procedimiento
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
                
