/*EJERCICIOS SUCONSULTAS II */

/*Los ejercicios se pueden resolver de varias maneras, intenta resolverlos utilizando subconsultas ya que de eso trata el tema.*/


/*1.- Mostrar el nombre de los empleados cuyo jefe sea Luis Amezti.*/
SELECT NOMBRE
FROM EMPLEADOS
WHERE JEFE IN (
    SELECT IDEMPLEADO
    FROM EMPLEADOS
    WHERE LOWER(NOMBRE) LIKE 'luis amezti%'
);

/*2.- Mostrar el nombre del jefe del empleado apellidado Marquez. (Andres Diaz Zabalburu)*/
SELECT NOMBRE
FROM EMPLEADOS
WHERE IDEMPLEADO IN (
    SELECT JEFE
    FROM EMPLEADOS
    WHERE LOWER(NOMBRE) LIKE '%marquez%');

/*3.- Mostrar los datos de las oficinas que dirige Jose Miguel Estrella que no est�n en Valencia y que hayan hecho m�s de 500000� de ventas. (Oficina n� 7)*/
SELECT *
FROM OFICINAS
WHERE DIRECTOR IN (
    SELECT IDEMPLEADO
    FROM EMPLEADOS
    WHERE LOWER(NOMBRE) LIKE 'miguel estrella%')
AND LOWER(CIUDAD) != 'valencia'
AND VENTAS > 500000;

/*4.- Mostrar el nombre de los empleados y que en el a�o 2012 han hecho un total de m�s de 10000� en pedidos a sus clientes. (M� Bego�a Se�or Se�or)*/
SELECT NOMBRE
FROM EMPLEADOS
WHERE IDEMPLEADO IN (
    SELECT p.IDVENDEDOR
    FROM PEDIDOS p
    JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
    WHERE EXTRACT(YEAR FROM p.FPEDIDO) = 2012
    GROUP BY p.IDVENDEDOR
    HAVING SUM(lp.PUNITARIO * lp.CANTIDAD) > 10000);
/*5.- Mostrar todos los datos de las oficinas del este y que su objetivo sea menor que las ventas de todos sus empleados.*/

SELECT * FROM OFICINAS o
    Where objetivo <(
        SELECT MIN(ventas) FROM EMPLEADOS e
        where o.idoficina = e.idoficina)
    AND LOWER(region)='este';

/*6.- Mostrar los nombres de los clientes que en el a�o 2007 han comprado alg�n mantel de cualquier fabricante.*/
SELECT NOMBRE
FROM CLIENTES
WHERE IDCLIENTE IN (
    SELECT p.IDCLIENTE
    FROM PEDIDOS p
    JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
    JOIN PRODUCTOS pr ON lp.FABRICANTE = pr.IDFABRICANTE
        AND lp.PRODUCTO = pr.IDPRODUCTO
    WHERE EXTRACT(YEAR FROM p.FPEDIDO) = 2007
    AND LOWER(pr.DESCRIPCION) LIKE '%mantel%');
/*7.- Mostrar los nombres de los clientes (sin valores repetidos) que en el a�o 2007 han comprado un mantel del fabricante bra.*/
SELECT NOMBRE
FROM CLIENTES
WHERE IDCLIENTE IN (
    SELECT DISTINCT p.IDCLIENTE
    FROM PEDIDOS p
    JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
    JOIN PRODUCTOS pr ON lp.FABRICANTE = pr.IDFABRICANTE
        AND lp.PRODUCTO = pr.IDPRODUCTO
    WHERE EXTRACT(YEAR FROM p.FPEDIDO) = 2007
    AND LOWER(pr.DESCRIPCION) LIKE '%mantel%'
    AND LOWER(idfabricante) LIKE '%bra%');


/*8.- Mostrar el nombre de los empleados que fueron contratados antes de la fecha en que se realiz� el primer pedido.*/
SELECT NOMBRE
FROM EMPLEADOS
WHERE FCONTRATO < (
    SELECT MIN(FPEDIDO)
    FROM PEDIDOS);

/*9.- Mostrar los nombres de los jefes que tengan m�s de 4 empleados a su cargo.*/
SELECT NOMBRE
FROM EMPLEADOS
WHERE IDEMPLEADO IN (
    SELECT JEFE
    FROM EMPLEADOS
    WHERE JEFE IS NOT NULL
    GROUP BY JEFE
    HAVING COUNT(*) > 4);

/*10.-Mostrar los nombres de los jefes cuyas ventas 
sean menores que las de todos sus empleados.*/
SELECT idempleado,nombre FROM EMPLEADOS
WHERE idempleado IN (
        SELECT e.JEFE
            FROM EMPLEADOS e JOIN empleados j
            on e.jefe = j.idempleado
            GROUP BY e.jefe, j.ventas
            HAVING SUM(e.ventas) > j.ventas);



