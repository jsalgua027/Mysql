/*
Busca en la plataforma el recurso “Datos para BDMuseo” y descárgalo. Se trata de una hoja de
cálculo con datos para insertar en nuestra base de datos del museo.
10 Inserta los datos del archivo anterior en la base de datos del museo que hiciste en el ejercicio 5
de la Unidad 5.
11 Hoy hemos contratado a una nueva empleada de seguridad para sustituir al empleado 1 que
también se jubila hoy. Sus datos son: Carmen Gómez Pérez, su núm. de la seg. social es
“0000000000001”.
*/
/* `codartista` int(11) NOT NULL DEFAULT '0',
  `nomartista` varchar(60) DEFAULT NULL,
  `biografia` text,
  `edad` tinyint(3) unsigned DEFAULT NULL,
  */
  insert into artistas
  (codartista,nomartista,biografia,edad)
  values
  (1,'Vicent van Goh'),
  (2, 'Eva Gonzales'),
  (3,'Rafael Mengs'),
  (4,'Pablo Ruiz Picaso'),
  (5,'Salvador Dalí'),
  (6,'Joan Miro');
  
/*  CREATE TABLE `empleados` (
  `codemple` int(11) NOT NULL DEFAULT '0',
  `nomemle` varchar(20) DEFAULT NULL,
  `ape1emple` varchar(20) DEFAULT NULL,
  `ape2emple` varchar(20) DEFAULT NULL,
  `fecincorp` date DEFAULT NULL,
  `numsegsoc` char(15) DEFAULT NULL,
  PRIMARY KEY (`codemple`)
  */
  insert into empleados
  (numem,nomemle,ape1emle,ape2emle,fecincorp,numsegsoc)
  values
  (110,'PEPA','PEREZ',null,null,null),
  (120,'JUAN ','LOPEZ',null,null,null),
  (130,'ANA','GARCIA',null,null,null),
  (150,'JULIA','VARGAS',null,null,null),
  (160,'PEPA','CANALES',null,null,null),
  (180,'JUANA','PEREZ','PEREZ',null,null),
  (190,'LUISA','GOMEZ',null,null),
  (210,'CESAR ','PONS',null,null,null),
  (240,'MARIO','LASA',null,null,null),
  (250,'LUCIANO','TEROL',null,null,null),
  (260,'JULIO','PEREZ',null,null,null),
  (270,'AUREO','AGUIRREZ',null,null,null),
  (280,'MARCOS','PEREZ',null,null,null),
  (285,'JULIANA','VEIGA',null,null,null),
  (290,'PILAR','GALVEZ',null,null,null),
  (310,'LAVINIA','SANZ',null,null,null),
  (320,'ADRIANA','ALBA',null,null,null),
  (330,'ANTONIO','LOPEZ',null,null,null),
  (350,'OCTAVIO','GARCIA',null,null,null),
  (360,'DOROTEA','FLOR',null,null,null),
  (370,'OTILIA','POLO',null,null,null),
  (380,'GLORIA','GUIL',null,null,null),
  (390,'AUGUSTO','GARCIA',null,null,null),
  (400,'CORNELIO','SANZ',null,null,null),
  (410,'DORINDA','LARA',null,null,null),
  (420	,'FABIOLA','RUIZ',null,null,null),
  (430,'MICAELA','MARTIN',null,null,null),
  (440,	'CARMEN','MORAN',null,null,null),
  (450,'LUCRECIA','LARA',null,null,null),
  (480,	'AZUCENA','MUÑOZ',null,null,null),
  (490,'CLAUDIA','FIERRO',null,null,null),
  (500,'VALERIANA','MORA',null,null,null),
  (510,'LIVIA','DURAN',null,null,null),
  (550,'DIANA','PINO',null,null,null),
  (560,'HONORIA','TORRES',null,null,null),
  (570,'MARÍA','VALLE','DEL RÍO',l,null,null),
  (110,'PEPA','PEREZ',null,null,null),
  (580,'JAVIER','LÓPEZ','CAMPOS',null,null);
  
  /*CREATE TABLE `estilos` (
  `codestilo` int(11) NOT NULL DEFAULT '0',
  `nomestilo` varchar(20) DEFAULT NULL,
  `desestilo` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`codestilo`)
  */
  insert into estilos
  (codestilo,nomestilo,deestilo)
  values
( 1,'ABSTRACTO',null),
(2,'REALISMO',null),
(3,'SURREALISMO',null),
(4,'IMPRESIONISMO',null),
(5,'BARROCO',null),
(6,'POP',null),
(7,'EXPRESIONISMO',null),
(8,'DETALLISMO',null),
(9,'NEOCLASICISMO',null);

/*CREATE TABLE `obras` (
  `codobra` int(11) NOT NULL DEFAULT '0',
  `nomobra` varchar(20) DEFAULT NULL,
  `desobra` varchar(100) DEFAULT NULL,
  `feccreacion` date DEFAULT NULL,
  `fecadquisicion` date DEFAULT NULL,
  `valoracion` decimal(12,2) DEFAULT NULL,
  `codestilo` int(11) DEFAULT NULL,
  `codtipobra` int(11) DEFAULT NULL,
  `codubicacion` int(11) DEFAULT NULL,
  `codartista` int(11) DEFAULT NULL,
  PRIMARY KEY (`codobra`),
  */
  
  insert into obras
  (codobra,nomobra,desobra,feccreacion,fecadquisicion,valoracion,codestilo,codtipobra,codubicacion,codartista)
  values
  
 ( 1,'LA MASÍA',null,null,null,700000,8,1,1,6),
