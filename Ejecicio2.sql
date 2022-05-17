/* departamentos( pk[numdepot], presupuesto, nomdepto, ubicacion)
profesores (pk[numprof], despacho, fecnacim, fecingreso, sueldo, nomprofe, numdepto*)
asignaturas(pk[numasigna], nomasiga, curso)
imparten (pk[numprof*, numasigna*], anio_cad, grupo)
*/
create database Ejercicio_2;
use	Ejercicio_2;

create table departamentos 
	(numdepto int,
	presupesto decimal (10,2) not null,
	nomdepto varchar(60) not null,
    ubicacion varchar(4) not null,
    constraint pk_departamentos primary key (numdepto)
		
    );

create table profesores
	(numprof int,
    despacho int,
    fecnaci date null,
    fecingreso date  not null,
    sueldo decimal (6,2),
    nomprofe varchar(60),
    numdepto int,
    numjefe int,
    constraint pk_profesores primary key (numprof),
    constraint fk_profesores_departamentos foreign key(numdepto)
		references departamentos (numdepto)
		on delete no action on update cascade,
	constraint fk_profesores_profesores foreign key (numjefe)
		references profesores (numprof)
        on delete no action  on update cascade
    );



create table imparten 
(numprof int,
numasigna int,
anio_cad date not null,
grupo varchar(60) not null,
constraint pk_imparten primary key (numprof, numasigna),
constraint fk_imparten_profesores  foreign key (numprof)
	references profesores(numprof)
    on delete no action on update cascade,

constraint fk_imparten_asignaturas foreign key (numasigna)
	references asignaturas (numasigna)
    on delete no action on update cascade
    

);

create table asignaturas
(numasigna int,
nomasigna varchar(60) not null,
curso int not null,
constraint pk_asignaturas primary key(numasigna)

);
