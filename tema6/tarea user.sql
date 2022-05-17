/* obtener  un listin telefonico con el nombre completo de los empleados (APE1 APE2 NOMBRE), EXTELEM
cada usuario podra ver solo los datos de sus compañeros de departamento*/
delimiter $$
drop view if exists listinTel;
create view listinTel
definer = user
sql security invoker
as
select user()
where substring(user()<'@');

delimiter;


select concat_ws('', ape1em, ape2em, nomem), extelem as 'Número de extension'
from empleados



-- solucion 
listin telefonico*/
select user(),
    locate('@', user()),
    left(user(),locate('@', user())),
    locate('@', user())-1;
select left(user(),locate('@', user())-1);


CREATE VIEW LISTIN
    (Nombre, extension)
AS
    select concat (ape1em, ifnull(concat(' ', ape2em),''), ', ', nomem), extelem
    from empleados
    where numde = (select numde
                   from empleados
                   where userem = left(user(),locate('@',user())-1 )
                  );
                  
select *
from LISTIN;


/***** PARA LA BD DE LAS PROMOCIONES **/
/* PREPARAR UNA VISTA EN LA QUE TENGAMOS DISPONIBLE CON FACILIDAD EL PRECIO DE VENTA DE CADA DÍA DE LOS PRODUCTOS */

-- tenemos que unir precio articulos con los precios de promocion y despues unir los precios que no estan promocionados,
-- me tiene que dar el precio del articulo hoy
-- si esta en promocion tiene que dar el de promocio
-- tenemos que jugar con las fechas y la union 