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



/*5.- Obtener los pedidos ordenados por fecha de pedido y
los que tengan la misma fecha por identificativo de empleado en orden ascendente.*/

/*6.- Mostrar un listado de toda la informaci�n de los pedidos realizados en mayo de cualquier a�o.*/ 

/*7.- Mostrar un listado de los n�meros de los empleados que tienen una oficina asignada.*/ 

/*8.- Mostrar un listado de los n�meros de las oficinas que no tienen director. */

/*9.- Mostrar un listado de los datos de las oficinas de las regiones del norte y del este
(tienen que aparecer primero las del norte y despu�s las del este).*/

/*10.- Mostrar un listado de los empleados de nombre �Maria�. */

/*11.- Mostrar un listado de los productos cuya descripci�n sea manteles de color verde
(mirad como aparecen los valores). */

/*12.- Mostrar un listado de los datos de todos los empleados que sean comerciales
y les corresponda la oficina 12.*/

/*13.- Mostrar un listado de nombres de los empleados con una cuota mayor de 300.000
y ventas mayores que 300.000.*/

/*14.- Obtener los nombres de los empleados que no tengan asignada ninguna oficina.*/

/*15.- Obtener los datos de las oficinas que tengan asignado un director.*/

/*16.- Mostrar toda la informaci�n de las oficinas de Madrid.*/

/*17.- Mostrar los datos de las oficinas que no tengan asignado un objetivo o ventas
o que lo tengan asignado a 0.*/

/*18.- Mostrar los datos de los clientes ordenados por fecha de alta 
de m�s nueva a m�s antigua a menor. Si hubiese clientes con la misma fecha de alta
aparecer�n ordenados por nombre en orde ascendente.*/

/*19.- Mostrar los productos con existencias 0.*/

/*20.- Mostrar los campos idproducto, descripci�n y fabricante de los productos
cuyo fabricante sea �asa�, �bra� o �duni�, ordenados por fabricante.*/

/*21.- Mostrar todos los pedidos de mayo del a�o 1999.*/

/*22.- Mostrar las oficinas cuyas ventas superen en un 10% los objetivos.*/

/*23.- Mostrar los datos de los productos cuyo idproducto acabe en �mg�.*/

/*24.- Mostrar los pedidos del segundo semestre.*/

/*25.- Mostrar los datos de los empleados que sean directores.*/

/*26.- Debemos mostrar de la tabla de empleados a todos los empleados con sus ventas
con el siguiente formato:
            El �titulo�.. ��nombre�.. ha sido contratado el 99/99/9999 .*/
