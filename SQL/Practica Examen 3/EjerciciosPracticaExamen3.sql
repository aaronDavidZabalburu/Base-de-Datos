/*
1.- Mostrar los productos que sean manteles de los fabricantes asa, bra y duni de 140x140.
Mostrar fabricante, producto, descripción (la descripción se mostrará con el inicio de cada letra
en mayúsculas), precio y precio total (que será el precio incrementado en un 4% de IVA),
Esta orden la debemos mostrar ordenada por fabricante y si tienen el mismo fabricante por precio
total de mayor a menor.
*/

SELECT IDFABRICANTE, IDPRODUCTO, INITCAP(DESCRIPCION), PUNITARIO, PUNITARIO*1.04 AS "PRECIO TOTAL" 
    FROM PRODUCTOS
    WHERE LOWER(idfabricante) IN ('asa','bra','duni') AND
    LOWER (DESCRIPCION) LIKE 'mantel%140x140%'
    ORDER BY IDFABRICANTE, 5 DESC;

/*2A.- Mostrar el nombre de los clientes y nombre de los empleados que son sus representantes.
En el listado deben aparecer todos los empleados, tanto los que son representantes de clientes,
como los que no lo son. (1 punto)
*/

SELECT c.nombre, e.nombre 
    from clientes c RIGHT JOIN EMPLEADOS e ON c.representante = e.idempleado;


/*2B.- Y si queremos mostrar de cada empleado cuantos clientes representa. Mostraremos el
nombre del empleado y un campo denominado Nº Clientes con el número de clientes que
representan. (1 punto)
*/

SELECT e.IDEMPLEADO, e.NOMBRE, COUNT(c.IDCLIENTE) "Nº Clientes"
    FROM EMPLEADOS e LEFT JOIN CLIENTES c ON e.IDEMPLEADO = c.REPRESENTANTE
    GROUP BY e.IDEMPLEADO, e.NOMBRE;

/*2C.- Solo queremos mostrar aquellos empleados que representan a más de 3 clientes. Mostraremos
como en la pregunta 3B el nombre del empleado y el campo Nº Clientes. (0.5 puntos)
*/

SELECT e.IDEMPLEADO, e.NOMBRE, COUNT(c.IDCLIENTE) "Nº Clientes"
    FROM EMPLEADOS e LEFT JOIN CLIENTES c ON e.IDEMPLEADO = c.REPRESENTANTE
    GROUP BY e.IDEMPLEADO, e.NOMBRE
    HAVING COUNT(c.IDCLIENTE) > 3;

/*3A.- Mostrar la descripción y el nombre del fabricante del producto más barato de toda nuestra
base de datos. (1,25 puntos)
*/

SELECT DESCRIPCION, IDFABRICANTE
    FROM PRODUCTOS 
    WHERE punitario = (SELECT MIN(PUNITARIO) FROM PRODUCTOS);

SELECT MIN(PUNITARIO) FROM PRODUCTOS;

/*3B.- Por cada fabricante queremos mostrar el precio de su producto más caro, más barato y la
media de precios de sus productos. Todos deben redondeados a 1 decimal y se mostrarán con la
moneda de € por detrás los precios. Se mostrará el fabricante, el precio más barato, el precio
más caro y la media de precios. Se colocarán los siguientes alias a los campos: Precio más bajo,
Precio más alto y Media de Precios. (1 punto)
*/

SELECT IDFABRICANTE, ROUND(MIN(PUNITARIO),1) || '€' "Precio MAS BAJO", ROUND(MAX(PUNITARIO),1) || '€' "PRECIO MAS ALTO", ROUND(AVG(PUNITARIO),1) || '€' "MEDIA DE PRECIOS"
    FROM PRODUCTOS
    GROUP BY IDFABRICANTE;

/*4.- Mostrar cuantos empleados trabajan en bajo las órdenes de Luis Amezti (es decir, Luis
Amezti es su jefe). (1,25 puntos)
*/

SELECT COUNT(*) FROM EMPLEADOS
WHERE JEFE = (SELECT IDEMPLEADO FROM EMPLEADOS 
WHERE LOWER(NOMBRE) LIKE 'luis% amezti%');

SELECT IDEMPLEADO FROM EMPLEADOS 
WHERE LOWER(NOMBRE) LIKE 'luis% amezti%';

/*5.- Mostrar cuantas oficinas no tienen director. (1 punto)
*/

SELECT COUNT(*) FROM OFICINAS
WHERE DIRECTOR IS NULL;

SELECT * FROM OFICINAS WHERE DIRECTOR IS NULL;

/*6.- Mostrar en un campo el Nombre del cliente y en otro los apellidos de los clientes en
formato “Apellido2, Apellido1” que han realizado pedidos. (1,5 puntos)
*/

