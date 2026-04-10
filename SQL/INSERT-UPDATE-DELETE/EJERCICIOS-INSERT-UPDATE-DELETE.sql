--1 

INSERT INTO OFICINAS 
    VALUES (90, 'Alameda Recalde 31, 2 Planta', '48009', 'Bilbao',
            'NORTE', '944111144', 110, 500000, 175000);

INSERT INTO OFICINAS 
    VALUES (91, 'Sabino Arana 33, Bajo', '48013', 'Bilbao',
            'NORTE', '944241424', 104, 585000, NULL);
            

--2
    INSERT INTO OFICINAS (idoficina, ciudad, objetivo, region, direccion, cpostal)
        VALUES(30, 'MADRID', 600000, 'CENTRO', 'Gran Vía 34', '28013' );

--3
    UPDATE EMPLEADOS SET VENTAS = 0
        WHERE idoficina IN (12,21);

--4
    UPDATE EMPLEADOS SET VENTAS = 0
        WHERE IDOFICINA IN 
            (SELECT IDOFICINA FROM OFICINAS 
                WHERE LOWER(ciudad) IN ('madrid', 'valencia'));

--5 
    UPDATE EMPLEADOS e SET CUOTA =
        (SELECT o.OBJETIVO  * 1.01 FROM OFICINAS o
            WHERE o.idoficina = e.idoficina);
--6
    DELETE FROM LINEAS_PEDIDOS 
        WHERE codigo IN (SELECT CODIGO FROM PEDIDOS
            WHERE IDCLIENTE = (
                SELECT IDCLIENTE FROM CLIENTES 
                    WHERE LOWER(NOMBRE) LIKE 'estefania garcia anton'));

    DELETE FROM PEDIDOS 
        WHERE CODIGO IN (SELECT CODIGO FROM PEDIDOS
            WHERE IDCLIENTE = (
                SELECT IDCLIENTE FROM CLIENTES 
                    WHERE LOWER(NOMBRE) LIKE 'estefania garcia anton'));
                    
--7
    UPDATE PRODUCTOS SET PUNITARIO = punitario * 1.05
    WHERE lower(idfabricante) = 'bra';
        
        
--8
    UPDATE EMPLEADOS SET IDOFICINA = 30
    WHERE IDOFICINA = 21;
    
--9
 DELETE FROM LINEAS_PEDIDOS 
        WHERE codigo IN (SELECT CODIGO FROM PEDIDOS
            WHERE IDVENDEDOR = (
                SELECT IDEMPLEADO FROM EMPLEADOS 
                    WHERE LOWER(NOMBRE) LIKE 'fernando lopez'));

DELETE FROM PEDIDOS 
        WHERE CODIGO IN (SELECT CODIGO FROM PEDIDOS
            WHERE IDVENDEDOR = (
                SELECT IDEMPLEADO FROM EMPLEADOS 
                    WHERE LOWER(NOMBRE) LIKE 'fernando lopez'));
                    
--10
    DELETE FROM OFICINAS
        WHERE IDOFICINA NOT IN 
            (SELECT IDOFICINA FROM EMPLEADOS
                WHERE IDOFICINA IS NOT NULL);
--11
    UPDATE EMPLEADOS SET CUOTA = CUOTA * 0.95
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, fcontrato) / 12) > 25;

--12
    DELETE FROM LINEAS_PEDIDOS
        WHERE CODIGO IN (SELECT CODIGO FROM PEDIDOS
            WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM CLIENTES
                WHERE REPRESENTANTE = (SELECT IDEMPLEADO FROM EMPLEADOS
                    WHERE LOWER(NOMBRE) LIKE 'miguel estrella')));
                    
                    
    DELETE FROM PEDIDOS
        WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM CLIENTES
                WHERE REPRESENTANTE = (SELECT IDEMPLEADO FROM EMPLEADOS
                    WHERE LOWER(NOMBRE) LIKE 'miguel estrella'));
                    
--13
    UPDATE PEDIDOS SET FENVIO = FPEDIDO + 5 
            WHERE EXTRACT(MONTH FROM FPEDIDO) = 5 AND
                EXTRACT(YEAR FROM FPEDIDO) = 2007;
                
--14
    UPDATE EMPLEADOS SET JEFE = 
        (SELECT JEFE FROM EMPLEADOS 
            WHERE LOWER(NOMBRE) LIKE 'maria larraga%')
    WHERE JEFE = (SELECT idempleado FROM empleados 
              WHERE LOWER(nombre) LIKE 'maria larraga%'); 
              
    UPDATE OFICINAS SET DIRECTOR = 
        (SELECT JEFE FROM EMPLEADOS 
            WHERE LOWER(NOMBRE) LIKE 'maria larraga%')
        WHERE DIRECTOR = (SELECT IDEMPLEADO FROM EMPLEADOS
            WHERE LOWER(NOMBRE) LIKE 'maria larraga%');
    
    rollback;

    
    