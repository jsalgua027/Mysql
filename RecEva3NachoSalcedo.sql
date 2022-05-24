use cadcafeterias;


-- *****************EXAMEN UNIDAD 6.2*******************

/*
EJERCICIO 1

*/

drop  procedure if exists examen_recu_p1;
delimiter $$
create procedure  examen_recu_p1
(in codPostal char(5))
begin
	select concat(nomcafet, direccion, poblacion, tlfcontacto)
		from cafeterias
        where cafeterias.codpostal = codPostal
        group by cafeterias.codcafet;
       
 end $$
 delimiter ;
 
 call examen_recu_p1 (29680);
        
/*
***********************EJERCICIO 2********************************************

*/        
        
drop procedure if exists examen_recu_p2;
delimiter $$
create procedure examen_recu_p2
	(in fechaCom1 date , in fechaCom2 date )

begin 
	select cafeterias.nomcafet , count(comandas.importe * comandas.codcomanda)
    from comandas join cafeterias on comandas.codcafet = cafeterias.codcafet
    where comandas.fechacomanda between fechaCom1 and fechaCom2;
    
end $$
delimiter ;


-- call examen_recu_p2 (2020-02-12, 2020-02-14)

/*
***********************EJERCICIO 3********************************************

*/    

   
drop procedure if exists examen_recu_p3;
delimiter $$
create procedure examen_recu_p3
	(in codEmp1 int , in codEmp2 int, out totalDias int )

begin 
	select count(datediff(turnos_emple.dia_desde, turnos_emple.dia_hasta)) as totaldias
    from personal join turnos_emple on personal.codemp = turnos_emple.codemp
    where personal.codemp = codEmp1 and turnos_emple.codemp = codEmp2;
    
end $$
delimiter ;


-- call examen_recu_p3 (4,5)

/*
***********************EJERCICIO 4********************************************

*/    

create view ejer4
(nombre, ape1,ape2, direccion, codigoPostal, codigo)
as
select personal.nomemp, personal.ape1emp, personal.ape2emp, personal.diremp, personal.codemp
from personal join socios on personal.codemp = socios.codsocio
where personal.codemp not in (select personal from socios)
union
select socios.nomsocio, socios.ape1socio, socios.ape2socio, socios.dirpostal, socios.codsocio
from socios join personal on socios.codsocio = personal.codemp
where socios.codsocio not in (select socios from personal);


/*
***********************EJERCICIO 5********************************************

*/ 



drop procedure if exists examen_recu_p5;
delimiter $$
create procedure examen_recu_p5
	(in codigoComanda int )

begin 
	select comandas.importe, turnos.descripcion 
    from comandas join turnos on comandas.codturno = turnos.codturno
    where comandas.codturno = codigoComanda;
    
end $$
delimiter ;

call examen_recu_p5(1);

/*
***********************EJERCICIO 6********************************************

*/ 

drop procedure if exists examen_recu_p6;
delimiter $$
create procedure examen_recu_p6
	(in año date, out totalComandas int,  out importeTotal decimal )

begin 
	select count(comandas.codcomanda), count(comandas.importe)
    from comandas
    group by comandas.codcomanda
    having year(fechacomanda) = año;
    
end $$
delimiter ;

-- call examen_recu_p6(2020);
