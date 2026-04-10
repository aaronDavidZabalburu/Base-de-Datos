/*UPDATE*/

--6 
    UPDATE OFICINAS SET DIRECTOR = 106 
        WHERE LOWER(ciudad) = 'valencia';
    
--7
    UPDATE OFICINAS 
        SET DIRECTOR = ( SELECT idempleado from empleados
            where lower(nombre) like 'luisa sabater%')
        WHERE LOWER(CIUDAD) = 'madrid';
    
--8
    UPDATE CLIENTES SET REPRESENTANTE = 110
        WHERE EXTRACT(YEAR FROM falta) > 2012;

--9
    UPDATE CLIENTES SET REPRESENTANTE =
        ( SELECT idempleado from empleados
            where lower(nombre) like 'bego% marquez%')
    WHERE EXTRACT(YEAR FROM falta) between 2007 and 2012;

--10
    UPDATE EMPLEADOS SET movil = '987987987'
        WHERE LOWER(NOMBRE) LIKE 'estibaliz ulibarri%';

--11 
    UPDATE EMPLEADOS SET PUESTO = 'REPRESENTANTE COMERCIAL'
        WHERE LOWER(PUESTO) LIKE 'comercial';
        

rollback;

/*DELETE*/

--19
    DELETE FROM LINEAS_PEDIDOS
        WHERE CANTIDAD < 100;

--20
    DELETE FROM PRODUCTOS
        WHERE (idfabricante, idproducto) NOT IN
            (SELECT fabricante, producto from lineas_pedidos);

--21
    DELETE FROM EMPLEADOS 
        WHERE LOWER(PUESTO) LIKE 'comercial%';

--22
    DELETE FROM OFICINAS
        WHERE OBJETIVO > 600000 
        AND director = (SELECT idempleado from empleados where lower(nombre) like 'estibaliz ulibarri%');
        

rollback;
















