/*EXAMEN TIPO DML-QL-Consultas*/

/*1.- Mostrar todos los empleados que son comerciales y han nacido entre 1965 y 1975. Mostrar el nombre y sus ventas. */
select * from empleados;

Select nombre, ventas || ' €' from empleados
where lower(puesto) = 'comercial' 
and EXTRACT(YEAR FROM fnacimiento) BETWEEN  1965 and 1975;


/*2.- Mostrar cuantos empleados trabajan en oficinas de Madrid.*/
select * from oficinas;

select count(*) 
from empleados e JOIN OFICINAS o ON e.idoficina = o.idoficina
where lower(ciudad) = 'madrid';

/*3.- Mostrar los nombres de los empleados que no han realizado ning�n pedido. */
select * from pedidos
order by idvendedor;

select e.idempleado, e.nombre from empleados e
where e.idempleado NOT IN (SELECT idvendedor from pedidos);

/*4.- Mostrar el n�mero de oficina, nombre del director, regi�n y ventas de las oficinas ordenadas por su regi�n. 
Si tienen igual regi�n aparecer�n primero las que m�s ventas tengan. */

SELECT o.idoficina, e.nombre, o.region, o.ventas
FROM OFICINAS o JOIN EMPLEADOS e ON e.idempleado = o.director
ORDER BY region asc, ventas desc;

/*4B.- Si quiero que aparezcan todas las oficinas independientemente de que tengan director o no �C�mo lo har�amos? */

SELECT o.idoficina, e.nombre, o.region, o.ventas
FROM OFICINAS o LEFT JOIN EMPLEADOS e ON e.idempleado = o.director
ORDER BY region asc, ventas desc;

/*5.- Mostrar todos los pedidos que han sido realizados en Julio del a�o 1997. Mostrad todos los datos de pedidos. */

SELECT * FROM PEDIDOS
WHERE extract(MONTH FROM FPEDIDO) = 5
AND EXTRACT(YEAR FROM FPEDIDO) = 1997;

/*6.- Mostrar de cada pedido, el nombre del cliente, nombre del empleado, fecha del pedido en formato largo
(p ej: mi�rcoles, 6 de enero de 2018), descripci�n del producto e importe de sus pedidos. */

SELECT c.nombre "CLIENTE", e.NOMBRE "EMPLEADO", TO_CHAR(p.fpedido, 'day, DD "de" MONTH "de" YYYY')"FECHA", lp.punitario * lp.cantidad || '€'"IMPORTE", pr.descripcion "DESCRIPCION"
FROM PEDIDOS p
JOIN CLIENTES c ON p.idcliente = c.idcliente 
JOIN EMPLEADOS e ON e.idempleado = p.idvendedor
JOIN LINEAS_PEDIDOS lp ON p.codigo = lp.codigo
JOIN PRODUCTOS pr ON lp.fabricante = pr.idfabricante AND lp.producto = pr.idproducto;

SELECT CODIGO, TO_CHAR(fpedido, 'day, DD "de" MONTH "de" YYYY') FROM PEDIDOS;


/*7.- Mostrar de cada empleado: el correo electr�nico que ser� un campo que se forme por la inicial del nombre 
seguida del primer apellido y del segundo apellido. Tras esto aparecer� �@zabalburu.org� y su fecha de contrato.
Por ejemplo para Alfonso Garcia Jimenez su correo ser� agarciajimenez@zabalburu.org.*/

SELECT nombre,LOWER(SUBSTR(nombre,1,1) 
|| SUBSTR(nombre,INSTR(nombre,' ')+1,INSTR(nombre,' ',1,2)-INSTR(nombre,' ')-1)
|| SUBSTR(nombre,INSTR(nombre,' ',1,2)+1) || '@zabalburu.org') "EMAIL", Fcontrato FROM empleados;


/*8.- Mostrar el nombre de los empleados, nombre de sus jefes, sus ventas y las de sus jefes.
En el listado deben aparecer todos los empleados, tanto si tienen, jefe, como si no. */

SELECT * fROM EMPLEADOS;

SELECT emp.nombre "EMPLEADO", emp.ventas, jefe.nombre "JEFE" , jefe.ventas
FROM EMPLEADOS emp LEFT JOIN EMPLEADOS jefe ON  emp.jefe = jefe.idempleado; 


/*9.- Listar los empleados con una cuota superior a la de su jefe; Solo queremos saber el nombre
y la cuota del empleado. */

SELECT emp.nombre, emp.cuota 
FROM EMPLEADOS emp JOIN EMPLEADOS jefe ON emp.jefe = jefe.idempleado
WHERE emp.cuota > jefe.cuota;

/*10.- Hallar el empleado que hizo el primer pedido en la empresa. Mostrad nombre del empleado,
fecha de pedido, a�os que han pasado. */

SELECT e.nombre, p.fpedido, TRUNC(MONTHS_BETWEEN(sysdate,p.fpedido)/12) "AÑOS QUE HAN PASADO"
FROM EMPLEADOS e
JOIN PEDIDOS p ON e.idempleado = p.idvendedor
WHERE p.fpedido = (select MIN(fpedido) from pedidos);

