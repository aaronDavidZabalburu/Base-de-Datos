/*Ejercicios Consultas JOIN*/
/*1.- Listar las oficinas del este indicando para cada una de ellas su n�mero, 
ciudad, n�meros y nombres de sus empleados.Mostrar todas las oficinas aunque no tengan 
empleados asignados*/

SELECT  o.idoficina, o.region, o.ciudad, e.idempleado, e.nombre 
FROM oficinas o LEFT JOIN empleados e ON  e.idoficina = o.idoficina 
WHERE LOWER(o.region)= 'este'
order by 1;


/*2.- Listar los pedidos mostrando su n�mero, 
importe, c�digo y nombre del cliente,
su fecha de alta.*/

SELECT lp.codigo, SUM(lp.punitario*lp.cantidad) || ' €' AS "IMPORTE" , c.idcliente, c.nombre, c.falta  
    FROM LINEAS_PEDIDOS lp JOIN PEDIDOS p ON lp.codigo = p.codigo
    JOIN CLIENTES c ON c.idcliente = p.idcliente
    GROUP BY lp.codigo, c.idcliente, c.nombre, c.falta;

/*3.- Listar los datos de cada uno de los empleados, 
la ciudad y regi�n en donde trabaja.
Mostrar todos los empleados aunque no tengan oficina asignada.*/

SELECT e.*, o.ciudad, o.region
     FROM OFICINAS o RIGHT JOIN EMPLEADOS e --O FULL JOIN
     ON e.idoficina = o.idoficina
     ORDER BY idempleado;

/*4.- Listar las oficinas con objetivo superior a 590.000 �
indicando para cada una de ellas el nombre de su director. Mostrar todas las oficinas
aunque no tengan director asignado.*/

SELECT o.*, e.nombre AS "NOMBRE DIRECTOR"
    FROM OFICINAS o LEFT JOIN EMPLEADOS e 
    ON o.director = e.idempleado
    WHERE o.objetivo > 590000;

/*5.- Listar los pedidos con importe superior a 10000�. 
Se mostrar�n los c�digos y n�meros de pedidos, junto con su importe.*/

SELECT p.codigo, p.numpedido, SUM(lp.punitario*lp.cantidad) || ' €' AS "IMPORTE"
    FROM PEDIDOS p JOIN LINEAS_PEDIDOS lp
    on p.codigo = lp.codigo
    GROUP BY p.codigo, p.numpedido
    HAVING SUM(lp.punitario*lp.cantidad) > 10000;

/*Posteriormente se incluir� el nombre del empleado que tom� el pedido 
y el nombre del cliente que lo solicit�.*/


SELECT p.codigo, p.numpedido, SUM(lp.punitario*lp.cantidad) || ' €' AS "IMPORTE", c.nombre AS "CLIENTE" , e.nombre AS "EMPLEADO" 
    FROM PEDIDOS p JOIN LINEAS_PEDIDOS lp
    on p.codigo = lp.codigo
    JOIN CLIENTES c on c.idcliente = p.idcliente
    JOIN EMPLEADOS e on e.idempleado = p.idvendedor
    GROUP BY p.codigo, p.numpedido, c.nombre, e.nombre 
    HAVING SUM(lp.punitario*lp.cantidad) > 10000;

/*6.- Listar los empleados que realizaron sus primeros pedidos el d�a que fueron contratados. Mostrar el nombre del empleado,
fecha de contrato, c�digo e importe de esos pedidos.*/
SELECT e.nombre, e.fcontrato AS "FECHA CONTRATO", p.fpedido AS "FECHA PEDIDO", p.codigo, SUM(lp.punitario*lp.cantidad) || ' €' AS "IMPORTE"
    FROM EMPLEADOS e JOIN PEDIDOS p
    ON e.idempleado = p.idvendedor
    JOIN LINEAS_PEDIDOS lp ON p.codigo = lp.codigo
    WHERE p.fpedido = e.fcontrato
    GROUP BY e.nombre, e.fcontrato, p.fpedido, p.codigo;

/*7.- Listar los empleados con una cuota superior a la de su jefe;
para cada empleado mostrar todos sus datos
y el n�mero, nombre y cuota de su jefe. Mostrar todos los empleados independientemente de si
tienen jefe o no.*/

SELECT e.*, j.idempleado AS "ID JEFE", j.nombre AS "NOMBRE DEL JEFE", j.cuota AS "CUOTA DEL JEFE"
    FROM EMPLEADOS e LEFT JOIN EMPLEADOS j
    ON e.jefe = j.idempleado
    WHERE (e.cuota > j.cuota OR e.cuota IS NULL);

/*8.- Listar todos los pedidos en los que se hayan comprado cucharas o cuchillos. 
Debemos mostrar el n�mero de pedido, la cantidad e importe de las l�neas de pedido que las contengan 
el fabricante y la descripci�n del producto.*/

SELECT p.numpedido, lp.cantidad, (lp.punitario*lp.cantidad) || ' €' AS "IMPORTE", pr.idfabricante, pr.descripcion
    FROM PRODUCTOS pr JOIN LINEAS_PEDIDOS lp 
    ON pr.idfabricante = lp.fabricante AND pr.idproducto = lp.producto 
    JOIN PEDIDOS p on p.codigo = lp.codigo
    WHERE (LOWER(pr.descripcion) LIKE '%cuchara%' OR LOWER (pr.descripcion) LIKE '%cuchillo%');

/*9.- Listar el n�mero de pedidos e importe de los mismos que cada empleado ha realizado a cada cliente.
Se mostrar� el n�mero y nombre del cliente, el n�mero y nombre del empleado, la cantidad de pedidos y el importe del pedido.*/

SELECT c.idcliente, c.nombre AS "Cliente", e.idempleado, e.nombre AS "Empleado", COUNT(DISTINCT p.codigo) AS "Cant_Pedidos", SUM(lp.punitario * lp.cantidad) || ' €' AS "Importe_Total"
    FROM PEDIDOS p JOIN LINEAS_PEDIDOS lp
    ON p.codigo = lp.codigo JOIN CLIENTES c 
    ON c.idcliente = p.idcliente JOIN EMPLEADOS e 
    ON e.idempleado = p.idvendedor
    GROUP BY c.idcliente, c.nombre, e.idempleado, e.nombre
    ORDER BY idcliente;

/*10.- Listar el n�mero de oficinas con su ciudad y region
que dirige cada uno de los empleados mostrando su n�mero,nombre y fecha de contrato.
Mostrar los datos de los empleados aunque no dirijan oficinas */
SELECT e.idempleado, e.nombre, e.fcontrato, COUNT(o.idoficina) AS "Oficinas_Dirigidas" , o.ciudad, o.region
    FROM EMPLEADOS e LEFT JOIN OFICINAS o 
    ON e.idempleado = o.director
    GROUP BY e.idempleado, e.nombre, e.fcontrato, o.ciudad, o.region
    ORDER BY 4  DESC;


/*Listar el n�mero de oficinas que tengan ventas que dirige cada uno de los empleados.*/ 

SELECT e.idempleado, e.nombre, e.fcontrato, COUNT(o.idoficina) AS "Oficinas_Dirigidas" , o.ciudad, o.region
    FROM EMPLEADOS e LEFT JOIN OFICINAS o 
    ON e.idempleado = o.director AND o.ventas > 0
    GROUP BY e.idempleado, e.nombre, e.fcontrato, o.ciudad, o.region
    ORDER BY "Oficinas_Dirigidas"  DESC;
