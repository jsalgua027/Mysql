delimiter $$
create procedure buscaCentros()
begin
	select centros.numce as 'Num.Centro', 
		centros.nomce as 'Nombre'
	from centros
	order by centros.nomce;

end $$
delimiter ;

call buscaCentros();

/******/

set @nuevocentro = (select max(numce)+1 from centros);
insert into centros
	(numce, nomce, dirce,codpostal)
values
	(@nuevocentro, centros.getnombre,centros.getdircentro, centros.getcodpostal); 


delimiter $$
drop procedure if exists insertaCentros $$
create procedure insertaCentros
	(in nombre varchar(60),
     in direccion varchar(60),
     in codigopostal char(5),
     out resultado int
     )
begin
	declare nuevocentro int;
	
    start transaction;
    
		set nuevocentro = (select max(numce)+10 
						   from centros);
		
		insert into centros
			(numce, nomce, dirce,codpostal)
		values
			(nuevocentro, 
			nombre,
			direccion,
			codigopostal);
	commit;
    set resultado = nuevocentro;

end $$
delimiter ;
/* el programador de java (u otro lenguaje):
call insertaCentros(centro.getnombre,
	centro.getdireccion, centro.codpostal, miResultado);
*/
-- nosotros para probar el procedimeinto:
call insertaCentros('probando','sin calle', '29680', @result);

select @result;


/**** consulta de centros */

select numce, dirce, nomce, codpostal
from centros
-- where numce = celdaCentrosDeFilaActual;
where numce = 20;


delimiter $$
drop procedure if exists BuscaUnCentro $$
create procedure BuscaUnCentro
	(in numCentro int
     )
begin
    select numce as num, dirce as direccion, nomce as nombre, codpostal as codigoPos
	from centros
	-- where numce = celdaCentrosDeFilaActual;
	where numce = numCentro;

end $$
delimiter ;
/* el programador de java (u otro lenguaje):
call BuscaUnCentro(celdaCentrosDeFilaActual);
*/
-- nosotros para probar el procedimeinto:
call BuscaUnCentro(20);

/*****  EDICION DE CENTRO DE TRABAJO **/
/** 1. UPDATE */
delimiter $$
drop procedure if exists ActualizaCentro $$
create procedure ActualizaCentro 
	(in numCentro int,
     in nombre varchar(60),
     in direccion varchar(60),
     in codigopostal char(5)
     )
begin
    update centros
    set 
		nomce = nombre,
        dirce = direccion,
        codpostal = codigopostal
	where numce = numCentro;

end $$
delimiter ;
/* el programador de java (u otro lenguaje):
call ActualizaCentro(centro.getnumcentro, .....);
*/
-- nosotros para probar el procedimeinto:
set @nombre = 'nombre nuevo';

call ActualizaCentro(40, @nombre,'dir nueva','29605');
call BuscaUnCentro(40);


/*** 2. DELETE */

delimiter $$
drop procedure if exists BorraCentro $$
create procedure BorraCentro 
	(in numCentro int
     )
begin
    delete from centros
	where numce = numCentro;

end $$
delimiter ;
/* el programador de java (u otro lenguaje):
call BorraCentro(centro.getnumcentro);
*/
-- nosotros para probar el procedimeinto:
call BorraCentro(41);
