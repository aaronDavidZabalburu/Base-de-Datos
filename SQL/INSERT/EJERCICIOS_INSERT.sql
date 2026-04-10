INSERT INTO EMPLEADOS VALUES (
    701, 'Pilar Gallego Rivas', TO_DATE('10/10/1968', 'DD/MM/YYYY'),
    12, 'Directora Comercial', TO_DATE('01/05/1997', 'DD/MM/YYYY'),
    100, '999888777',  100000, 150000
);

INSERT INTO EMPLEADOS (idempleado, nombre, idoficina, puesto, fcontrato, jefe, movil)
    VALUES (
        702, 'Rosa Mar Oceano', 12, 'Directora area', 
        TO_DATE(sysdate, 'DD/MM/YYYY'), 104 , '888777999');
        
INSERT INTO EMPLEADOS (idempleado, nombre, idoficina) 
    VALUES (703, 'Susana Diaz Romero', 12);
    
INSERT INTO EMPLEADOS (idempleado, nombre, idoficina, puesto, fcontrato, jefe, movil, cuota)
    VALUES(704, 'Martin Gomez Acebo', 
        (SELECT o.IDOFICINA FROM OFICINAS o
            WHERE o.idoficina IN (SELECT idoficina FROM EMPLEADOS e
            WHERE LOWER(nombre) LIKE 'bego% marquez sevilla')),
        (SELECT PUESTO FROM EMPLEADOS
            WHERE LOWER(NOMBRE) LIKE 'pablo rivas%'), 
        sysdate - 1,
        (SELECT director from oficinas 
            WHERE idoficina = 21),
        '666777888',
         (SELECT MIN(cuota) from empleados
            where idoficina = 21));
    
INSERT INTO CLIENTES (idcliente, nombre, falta)
    SELECT idempleado, nombre, fcontrato from empleados
    where idoficina = 21;
    

INSERT INTO CLIENTES (idcliente, nombre, falta, representante)
    VALUES (9130, 'Juan Iglesias Jurado', sysdate + 7,
        (SELECT idempleado FROM EMPLEADOS
            WHERE FCONTRATO = (SELECT MIN(FCONTRATO) FROM EMPLEADOS) 
            AND LOWER(PUESTO) = 'comercial'));

   