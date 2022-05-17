/* Ejercicio P1 */
insert into reservas
	(codreserva, codcliente, codcasa,fecreserva, pagocuenta, 
	feciniestancia,numdiasestancia, fecanulacion)
values
(3501,520, 315, '2020-02-07',100, '2020/8/5', 7, null);
-- (3501,1, 1, '2020-02-07',100, '2020/8/5', 7, null); (para hacer la prueba)
/* Ejercicio P2*/
/* lo haremos de una de las dos formas según nuestra interpretación: */
-- opción A
	insert into caracteristicasdecasa
	(codcasa, codcaracteristica, tiene)
	values
	(350,17,1),
	(350,3,1),
	(350,5,1);

-- opción B
	update caracteristicasdecasa
	set tiene = 1
	where codcasa = 350 and (codcaracteristica = 17 or 
		codcaracteristica = 3 or codcaracteristica = 5);

/* Ejercicio P3 */
Start transaction;
	update reservas
	set fecanulacion = '2022/02/07' -- curdate()
	where codreserva = 3501;  -- 2450;

	insert into devoluciones
		(numdevol, codreserva,importedevol) -- lista de campos separados por comas
	values
	(226,3501, 200.00);
commit;    
/* Ejercicio P4 */
start transaction;
	delete from caracteristicasdecasa
	where codcasa = 5640 or codcasa = 5641;

	delete from casas
	where codcasa = 5640 or codcasa = 5641;
	delete from propietarios
	where codpropietario = 520;
commit;
/* Ejercicio P5*/

update casas
set numhabit = 3,
	m2 = 200,
    minpersonas = 4,
    maxpersonas = 8
where codcasa = 5789;