create unique index dniempleado
	on empleados (dniem);
    
    
    create index buscanombre
		on empleados (ape1em, ape2em, nomem)