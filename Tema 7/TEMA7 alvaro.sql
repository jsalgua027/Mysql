/*
************************* TEMA 7 *************************
*/




/*
	IF ELSEIF ENDIF
*/
 
/*----------------------- R1.6 -----------------------
Crea una función que devuelva 1 ó 0 en función de si un número es o no divisible por otro.
*/
delimiter $$
create function r1_6 (dividendo int, divisor int)
	returns boolean
	begin
		declare res boolean;	-- crea la variable res que será la salida booleana
			if mod(dividendo,divisor) = 0 then	-- if else
				set res = 1;
			else
				set res = 0;
			end if;
            
			return res;
	end$$
    
delimiter ;



/*----------------------- R1.8 -----------------------
Crea una función que devuelva el mayor de tres números que pasamos como parámetros.
*/
delimiter $$
create function r1_8 (num1 int, num2 int, num3 int)
	returns boolean
	begin
		declare numax boolean;
	
    if num1 > num2 then -- primero lo hace del primero y el segundo
    begin
        if num1 > num3 then	-- si es mayor que el 2 pasa al 3 y lo compara
			begin
				set numax = num1;	-- si es true mete el 1 en la variable
			end;
        else
			begin
				set numax = num3;	-- si es false lo mete en el 3
			end;
        end if;		-- cierra el if de la comparacion 1 y 3
    end;
    else
    begin
        if num2 > num3 then	-- comienza if del 2 y 3
			begin
				set numax = num2;	-- si es true mete el 2 en la variable
			end;
        else
			begin
				set numax = num3;	-- si es false mete el 3 en la variable
			end;
        end if;	-- cierra el if del 2 y 3
    end;
    end if;	-- cierra el if principal que comparaba el 1 y el 2

    return max;	-- devuelve la variable
	end$$
    
delimiter ;




/* ----------------------- R1.11 -----------------------
Prepara un procedimiento que muestre la suma de los términos 1/n con n entre 1 y m (1/2 + 1/3 + ¼ +…), 
siendo m un parámetro de entrada.
*/
delimiter $$
create procedure  r1_11 (in m int)
	begin
    
		declare cont, suma decimal (10,2);	-- declara dos variables que vamos a utilizar
        
		if m=0 then	-- si m es 0
			select 'división por cero';	-- muestra por pantalla esto
		else if m = 1 then	-- si m es 1
			select 1;	-- muestra esto por pantalla
		else
			begin
				set cont = 2;	-- inicializa el contador a 2
			   
				set suma = 0;	-- y la suma a 0
				
				while cont <= m do	-- crea un bucle (mientras contador sea <= a m )
					begin
						set suma = suma + 1/cont;	-- hace estas movidas
						set cont = cont + 1;
					end;
				end while;
				select suma;	-- muestra la variable suma
			end;
		end if;	-- dos cierres de los dos if 
		end if;
		
	end$$
    
delimiter ;


















/*
	CASE
  (switch)
*/
-- FORMATO A
SELECT numem, nomem, ape1em, ifnull(ape2em,''), -- leemos cuatro columnas de la tabla
	CASE numhiem	-- dependiendo el numero de cada campo escogerá uno u otro
		WHEN 0 THEN 'Cero hijos'
		WHEN 1 THEN 'Un hijo'
		WHEN 2 THEN 'Dos hijos'
		WHEN 4 THEN 'Cuatro hijos'
		WHEN 5 THEN 'Cinco hijos'
		ELSE 'Mas de cinco hijos'
	END as NUM_HIJOS,
 	salarem, comisem -- leemos otras dos columnas de la tabla 
FROM empleados;

-- FORMATO B
SELECT numem, nomem, ape1em, ape2em,	-- es igual pero
	CASE
		WHEN numhiem= 0 THEN 'Cero hijos'	-- se va "filtrando" en cada WHEN
		WHEN  numhiem <= 3 THEN 'Entre 1 y 3 hijos'
		ELSE 'Mas de tres hijos'
	END AS NUM_HIJOS,
	 salarem, comisem
FROM empleados;



















/*
	REPEAT
	WHILE
*/
-- repeat
REPEAT
	BEGIN
		UPDATE productos
		SET precio_unidad = precio_unidad*2
	END
UNTIL (SELECT avg(precio_unidad) FROM productos) >=100
END REPEAT;


-- while
WHILE (SELECT avg(precio_unidad) FROM productos) <100 DO
	BEGIN
		UPDATE productos
		SET precio_unidad = precio_unidad*2
	END
END WHILE;



-- EJERCICIOS

/* ----------------------- R1.12 -----------------------
Crea una función que determine si un número es primo o no (devolverá 0 ó 1).
*/

drop function if exists es_primo;
delimiter $$
-- create function GBD_2012_2013_U6_EJER1_12(n int)
create function es_primo(n int)
returns boolean
begin
    declare cont int;
   declare es_primo bit default 1;
    set cont = 2;
       
    while (cont < n) do
    begin
	if (n%cont = 0) then
        begin
           set es_primo = 0;
           set cont = n;
        end;
        else
        	set cont = cont + 1;
        end if;
    end;
    end while;
    
    return es_primo;
end
$$
delimiter ;
-- select es_primo(2), es_primo(10), es_primo(7);

