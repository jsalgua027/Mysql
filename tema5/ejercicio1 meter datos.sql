use EJER_4_1;
insert into centros
(numce,nomce,dirce)
values 
(10, 'SEDE CENTRAL','C.ALCALA,820,MADRID' ),
(20, 'RELACION CON CLIENTE','C.ATOCHA,405,MADRID');

insert	into deptos
(numde,numce,nomde,presude)
values
(100,10,129000,null,'DIRECCION GENERAL'),
(110,20,100000,100,'DIRECC.COMERCIAL'),
(111,20,90000,110,'SECTOR INDUSTRIAL'),
(112,20,175000,110,'SECTOR SERVICIOS'),
(120,10,50000,100,'ORGANIZACION'),
(121,10,74000,120,'PERSONAL'),
(122,10,68000,120,'PROCESO DE DATOS'),
(130,10,85000,100,'FINANZAS');

insert into empleados
(numem,numde,numce,extelem,fecnaem,fecinem
,salarem,comisem,numhiem,nomem,ape1em,ape2em)
values
(110,121,10,350,1965-04-30,1985-03-15,1000,null,2,'PEPA','PEREZ',null),
(120,112,20,840,1970-09-10,1995-10-01,1200,null,3,'JUAN','LOPEZ',null),
(130,112,10,810,1958-03-30,1988-03-01,987,null,1,'ANA','GARCIA',null),
(150.121,10,340,1972-01-15,2001-01-15,856,null,0,'JULA','VARGAS',null),
(160,111,20,740,1969-03-18,2002-03-18,998,null,0,'PEPA','CANALES',null),
(180,110,10,505,1971-02-11,1998-02-11,1967,null,5,'JUANA','RODRIGUEZ','PEREZ'),
(190, 121,350, 1969-01-22,1997-01-22,1174,null, 0,'LUISA','GOMEZ',null),
(210,100,200,1964-20-24,1986-02-24,3000,NULL, 3, 'CESAR','PONS',null),
(240,111,760,1959-03-01,1987-03-01,2145,110,1,'MARIO','LASA',null),
(250,100,250,1954-07-12,1976-07-12,3123,110,2,'LUCIANO','TEROL',null);




