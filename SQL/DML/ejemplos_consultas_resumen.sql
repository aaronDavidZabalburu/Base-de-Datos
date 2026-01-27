/* --- CONSULTAS DE AGREGACIÓN BÁSICA --- */

-- Calcula el precio unitario medio de los productos del fabricante 'asa', truncado a 2 decimales
SELECT TRUNC(AVG(punitario),2) "MEDIA PRECIO PRODUCTOS" 
    FROM productos
    WHERE LOWER(idfabricante) = 'asa'; 

-- Obtiene la fecha de contratación más antigua de la tabla empleados
SELECT MIN(fcontrato) "Fecha Primer Empleado"
    FROM empleados;
    
-- Cuenta cuántas oficinas pertenecen a la región 'este'
SELECT COUNT(region) "Nº OFICINAS ESTE"
    FROM OFICINAS
    WHERE LOWER(region) = 'este';
    
-- Cuenta oficinas de la región 'este' cuyo volumen de ventas supera los 300,000
SELECT COUNT(region) "Nº OFICINAS ESTE VENTAS > 300000"
    FROM OFICINAS
    WHERE LOWER(region) = 'este' AND ventas > 300000;
    
-- Muestra el precio unitario mínimo y máximo de todas las líneas de pedidos
SELECT MIN(Punitario), MAX(punitario) 
    FROM LINEAS_PEDIDOS;
    
-- Calcula el importe total sumando el resultado de (precio * cantidad) de todos los pedidos
SELECT SUM(punitario * cantidad)
    FROM LINEAS_PEDIDOS;
    
-- Calcula la media general del precio unitario de todos los productos, truncado a 2 decimales
SELECT TRUNC(AVG(punitario), 2)
    FROM PRODUCTOS;
    
    
/* --- CONSULTAS CON AGRUPACIÓN (GROUP BY) --- */

-- Cuenta cuántos clientes tiene asignados cada representante, ordenado de menos a más clientes
SELECT representante, COUNT(IDCLIENTE) 
    FROM CLIENTES
    GROUP BY (representante)
    ORDER BY 2 asc;
    
-- Cuenta los registros de ventas por ciudad, ordenado de mayor a menor cantidad
SELECT ciudad, COUNT(ventas) 
    FROM OFICINAS
    GROUP BY ciudad
    ORDER BY 2 desc;
    
-- Muestra el precio mínimo y máximo por cada fabricante
SELECT idfabricante, MIN(Punitario), MAX(punitario) 
    FROM PRODUCTOS
    GROUP BY idfabricante;
    
-- Muestra el precio medio por fabricante, truncado a 2 decimales
SELECT idfabricante, TRUNC(AVG(punitario), 2) 
    FROM PRODUCTOS
    GROUP BY idfabricante;
    
-- Precio medio por fabricante excluyendo aquellos productos que contengan la palabra 'mantel' en su descripción
SELECT idfabricante, TRUNC(AVG(punitario), 2) "PRECIO MEDIO PRODUCTOS NO MANTEL"
    FROM PRODUCTOS
    WHERE LOWER(descripcion) NOT LIKE '%mantel %'
    GROUP BY idfabricante;
    
-- Cuenta el número total de pedidos realizados por cada cliente
SELECT IDCLIENTE, COUNT(NUMPEDIDO) 
    FROM PEDIDOS
    GROUP BY IDCLIENTE;

-- Desglose de pedidos por cliente y año, ordenado por cliente
SELECT idcliente,  EXTRACT (YEAR FROM FPEDIDO), COUNT(NUMPEDIDO)
    FROM PEDIDOS
    GROUP BY idcliente, EXTRACT (YEAR FROM FPEDIDO)
    ORDER BY idcliente;
    
-- Desglose detallado de pedidos por cliente, año y mes
SELECT idcliente,  EXTRACT (YEAR FROM FPEDIDO), EXTRACT (MONTH FROM FPEDIDO), COUNT(*)
    FROM PEDIDOS
    GROUP BY idcliente, EXTRACT (YEAR FROM FPEDIDO), EXTRACT (MONTH FROM FPEDIDO)
    ORDER BY idcliente;
    
-- Cuenta cuántos empleados hay en cada oficina
SELECT IDOFICINA, COUNT(IDEMPLEADO) 
    FROM EMPLEADOS
    GROUP BY IDOFICINA
    ORDER BY IDOFICINA;


/* --- CONSULTAS CON FILTRADO DE GRUPOS (HAVING) --- */

-- Muestra solo las oficinas que tienen más de 3 empleados
SELECT IDOFICINA, COUNT(IDEMPLEADO) 
    FROM EMPLEADOS
    GROUP BY IDOFICINA
    HAVING COUNT(IDEMPLEADO)> 3
    ORDER BY IDOFICINA;