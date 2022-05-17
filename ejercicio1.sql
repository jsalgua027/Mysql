-- CENTROS (pk (numcentro),nomcentro,direccion)
-- DEPARTAMENTOS ( pk ( num centro*, numdepto),presupuesto,nomdepto, [centrotodepen, deptodepen]*)
-- EMPLEADOS (pk(numempleado),extelefon,fecnacim,fecingreso,salario,comision,numhijos,nomemp,[num centro, numdepto]*
-- dirigir (pk (numempleado*,[numcentro,numdepartamento]*, feinidir), fechadindir)


create	database ejercicio1;
use ejercicio1;

-- creo las tablas
create table centros(

	numcentro int not null,
    nomcentro varchar(60) not null,
    dirce	varchar(120) not null,
    
    constraint pk_centros primary key (numcentro)


);

create table departamentos(
	numdepto int ,
    numcentro int,	
    presupuesto decimal (10.2),
    nomdepto varchar(60) not null,
   
    
	constraint pk_departamentos primary key( numdepto, numcentro),
    constraint fk_departamentos_centros foreign key (numcentro)


);
create table empleados(

	numempleado int,
    





);