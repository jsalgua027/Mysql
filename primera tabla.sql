create database probando;
use probando;
/* para escribir comentario
-- para comentar

*/
-- creo la tabla
create table tabla1 
(
	codt1 int not null, 
    dest1 varchar(20) not null default 'descripcion de campo', -- char es hasta un numero fijo de caracteres
																-- y varchar es cuando puede ser de longitud variable
    constraint pk_tabla1 primary key (codt1) 
																-- constraint es una restriccion, pk clave primaria
);

create table tabla2
(
	codt2 int not null,
    dest2 varchar(20) not null default 'descripcion de campo',
    codt1 int null,
    constraint pk_tabla2 primary key (codt2),
													-- definicion clave foranea
    constraint fk_tabla2_tabla1 foreign key (codt1) references tabla1 (codt1)
													-- restricciones
		on delete no action  on update cascade  
													-- no action para no poder eliminar un registro que afecte a la otra tabla
													-- cascade para que si eliminas una se elimina la otra
													-- set null si elemina un resgistro en la otra tabla la pasa a null



);

create table table3
(
	codt1 int not null,
    codt2 int not null,
    fechaRel2 date,
    constraint pk_tabla3 primary key (codt1, codt2),
    constraint fk_tabla3_tabla1 foreign key (codt1) references tabla1 (codt1)
		on delete no action on update cascade,
	constraint fk_tabla3_tabla2 foreign key (codt2) references tabla2 (codt2)
		on 	delete no action on update cascade
        




);