(2,	'CABEZA DE FUMADOR',null,null,null,400000,3,1,1,6),
(3,'LA PERSISTENCIA DE LA MEMORIA',null,null,null,0,3,1,2,5),
(4,'TRITÓN ALADO',null,null,null,0,3,2,3,5),
(5,'ANGEL SURREALISTA',null,null,null,0,3,2,3,5),
(6,'LA SOMBRERERA',null,null,null,0,4,1,2,2),
(7,'GRANJA EN REBAIS',null,null,null,0,4,1,1,2),
(8,'TE POR LA TARDE',null,null,null,0,4,1,5,2),
(9,'EL TRIUNFO DE LA AURORA',null,null,null,0,9,1,4,3);


  
  /*
  CREATE TABLE `restauradores` (
  `codrestaurador` int(11) NOT NULL DEFAULT '0',
  `codemple` int(11) DEFAULT NULL,
  `especialidad` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`codrestaurador`),
  */
  insert into restauradores
  (codrestaurador,codemple,especialidad)
  values
  (1,570,'Salvador Dalí'),
  (2,580,'Expresionistas');
  
  /*
  CREATE TABLE `salas` (
  `codsala` int(11) NOT NULL DEFAULT '0',
  `nomsala` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codsala`)
  */
  insert into salas
  (codsala,nomsala)
  values
  (1,'primera sala'),
(2,'segunda sala'),
(3,'tercera sala'),
(4,'cuarta sala'),
(5,'quinta sala'),
(6,'almacén 1'),
(7,'almacén 2'),
(8,'despacho restauración 1'),
(9,'despacho restauración 2');

/*
CREATE TABLE `seguridad` (
  `codsegur` int(11) NOT NULL DEFAULT '0',
  `codemple` int(11) DEFAULT NULL,
  `codsala` int(11) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`codsegur`),
  */
  insert into seguridad
  (codsegur,codemple,codsala,observaciones)
  values
  (1,110,1,null),
(2,120,1,null),
(3,130,2,null),
(4,150,1,null),
(5,160,3,null),
(6,180,4,null),
(7,190,5,null),
(8,210,6,null),
(9,240,6,null),
(10,250,5,null),
(11,260,6,null),
(12,270,7,null),
(13,280,5,null),
(14,285,8,null),
(15,290,9,null),
(16,310,2,null),
(17,320,2,null),
(18,330,4,null),
(19,350,5,null),
(20,360,7,null),
(21,370,7,null),
(22,380,8,null),
(23,390,8,null),
(24,400,8,null),
(25,410,9,null),
(26,420,9,null),
(27,430,7,null),
(28,440,8,null),
(29,450,1,null),
(30,480,2,null),
(31,490,3,null),
(32,500,3,null),
(33,510,4,null),
(34,550,4,null),
(35,560,5,null);

/*
CREATE TABLE `tipobras` (
  `codtipobra` int(11) NOT NULL DEFAULT '0',
  `destipobra` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codtipobra`)
  */
  
insert into tipobras
(codtipobra,destipobra)
values  
  
  (1,'PINTURA'),
  (2,'ESCULTURA');  
  
  
 /*
 Ejercicio 11.Hoy hemos contratado a una nueva empleada de seguridad para sustituir al empleado 1 que
también se jubila hoy. Sus datos son: Carmen Gómez Pérez, su núm. de la seg. social es
“0000000000001”.
*/
Start transaction;
insert into empleados

 (codemple,nomemle,ape1emle,ape2emle,fecincorp,numsegsoc)
  values
  (581,'Carmen','Gómez','Pérez','2022-02-06','0000000000001');
  
  insert into seguridad
  (codsegur,codemple,codsala,observaciones)
  values
  (36,581,1,null);
  
  delete from empleados
  where codemple=110 or nomemle='PEPA' or ape1emle='PEREZ' ;
  
  delete from seguridad
  where codsegur=1 or codemple=110 or codsala=1;
  
  commit;
  
  /*
   Ejercicio 12 Añade un campo “jubilacion” en la tabla de los empleados. Se trata de la fecha de jubilación de
nuestros empleados, debe permitirse que tenga valores nulos, ya que solo se almacenará dicha
fecha cuando un empleado se jubile.
*/
alter table empleados 
add column jubilacion date default null after fecincorp;

/*
Ejercicio 13 Hace una semana se jubiló el empleado 5, se trata de un restaurador. Las obras que tenía
encargadas se le han asignado al restaurador 2 y se entiende que la fecha de fin de restauración
para nuestro jubilado es la misma que la de jubilación. Por razones que se desconocen no se ha
guardado la información referente a dicha jubilación, subsánalo.

CREATE TABLE `restauraciones` (
  `codrestaurador` int(11) NOT NULL DEFAULT '0',
  `codobra` int(11) NOT NULL DEFAULT '0',
  `fecinirestauracion` date NOT NULL DEFAULT '0000-00-00',
  `fecfinrestauracion` date DEFAULT NULL,
  `observaciones` text,
  PRIMARY KEY (`codrestaurador`,`codobra`,`fecinirestauracion`),




*/
 Start transaction;
 update empleados
 set jubilacion =2022-03-01
 where codemple =5;
 -- EL EJERCICIO 13 ESTA MAL
 update restauraciones
 set fechafinrestauracion=2022-03-01
 where codrestaurador=5;
 commit;
 
/*
14 Nuestro museo ha adquirido “El Guernica” de Picasso y lo hemos situado en la sala 3.
*/
insert into obras
  (codobra,nomobra,desobra,feccreacion,fecadquisicion,valoracion,codestilo,codtipobra,codubicacion,codartista)
  values
  (10,'El Gernica',null,curdate(),null,null,7,1,103,4);
  
  /*
  15 Ha habido un error, no hemos adquirido el cuadro del apartado anterior.
  */
 
  delete from obras
  
  
  
  
  
  
  
  
  
  