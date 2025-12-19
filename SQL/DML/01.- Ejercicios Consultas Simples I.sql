/*EJERCICIO CONSULTAS SIMPLES 1*/

/*1.- Obtener una lista de todos los productos indicando para cada uno 
su identificativo de fabricante, identificativo de producto, descripci�n,
precio y precio con IVA incluido (es el precio anterior aumentado en un 21%). */
SELECT idfabricante, idproducto, descripcion, punitario, punitario * 1.21 "PRECIO CON IVA"
    FROM PRODUCTOS; 

/*2.- De cada l�nea de pedido queremos saber su n�mero de pedido, fabricante, producto,
cantidad, precio unitario y calcularemos su importe. */
SELECT codigo, fabricante, producto, cantidad, punitario, cantidad * punitario "IMPORTE"
    FROM LINEAS_PEDIDOS;

/*3.- Obtener la lista de los clientes agrupados por c�digo de representante asignado,
visualizar todas las columnas de la tabla. */

SELECT * FROM clientes
    ORDER BY representante; 

/*4.- Obtener las oficinas ordenadas por orden alfab�tico de regi�n y 
dentro de cada regi�n por ciudad, si hay m�s de una oficina en la misma ciudad,
aparecer� primero la que tenga el n�mero de oficina mayor. */

SELECT * 
    FROM OFICINAS
    ORDER BY REGION ASC, CIUDAD ASC, IDOFICINA DESC;


/*5.- Obtener los pedidos ordenados por fecha de pedido y
los que tengan la misma fecha por identificativo de empleado en orden ascendente.*/
SELECT *
    FROM PEDIDOS 
    ORDER BY FPEDIDO DESC, IDVENDEDOR ASC;


/*6.- Mostrar un listado de toda la informaci�n de los pedidos realizados en mayo de cualquier a�o.*/ 
SELECT * 
    FROM PEDIDOS
    WHERE EXTRACT(MONTH FROM fpedido)=05
    ORDER BY FPEDIDO DESC;

/*7.- Mostrar un listado de los n�meros de los empleados que tienen una oficina asignada. Que no tengan valor null*/ 
SELECT IDEMPLEADO
    FROM EMPLEADOS
    WHERE idoficina IS NOT NULL;

/*8.- Mostrar un listado de los n�meros de las oficinas que no tienen director. */
SELECT IDOFICINA
    FROM OFICINAS
    WHERE director IS NOT NULL;

/*9.- Mostrar un listado de los datos de las oficinas de las regiones del norte y del este
(tienen que aparecer primero las del norte y despu�s las del este).*/

SELECT *
    FROM OFICINAS
    WHERE UPPER(region) in ('NORTE','ESTE')
    ORDER BY REGION DESC;
/*10.- Mostrar un listado de los empleados de nombre �Maria�. */
SELECT IDEMPLEADO, NOMBRE
    FROM EMPLEADOS
    WHERE UPPER(nombre) LIKE 'MARIA %';

/*11.- Mostrar un listado de los productos cuya descripci�n sea manteles de color verde
(mirad como aparecen los valores). */

SELECT * FROM PRODUCTOS
    WHERE UPPER(DESCRIPCION) LIKE 'MANTEL % VERDE';

/*12.- Mostrar un listado de los datos de todos los empleados que sean comerciales
y les corresponda la oficina 12.*/

SELECT * 
    FROM EMPLEADOS
    WHERE UPPER (PUESTO) LIKE '%COMERCIAL' AND IDOFICINA = 12; 

/*13.- Mostrar un listado de nombres de los empleados con una cuota mayor de 300.000
y ventas mayores que 300.000.*/

SELECT NOMBRE, VENTAS, CUOTA
    FROM EMPLEADOS
    WHERE CUOTA > 300000 AND VENTAS > 300000;

/*14.- Obtener los nombres de los empleados que no tengan asignada ninguna oficina.*/
SELECT * 
    FROM EMPLEADOS
    WHERE IDOFICINA IS NULL;
/*15.- Obtener los datos de las oficinas que tengan asignado un director.*/
SELECT *
    FROM OFICINAS
    WHERE DIRECTOR IS NOT NULL;
/*16.- Mostrar toda la informaci�n de las oficinas de Madrid.*/
SELECT * 
    FROM OFICINAS
    WHERE UPPER(CIUDAD)='MADRID';
/*17.- Mostrar los datos de las 10oficinas que no tengan asignado un objetivo o ventas
o que lo tengan asignado a 0.*/
SELECT *
    FROM OFICINAS 
    WHERE OBJETIVO IS NULL OR OBJETIVO = 0 OR VENTAS IS NULL OR VENTAS = 0
    ORDER BY OBJETIVO ASC;
/*18.- Mostrar los datos de los clientes ordenados por fecha de alta 
de m�s nueva a m�s antigua a menor. Si hubiese clientes con la misma fecha de alta
aparecer�n ordenados por nombre en orde ascendente.*/
SELECT IDCLIENTE, NOMBRE, FALTA
    FROM CLIENTES
    ORDER BY FALTA DESC, NOMBRE ASC;
/*19.- Mostrar los productos con existencias 0.*/
SELECT *
    FROM PRODUCTOS
    WHERE STOCK = 0;
/*20.- Mostrar los campos idproducto, descripci�n y fabricante de los productos
cuyo fabricante sea �asa�, �bra� o �duni�, ordenados por fabricante.*/
SELECT IDPRODUCTO, DESCRIPCION, IDFABRICANTE
    FROM PRODUCTOS
    WHERE IDFABRICANTE IN ('asa','bra','duni')
    ORDER BY IDFABRICANTE ASC;
/*21.- Mostrar todos los pedidos de mayo del a�o 1999.*/
SELECT * 
    FROM PEDIDOS
    WHERE EXTRACT(YEAR FROM fpedido)=1999 AND EXTRACT(MONTH FROM fpedido)=05
    ORDER BY FPEDIDO DESC;
/*22.- Mostrar las oficinas cuyas ventas superen en un 10% los objetivos.*/
SELECT * 
    FROM OFICINAS
    WHERE VENTAS > OBJETIVO *1.10;
/*23.- Mostrar los datos de los productos cuyo idproducto acabe en �mg�.*/
SELECT *
    FROM PRODUCTOS
    WHERE UPPER (IDPRODUCTO) LIKE '%MG';
/*24.- Mostrar los pedidos del segundo semestre.*/
SELECT * 
    FROM PEDIDOS
    WHERE EXTRACT(MONTH FROM FPEDIDO) BETWEEN 07 AND 12
    ORDER BY FPEDIDO DESC;
/*25.- Mostrar los datos de los empleados que sean directores.*/
SELECT *
    FROM EMPLEADOS
    WHERE UPPER(PUESTO) LIKE 'DIRECTOR%'
    ORDER BY IDEMPLEADO ASC;
/*26.- Debemos mostrar de la tabla de empleados a todos los empleados con sus ventas
con el siguiente formato:
            El �titulo�.. ��nombre�.. ha sido contratado el 99/99/9999 .*/
SELECT 'El ' || PUESTO || ' ' || NOMBRE ||' HA SIDO CONTRATADO EL ' || FCONTRATO
    FROM EMPLEADOS;

