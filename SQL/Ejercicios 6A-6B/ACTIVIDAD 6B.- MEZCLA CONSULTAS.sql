/*1A.-  Mostrar todos los pedidos realizados en enero de 2007 
con un precio superior a 25000�. Mostrar el n�mero de pedido y 
n�mero del empleado que lo ha realizado, 
n�mero del cliente que lo ha pedido ,
fecha del pedido  e importe (correctamente formateado). (1 punto)*/

SELECT p.NUMPEDIDO, p.IDVENDEDOR, p.IDCLIENTE, p.FPEDIDO, 
       TO_CHAR(SUM(lp.PUNITARIO * lp.CANTIDAD), '999G999D99') || ' €' AS IMPORTE
FROM PEDIDOS p
JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
WHERE EXTRACT(MONTH FROM p.fpedido) = 5
AND EXTRACT(YEAR FROM p.fpedido) = 2007
GROUP BY p.NUMPEDIDO, p.IDVENDEDOR, p.IDCLIENTE, p.FPEDIDO
HAVING SUM(lp.PUNITARIO * lp.CANTIDAD) > 25000;


/*1B.- Mostrar todos los pedidos realizados en enero de 2007 con un precio superior a 25000�.
Mostrar el n�mero de pedido y nombre del empleado que lo ha realizado,
nombre del cliente que lo ha pedido, fecha del pedido 
(formato largo ejemplo: lunes, 10 de junio de 2007) 
e importe (correctamente formateado). */

SELECT p.NUMPEDIDO, e.NOMBRE AS EMPLEADO, c.NOMBRE AS CLIENTE,
       TO_CHAR(p.FPEDIDO, 'day DD "de" Month "de" YYYY') AS FECHA,
       TO_CHAR(SUM(l.PUNITARIO * l.CANTIDAD), '999G999D99') || ' €' AS IMPORTE
FROM PEDIDOS p
JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
JOIN EMPLEADOS e ON p.IDVENDEDOR = e.IDEMPLEADO
JOIN CLIENTES c ON p.IDCLIENTE = c.IDCLIENTE
WHERE EXTRACT(MONTH FROM p.fpedido) = 5
AND EXTRACT(YEAR FROM p.fpedido) = 2007
GROUP BY p.NUMPEDIDO, e.NOMBRE, c.NOMBRE, p.FPEDIDO
HAVING SUM(lp.PUNITARIO * lp.CANTIDAD) > 5000;


/*2.- Mostrar el n�mero de oficina, ciudad y director de aquellas oficinas que
no tienen empleados asignados. */

SELECT IDOFICINA, CIUDAD, DIRECTOR
FROM OFICINAS
WHERE IDOFICINA NOT IN (SELECT DISTINCT IDOFICINA FROM EMPLEADOS WHERE IDOFICINA IS NOT NULL);

/*3.- Quiero mostrar cuantos productos se han pedido del fabricante aci y del fabricante rei.
Mostrar fabricante y n�mero de productos pedidos. */

SELECT FABRICANTE, COUNT(*)  "PRODUCTOS_PEDIDOS"
FROM LINEAS_PEDIDOS
WHERE LOWER(FABRICANTE) IN ('asa', 'bra')
GROUP BY FABRICANTE;

/*4.- Mostrar cuantos productos se han pedido de cada fabricante.
Mostrar fabricante y cantidad de productos. */

SELECT FABRICANTE, COUNT(*) AS CANTIDAD_PRODUCTOS
FROM LINEAS_PEDIDOS
GROUP BY FABRICANTE;

/*5.- Mostrar el nombre de los empleados, nombre de sus jefes, sus ventas y cuotas y las de sus jefes.
En el listado deben aparecer todos los empleados, tanto si tienen, jefe, como si no. */

SELECT e.NOMBRE AS EMPLEADO, j.NOMBRE AS JEFE, 
       e.VENTAS AS VENTAS_EMP, e.CUOTA AS CUOTA_EMP,
       j.VENTAS AS VENTAS_JEFE, j.CUOTA AS CUOTA_JEFE
FROM EMPLEADOS e
LEFT JOIN EMPLEADOS j ON e.JEFE = j.IDEMPLEADO;

/*6.- Listar la oficina que tenga un objetivo mayor de las que tienen director. 
Se deben mostrar los campos de n�mero de oficina, nombre del director, 
objetivo y un objetivo para el a�o que viene que ser� el objetivo incrementado en un 5%.
A este nuevo campo lo vamos a denominar Objetivo 2023. */

SELECT o.IDOFICINA, e.NOMBRE  "DIRECTOR", o.OBJETIVO,
       (o.OBJETIVO * 1.05) "Objetivo 2023"
FROM OFICINAS o
JOIN EMPLEADOS e ON o.DIRECTOR = e.IDEMPLEADO
WHERE o.OBJETIVO = (SELECT MAX(OBJETIVO) FROM OFICINAS WHERE DIRECTOR IS NOT NULL);


/*7.- Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% 
del objetivo de su oficina. Mostrar de cada oficina el n�mero, regi�n y objetivo. */

SELECT IDOFICINA, REGION, OBJETIVO
FROM OFICINAS o
WHERE NOT EXISTS (
    SELECT idempleado FROM EMPLEADOS e 
    WHERE e.IDOFICINA = o.IDOFICINA 
    AND e.VENTAS <= (o.OBJETIVO * 0.5)
);


/*8.- Estamos haciendo un control de existencias y debemos mostrar
por cada uno de nuestros productos si los pedidos son urgentes, 
para dentro de una semana, para dentro de un mes.
Si el campo existencias es menor de 50 unidades el pedido ser� urgente (URGENTE).
Si est� entre 51 y 150 ser� para dentro de una semana (SEMANA) 
y si es superior a 150 ser� para dentro de un mes (MES). 
Esta consulta debe mostrar el fabricante, descripci�n, 
existencias y la petici�n del pedido mostrando URGENTE, SEMANA o MES. */

