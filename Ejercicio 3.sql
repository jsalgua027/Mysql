/* categorias ( pk[numcat], nomcategor, proveedor)
productos (pk[refprod,numcat*],descrip, precio, codcat, fecingreso, salario, comision, numhijos, nomemp,)
ventas (pk[codventa], fecventa, cliente)
lin_venta (pk[codventa*,[refprod,nomcat]*,cantidad)
*/

create database ejercicio_3;
use Ejercicio_3;

create table categorias
	(numcat int,
    nomcategor varchar(60) not null,
    proveedor  int not null,
	constraint pk_categorias primary key  (numcat)
    
    
    );
    
create table productos
	(
    refprod int ,
    numcat int  not null,
    descrip varchar(200) not null,
    precio decimal(6,2) not null,
    codcat int not null,
    fecingreso date not null,
    salario decimal (7,2) not null,
    comision decimal (6,2),
    numhijos tinyint unsigned,
    n
    
    
    );