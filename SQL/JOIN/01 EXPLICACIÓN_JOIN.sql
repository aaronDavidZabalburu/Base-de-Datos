
--JOINS: MOSTRAR DATOS DE VARIAS TABLAS. Pueden mostrar información que las multitablas no pueden.

/**********************************************************************/
--INNER JOIN   o JOIN  : Hace lo mismo que la multitabla. 
/**********************************************************************/

/*****EJEMPLO 1 ******/

--1.- Mostrar los empleados que trabajan en oficinas. Mostrar número y nombre del empleado y el número, ciudad y ventas de la oficina. 
            --Hecho con MULTITABLA    
                SELECT e.idempleado,e.nombre,o.idoficina,o.ciudad,o.ventas
                FROM empleados e,oficinas o
                WHERE e.idoficina=o.idoficina;

            --Hecho con JOIN    
                SELECT e.idempleado,e.nombre,o.idoficina,o.ciudad,o.ventas
                FROM empleados e JOIN oficinas o
                ON e.idoficina=o.idoficina;
   
--2.- Mostrar los empleados que trabajan en oficinas de valencia y de castellon. Mostrar número y nombre del empleado y el número, ciudad y ventas de la oficina. 
     
                 --Hecho con MULTITABLA    
                SELECT e.idempleado,e.nombre,o.idoficina,o.ciudad,o.ventas
                FROM empleados e,oficinas o
                WHERE e.idoficina=o.idoficina AND
                lower(ciudad) IN ('valencia','castellon');

                --Hecho con JOIN    
                SELECT e.idempleado,e.nombre,o.idoficina,o.ciudad,o.ventas
                FROM empleados e JOIN oficinas o
                ON e.idoficina=o.idoficina
                WHERE  lower(ciudad) IN ('valencia','castellon');
                    
    
   /**********************************************************************/
   /*********INNER JOIN o JOIN ************************************/
     /*******LEFT OUTER JOIN o LEFT JOIN ********************/
  /*********RIGHT OUTER JOIN o RIGHT JOIN ******************/
   /********FULL OUTER JOIN o FULL JOIN ********************/ 
   /*******************************************************************/
    
    --PRIMER CASO : INNER JOIN O JOIN ( Empleados que tienen oficina )
    
    SELECT e.idempleado,e.nombre,o.idoficina,o.ciudad,o.ventas
    FROM empleados e JOIN oficinas o
    ON e.idoficina=o.idoficina ORDER BY idoficina;
    
    --SEGUNDO CASO : LEFT OUTER JOIN o LEFT JOIN ( Empleados que tienen oficina y empleados que no tienen oficina )
    
    SELECT e.idempleado,e.nombre,o.idoficina,o.ciudad,o.ventas
    FROM empleados e LEFT JOIN oficinas o
    ON e.idoficina=o.idoficina;
    
    --TERCER CASO : RIGHT OUTER JOIN o RIGHT JOIN ( Empleados que tienen oficina y oficinas que no tienen empleados )
      SELECT e.idempleado,e.nombre,o.idoficina,o.ciudad,o.ventas
    FROM empleados e RIGHT JOIN oficinas o
    ON e.idoficina=o.idoficina;
    
       --CUARTO CASO : LEFT OUTER JOIN o LEFT JOIN con WHERE campo IS NULL ( empleados que no tienen oficina )
    
    SELECT e.idempleado,e.nombre,o.idoficina,o.ciudad,o.ventas
    FROM empleados e LEFT JOIN oficinas o
    ON e.idoficina=o.idoficina
      WHERE o.idoficina IS NULL;
      
      --QUINTO CASO : RIGHT OUTER JOIN o RIGHT JOIN con WHERE campo IS NULL ( Oficinas que no tienen empleados )
      SELECT e.idempleado,e.nombre,e.idoficina,o.idoficina,o.ciudad,o.ventas
    FROM empleados e RIGHT JOIN oficinas o
    ON e.idoficina=o.idoficina
    WHERE e.idoficina IS NULL;
    
    --SEXTO CASO: FULL JOIN  ( Empleados que tienen oficina y empleados que no tienen oficina y Oficinas que no tienen empleados )
    
     SELECT e.idempleado,e.nombre,e.idoficina,o.idoficina,o.ciudad,o.ventas
    FROM empleados e FULL JOIN oficinas o
    ON e.idoficina=o.idoficina;
  
    
       --SEPTIMO CASO: FULL JOIN con CONDICIONES campo1 IS NULL or CAMPO2 IS NULL ( Empleados que tienen oficina y empleados que no tienen oficina y Oficinas que no tienen empleados )
       
        SELECT e.idempleado,e.nombre,e.idoficina,o.idoficina,o.ciudad,o.ventas
    FROM empleados e FULL JOIN oficinas o
    ON e.idoficina=o.idoficina
    WHERE e.idoficina IS NULL or o.idoficina IS NULL ;