/* ----------------------- R1.13 -----------------------
Crea una función que calcule la suma de los primeros m números primos empezando por el 1. 
Utiliza la función del apartado anterior.
*/
drop function if exists GBD_2012_2013_U6_EJER1_13;
delimiter $$
create function GBD_2012_2013_U6_EJER1_13(n int)
returns int
begin
    declare cont, suma int;
    declare num_primos  int default 1;
    
    set cont = 1;
    set suma = 0;
    
    while (num_primos <= n) do
    begin
        if (es_primo (cont)) then
        begin
            set suma = suma + cont;
            set num_primos = num_primos + 1;
        end;
        end if;
       set cont = cont + 1;
    end;
    end while;

    return suma;
end
$$
delimiter ;


/* ----------------------- R1.14 -----------------------
Crea un procedimiento que almacene en una tabla (primos (id, numero)) 
los primeros números primos comprendidos entre 1 y m (m es parámetro de entrada).
*/
drop procedure if exists GBD_2012_2013_U6_EJER1_14;
delimiter $$
create procedure GBD_2012_2013_U6_EJER1_14(n int)
begin
    declare cont int;
    declare numid int;
    declare num_primos int default 0;
    
    drop table if exists primos;
    create temporary table if not exists primos
        (id int auto_increment primary key,
        primo int);

    set cont = 1;

    while (num_primos< n) do
    begin
        if es_primo (cont) then
            -- set numid = (select ifnull(max(id),0)+1 from primos);
            insert primos
                (primo)
            values
                (cont);
            set num_primos = num_primos + 1;
        end if;
        set cont = cont + 1;
    end;
    
    end while;
    select * from primos;
end
$$
delimiter ;


/* ----------------------- R1.15 -----------------------
Modifica el procedimiento anterior para que se almacene en un parámetro de 
salida el número de primos almacenados.
*/
delimiter $$
create procedure GBD_2012_2013_U6_EJER1_15(n int, out n_primos int)
begin
    declare cont int;
    
    set cont = 1;
    delete
    from primos;
    while (cont <= n) do
    begin
        if (es_primo (cont)) then
            insert primos
                (id, primo)
            values
                ((select ifnull(max(id),0)+1 from primos), cont);
        end if;
        set cont = cont + 1;
    end;
    end while;
    select n_primos = ifnull(count(*),0)
    from primos;
end
$$
delimiter ;


















/*
	MANEJADORES
*/

/* 
	ejercicio de intento
 Crea la tabla de control de errores en la base de datos empresa. Averigua cual es el código de error 
 para la restricción de integridad referencial (no existe el valor de clave foránea donde es clave primaria). 
 Prepara un procedimiento almacenado que inserte un empleado nuevo, incluye el manejador de error para 
 clave primaria repetida del ejercicio anterior y añade un manejador de error de restricción de 
 integridad referencial con la tabla departamentos).
*/

DELIMITER $$
CREATE PROCEDURE inserta_empleado (cod_emp INT, nombre VARCHAR(100))
MODIFIES SQL DATA
	BEGIN
		DECLARE EXIT HANDLER FOR SQLSTATE '23000'
		BEGIN
			insert 
	END;
	INSERT INTO empleados (cod_emp, nombre);
	
END$$
DELIMITER ;


















/*
	CURSORES
*/
/*
 sacar un listado en el que coy a tener el centro de trabajo y abajo 
 una lista con los departamentos que hay en ese centro
*/
-- se deben usar rutinas
delimiter $$		-- trabajaremos con departamento y empleados
create procedure pruebaCursor()			-- lo importante es el select
	begin
    
		declare curDeptos cursor for
					select numde, nomde, presude, nomce
					from departamentos join centros on departamentos.numce = centros.numce
                    order by nomce;		-- nomce será el que nos indique si "saltamos a otra tabla"
        declare numdepto int DEFAULT 0;		-- declaramos variables que guardaran cada campo de la tabla del select
        declare nomdepto, nomcentro, nomcentroaux varchar(100) default ''; -- nomcentroaux auxiliar para la cabecera y el pie
        declare presupuesto deciaml(12,2) default 0.00;
        
        declare fin_cursor boolean default 0;
        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'	-- al producirse el warning de que ya no hay mas filas se ejecuta el codigo, que hace que se cierre
        
			-- BEGIN
				set fin_cursor = 1;	-- al ser solo una linea no necesita begin y end
            -- END ;
            
            
            
	create temporary table  listado	-- creamos la tabla donde se guardará
		(filalistado varchar(500));
        
	OPEN curdeptos;
    FETCH curDeptos INTO numdepto, nomdepto, presupuesto, nomce
    
		WHILE fin_cursor = 0 do
			BEGIN -- aqui se mete todo el codigo que quieras hacer 
				
                if nomcentro <> nomcentroaux then
					begin
						insert into listado 
						values
						(concat('centro de trabajo: '), nomcentro);
						
						insert into listado 
						values
						('num.deptodepto		nombre		presupuesto');
                        
                        set nomcentroaux = nomcentro;
                    end;
				end if;
                    
				/*
				insert into listado 
                values
                (concat('centro de trabajo: '), nomcentro);
                
                insert into listado 
                values
                ('num.deptodepto		nombre		presupuesto');
                */
                insert into listado 
                values
                (concat(numdepto,'		' nomdepto,'		' presupuesto);
				            
				FETCH curDeptos INTO numdepto, nomdepto, presupuesto, nomce -- para seguir bajando
            END;
		END WHILE;
    
    CLOSE curDeptos;
    select * from listado;
    drop table listado;
    
    end $$
delimiter ;






