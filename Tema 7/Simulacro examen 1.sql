/*
Nos han pedido que preparemos un procedimiento almacenado que, mediante el uso de cursores muestre un listado de clientes
 y las compras que han realizado por meses entre dos meses dados (usaremos el número de mes).
Además, a medida que vamos obteniendo los datos, 
para los clientes cuya media de artículos comprados supere a la media de la empresa 
para ese mes (media de artículos que se han comprado en la empresa en un mes) se les regalará 5 puntos.
Queremos asegurar que la operación se realice de manera íntegra y garantizando que al terminar, 
la base de datos quedará en buen estado.
El listado que queremos se mostraría para los meses ENERO (1) A MARZO (3) sería algo así:
COMPRAS  DE CLIENTES ENTRE ENERO Y MARZO:



CLIENTE: Nombre de cliente
-------------------------------------------------------------------------------------------------------------------------------------
ENERO:
Artículo                    Unidades  compradas            Precio de compra
Nombre artítulo                    x                    x,xx
Nombre artítulo                    x                    x,xx
…..
----------------------------------------------------------------------------------------------------------------------------------
Media de Nombre de cliente en ENERO:    Media unidades compradas*        puntos regalados**
----------------------------------------------------------------------------------------------------------------------------------
FEBRERO
Artículo                    Unidades  compradas            Precio de compra
Nombre artítulo                    x                    x,xx
Nombre artítulo                    x                    x,xx
…..
-----------------------------------------------------------------------------------------------------------------------------------
Media de Nombre de cliente en FEBRERO:    Media unidades compradas*        puntos regalados**
----------------------------------------------------------------------------------------------------------------------------------
MARZO
Artículo                    Unidades  compradas            Precio de compra
Nombre artítulo                    x                    x,xx
Nombre artítulo                    x                    x,xx
…..
-----------------------------------------------------------------------------------------------------------------------------------
Media de Nombre de cliente en MARZO:    Media unidades compradas*        puntos regalados**
-------------------------------------------------------------------------------------------------------------------------------------


*/

use  ventapromoscompleta;

drop procedure if exists simulacro1;
delimiter $$
create procedure simulacro1()
begin

	declare nombreCliente, nombreArticulo, mes varchar(40) default '';
    declare unidadesCompradas int default 0;
    declare precioCompra decimal (7,2) default 0.00;
    declare mediaUnidadesCompradas decimal (7,2) default 0.00;
    declare puntosRegalados int default 0;
    declare cambioCliente int;
    declare cambioMes int;
    declare fin_cursor boolean default 0;
    
declare curVentas cursor for

		select clientes.codcli, concat_ws(' ', clientes.nomcli, clientes.ape1cli, clientes.ape2cli),
			monthname(ventas.fecventa), articulos.nomart, detalleventa.cant, detalleventa.precioventa
				from ventas join clientes on ventas.codcli = clientes.codcli
					join detalleventa on ventas.codventa = detalleventa.codventa
						join articulos on detalleventa.refart = articulos.refart
				where month(ventas.fecventa) between 1 and 6 
					and year(ventas.fecventa) = year(curdate())
			order by concat_ws(' ', clientes.nomcli, clientes.ape1cli, clientes.ape2cli),
            month(ventas.fecventa);

declare continue handler for sqlstate '02000' 
SET final = 1;

drop table if exists listado;
create temporary table listado
	(descripcion varchar(100));

open curVentas;
fetch from curVentas into nombreCliente, nombreArticulo, mes, unidadesCompradas, precioCompra, mediaUnidadesCompradas, puntosRegalados;
 while fin_cursor =0 do
 
























