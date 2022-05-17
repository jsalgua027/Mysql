/*Utilizando la base de datos BD Almacén realizar las siguientes actividades:
Preparar un procedimiento almacenado que utilizando cursores, obtenga un catálogo de productos con el siguiente formato:
    Productos de: Nombre y descripción de categoría
        Código        Descripción        Precio unidad        Existencias
        --------------------------------------------------------------------------------------------
        Codproducto    descripcion        preciounitariio        SI/NO
        ….
    Productos de: Nombre y descripción de categoría
        Código        Descripción        Precio unidad        Existencias
        --------------------------------------------------------------------------------------------
        Codproducto    descripcion        preciounitariio        SI/NO
        ….
        */
        
delimiter $$        
drop procedure if exists procediAlmacenado $$
create procedure procediAlmacenado()
begin
	declare codigo int default 0;
    declare nomcatego varchar (100) default '';
    declare descripcion varchar(500) default '';
    declare precioUnidad double (7,2) default 0.00;
    declare stockaux  int default 0;
    DECLARE fin_cursor BOOLEAN default 0;
    
    declare cursordeptos cursor for
						select codproducto, descripcion, preciounidad, Nomcategoria, stock
                        from productos join categorias on productos.codcategoria = categorias.codcategoria
                        order by productos.codcategoria;
	DECLARE continue HANDLER FOR SQLSTATE '02000'
		set fin_cursor = 1;
        
	drop table if exists listado;
    create temporary table listado
    (filalistado varchar(500));
    
    open cursordeptos;
    fetch cursordeptos into codigo, descripcion, preciounidad, nomcatego, stockaux;
    
    while fin_cursor= 0 do
	begin
    if productos.codproducto <> codigo then
		 begin
			insert into listado
	values
	(concat('Productos de=  ', Nomcategoria, descripcion)),
	('Código        Descripcion        Precio Unidad           Existencias ');
    set codigo = categorias.codcategoria;
    end;
    end if;
    
    insert into listado
    values 
    (concat( codproducto, '          ', descripcion, '           ', preciounidad, '             ', stock));
    
    fetch cursordeptos into codigo, descripcion, preciounidad, nomcatego, stockaux;
    end;
    end while;
    close cursordeptos;
    drop table listados;
    
    end $$
    delimiter ;
    
     
    
    call procediAlmacenado();
    
	
    -- solucion 1 de eva

drop procedure if exists EJER_7_3_1;
DELIMITER $$
CREATE PROCEDURE EJER_7_3_1()
BEGIN
-- call EJER_7_3_1();

DECLARE	nomcat, nomcataux varchar(30);
DECLARE descat varchar(100);
DECLARE codprod int;
DECLARE desprod varchar(50);
DECLARE precio decimal(12,2);
DECLARE existencias char(2);

DECLARE final bit default 0;
	
DECLARE curCatalogo CURSOR 
	FOR select categorias.Nomcategoria, categorias.descripcion, 
            productos.codproducto, productos.descripcion, productos.preciounidad,
            case
                when stock > 0 then 'SI'
                when stock = 0 then 'NO'
            END 
        from categorias join productos on productos.codcategoria = categorias.codcategoria
        order by categorias.Nomcategoria, productos.descripcion;

DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET final = 1;

drop table if exists listado;
create temporary table listado
    (descripcion varchar(100));
OPEN curCatalogo;
FETCH FROM curCatalogo INTO nomcat,descat,codprod, desprod,precio, existencias; -- siempre en el mismo orden que el select
SET nomcataux='';
WHILE final = 0 DO
BEGIN
	IF (nomcataux <> nomcat) THEN
	BEGIN
		INSERT INTO listado 
            -- (descripcion) 
        VALUES 
            (CONCAT('Productos de: ', nomcat, ' --- ', descat));
        INSERT INTO listado 
            -- (descripcion) 
        VALUES 
            (CONCAT('Ref. prod          Descripcion             Precio        Existencias'));
		SET nomcataux = nomcat;
	END;
    END IF;
    INSERT INTO listado 
            (descripcion) 
        VALUES 
            (CONCAT('  ',codprod, '            ', desprod, '            ', precio, '      ',
                existencias));
	FETCH FROM curCatalogo INTO nomcat,descat,codprod, desprod,precio, existencias;
END;
END WHILE;
CLOSE curCatalogo;

if (select count(*) from listado) > 0 then
    select * from listado;
else
    select 'No existen productos';
end if;
drop table if exists listado;

END $$
DELIMITER ;


