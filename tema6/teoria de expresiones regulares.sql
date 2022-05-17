-- expresiones regulares


/*aquellos empleados  que empiece por vocal y después tenga una l o una n

*/

select *
from empleados
where nomem regexp '^[aeiou][ln]';


/* que empiece por 2 vocales*/

select *
from empleados
where nomem regexp '^[aeiou]{2}';


/* contengan 0 1 o más de 1 b */

select *
from empleados
where nomem regexp 'b*';

/* que empiecen e contengan  1 o más de 1 b*/

select *
from empleados
where nomem regexp 'eb*';
