/* ejer 1*/
select concat(ape1cli, ifnull(concat(' ', ape2cli),''),', ', nomcli)
from clientes join proyectos on clientes.numcli = proyectos.numcli
where proyectos.aprobado = 0 and year(fecpresupuesto) = year(curdate())-1;

/* ejer 2. 
patrón de nombre usuaario:  
tener 6 o más caracteres, incluir algún número y empezar por una letra que se debe repetir 2 o 3 veces. 
*/
select *
from empleados
where  userem  not regexp '[0-9]' or userem not regexp '^[a-z]{2,3}' or length(userem)<6;


drop procedure if exists ExamU6G2_ejer3;
delimiter $$
create procedure ExamU6G2_ejer3
(
	in proyecto int,
    out empleados int,
    out colaboradores int
)
begin

/* call ExamU6G2_ejer3(1, @emple,@colabora);
select @emple,@colabora;
*/
/*
select count(*) into empleados
from tecnicosenproyectos
where tecnicosenproyectos.numproyecto = proyecto;

select count(*) into colaboradores
from colaboradoresenproyectos
where colaboradoresenproyectos.numproyecto = proyecto;*/
/* OTRA SOLUCIÓN: */
select  count(distinct tecnicosenproyectos.numtec), count(distinct colaboradoresenproyectos.numcol)
 	into empleados, colaboradores
from proyectos
    left join colaboradoresenproyectos on proyectos.numproyecto = colaboradoresenproyectos.numproyecto
    left join tecnicosenproyectos on proyectos.numproyecto = tecnicosenproyectos.numproyecto
where proyectos.numproyecto = proyecto;

end $$
delimiter ;

/* ejer 4 */
/*
Los datos que necesitamos son código, nombre, y apellidos (en columnas separadas) de los empleados que nunca 
han dirigido un proyecto o bien no están dirigiendo un proyecto en la actualidad.
*/
create view ejer4
(codigo, nombre, ape1,ape2)
as
-- los que nunca han  dirigido proyectos
select empleados.numem, nomem, ape1em, ape2em
from empleados join tecnicos on empleados.numem = tecnicos.numem
where tecnicos.numtec not in (select director from proyectos)
union
select empleados.numem, nomem, ape1em, ape2em
from empleados join tecnicos on empleados.numem = tecnicos.numem
where tecnicos.numtec not in (select director from proyectos where fecfinproy > curdate());
	
select * from ejer4;

/*
Prepara una función que, dado un número de técnico y un código de proyecto devuelva el número de 
semanas que ha trabajado dicho técnico en el proyecto.

*/

drop function if exists ExamU6G2_ejer5;
delimiter $$
create function ExamU6G2_ejer5(tecnico int, proyecto int)
returns int  -- returns como en los modos de java.
deterministic -- esto es obligatorio en la funcion (algo determinista es que sabemos el resultado que nos da )
begin

-- select ExamU6G2_ejer5(1,1);
return (select sum(datediff(fecfintrabajo, fecinitrabajo)/7) -- aqui esta el return 
		from tecnicosenproyectos
		where numproyecto= proyecto and numtec = tecnico
        );
end $$
delimiter ;

-- con procedimiento

drop procedure if exists PExamU6G2_ejer5;
delimiter $$
create procedure PExamU6G2_ejer5(in tecnico int, in proyecto int, out resultado int)

        
begin

-- call  PExamU6G2_ejer5(1,1 @resultado);
-- select @resultado
set resultado=  (select sum(datediff(fecfintrabajo, fecinitrabajo)/7)
		from tecnicosenproyectos
		where numproyecto= proyecto and numtec = tecnico
        );
end $$
delimiter ;




/*
Prepara un procedimiento que obtenga el número de proyectos presupuestados de cada actividad 
(descripción de la actividad) y el número de proyectos llevados a cabo (campo aprobado será 1). 
Además queremos que, si no se ha presupuestado ningún proyecto de una actividad, 
se muestre dicha actividad y tanto el número de proyectos presupuestados como llevados a cabo será 0.
*/

drop procedure if exists ExamU6G2_ejer6;
delimiter $$
create procedure ExamU6G2_ejer6()
begin

-- call ExamU6G2_ejer6();
select actividades.nomactividad, count(numproyecto), (select count(*) 
													  from proyectos as p 
                                                      where p.codactividad = actividades.codactividad
														and p.aprobado = 1)
from actividades left join proyectos on actividades.codactividad = proyectos.codactividad
group by actividades.nomactividad;
end $$
delimiter ;


/*
Cada proyecto tiene una fecha de inicio de proyecto (cuando comienza a desarrollarse), una duración 
prevista (en días) y una fecha de fin real de proyecto. 
Obtén un listado de proyectos que han terminado en el tiempo previsto. 
Queremos mostrar el número de proyecto, el director de proyecto (nombre y apellidos), el número de personal 
previsto (personal_prev), el número de técnicos y el número de colaboradores.
*/

select numproyecto, concat(ape1em, ifnull(concat(' ', ape2em),''),', ', nomem) as director,
	personal_prev,
    (select count(*) from tecnicosenproyectos where tecnicosenproyectos.numproyecto = proyectos.numproyecto) as tecnicos,
	(select count(*) from colaboradoresenproyectos where colaboradoresenproyectos.numproyecto = proyectos.numproyecto) as colaboradores
from proyectos join tecnicos on proyectos.director = tecnicos.numtec 
	join empleados on tecnicos.numem = empleados.numem
where fecfinproy >= date_add(feciniproy, interval duracionprevista day);

/*
 Cada proyecto tiene un número previsto de personas necesarias (personal_prev). 
 Obtén para cada proyecto que no haya superado en su ejecución al personal previsto 
 (es decir, el número de técnicos y de colaboradores que han trabajado en el mismo no supera al número previsto) 
 el número de técnicos y de colaboradores
*/

select numproyecto, personal_prev, (select count(*) from tecnicosenproyectos where numproyecto = proyectos.numproyecto) as tecnicos,
	(select count(*) from colaboradoresenproyectos where numproyecto = proyectos.numproyecto) as colaboradores
from proyectos
where personal_prev >= ((select count(*) from tecnicosenproyectos where numproyecto = proyectos.numproyecto)
						+
						(select count(*) from colaboradoresenproyectos where numproyecto = proyectos.numproyecto));
						
/*** otra solución: */
select  proyectos.numproyecto, personal_prev, count(colaboradoresenproyectos.numcol), count(tecnicosenproyectos.numtec)
from proyectos
    left join colaboradoresenproyectos on proyectos.numproyecto = colaboradoresenproyectos.numproyecto
    left join tecnicosenproyectos on proyectos.numproyecto = tecnicosenproyectos.numproyecto
group by proyectos.numproyecto
having count(colaboradoresenproyectos.numcol) + count(tecnicosenproyectos.numtec) <= personal_prev;