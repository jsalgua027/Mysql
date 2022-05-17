-- obtener el numero de alumnos matriculados en cada materia y la nota media  de la materia 
select count(alumnos.numexped), avg(materias.nommateria)
from alumnos join matriculas on alumnos.numexped= matriculas.numexped
group by materias.nommateria;

-- solucion 
select mariculas.nommateria, count(*) as numero_alumnos,
	avg(matriculas.nota) as nota_media
    from materias join matriculas on materias.codmateria = matriculas.codmateria
    group by materias.nommateria;
    
-- obtener el número de materias matriculdas de cada alumno 
select count(materias.codmaterias), alumnos.nomalum as nombre_alumno
from materias join matriculas on materias.codmateria = matriculas.codmateria
where matriculas.numexped = alumnos.numexped
group by alumnos.numexped;

-- solucion 

select concat_ws(' ', alumnos.nomalum, alumnos.ape1alum, alumnos.ape2alum), count(codmateria)
from alumnos join matriculas on alumnos.numexped = matriculas.numexped
group by concat_ws(' ', alumnos.nomalum, alumnos.ape1alum, alumnos.ape2alum);

/* obtener el número de alumnos matriculados en cada materia , la nota media de la materia
y el número de expediente de los alumnos*/

select mariculas.nommateria, count(*) as numero_alumnos, avg(matriculas.nota) as nota_media,
		alumnos.numexped as numero_expediente;
        

-- esta consulta no tiene sentido ====> da error   cuando agrupamos solo podemos obtener resultados para el grupo

/* obtener el número de alumnos matriculados en cada materia , la nota media de la materia
y el número de expediente de los alumnos con la nota mas alta en la materia

*/

select materias.nommateria, count(*) as numero_alumnos, avg(matriculas.nota) as nota_media,
		alumnos.numexped as numero_expediente
        from  materias join matriculas on materias.codmateria = matriculas.codmateria
         where matriculas.numexped = alumnos.numexped
         group by materias.codmateria
         having (select max(materias.codmateria)
					from materias join matriculas on materias.codmateria = matriculas.codmateria);
        
-- solucion javi

 select	 
 concat_ws(' - ', materias.nommateria, materias.cursomateria) as 'materia',
 ifnull(count(matriculas.numexped), 0) as 'Número de alumnos',
 round(avg(matriculas.nota),2) as 'Nota media',
 max(matriculas.nota) as 'Nota máxima',
 
 (select m.numexped
 from matriculas as m
 where m.nota = max(matriculas.nota) and m.codmateria = matriculas.codmateria) as 'numero expediente'
 
 from matriculas join materias on matriculas.codmateria = materias.codmateria
 group by matriculas.codmateria;
 
-- solución eva
select matriculas.codmateria, count(*) as número_alumnos, 
	avg(matriculas.nota) as nota_media,
	(select numexped
	 from matriculas as m
     where m.codmateria = matriculas.codmateria 
		and nota = (select max(nota)
					from matriculas as m2
                    where m2.codmateria = m.codmateria
                    )
	) as mejorAlum
from matriculas
group by codmateria;

/* numero de preguntas que tiene cada test */
 select	 count(numpreg) as preguntas
 from preguntas
 group by codtest;

-- solucion 
select tests.descrip, count(*) as numeroPreguntas
from tests join preguntas on tests.codtest = preguntas.codtest
group by tests.descrip;




/

/** obtener el número de tests que ha realizado el alumno 1 */

select alumnos.numexped, count(distinct respuestas.codtest)
from alumnos join respuestas on alumnos.numexped = respuestas.numexped
where respuestas.numexped = 1
group by alumnos.numexped;

select * 
from respuestas
where numexped = 1;

