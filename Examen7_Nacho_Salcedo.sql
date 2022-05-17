use GBDgestionaTests;
drop procedure if exists examen7;
delimiter $$
create procedure examen7
   (in curso char(6))

begin

declare codigoMateria  int default 0;
declare nombreMateria varchar (60) default '';
declare nombreCurso varchar(6) default '';
declare numeroPregunta, codigoTest int default 0;
declare numeroDias int default 0;
declare mediapreguntas , mediaDias decimal(7,2) default 0.0;
declare primerTest, primeraMateria boolean default 1;
declare final bit default 0;

declare curCurso cursor for
	select materias.codmateria, materias.cursomateria, materias.nommateria, tests.codtest, preguntas.numpreg
		from materias join  tests on materias.codmateria = tests.codmateria
			join	preguntas on tests.codtest= preguntas.codtest
	
		order by cursomateria, tests.codtest;

declare continue handler for sqlstate '02000' set final= 1;

 drop table if exists listado;
 create temporary table listado
	(descripcion varchar(2000));
    
open cursorTests;
fetch from cursorTests into codigoMateria, nombreCurso, nombreMateria, codigoTest,numeroPregunta;

while final = 0 do
	begin
     if nombreMateria <> nommateria then
		begin 
			set nombreMateria = nommateria;
				if (primeraMateria = 1) then 
					set primeraMateria = 0;
				else 
					begin
						insert into listado
							(descripcion)
						values
                        (concat('LA MEDIA DE : 'nombreMateria, '   ',mediapreguntas,'    ' ,mediaDias ));
					set numeroTests =0;
                    end;
				end if;
                
                insert into listado
					(descripcion)
				values (concat('Materia: ' nombreMateria));
                insert into listado
					(descripcion)
				values (concat('Tests          Num.preguntas test            días desde la publicacion '));
					set	primerTest = 1;
                    end;
				end if;
				insert into listado
					(descripcion)
                    values
						(concat(codigoTest,'     ', numeroPregunta, '      ', numeroDias));
	
fetch from cursorTests into codigoMateria, nombreCurso, nombreMateria, codigoTest,numeroPregunta;
end;
end while;

drop table if exists listado;
END $$
DELIMITER ;
	
              -- dos versiones con la solución EVA
              
use GBDgestionaTests;
drop procedure if exists examU72021_2022_V1;
	
delimiter $$

create procedure examU72021_2022_V1
	(in curso char(6)
    )
begin

-- call examU72021_2022_V1('1eso');
declare finalcursor boolean default 0;
declare materia, materiaaux varchar(60) default '';
declare test, textaux varchar(30) default '';
declare cuentatests int default 0;
declare dias, sumadias int default 0;
declare pregunta, sumapreg int default 0;
declare primeraIter boolean default 1;

declare curTests cursor for
	select materias.nommateria, tests.descrip, datediff(curdate(), tests.fecpublic), count(preguntas.numpreg)-- datediff función para hacer de la diferencia entre varias cosas (cosa1,cosa2)
    from materias join tests on materias.codmateria = tests.codmateria
		join preguntas on tests.codtest = preguntas.codtest
 	where materias.cursomateria = '1eso' -- curso
	group by materias.nommateria, tests.descrip  , datediff(curdate(), tests.fecpublic)
    order by materias.nommateria, tests.descrip;

declare continue handler for sqlstate '02000'
	begin
		set finalcursor = 1;
	end;

drop table if exists listado;
create temporary table listado
	(filalistado varchar(1000));
insert into listado
values
	(concat('Materias del curso: ',  curso)),
	('----------------------------------------------------');
open curTests;
fetch curTests into materia, test, dias, pregunta;

while not finalcursor do
begin
	
    
	if materia <> materiaaux then
    begin
		if not primeraIter then
		begin
			insert into listado
			values
				('----------------------------------------------------'),
				(concat('Media de ', materiaaux, '               ', sumapreg/cuentatests,'              ', sumadias/cuentatests));
		end;
		else
			set primeraIter = 0;
		end if;
		insert into listado
		values
			(concat('materia: ', materia)),
			('test                  Núm preguntas test                  días desde la publicación'),
            ('----------------------------------------------------');
		set materiaaux = materia;
        set sumapreg = 0;
		set sumadias = 0;
		set cuentatests = 0;
    end;
    end if;
    insert into listado
	values
    (concat(test, '                   ', pregunta, '                  ', dias));
    set cuentatests = cuentatests + 1;
    set sumapreg = sumapreg + pregunta;
	set sumadias = sumadias + dias;
    
	fetch curTests into materia, test, dias, pregunta;
end;
end while;
CLOSE curTests;

insert into listado
values
	('----------------------------------------------------'),
	(concat('Media de ', materiaaux, '               ', sumapreg/cuentatests,'              ', sumadias/cuentatests));

select * from listado;

drop table if exists listado;

end $$
delimiter ;



/* VERSIÓN 2: */

use GBDgestionaTests;
drop procedure if exists examU72021_2022_V2;
	
delimiter $$

create procedure examU72021_2022_V2
	(in curso char(6)
    )
begin

