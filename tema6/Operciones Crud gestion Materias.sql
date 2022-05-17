use gbdgestionatests;
delimiter $$

create procedure buscarMaterias() 
begin 
	select materias.codmateria as 'Cod.Materia',
			materias.nommateria as 'Nombre'
		
	from materias
    order by materias.nommateria;

end $$
delimiter ;

call buscarMaterias();
			
set @nuevamateria = (select max (codmateria)+1 from materias);
insert into materias
		(codmateria,nommateria,cursomateria)
values
	(@nuevamateria, materia.getcodmateria, materia.getnomateria, materia.getcursomateria);


delimiter $$
drop procedure if exists insertarMaterias $$
create procedure insertarMaterias 
		(in materia varchar(60),
		 in cursomateria char(6),
         out resultado int
         )
begin 
		declare nuevamateria varchar(60);
        
		start transaction;
        
        set nuevamateria = (select max(codmateria)+1 from materias);
        
        insert into materias 
			(codmateria,nommateria,cursomateria)
            values
				(nuevamateria,
					materia,
                    cursomateria);
		commit;
        
        set resultado = nuevamateria;

end $$
delimiter ;

call nuevamateria ('filosofia','1BACH',@result);

select @result;
 
-- consulta de materias
select codmateria, nommateria, cursomateria

	from materias
	where codmateria =38;
    
    
    delimiter $$
    drop procedure if exists buscarunaMateria$$
    create procedure buscarunaMateria
			(in codigo int
            )
	begin
		select codmateria as codigo, nommateria as materia, cursomateria as cursomateria
		from materias
        
        where codmateria = codigo;
        
	end$$
    delimiter ;
	
  -- falta la llamada que no reconoce porqque me da error   call bus
  
  -- editar materias
  -- 1 update
  
  delimiter $$
  drop procedure if	exists ActualizarMateria $$
  create procedure ActualizarMateria
		(in codigo int,
         in nombre varchar(60),
         in curso char(6)
         )
begin
	update materias
    set 
		
        nommateria = nombre,
        cursomateria = curso
        
	where codmateria = codigo;
end$$
delimiter ;
        
   /*aqui iria la llamada al metodo y probarlos      
		
  */
  
  -- delete  
  delimiter $$
  drop procedure if exists	borrarMateria $$
  create	procedure borrarMateria
		(in codigo int)
  begin
		delete from materias
		where codmateria = codigo;
  end$$
  delimiter ;

    
    
    
    -- ahora se hace la llamada al metodo 
    