select MIN(fpedido) from pedidos;

/*11.- Por cada fabricante, mostrar cuantos productos tiene, el precio medio de sus productos (redondeados a 2 decimales),
el precio m�s barato y el precio m�s caro. Los campos de precios deben aparecer con dos decimales y el s�mbolo del euro por detr�s.
*/

SELECT idfabricante, COUNT(*), ROUND(AVG(punitario), 2) || '€' "PRECIO MEDIO", MIN(punitario)|| '€'  "MAS BARATO" , MAX(punitario) || '€' "MAS CARO"
from productos 
group by idfabricante;

/*11B.- De la pregunta anterior solo mostrar aquellos fabricantes cuyo precio m�s alto sea m�s del doble de la media del precio
de sus productos.*/

SELECT idfabricante, COUNT(*), ROUND(AVG(punitario), 2) || '€' "PRECIO MEDIO", MIN(punitario)|| '€'  "MAS BARATO" , MAX(punitario) || '€' "MAS CARO"
from productos 
group by idfabricante
HAVING MAX(punitario) > ROUND(AVG(punitario), 2) * 2;

/*12.- Listar la oficina que tenga un objetivo mayor de las que tienen director. 
Se deben mostrar los campos de n�mero de oficina, nombre del director, objetivo y 
un objetivo para el a�o que viene que ser� el objetivo incrementado en un 5%. 
A este nuevo campo lo vamos a denominar Objetivo 2021. */


SELECT o.* FROM OFICINAS o
WHERE o.DIRECTOR IS NOT NULL;

SELECT MAX(OBJETIVO)
FROM OFICINAS
WHERE DIRECTOR IS NOT NULL;

SELECT objetivo * 1.05 FROM OFICINAS;

SELECT o.idoficina, e.nombre "DIRECTOR", o.objetivo,
objetivo * 1.05 "Objetivo 2021"
FROM OFICINAS o JOIN EMPLEADOS e ON o.director = e.idempleado
Where o.director is not null 
AND o.objetivo = (SELECT MAX(OBJETIVO) FROM OFICINAS WHERE DIRECTOR is not null);


/*13.- Mostrar por cada cliente su nombre, fecha de sus pedidos, y calcular la fecha en la que ha sido enviado, 
calcul�ndose esta de la siguiente forma:

Si el pedido es inferior a 5000 se env�a en 15 d�as.
Si el pedido es superior a 5000 e inferior a 15000 se env�a en 10 d�as.
Si el pedido es superior a 15000 e inferior a 30000 se env�a en 5 d�as.
Si el pedido es superior a 30000 se env�a al d�a siguiente.

Tanto la fecha del pedido como la fecha del env�o debe ser mostrada con el siguiente formato:
d�a de mes de a�o (por ejemplo: 7 de marzo de 2012).
*/

SELECT c.NOMBRE, TO_CHAR(p.fpedido, 'day, DD "de" MONTH "de" YYYY')"FECHA de pedidos",
TO_CHAR(
CASE 
    WHEN SUM(lp.punitario * lp.cantidad) < 5000 THEN p.fpedido + 15
    WHEN SUM(lp.punitario * lp.cantidad) BETWEEN 5000 AND 15000 THEN p.fpedido + 10
    WHEN SUM(lp.punitario * lp.cantidad) BETWEEN 15000 AND 30000 THEN p.fpedido + 5
    WHEN SUM(lp.punitario * lp.cantidad) > 30000 THEN  p.fpedido + 1
    END, 'DD "de" MONTH "de" YYYY')"FECHA ENVIO"
FROM PEDIDOS p 
JOIN CLIENTES c ON c.idcliente = p.idcliente
JOIN LINEAS_PEDIDOS lp ON p.codigo = lp.codigo
group by c.nombre, p.fpedido;

/*14.- Mostrar por cada producto (identificado por su fabricante y producto) su descripci�n, precio unitario y
mostrar un campo m�s denominado cantidad de ventas que muestre un texto dependiendo de la cantidad total
que de ese producto ha sido vendido a los clientes en el a�o 2001, si es inferior a 10 mostraremos �poco vendido�,
si est� entre 10 y 50 mostraremos �NOTABLE�, si es superior a 50 mostraremos �MUY VENDIDO�.
*/

SELECT pr.IDFABRICANTE, pr.IDPRODUCTO, pr.descripcion, pr.punitario, 
CASE 
    WHEN SUM(cantidad) < 10 THEN 'Poco Vendido'
    WHEN SUM(cantidad) between 10 and 50 THEN 'NOTABLE'
    when SUM(cantidad) > 50 THEN 'MUY VENDIDO'
    END "CANTIDAD VENTAS"
FROM PRODUCTOS pr
JOIN LINEAS_PEDIDOS lp ON pr.idfabricante = lp.fabricante AND pr.idproducto = lp.producto
JOIN PEDIDOS p ON lp.codigo = p.codigo
WHERE EXTRACT(YEAR FROM p.FPEDIDO) = 2001
GROUP BY pr.IDFABRICANTE, pr.IDPRODUCTO, pr.descripcion, pr.punitario;