-- call examU72021_2022_V2('1eso');
declare finalcursor boolean default false; -- el manejador de error la cambiará a true cuando se terminen las filas del cursor
declare materia, materiaaux varchar(60) default ''; -- variables para guardar la materia de la fila actual del cursor y saber cuando cambiamos de materia
declare test, testaux varchar(30) default ''; --  variables para guardar el test de la fila actual del cursor y saber cuando cambiamos de test (hay una fila por cada pregunta del test)
declare cuentatests int default 0; -- contador del núm. de tests por materia
declare cuentapreg int default 0; -- contador del núm. de preguntas por cada test
declare dias, diasaux, sumadias int default 0; --  variables para guardar los días desde publicación de la fila actual del cursor y para imprimir el anterior cuando cambiemos de test
												-- sumadias nos permitirá ir sumando los días desde publicación de los tests de la misma materia para calcular la media
declare pregunta int default 0; -- almacenamos el número de pregunta de la fila actual del cursor (en realidad, no se necesita esta columna)
declare sumapreg int default 0; -- sumatorio del número de preguntas de cada test para cada materia (la usaremos para calcular la media de preguntas de la materia)
declare primeraIter boolean default true; -- control de primera iteración en bucle (nos permitirá controlar que no se impriman las medias de la materia anterior, puesto que no lo hay)

-- declaración del cursor
declare curTests cursor for
	select materias.nommateria, tests.descrip, datediff(curdate(), tests.fecpublic), preguntas.numpreg 
    from materias join tests on materias.codmateria = tests.codmateria
		join preguntas on tests.codtest = preguntas.codtest
 	where materias.cursomateria = '1eso' -- curso
    order by materias.nommateria, tests.descrip;

-- declaración del manejador de error (warning) de fin de cursor
declare continue handler for sqlstate '02000'
	begin
		set finalcursor = true;
	end;

-- tabla temporal donde iremos almacenando la información que se listará finalmente:
drop table if exists listado;
create temporary table listado
	(filalistado varchar(1000));

-- Almacenamos la cabecera: 
insert into listado
values
	(concat('Materias del curso: ',  curso)),
	('----------------------------------------------------');

-- Abrimos el cursor y nos posicionamos en la primera posición, almacenando sus valores en cada variable:
open curTests;
fetch curTests into materia, test, dias, pregunta;

-- mientras no hayamos llegado al final del cursor:
while not finalcursor do
begin
	-- Cuando cambiemos de materia:
	if materia <> materiaaux then
    begin
		-- siempre menos en la primera iteración, almacenaremos la información del el último test y las medias de la materia anterior:
		if not primeraIter then
		begin
			insert into listado
				values
					(concat(testaux, '                   ', cuentapreg, '                  ', diasaux));
			
			insert into listado
			values
				('----------------------------------------------------'),
				(concat('sumapreg: ', sumapreg, ' cuentatests: ', cuentatests, '  sumadias: ', sumadias)),
                (concat('Media de ', materiaaux, '               ', sumapreg/cuentatests,'              ', sumadias/cuentatests));
		end;
		else
			-- nos aseguramos que, a partir de ahora, ya no será primeraIter
			set primeraIter = false;
		end if;
        -- Siempre que cambiamos de materia, almacenamos los datos de la nueva materia y el resto de la cabecera de materia:
		insert into listado
		values
			(concat('materia: ', materia)),
			('test                  Núm preguntas test                  días desde la publicación'),
            ('----------------------------------------------------');
		-- inicializamos las variables: 
		set cuentapreg = 0;
        set materiaaux = materia;
		set testaux = test; -- evitamos que en la primera fila de un test de nueva materia se almacene la fila de ese test.
        set diasaux = dias;
        set sumapreg = 1; -- para contar la primera pregunta del primer test de cada materia
		set sumadias = dias; -- para contar los días del primer test de cada materia
		set cuentatests = 1; -- para contar el primer test de cada materia
    end;
    end if;
    -- al cambiar de test:
    -- 1. Almacenaremos los datos del test anterior (el último de cada materia se almacena al cambiar de materia)
    -- 2. Sumare
    if test <> testaux then
    begin
		insert into listado
		values
			(concat(testaux, '                   ', cuentapreg, '                  ', diasaux));
		set cuentatests = cuentatests + 1;
		set sumadias = sumadias + diasaux;
        set testaux= test;
        
        set diasaux = dias;
        set sumapreg = sumapreg + cuentapreg; -- sumamos las preguntas de cada test para hacer la media de la materia
        set cuentapreg = 0;
	end;
    end if;
	set cuentapreg = cuentapreg+1;
    

	fetch curTests into materia, test, dias, pregunta;
end;
end while;
CLOSE curTests;
insert into listado
values
	(concat(testaux, '                   ', cuentapreg, '                  ', diasaux));
insert into listado
values
	('----------------------------------------------------'),
    (concat('sumapreg: ', sumapreg, ' cuentatests: ', cuentatests, '  sumadias: ', sumadias)),
	(concat('Media de ', materiaaux, '               ', sumapreg/cuentatests,'              ', sumadias/cuentatests));

select * from listado;

drop table if exists listado;

end $$
delimiter ;


 




