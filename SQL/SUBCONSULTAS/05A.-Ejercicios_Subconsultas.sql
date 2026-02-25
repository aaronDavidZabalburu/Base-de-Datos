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
    WHERE LOWER(puesto) LIKE 'comercial%' AND EXISTS ( 
        SELECT OBJETIVO, VENTAS FROM OFICINAS o
            WHERE e.IDOFICINA = o.IDOFICINA AND
            OBJETIVO < VENTAS);
            
SELECT e.IDEMPLEADO, e.NOMBRE, e.IDOFICINA FROM EMPLEADOS e
    JOIN OFICINAS o ON e.IDOFICINA = o.IDOFICINA WHERE LOWER(e.puesto) LIKE 'comercial%'
    AND o.OBJETIVO < o.VENTAS;
/*3.- Listar los vendedores que no trabajan en oficinas dirigidas por el empleado Jose Miguel Estrella Lopez.*/


/*4.- Listar los productos (idfab, idproducto y descripci�n) que aparecen en pedidos de m�s de 25000� o m�s.*/

/*5.- Listar los clientes asignados a Maria Bego�a Se�or Se�or que han remitido un pedido superior a 3000 �. 
�Y los que no han remitido un pedido superior a 3000�?*/

/*6.- Listar las oficinas en donde haya un vendedor cuyas ventas representen m�s del 55% del objetivo de su oficina.*/

/*7.- Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% del objetivo de la oficina.*/

/*8.- Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus vendedores.*/