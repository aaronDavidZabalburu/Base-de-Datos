SELECT TRUNC(AVG(punitario),2) "MEDIA PRECIO PRODUCTOS" 
    FROM productos
    WHERE LOWER(idfabricante) = 'asa'; 
    
SELECT MIN(fcontrato) "Fecha Primer Empleado"
    FROM empleados;
    
SELECT COUNT(region) "Nº OFICINAS ESTE"
    FROM OFICINAS
    WHERE LOWER(region) = 'este';
    
    
SELECT COUNT(region) "Nº OFICINAS ESTE VENTAS > 300000"
    FROM OFICINAS
    WHERE LOWER(region) = 'este' AND ventas > 300000;
    
SELECT MIN(Punitario), MAX(punitario) 
    FROM LINEAS_PEDIDOS;
    
SELECT SUM(punitario * cantidad)
    FROM LINEAS_PEDIDOS;
    
SELECT TRUNC(AVG(punitario), 2)
    FROM PRODUCTOS;
    
    
SELECT representante, COUNT(IDCLIENTE) 
    FROM CLIENTES
    GROUP BY (representante)
    ORDER BY 2 asc;
    
SELECT ciudad, COUNT(ventas) 
    FROM OFICINAS
    GROUP BY ciudad
    ORDER BY 2 desc;
    
SELECT idfabricante, MIN(Punitario), MAX(punitario) 
    FROM PRODUCTOS
    GROUP BY idfabricante;
    
SELECT idfabricante, TRUNC(AVG(punitario), 2) 
    FROM PRODUCTOS
    GROUP BY idfabricante;
    
SELECT idfabricante, TRUNC(AVG(punitario), 2) 
    FROM PRODUCTOS
    WHERE LOWER(descripcion) NOT LIKE '%mantel%'
    GROUP BY idfabricante;