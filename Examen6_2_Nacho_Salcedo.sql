

-- ejercicio 1


drop procedure if exists ejer1_casaR;
delimiter $$
create procedure ejer1_casaR
	( in zona int,
		in caracteristica int
        )
begin

select nomcasa as nombre_casa, preciobase as precio
	from casas left join zonas on casas.codzona = zonas.numzona
	 left join caracteristicas on casas.codzona = caracteristicas.codcasa
where zona = numzona and caracteristicas = codcaracter
order by preciobase asc;
end $$
delimiter ;

call ejer1_casaR(1,1);


-- ejercicio 2

select casas.nomcasa as nombre_de_casas, nomcaracter as nombre_carateristicas
from caracteristicasdecasas join caracteristicas on caracteristicasdecasas.codcaracter = caracteristicas.numcaracter
where casas.codcasa = caracteristicasdecasas.codcasa;
    


-- ejercicio 3

drop procedure if exists ejer3_casaR;
delimiter $$

create procedure ejer3_casaR
	(in tipocasa int)
    
begin
	select zonas.nomzona as ZONA, casas.nomcasa as CASA, concat_ws('de ', minpersonas,'a ', maxpersonas, 'personas') 
    as 	ALOJAMIENTO_PARA
	from casas join tiposcasa on casas.codtipocasa = tiposcasa.numtipo
    where tipocasa = casas.codtipocasa;
end $$
delimiter ;


-- call ejer3_casaR(2);

-- ejercicio 4
drop procedure if exists ejer4_casaR;

delimiter $$
create procedure ejer4_casaR
	( in zona int)
begin
	select avg(casas.m2) as Metros_cuadrados, zonas.nomzona as ZONA
    from casas join zonas on codzona = numzona
    where zona = numzona;
end $$
delimiter ;

-- call ejer4_casaR(2);

-- ejercicio 5
drop procedure if exists ejer5_casaR;
delimiter $$
create procedure ejer5_casaR
	( in casa int)
begin
	select count(reservas.codreserva) as Total_Reservas
    from reservas join casas on reservas.codcasa = casas.codcasa
    where casa = casas.codcasa;
end$$
delimiter ;

call ejer5_casaR(2);

-- ejercicio 6

drop procedure if exists ejer6_casaR;
delimiter $$
create procedure ejer6_casaR
	( in casa int)
begin
	select count(reservas.codreserva) as Total_Reservas,  count(reservas.numdiasestancia) as Total_Dias
    from reservas join casas on reservas.codcasa = casas.codcasa
    where casa = casas.codcasa;
end$$
delimiter ;

call ejer6_casaR(2);

-- ejercicio 7

drop procedure if exists ejer7_casaR
delimiter $$
create procedure ejer7_casaR
	(in propietario int)
begin
	
select  nompropietario, left(nompropietario, locate(' ', nompropietario)-1) as nombre, 
	left(substring(nompropietario, locate(' ', nompropietario)+1), locate(' ', substring(nompropietario, locate(' ', nompropietario)+1))) as apellido1 
	from propietarios join casas on codpropi = codpropietario
	left join reservas on reservas.codcasa = casas.codcasa
where propietario = propietarios.codpropietario;

end $$
delimiter ;

call ejer7_casaR(2);