SELECT IDFABRICANTE, DESCRIPCION, STOCK,
       CASE 
          WHEN STOCK < 50 THEN 'URGENTE'
          WHEN STOCK BETWEEN 51 AND 150 THEN 'SEMANA'
          ELSE 'MES'
       END AS PETICION
FROM PRODUCTOS;


/*9.- Mostrar el precio medio de los productos de cada fabricante que superen los 500 �.
El precio debe aparecer con dos decimales y el s�mbolo del euro por detr�s.
Mostrar Fabricante y un campo denominado Precio Medio Productos. */

SELECT IDFABRICANTE, 
       TO_CHAR(ROUND(AVG(PUNITARIO), 2), '999G999D99') || ' €' AS "Precio Medio Productos"
FROM PRODUCTOS
GROUP BY IDFABRICANTE
HAVING AVG(PUNITARIO) > 10;

/*10.- Mostrar para cada empleado su nombre, su campo ventas, y 
calcular el premio que van a conseguir seg�n las ventas conseguidas,

Si las ventas son inferiores a 100000 no se dar� premio.
Si las ventas son inferiores a 200000 el premio ser� de 100�.
Si las ventas son inferiores a 300000 el premio ser� de 200�.
Si las ventas son inferiores a 400000 el premio ser� de 300�.
Si las ventas son superiores a 400000 el premio ser� de 500�.
Tanto la fecha del pedido como la fecha del env�o debe ser mostrada 
con el siguiente formato: d�a de mes de a�o (por ejemplo: 7-marzo-2012).*/

SELECT NOMBRE, VENTAS,
       CASE 
          WHEN VENTAS < 100000 THEN 0
          WHEN VENTAS < 200000 THEN 100
          WHEN VENTAS < 300000 THEN 200
          WHEN VENTAS < 400000 THEN 300
          ELSE 500
       END  "PREMIO"
FROM EMPLEADOS;

/*11.- Mostrar de cada empleado su nombre, el nombre de su jefe solo de aquellos empleados
que su jefe haya sido contratado posteriormente a ellos. 
Aparecer�n en el listado tambi�n aquellos empleados que no tienen jefe. */  

SELECT e.NOMBRE "EMPLEADO", j.NOMBRE "JEFE"
FROM EMPLEADOS e
LEFT JOIN EMPLEADOS j ON e.JEFE = j.IDEMPLEADO
WHERE j.FCONTRATO > e.FCONTRATO OR e.JEFE IS NULL;


/*12.- Mostrar por cada empleado el importe m�nimo que ha realizado en un pedido
y el importe m�ximo en el a�o 2007. Mostrar nombre del empleado, importe m�nimo e importe m�ximo. */

SELECT e.NOMBRE, MIN(totales.TOTAL) "MIN 2007", MAX(totales.TOTAL)  "MAX 2007"
FROM EMPLEADOS e
JOIN (
    SELECT IDVENDEDOR, FPEDIDO, SUM(PUNITARIO * CANTIDAD) "TOTAL"
    FROM PEDIDOS p
    JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
    GROUP BY p.CODIGO, p.IDVENDEDOR, p.FPEDIDO
) totales ON e.IDEMPLEADO = totales.IDVENDEDOR
WHERE EXTRACT(YEAR FROM totales.fpedido) = 2007
GROUP BY e.NOMBRE;

/*13.- Mostrar los pedidos que ha realizado Ana Bustamante en Julio del 97.
Mostrar el n�mero de pedido, fecha del pedido en formato largo 
(p ej: mi�rcoles, 3 de mayo de 2012), y el importe.
El importe debe aparecer con dos decimales y el s�mbolo del � detr�s. */

SELECT p.NUMPEDIDO, 
       TO_CHAR(p.FPEDIDO, 'day, DD "de" Month "de" YYYY') "FECHA",
       TO_CHAR(SUM(lp.PUNITARIO * lp.CANTIDAD), '999G999D99') || ' €' "IMPORTE"
FROM PEDIDOS p
JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
JOIN CLIENTES c ON p.idcliente = c.idcliente
WHERE LOWER(c.NOMBRE) = 'ana bustamante' 
  AND EXTRACT(MONTH FROM p.fpedido) = 7
AND EXTRACT(YEAR FROM p.fpedido) = 1997
GROUP BY p.NUMPEDIDO, p.FPEDIDO;


/*14.- Se quiere incrementar el objetivo de las oficinas por regiones,
a aquellas del norte se les incrementar� su objetivo en un 5%,
a las del este en un 3% a las del oeste en un 2% y al resto en un 7%.
Mostrar en el listado el n�mero de oficina, regi�n, porcentaje a incrementar,
el objetivo actual y el objetivo actualizado con el incremento. */


SELECT IDOFICINA, REGION, OBJETIVO "OBJETIVO ACTUAL",
       CASE 
          WHEN REGION = 'NORTE' THEN '5%'
          WHEN REGION = 'ESTE' THEN '3%'
          WHEN REGION = 'OESTE' THEN '2%'
          ELSE '7%'
       END "PORCENTAJE",
       CASE 
          WHEN REGION = 'NORTE' THEN OBJETIVO * 1.05
          WHEN REGION = 'ESTE' THEN OBJETIVO * 1.03
          WHEN REGION = 'OESTE' THEN OBJETIVO * 1.02
          ELSE OBJETIVO * 1.07
       END  "OBJETIVO ACTUALIZADO"
FROM OFICINAS;