SELECT DISTINCT p.IDCLIENTE, INITCAP(LOWER(SUBSTR(c.nombre,1, INSTR(c.nombre,' ')))) AS "NOMBRE" , -- nombre
INITCAP(LOWER(SUBSTR(c.nombre,INSTR(nombre,' ',1,2)+1))) || ', ' -- segundo apellido
|| INITCAP(LOWER(SUBSTR(c.nombre,INSTR(c.nombre,' ')+1,INSTR(c.nombre,' ',1,2)-INSTR(c.nombre,' ')-1))) --primer apellido
AS "APELLIDOS" FROM PEDIDOS p JOIN CLIENTES c ON p.idcliente = c.idcliente;

SELECT p.IDCLIENTE, c.nombre
FROM PEDIDOS p JOIN CLIENTES c ON p.idcliente = c.idcliente;


/*7.-Queremos obtener un listado las descripciones de los productos que no hayan sido vendidos.
(1,5 puntos)
*/

SELECT descripcion
FROM productos
WHERE (idfabricante, idproducto) NOT IN 
    (SELECT fabricante, producto FROM lineas_pedidos);

/*8.- Mostrar todos los pedidos realizados en abril y mayo de 2001 con un importe superior a
15.000€. Mostrar el número de pedido, número del empleado que lo ha realizado, número del
cliente que lo ha pedido, fecha del pedido (formato fecha: 12 de enero de 2021) e importe del
pedido (el importe vendrá con puntos de miles, dos decimales y con la moneda tras la cantidad).
(1,25 puntos)
*/

SELECT p.numpedido, p.idvendedor "EMPLEADO", p.idcliente "CLIENTE",
    TO_CHAR(FPEDIDO, 'DD "de" FMMONTH "de" YYYY') "FECHA DEL PEDIDO",
    TO_CHAR(SUM(lp.punitario*lp.cantidad),'999G999D99L') "IMPORTE"
    FROM PEDIDOS p JOIN LINEAS_PEDIDOS lp ON p.codigo = lp.codigo
    WHERE EXTRACT(MONTH FROM FPEDIDO)BETWEEN 4 AND 5 
    AND EXTRACT(YEAR FROM FPEDIDO) = 2001
    GROUP BY p.numpedido, p.idvendedor, p.idcliente,
    TO_CHAR(FPEDIDO, 'DD "de" FMMONTH "de" YYYY')
    HAVING SUM(lp.punitario*lp.cantidad) > 15000;


/*9A.- Por cada año queremos mostrar cuantos clientes nos han hecho pedidos. (1,25 puntos)
*/

SELECT EXTRACT(YEAR FROM fpedido) AS año, 
    COUNT(DISTINCT idcliente) AS NumeroClientes
FROM Pedidos
GROUP BY EXTRACT(YEAR FROM fpedido);

SELECT * FROM PEDIDOS;

/*9B.- Por cada año y cliente queremos mostrar cuantos pedidos ha hecho y cual el importe total de
los pedidos. (1,5 puntos)
*/

SELECT 
    EXTRACT(YEAR FROM fpedido) AS Año,
    p.IDCLIENTE,
    COUNT(DISTINCT p.NUMPEDIDO) AS CantidadPedidos,
    SUM(lp.PUNITARIO * lp.CANTIDAD) AS ImporteTotal
FROM PEDIDOS p
JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
GROUP BY EXTRACT(YEAR FROM fpedido), p.IDCLIENTE;


/*10.- Queremos premiar a los empleados mayores de 60 años. Si son comerciales incrementaremos
su cuota en un 6%, si son directores/as comerciales incrementaremos su cuota en un 5%, si son
directores/as de ventas incrementaremos su cuota en un 4% y si tienen otro puesto se
incrementará su cuota en un 2%. Mostraremos el nombre del empleado, su edad, la cuota actual y
la cuota incrementada. (1,5 puntos)
*/

SELECT 
    NOMBRE,
    TRUNC(MONTHS_BETWEEN(SYSDATE, FNACIMIENTO) / 12) AS EDAD,
    CUOTA AS CUOTA_ACTUAL,
    CASE 
        WHEN PUESTO = 'COMERCIAL' THEN CUOTA * 1.06
        WHEN PUESTO IN ('DIRECTOR COMERCIAL', 'DIRECTORA COMERCIAL') THEN CUOTA * 1.05
        WHEN PUESTO IN ('DIRECTOR DE VENTAS', 'DIRECTORA DE VENTAS') THEN CUOTA * 1.04
        ELSE CUOTA * 1.02
    END AS CUOTA_INCREMENTADA
FROM EMPLEADOS
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, FNACIMIENTO) / 12) > 60;