-- base datos ventaPromociones


/* prepara una funcion que, dado el codigo de una venta, devuelva el importe de dicha venta*/

DROP FUNCTION IF  EXISTS ejer_Repaso_1;

delimiter $$
create function ejer_Repaso_1
	(codVenta int)
    returns decimal(6,2)
    language sql
    deterministic
    reads sql data
begin
	return(select sum(cant*precioventa)
    from detalleventa
    where codventa=codVenta);
    
end $$
delimiter ;

select ejer_Repaso_1(3);
    
-- solucion eva

    


/*obtén un listado de las ventas de este año en el que se muestre el código de la venta, la fecha de la venta el nombre
y apellidos de los clientes de la venta y el importe de la venta(utliza la funcion del apartado anterior)
*/

drop procedure if exists ejer_Repaso_2;
delimiter $$
 create procedure ejer_Repaso_2( in anioVenta int)
		
begin
	select codventa, fecventa, nomcli, ape1cli, ape2cli, ejer_Repaso_1()
    from ventas join clientes on ventas.codcli = clientes.codcli
    where year(fecventa)= year(curdate());

end $$
delimiter ;
 

call ejer_Repaso_2(2012);
-- solucion eva

select codventa, date_format(fecventa,'%d/%m/%Y'), concat_ws( ' ', nomcli, ape1cli, ape2cli, ejer_Repaso_1(codventa))
from ventas join clientes on ventas.codcli = clientes.codcli
where year(fecventa)= year (curdate());


/*
Prepara una fucncion que devuelva la parte anterior a la arroba del email de un cliente dado
*/


drop function if exists fun_ejerc_3
delimiter $$
create function fun_ejerc_3 (cliente int)
	returns varchar(20)
	language sql
    deterministic
    reads sql data
begin
	return (select ifnull(substring(email, 1, locate ('@', email)-1), 'no tiene correo')
		from clientes
        where codcli = cliente
        );
        
end $$
delimiter ;

-- solucion eva
DROP FUNCTION IF EXISTS Fun_ejer_TAREA_18_3;
DELIMITER $$
CREATE FUNCTION Fun_ejer_TAREA_18_3
    (cliente int)
  RETURNS varchar(20)
    LANGUAGE SQL
	DETERMINISTIC
    reads sql data
    
    COMMENT 'MÓDULO: BASES DE DATOS - UNIDAD 6 - TAREA 18 DE ABRIL - EJERCICIO 3'
BEGIN
-- select Fun_ejer_TAREA_18_3(1);
/*	return (select ifnull(substring_index(email,'@',1), ' no tiene correo')
			from clientes
			where codcli = cliente
            );*/
    return (select ifnull(substring(email,1,locate('@',email)-1), ' no tiene correo')
			from clientes
			where codcli = cliente
            );
    

END $$
DELIMITER ;

/* PROPUESTO PARA 19 DE ABRIL:
Obtener un listado de clientes  (código de cliente, nombre y apellidos) 
y el importe de las ventas que han hecho dichos  clientes
Si un cliente no tiene ventras debe mostrase
*/
select codcli, nomcli
from clientes;

select clientes.codcli as codigo_cliente , concat_ws(' ',nomcli, ape1cli, ape2cli ) as nombre_completo ,
 sum( ifnull(cant*precioventa, 'este cliente no ha comprado')) as detalle_venta
	from clientes left join ventas on clientes.codcli = ventas.codcli
		left join detalleventa on ventas.codventa = detalleventa.codventa
 group by codigo_cliente
 order by detalle_venta desc;
