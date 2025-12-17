/*DESC: Comando para ver los campos de las tablas*/
DESC empleados;
DESC oficinas;
DESC clientes;
DESC pedidos;
DESC productos;
DESC lineas_pedidos;

-- CONSULTAS BÁSICAS: Consultas a una Tabla (SELECT)

/* Mostrar todos los campos de una tabla*/
SELECT * FROM empleados;
SELECT * FROM pedidos;

/*SELECT: Ver proyección de una tabla*/
SELECT idempleado,nombre,idoficina,puesto FROM empleados;
--Mostrar nombre, fechanacimiento, representante de los clientes;
SELECT nombre,fnacimiento,representante FROM clientes;
-- Mostrar la descripción el precio unitario y el stock de todos los productos;
SELECT descripcion,punitario,stock FROM productos;

/* CAMPOS CALCULADOS*/

--Mostrar Codigo, fabricante, producto,punitario,cantidad de las líneas de pedidos
SELECT codigo,fabricante,producto,punitario,cantidad FROM lineas_pedidos;
SELECT codigo,fabricante,producto,punitario,cantidad,punitario*cantidad FROM lineas_pedidos;

/* CREACIÓN DE ALIAS de Campos*/
SELECT codigo,fabricante,producto,punitario,cantidad,punitario*cantidad "IMPORTE" 
FROM lineas_pedidos;
SELECT codigo,fabricante,producto,punitario,cantidad,punitario*cantidad as "IMPORTE"
FROM lineas_pedidos;

--Codigo, fecha de pedido, fecha aproximada de envío (2 días después de la fecha de pedido) 
--y el vendedor que ha realizado el pedido.
SELECT codigo,fpedido,fpedido+2 "FECHA ENVÍO APROXIMADA",idvendedor
FROM pedidos;

-- Mostrar nombre empleado, la cuota
-- y la cuota para el año 2025 que va a ser la cuota incrementada en un 5%) 

SELECT nombre,cuota,cuota*1.05 "CUOTA 2025"
FROM empleados;

/*CONCATENACIÓN: || nos sirve para unira campos o unir texto a los campos*/

SELECT idempleado || ' - ' ||nombre  "IDENTIFICATIVO" FROM empleados;
SELECT codigo,fabricante,producto,punitario || ' €' FROM lineas_pedidos;

SELECT 'El empleado ' || nombre || ' ha realizado ventas por valor de ' || ventas || '€' as "TEXTO EMPLEADOS"
FROM empleados;



/*DISTINCT: Los diferentes valores de un campo en una tabla*/

SELECT idoficina FROM oficinas;

SELECT DISTINCT idoficina FROM empleados;
--Muestra los diferentes fabricantes+productos de la tabla lineas de pedidos
SELECT DISTINCT fabricante,producto FROM lineas_pedidos;



/*ORDER BY: Ordenar el resultado de una consulta*/

--Ordena los empleados por nombre en orden ascendente (por defecto el orden es ascendente)
SELECT * FROM empleados ORDER BY nombre ;
SELECT * FROM empleados ORDER BY nombre asc;
--Ordena los empleados por nombre en orden descendente
SELECT * FROM empleados ORDER BY nombre desc;

--Mostrar los pedidos ordenados por fecha de pedido del más nuevo al más antiguo

SELECT * FROM pedidos ORDER BY fpedido desc;

-- Mostrar empleados por ventas de mayores ventas a menores ventas (nombre y ventas).
SELECT nombre,ventas FROM empleados ORDER BY ventas desc;

--ORDENAR LAS OFICINAS POR REGION
SELECT * FROM oficinas ORDER BY region desc,ciudad ,idoficina desc;


/******************CLÁUSULA WHERE *****************************/
--OPERACIÓN DE SELECCIÓN:
    --(CLAÚSULA WHERE -- Mostrar determinadas filas que cumplen ciertos criterios o condiciones =,!= o <>,>,>=,<,<=,AND, OR,IN,BETWEEN,LIKE)

--EMPLEADOS QUE HAN REALIZADO VENTAS MAYORES A 200000€ (nombre, fechacontrato y las ventas)
SELECT * FROM empleados;
SELECT nombre,fcontrato,ventas 
    FROM empleados
    WHERE ventas>200000
    ORDER BY ventas desc;
    
