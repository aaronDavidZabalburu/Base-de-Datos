/*EJERCICIOS SUBCONSULTAS*/
/*1.- Listar los nombres de los clientes que tienen asignada a la representante Luisa Sala Alfonte�a 
(suponiendo que no puede haber representantes con el mismo nombre).*/

SELECT c.nombre 
FROM CLIENTES c
WHERE REPRESENTANTE IN ( 
    SELECT e.IDEMPLEADO 
    FROM EMPLEADOS e
    WHERE LOWER(nombre)LIKE 'luisa sala %');

/*Mostrar todos los empleados que no act�an como representantes de clientes.*/
SELECT * 
FROM EMPLEADOS 
WHERE IDEMPLEADO NOT IN ( 
    SELECT REPRESENTANTE 
    FROM CLIENTES)
ORDER BY IDEMPLEADO;

/*2.- Listar los vendedores (numemp, nombre, y n� de oficina) que trabajan en oficinas "buenas" 
(las que tienen ventas superiores a su objetivo).*/

SELECT IDEMPLEADO, NOMBRE, IDOFICINA FROM EMPLEADOS e
    WHERE LOWER(puesto) LIKE 'comercial%' 
        AND EXISTS ( 
                    SELECT OBJETIVO, VENTAS FROM OFICINAS o
                        WHERE e.IDOFICINA = o.IDOFICINA AND
                        OBJETIVO < VENTAS);
            
/*3.- Listar los vendedores que no trabajan en oficinas dirigidas por el empleado Miguel Estrella Lopez.*/
SELECT IDEMPLEADO, NOMBRE, IDOFICINA 
    FROM EMPLEADOS
    WHERE LOWER(PUESTO) LIKE 'comercial%'
    AND IDOFICINA NOT IN (
                SELECT IDOFICINA 
                    FROM OFICINAS
                        WHERE DIRECTOR = (
                            SELECT IDEMPLEADO 
                            FROM EMPLEADOS 
                            WHERE LOWER(NOMBRE) LIKE 'miguel estrella%'));

/*4.- Listar los productos (idfab, idproducto y descripci�n) que aparecen en pedidos de m�s de 25000� o m�s.*/
SELECT IDFABRICANTE, IDPRODUCTO, DESCRIPCION
FROM PRODUCTOS
WHERE (IDFABRICANTE, IDPRODUCTO) IN (
    SELECT FABRICANTE, PRODUCTO
    FROM LINEAS_PEDIDOS
    GROUP BY FABRICANTE, PRODUCTO
    HAVING SUM(PUNITARIO * CANTIDAD) >= 25000);
    
SELECT DISTINCT IDFABRICANTE, IDPRODUCTO, DESCRIPCION
FROM PRODUCTOS
WHERE (IDFABRICANTE, IDPRODUCTO) IN (
    SELECT FABRICANTE, PRODUCTO
    FROM LINEAS_PEDIDOS
    WHERE CODIGO IN (
        SELECT CODIGO
        FROM LINEAS_PEDIDOS
        GROUP BY CODIGO
        HAVING SUM(PUNITARIO * CANTIDAD) >= 25000
    )
);

/*5.- Listar los clientes asignados a Maria Bego�a Se�or Se�or que han remitido un pedido superior a 3000 �. 
�Y los que no han remitido un pedido superior a 3000�?*/
SELECT NOMBRE 
FROM CLIENTES
WHERE REPRESENTANTE IN (
    SELECT IDEMPLEADO FROM EMPLEADOS 
    WHERE LOWER(NOMBRE) LIKE 'bego%se%or se%or%'
)AND IDCLIENTE IN (
    SELECT p.IDCLIENTE
    FROM PEDIDOS p
    JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
    GROUP BY p.IDCLIENTE, p.CODIGO
    HAVING SUM(lp.PUNITARIO * lp.CANTIDAD) > 3000);
    
SELECT NOMBRE 
FROM CLIENTES
WHERE REPRESENTANTE IN (
    SELECT IDEMPLEADO FROM EMPLEADOS 
    WHERE LOWER(NOMBRE) LIKE 'bego%se%or se%or%'
)AND IDCLIENTE NOT IN (
    SELECT p.IDCLIENTE
    FROM PEDIDOS p
    JOIN LINEAS_PEDIDOS lp ON p.CODIGO = lp.CODIGO
    GROUP BY p.IDCLIENTE, p.CODIGO
    HAVING SUM(lp.PUNITARIO * lp.CANTIDAD) > 3000);
        
/*6.- Listar las oficinas en donde haya un vendedor cuyas ventas representen m�s del 55% del objetivo de su oficina.*/
SELECT IDOFICINA, CIUDAD
FROM OFICINAS o
WHERE EXISTS (
    SELECT * FROM EMPLEADOS e
    WHERE e.IDOFICINA = o.IDOFICINA
    AND LOWER(e.PUESTO) LIKE 'comercial%'
    AND e.VENTAS > o.OBJETIVO * 0.55);
/*7.- Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% del objetivo de la oficina.*/
SELECT IDOFICINA, CIUDAD
FROM OFICINAS o
WHERE NOT EXISTS (
    SELECT * 
    FROM EMPLEADOS e
    WHERE e.IDOFICINA = o.IDOFICINA
    AND LOWER(e.PUESTO) LIKE 'comercial%'
    AND e.VENTAS <= o.OBJETIVO * 0.50);
/*8.- Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus vendedores.*/

SELECT IDOFICINA, CIUDAD, OBJETIVO
FROM OFICINAS o
WHERE OBJETIVO > (
    SELECT SUM(CUOTA)
    FROM EMPLEADOS e
    WHERE e.IDOFICINA = o.IDOFICINA
    AND LOWER(e.PUESTO) LIKE 'comercial%');