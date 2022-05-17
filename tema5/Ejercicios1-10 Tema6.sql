/* 1.Obtener todos los datos de todos los empleados.
2.Obtener la extensión telefónica de “Juan López”.
3.Obtener el nombre completo de los empleados que tienen más de un hijo.
4.Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.
5.Obtener el nombre completo y en una sola columna de los empleados sin comisión.
6.Obtener la dirección del centro de trabajo “Sede Central”.
7.Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
8.Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.
9.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).
10.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa entre 1 y tres años. (Añade filas nuevas para poder comprobar que tu consulta funciona).
*/
-- Ejercicio 1
select *
from empleados;

-- Ejercicio 2
select extelem
from empleados
where nomem = 'Juan' and ape1em ='Lopez';

-- Ejercicio 3 Obtener el nombre completo de los empleados que tienen más de un hijo.
select nomem,ape1em,ape2em
from empleados
where numhiem > 1;

-- 4.Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.
select nomem,ape1em,ape2em,
concat(nomem,' ',ape1em,' ',ifnull(ape2em,' ')) as 'Nombre completo'
from empleados
where numhiem between 1 and 3;

-- 5.Obtener el nombre completo y en una sola columna de los empleados sin comisión.

select 
concat(nomem,' ',ape1em,' ',ifnull(ape2em,' ')) as 'Nombre completo'
from empleados
where comisem is null or comisem=0;


-- 6.Obtener la dirección del centro de trabajo “Sede Central”.
select dirce
from centros
where nomce=' SEDE CENTRAL';

-- 7.Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
select nomde
from departamentos
where presude >6000;

-- 8.Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.
select nomde
from departamentos
where presude >=6000;

-- 9.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).

select concat(nomem,' ',ape1em,' ',ifnull(ape2em,' ')) as 'Nombre completo'
from empleados
where fecinem >='2021/2/14';

-- 10.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa entre 1 y tres años. (Añade filas nuevas para poder comprobar que tu consulta funciona).

select concat(nomem,' ',ape1em,' ',ifnull(ape2em,' ')) as 'Nombre completo'
from empleados
where fecinem between '2001/2/14' and '2010/2/14';


-- Ejercicio 11. Prepara un procedimiento almacenado que ejecute la consulta del apartado 1 y otro que ejecute la del apartado 5.

delimiter $$
drop procedure if exists almacenado $$
create procedure almacenado 
()
begin
select *
from empleados;
end$$
delimiter ;

delimiter $$
drop procedure if exists almacenado5 $$
create procedure almacenado5
()
begin
select 
concat(nomem,' ',ape1em,' ',ifnull(ape2em,' ')) as 'Nombre completo'
from empleados
where comisem is null or comisem=0;
end $$
delimiter ;


-- Ejercicio 12.Prepara un procedimiento almacenado que ejecute la consulta del apartado 2 de forma que nos sirva para averiguar la extensión del empleado que deseemos en cada caso.

delimiter $$
drop procedure if exists almacenado2 $$
create procedure almacenado2
(in extelem char)
begin
select extelem
from empleados
where nomem = 'Juan' and ape1em ='Lopez';
end$$
delimiter ;

-- Ejercicio 13.Prepara un procedimiento almacenado que ejecute la consulta del apartado 3 y otro para la del apartado 4 de forma que nos sirva para averiguar el nombre de aquellos que tengan el número de hijos que deseemos en cada caso.

delimiter $$
drop procedure if exists almacenado3 $$
create procedure almacenado3
(in nomem varchar (20))
begin
select nomem,ape1em,ape2em
from empleados
where numhiem > 1;
end$$
delimiter ;


delimiter $$
drop procedure if exists almacenado4 $$
create procedure almacenado4
(in nomem varchar(20))
begin
select nomem,ape1em,ape2em,
concat(nomem,' ',ape1em,' ',ifnull(ape2em,' ')) as 'Nombre completo'
from empleados
where numhiem between 1 and 3;
end$$
delimiter ;

-- Ejercicio 14.Prepara un procedimiento almacenado que, dado el nombre de un centro de trabajo, nos devuelva su dirección.
delimiter $$
drop procedure if exists almacenado6 $$
create procedure almacenado6
(in nomcen varchar(60), out direccion varchar(60))
begin
select dirce
from centros;
end$$
delimiter ;

-- Ejercicio 15. Prepara un procedimiento almacenado que ejecute la consulta del apartado 7 de forma que nos sirva para averiguar, dada una cantidad, el nombre de los departamentos que tienen un presupuesto superior a dicha cantidad.

delimiter $$
drop procedure if exists almacenado7$$
create procedure almacenado7
(in presude decimal, in nomde varchar(60))
begin
select nomde
from departamentos
where presude >6000;
end$$
delimiter ;

-- Ejercicio 16. Prepara un procedimiento almacenado que ejecute la consulta del apartado 8 de forma que nos sirva para averiguar, dada una cantidad, el nombre de los departamentos que tienen un presupuesto igual o superior a dicha cantidad.

delimiter $$
drop procedure if exists almacenado8$$
create procedure almacenado8
(in presude decimal, in nomde varchar(60))
begin
select nomde
from departamentos
where presude >=6000;
end$$
delimiter ;

-- Ejercicio 17 .Prepara un procedimiento almacenado que ejecute la consulta del apartado 9 de forma que nos sirva para averiguar, dada una fecha, el nombre completo y en una sola columna de los empleados que llevan trabajando con nosotros desde esa fecha.

delimiter $$
drop procedure if exists almacenado9$$
create procedure almacenado9
(in presude decimal, in nomde varchar(60))
begin
select concat(nomem,' ',ape1em,' ',ifnull(ape2em,' ')) as 'Nombre completo'
from empleados
where fecinem >='2021/2/14';
end$$
delimiter ;