--Mostrar los nombres, oficina y ventas de los empleados de las oficinas 12,15 y 21.
SELECT * FROM empleados;
SELECT nombre,idoficina,ventas 
    FROM empleados
    WHERE idoficina=12 OR idoficina=15 OR idoficina=21;
    
--Mostrar los nombres, oficina y ventas de los empleados que no trabajan en las oficinas 12,15 y 21.

SELECT nombre,idoficina,ventas 
    FROM empleados
    WHERE idoficina!=12 AND idoficina!=15 AND idoficina!=21;

--OPERADOR IN comparar diferentes valores del mismo campo.

--Mostrar los nombres, oficina y ventas de los empleados de las oficinas 12,15 y 21. HECHO CON IN
SELECT nombre,idoficina, ventas 
FROM empleados
WHERE idoficina IN (12,15,21);

--Mostrar los nombres, oficina y ventas de los empleados que no trabajan en las oficinas 12,15 y 21.HECHO CON NOT IN
SELECT nombre,idoficina, ventas 
FROM empleados
WHERE idoficina NOT IN (12,15,21);


--Mostrar todos los productos del fabricante asa que cuesten más de 10€.
SELECT * 
    FROM productos
    WHERE idfabricante='asa' AND punitario>10;
    
--Mostrar todas las oficinas de valencia que han hecho ventas menores a 200000€.
SELECT * FROM oficinas;
SELECT * 
    FROM oficinas
    WHERE UPPER(ciudad)='VALENCIA' AND ventas<200000;

SELECT * 
    FROM oficinas
    WHERE LOWER(ciudad)='valencia' AND ventas<200000;
    
--Mostrar todos los pedidos realizados entre el año 2000 y el año 2017.(numpedido,fechapedido)

SELECT numpedido,fpedido
        FROM pedidos
        WHERE fpedido>='01/01/2000' AND fpedido<='31/12/2017'
        ORDER BY fpedido desc;
        
 --Mostrar todos los pedidos que NO estén realizados entre el año 2000 y el año 2017.(numpedido,fechapedido)       
        
        SELECT numpedido,fpedido
        FROM pedidos
        WHERE fpedido<='01/01/2000' OR fpedido>='31/12/2017'
        ORDER BY fpedido desc;
        
--USando el operador BETWEEN (comparación para rangos de valores)        
--Mostrar todos los pedidos realizados entre el año 2000 y el año 2017.(numpedido,fechapedido)
SELECT numpedido,fpedido
        FROM pedidos
        WHERE fpedido BETWEEN '01/01/2000' AND '31/12/2017'
        ORDER BY fpedido desc;

 --Mostrar todos los pedidos que NO estén realizados entre el año 2000 y el año 2017.(numpedido,fechapedido) 
SELECT numpedido,fpedido
        FROM pedidos
        WHERE fpedido NOT BETWEEN '01/01/2000' AND '31/12/2017'
        ORDER BY fpedido desc;

--EXTRACT : Función para extraer de una fecha sus campos

SELECT numpedido,fpedido
    FROM pedidos
    WHERE EXTRACT(YEAR FROM fpedido)>=2000 AND EXTRACT(YEAR FROM fpedido)<=2017;

SELECT numpedido,fpedido
    FROM pedidos
    WHERE EXTRACT(YEAR FROM fpedido) BETWEEN 2000 AND 2017;
    
/*LIKE (comparar patrones de caracteres)
Caracteres comodines:
_: cubre por 0 o 1 caracter
%: cubre po0 o más caracteres */

SELECT * FROM empleados
    WHERE LOWER(nombre) LIKE 'maria%';
 
SELECT * FROM empleados
    WHERE LOWER(nombre) LIKE '% fernandez';  
    
SELECT * FROM empleados
    WHERE LOWER(nombre) LIKE '% uria %';
    
SELECT idproducto 
    FROM productos
        WHERE lower(idproducto) like '140__';   
        
        
/*NULL: Muestra campos nulos*/

SELECT *
    FROM empleados
      WHERE VENTAS IS NULL;
      
SELECT *
    FROM empleados
      WHERE VENTAS IS NOT NULL;      
