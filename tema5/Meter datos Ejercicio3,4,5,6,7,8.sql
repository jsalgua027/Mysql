USE `empresaclase`;
/*CREATE TABLE `departamentos` (
  `numde` int(11) NOT NULL,
  `numce` int(11) NOT NULL,
  `presude` decimal(10,2) NOT NULL,
  `depende` int(11) DEFAULT NULL,
  `nomde` varchar(60) NOT NULL,*/
  -- OJO CON LAS TRANSACCIONES AQUI HAY ERROR -----------------
  -- EJERCICIO 3
insert into departamentos
(numde,numce,presude,depende,nomde)
values
(112,20,15000,null,'DIRECCION COMERCIAL');

/*
`numem` int(11) NOT NULL,
  `numde` int(11) DEFAULT NULL,
  `extelem` char(3) DEFAULT NULL,
  `fecnaem` date NOT NULL,
  `fecinem` date NOT NULL,
  `salarem` decimal(7,2) DEFAULT NULL,
  `comisem` decimal(7,2) DEFAULT NULL,
  `numhiem` tinyint(3) DEFAULT NULL,
  `nomem` varchar(20) DEFAULT NULL,
  `ape1em` varchar(20) DEFAULT NULL,
  `ape2em` varchar(20) DEFAULT NULL,
  `dniem` char(9) DEFAULT NULL,
  `userem` char(12) DEFAULT NULL,
  `passem` char(12) DEFAULT NULL,
  curdate()!!!!!!!!!!!!!!!!!!!!!!!!!!!!!LA FECHA DE HOY
  */

insert into empleados 
(numen,numde,extelem,fecnaem,feciem,salarem,comisem,numhiem,nomem,ape1em,ape2em,dniem,userem,passem)
value
(1001,112,930,'1967-12-06',curdate(),2000,150,2,'ROSA','DEL CAMPO','FLORIDO',null,null,null);

/*
CREATE TABLE `dirigir` (
  `numdepto` int(11) NOT NULL,
  `numempdirec` int(11) NOT NULL,
  `fecinidir` date NOT NULL,
  `fecfindir` date DEFAULT NULL,
  `tipodir` char(1) NOT NULL,
  */
  insert into dirigir
   (numdepto,numempdirec,feinidir,fecfindir,tipodir)
  values
 (112,1001,curdate(),'2023-02-06','p');
 
 -- Ejercicio 4 El departamento “Sector industrial” se ha trasladado al centro “Sede central”.
 update departamentos 
 set numcem =10
 where 
 numdepto =111;
 
/* Ejercicio 5 Hemos contratado a dos nuevos empleados que van a formar parte del nuevo departamento
“Publicidad”. Sus datos son “Pedro González Sánchez” y “Juan Torres Campos” nacidos el
“12/2/1972” y “25/9/1975” respectivamente, ambos van a ganar 1400 € y no tendrán comisión.
El primero tiene 1 hijo y el segundo no tiene hijos. Compartirán la extensión telefónica 940.
OJO CON EL CURDATE()
 */
 
 insert into empleados
 (numen,numde,extelem,fecnaem,feciem,salarem,comisem,numhiem,nomem,ape1em,ape2em,dniem.userem,passem)
 values
 (1002,131,940,'1972-2-12',curdate(),1400,null,1,'PEDRO','GONZALEZ','SANCHEZ',null,null,null),
 (1003,131,940,'1975-9-25',curdate(),1400,null,null,'JUAN','TORRES','CAMPOS',null,null,null);

-- Ejercicio 6 Se va a despedir a Juan Torres Campos por no superar el periodo de prueba.
delete from empleados
where numen=1003;



/*Ejecicio 7 “Dorinda Lara” ha cambiado de departamento, ahora pertenece al departamento
“Organización”, se ha incrementado su sueldo en un 10% y su nueva extensión telefónica es la
910.
(410,131,'910','1968-07-14','1988-10-13',735.00,NULL,1,'DORINDA','LARA',NULL,NULL,NULL,NULL),
 */
 
 update empleados
 set numdep= 120, 
	salarem= salarem*1.1, 
    extelem= 910
 where
 numem=410;
-- where nomen='Dorinda' and aoe1em='Lara';
/*
salarem=900
salarem >900
salarem <= 900
salarem <900
salarem <=900
salarem <>900
salarem >900 and numde =100 and es y
salarem >900 or numde=100 or es o 
---------siempre tiene prioridad el and al or
COMPARAR CON NULL SE USA IS....................fecinrestauracion is null
-- Ejercicio 8 Haz una copia de seguridad de la BD con la que estás trabajando. 
 /* en la ventana de schemas en la zona de Administratio
	se hace con Data Export
  */
  
 
 /*
  empleados del departamento 120 de la decada de los 70 actualiza el salario un 10%
*/
  update empleados
  set salarem=salarem*1.1
  where fecnamen>='1970*1/1' and fecnamen <= '1979/12/31' and numde=120;
  
  /*
  empleados del departamento 120  fuera de la decada de los 70 actualiza el salario un 10%
*/
update empleados
  set salarem=salarem*1.1
  where  (fecnaem<'1970/1/1' or fecnamen >'1979*1/1')  and numde=120;
  