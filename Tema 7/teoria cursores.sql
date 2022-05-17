-- tema 7
/*
cursores
sacar un listado  en el que hay un centro de trabajo y abajo  una lista con
los departamentos que hay en ese centro

*/


delimiter $$
drop procedure if exists pruebaCursor $$
create procedure pruebacursor()
begin
declare numdepto int default 0; -- declaracion de variables ,se le puede poner un valor por defecto
declare nomdepto, nomcentro, nomcentroaux varchar(100) default ''; -- sirve para dar el salto entre las cabeceras nomcentroaux
declare presupuesto decimal(12,2) default 0.00;
declare fin_cursor boolean default 0;

declare curDeptos cursor for
						select numde, nomde, presude, nomce	
						from departamentos join centros on departamentos.numce = centros.numce
						order by nomce;


declare continue handler for sqlstate '02000'
 -- begin
		set fin_cursor= 1;
 -- end;
create temporary table listado
(filalistado varchar(500));
open curDeptos; -- abrimos el cursor
fetch curDeptos into numdepto, nomdepto, presupuesto, nomcentro;
-- definimos el bucle
	while fin_cursor = 0 do
		begin
		if nomcentro <> nomcentroaux then
		begin
			insert into listado
			values
			(concat('centro de trabajo: '), nomcentro);
			insert into listado
			values
			(' numdepto     nombre     presupuesto');
			set nomcentroaux = nomcentro;
		end;
      
	end if;
		insert into listado
		values
		(concat(numdepto,'       ' nomdepto,'          ' presupuesto));




		fetch curDeptos into numdepto, nomdepto, presupuesto, nomcentro;
	end;
end while;


close curDeptos;
select * from listado; -- señalo la lista temporal 

drop table listado;-- borro la lista temporal 

end $$
delimiter ;

-- solucion Eva

delimiter $$
DROP PROCEDURE IF exists pruebaCursor $$
create procedure pruebaCursor()
begin
-- CALL pruebaCursor();
DECLARE numdepto int DEFAULT 0;
DECLARE nomdepto, nomcentro, nomcentroaux VARCHAR(100) DEFAULT '';
DECLARE presupuesto decimal(12,2) DEFAULT 0.00;
DECLARE fin_cursor BOOLEAN default 0;

declare curDeptos cursor for
							select numde, nomde, presude, nomce
							from departamentos join centros on departamentos.numce = centros.numce
                            order by nomce;

DECLARE continue HANDLER FOR SQLSTATE '02000'
	-- BEGIN
		SET fin_cursor = 1;
   --  END;

create temporary table listado
(filalistado varchar(500));

OPEN curDeptos;
FETCH curDeptos INTO numdepto, nomdepto, presupuesto,nomcentro;

WHILE fin_cursor = 0 DO
BEGIN
if nomcentro <> nomcentroaux then
begin
	insert into listado
	values
	(concat('centro de trabajo: ', nomcentro)),
	('num.depto      nombre                  presupuesto');
    set nomcentroaux = nomcentro;
end; 
end if;

insert into listado
values
(concat(numdepto, '     	      ',nomdepto,'             ', presupuesto));



FETCH curDeptos INTO numdepto, nomdepto, presupuesto,nomcentro;
END;
END WHILE;

CLOSE curDeptos;

select * from listado;
 
drop table listado;

end $$
delimiter ;

call pruebaCursor();


-- version con el total del presupuesto del centro--------------------------------------------------

delimiter $$
DROP PROCEDURE IF exists pruebaCursor $$
create procedure pruebaCursor()
begin
-- declaramos la variables
DECLARE numdepto int DEFAULT 0;
DECLARE nomdepto, nomcentro, nomcentroaux VARCHAR(100) DEFAULT '';
DECLARE presupuesto decimal(12,2) DEFAULT 0.00;
DECLARE fin_cursor BOOLEAN default 0;
declare totalpresu decimal(12,2) default 0;
declare primerafila boolean default 1;

declare curDeptos cursor for
							select numde, nomde, presude, nomce
							from departamentos join centros on departamentos.numce = centros.numce
                            order by nomce;

DECLARE continue HANDLER FOR SQLSTATE '02000'
	-- BEGIN
		SET fin_cursor = 1;
   --  END;
   
   -- creamos la tablas temporales con las que vamos a trabajar
drop table if exists listado;
create temporary table listado
(filalistado varchar(500));

OPEN curDeptos;
FETCH curDeptos INTO numdepto, nomdepto, presupuesto,nomcentro;

WHILE fin_cursor = 0 DO
BEGIN
if nomcentro <> nomcentroaux then
begin
	if not primerafila then
	begin
		insert into listado
			values
		(concat('total presuesto: ', totalpresu));
	end;
	end if;
	set primerafila = 0;
    set totalpresu = 0;
	insert into listado
	values
	(concat('centro de trabajo: ', nomcentro)),
	('num.depto      nombre                  presupuesto');
    set nomcentroaux = nomcentro;
end; 
end if;

insert into listado
values
(concat(numdepto, '     	      ',nomdepto,'             ', presupuesto));
set totalpresu = totalpresu + presupuesto;


FETCH curDeptos INTO numdepto, nomdepto, presupuesto,nomcentro;
END;
END WHILE;

CLOSE curDeptos;
insert into listado
values
	(concat('total presuesto: ', totalpresu));
select * from listado;
 
drop table listado;

end $$
delimiter ;

call pruebaCursor();


