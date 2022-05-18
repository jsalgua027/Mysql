

create database if not exists BaseDprograma;
use BaseDprograma;
create table if not exists restaurante
	(
    codRest int (4),
    numTelRest varchar(60),
    direRest varchar(200),
    nomRest varchar(60),
    constraint pk_restaurante 
		primary key (codRest)
    );
    
create table if	not exists encargado
(
	 codRest int (4),
	codEncar int (4),
    nomEncar varchar(60),
    numTelEnca varchar(60),
    diasTraba int(10),
    constraint pk_encargado primary key (codEncar,codRest),
     constraint fk_restaurante_encargado foreign key (codRest)
		references restaurante (codRest) on delete no action on update cascade
    
);
create table if not exists clientes
(
	codRest int (4),
	codClien int (4),
    nomClien varchar(60),
    dirClien varchar(200),
    numTelClien varchar(60),
    numPedido int unsigned,
    constraint pk_clientes primary key (codClien, codRest),
    constraint fk_restaurante_clientes foreign key(codRest)
		references restaurante (codRest) on delete no action on update cascade


);

insert into  restaurante
	(codRest, numTelRest, direRest, nomRest)
    values
    (001, '952659874', 'calle del cielo', 'baliPoke');

-- select * from restaurante; 

insert into encargado
	(codRest,codEncar, nomEncar, numTelEnca, diasTraba)
    values
    (001,123, 'Juan perez', '60685989', 45);
    
   -- select * from encargado;
   insert into clientes 
	(codRest, codClien, nomClien, dirClien, numTelClien, numPedido)
    values
	 (001,312,'nacho salcedo', 'calle de los santos 3','65699865', 4564),
	 (001,313,'pepe sanchez', 'urb las mimosas 4', '85696541', 4565),
	 (001,314,'juan ortega','calle los melones 3', '6547832', 4566),
	 (001,315,'emilio reyes', 'avenida españa 7', '65693321', 4567),
	 (001,316,'perico palotes', 'calle el agua 3' ,'89674532', 4568),
	 (001,317,'kiko narvaez', 'urba casas del duque 4','15243985', 4569),
	 (01,318,'antonio lucas', 'avenida los reyes catolicos 5','58698745', 4570);
	
    select * from clientes;
          
          
          
    
    


