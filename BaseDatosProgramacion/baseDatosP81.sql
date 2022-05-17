create database  if not exists baseDatosP81;

use baseDatosP81;


drop table if exists alumnos;
create table alumnos 
(
numexped int (4),
nomalum varchar(60),
ape1alum varchar(60),
direccion varchar(100),
	constraint pk_alumnos
		primary key (numexped)

);
insert into alumnos 
 (numexped, nomalum, ape1alum, direccion)
 values
 (4456,'nacho','salcedo','calle del cielo'),
 (4457,'antono','perez','calle del mar'),
 (4458,'pepe','sanchez','calle del agua'),
 (4459,'juan','lucas','calle del loco'),
 (4460,'alvaro','hernandez','calle colon');
 
 










