/*Ejercicios Consultas Multitabla*/
/*1.- Listar las oficinas del este indicando para cada una de ellas su n�mero, ciudad, n�meros y nombres de sus empleados.*/
SELECT  o.idoficina, o.region, o.ciudad, e.idempleado, e.nombre 
FROM OFICINAS o, EMPLEADOS e
WHERE e.idoficina = o.idoficina AND 
    LOWER(o.region)= 'este';
    
/*2.- Listar los pedidos mostrando su n�mero, importe, c�digo y nombre del cliente, su fecha de alta.*/
SELECT lp.codigo, SUM(lp.punitario*lp.cantidad), c.idcliente, c.nombre, c.falta  
 FROM LINEAS_PEDIDOS lp, CLIENTES c, PEDIDOS p
 WHERE lp.codigo = p.codigo AND
        p.idcliente = c.idcliente
GROUP BY  lp.codigo, c.idcliente, c.nombre, c.falta ;
/*3.- Listar los datos de cada uno de los empleados, la ciudad y regi�n en donde trabaja.*/
SELECT e.*, o.ciudad, o.region
FROM EMPLEADOS e, OFICINAS o
WHERE e.idoficina = o.idoficina;

SELECT * FROM EMPLEADOS;
SELECT * FROM OFICINAS;

/*4.- Listar las oficinas con objetivo superior a 590.000 � indicando para cada una de ellas el nombre de su director. */
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT o.*, e.nombre, o.objetivo
FROM OFICINAS o, EMPLEADOS e
WHERE e.idoficina = o.idoficina AND
objetivo > 590000;

/*5.- Listar los pedidos con importe superior a 10000�. Se mostrar�n los c�digos y n�meros de pedidos, junto con su importe.*/
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT p.codigo, p.numpedido, SUM(lp.punitario*lp.cantidad) 
FROM PEDIDOS p, LINEAS_PEDIDOS lp
WHERE p.codigo = lp.codigo
GROUP BY p.codigo, p.numpedido
HAVING SUM(lp.punitario*lp.cantidad) > 10000;

/*Posteriormente se incluir� el nombre del empleado que tom� el pedido y el nombre del cliente que lo solicit�.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM CLIENTES;
SELECT * FROM PEDIDOS;

SELECT p.codigo, p.numpedido, SUM(lp.punitario*lp.cantidad), e.nombre, c.nombre 
FROM PEDIDOS p, LINEAS_PEDIDOS lp, CLIENTES c, EMPLEADOS e
WHERE p.codigo = lp.codigo AND
e.idempleado = p.idvendedor AND
c.idcliente = p.idcliente
GROUP BY p.codigo, p.numpedido,e.nombre, c.nombre 
HAVING SUM(lp.punitario*lp.cantidad) > 10000;
/*6.- Listar los empleados que realizaron sus primeros pedidos el d�a que fueron contratados. Mostrar el nombre del empleado,
fecha de contrato, c�digo e importe de esos pedidos.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;
SELECT * FROM CLIENTES;
SELECT * FROM LINEAS_PEDIDOS;

SELECT e.nombre, e.fcontrato, p.codigo, SUM(lp.punitario*lp.cantidad) 
FROM EMPLEADOS e, PEDIDOS p, LINEAS_PEDIDOS lp
WHERE e.idempleado = p.idvendedor AND 
lp.codigo = p.codigo AND
p.fpedido = e.fcontrato
GROUP BY e.nombre, e.fcontrato, p.codigo;
/*7.- Listar los empleados con una cuota superior a la de su jefe; para cada empleado mostrar todos sus datos
y el n�mero, nombre y cuota de su jefe.*/

SELECT * FROM EMPLEADOS;

SELECT e.*, j.idempleado, j.nombre, j.cuota
FROM EMPLEADOS e, EMPLEADOS j
WHERE e.jefe = j.idempleado AND 
e.cuota > j.cuota;

/*8.- Listar todos los pedidos en los que se hayan comprado cucharas o cuchillos. 
Debemos mostrar el n�mero de pedido, la cantidad e importe de las l�neas de pedido que las contengan 
el fabricante y la descripci�n del producto.*/

SELECT * FROM PRODUCTOS;
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT p.numpedido, lp.cantidad, (lp.punitario*lp.cantidad) || ' €' AS "IMPORTE", pr.idfabricante, pr.descripcion
FROM PRODUCTOS pr, PEDIDOS p, LINEAS_PEDIDOS lp
WHERE pr.idfabricante = lp.fabricante 
  AND p.codigo = lp.codigo
  AND pr.idproducto = lp.producto
  AND (LOWER(pr.descripcion) LIKE '%cuchara%' OR LOWER (pr.descripcion) LIKE '%cuchillo%')
  GROUP BY  p.numpedido, lp.cantidad,(lp.punitario*lp.cantidad), pr.idfabricante, pr.descripcion ;



/*9.- Listar el n�mero de pedidos e importe de los mismos que cada empleado ha realizado a cada cliente.
Se mostrar� el n�mero y nombre del cliente, el n�mero y nombre del empleado, la cantidad de pedidos y el importe del pedido.*/

SELECT 
    c.idcliente, c.nombre AS "Cliente", e.idempleado, e.nombre AS "Empleado", COUNT(DISTINCT p.codigo) AS "Cant_Pedidos", SUM(lp.punitario * lp.cantidad) AS "Importe_Total"
FROM CLIENTES c, EMPLEADOS e, PEDIDOS p, LINEAS_PEDIDOS lp
WHERE c.idcliente = p.idcliente 
  AND e.idempleado = p.idvendedor
  AND p.codigo = lp.codigo
GROUP BY c.idcliente, c.nombre, e.idempleado, e.nombre;

/*10.- Listar el n�mero de oficinas que dirige cada uno de los empleados. */
SELECT * FROM OFICINAS;

SELECT e.idempleado, e.nombre, COUNT(o.idoficina) AS "Oficinas_Dirigidas"
FROM EMPLEADOS e, OFICINAS o
WHERE e.idempleado = o.director
GROUP BY e.idempleado, e.nombre;
/*Listar el n�mero de oficinas que tengan ventas que dirige cada uno de los empleados.*/ 

SELECT e.idempleado, e.nombre, COUNT(o.idoficina) AS "Oficinas_Con_Ventas"
FROM EMPLEADOS e, OFICINAS o
WHERE e.idempleado = o.director
  AND o.ventas > 0
GROUP BY e.idempleado, e.nombre;
