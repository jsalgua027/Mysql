select * -- * selecionamos todos
from empleados
where fecinem >= '2001/1/1'
	and fecinem <= '2005/12/31'
    order by fecinem;
    
    select numem,nomem,ape1em,ape2em,fecinem
		from empleados
		where fecinem >= '2001/1/1'
			and fecinem <= '2005/12/31'
			order by fecinem; -- order by desc orden descendente
		-- order by ape1em , ape2em, nomem; ordenamos alfabeticamente
        
        select numem,nomem,ape1em,ape2em,fecinem
		from empleados
		where fecinem between '2000/1/1' and '2005/1/1' -- otra forma de comparar fechas !! se puede poner not between
			order by fecinem; -- order by desc orden descendente
		-- order by ape1em , ape2em, nomem; ordenamos alfabeticamente
        
        
         select numem as numero -- alias: para poner otro nonmbre en la cabecera de la columna a la hora de mostrar
		from empleados
        where fecinem
        order  by ape1em;
		
         select numem,nomem,ape1em,ape2em,fecinem, salarem, salarem + comisem,
         salarem*1.1, salarem<900 -- otro filtro de busqueda con resultado no modifica los datos, solo consulta
		from empleados
        order by ape1em;
        -- funcion concat()-----------
        select numem, nomem, ape1em, ape2em, fecinem, salarem, salarem + comisem,
         salarem*1.1, salarem<900 ,
        -- concat(nomem,'',ape1em,'',ape2em,'') as 'Nombre completo' concatena pero cuidado con los null
        concat(nomem,'',ape1em,'',ifnull(ape2em,'')) as 'Nombre completo',
        concat_ws('',nomem,ape1em,ape2em) as 'Nombre completo 2',-- separa cada dos campos por el simbolo que pones al principio y quita los nulos
        concat(ape1em,'',ifnull(ape2em,''),',',nomem) as 'Nombre completo 3',
        concat(ape1em,ifnull(contat('',ape2em),''),',',nomem) as 'Nombre completo 4'
		from empleados
        order by ape1em;
        -- segunda parte de la teoría Modos de trabajo en SQL.
        /* create procedure
			(lista de parametros)
         begin
			sentencias SQL
		end
        */
        -- Ejemplos----------funcion para mostra empleados
      --  drop procedure if exists muestraEmpleados;
        delimiter $$
          drop procedure if exists muestraEmpleados $$
        create procedure muestraEmpleados
        ( in depto int, in fecha date)      -- son in (de entrada por defecto)
        begin 
			select *
            from empleados
            where numde = depto
            and fecinem>= fecha;
            
		end $$
        delimiter ;
        
       -- call muestraEmpleados(100);-- me mostrara los empleados del departamento 100
        -- añdimos otro parametro, la llamada es de dos parametros
 
	call muestraEmpleados(121, '1990/1/1');
 