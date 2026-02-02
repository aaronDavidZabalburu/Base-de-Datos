/************************/
/* CONSULTAS DE RESUMEN */
/************************/
/* 1.- Mostrar la cuota media y las ventas medias de todos los empleados.
Emplea la funci�n ROUND si te aparecen muchos decimales.
ROUND(funci�n(campo) ,n�decimales)*/

    SELECT AVG(cuota)"M Cuota" , AVG(ventas)"M Ventas"
        FROM  empleados;
      

/* 2.- Mostrar la cuota media y las ventas medias de todos los empleados de la oficina 11,12 y 21. 
Emplea la funci�n ROUND si te aparecen muchos decimales.
/ROUND(funci�n(campo) ,n�decimales)*/

        SELECT idoficina, AVG(cuota)"M Cuota" , AVG(ventas)"M Ventas"
         FROM  empleados
         where idoficina IN (11,12,21)
         group by idoficina;

/* 3.- Mostrar la cuota media y las ventas medias de todos los empleados de cada una de las oficinas.
El listado queremos que aparezca ordenado por oficina.
Emplea la funci�n ROUND si te aparecen muchos decimales.
/ROUND(funci�n(campo) ,n�decimales)*/

    SELECT  ROUND(AVG(cuota),2)"M Cuota" , ROUND(AVG(ventas),2)"M Ventas"
    FROM empleados
    GROUP BY idoficina
    ORDER BY idoficina;
    
    

/* 4.- Mostrar la cuota media y las ventas medias de todos los empleados de cada una de las oficinas. 
En el listado solamente aparecer�n aquellas oficinas en las que el total de ventas supere los 300.000�.
El listado debe aparecer ordenado por oficina. Emplea la funci�n ROUND si te aparecen muchos decimales.*/
/* ROUND(funci�n(campo) ,n�decimales)*/

    SELECT idoficina "oficina", idempleado "Empleado", AVG(cuota)"M Cuota" , AVG(ventas)"M Ventas"
    FROM empleados    
    GROUP BY idoficina, idempleado
    having sum(ventas) > 300000
    ORDER BY idoficina;
    

/* 5.- Mostrar en qu� fecha se realiz� el primer pedido.*/

    SELECT MIN(fpedido) FROM pedidos;

/* 6.- Mostrar cu�ntos empleados est�n a cargo del empleado 118.*/

    select idempleado, jefe
        from empleados 
        where jefe = '118';

/* 7.- Mostrar cuantos pedidos ha realizado cada empleado a cada cliente.
Mostrar el n�mero de empleado, n�mero de cliente y el n�mero de pedidos realizados.
El listado aparecer� ordenado por empleado y dentro de cada empleado por n�mero de pedidos de mayor a menor.*/

    SELECT idvendedor, idcliente, count(numpedido) "NUM PED"
    
    from pedidos
    Group by idcliente, idvendedor
    Order by idvendedor;

/* 8.- Mostrar cu�ntas oficinas han superado en ventas su objetivo.*/

SELECT idoficina,ventas, objetivo
    FROM oficinas
    where ventas > objetivo;

/* 9.- Mostrar el precio medio de los productos cada fabricante.
Mostrar el listado ordenado por precio medio de menor a mayor.*/
SELECT idfabricante ,ROUND(AVG(PUNITARIO),2)
    FROM PRODUCTOS
    GROUP BY IDFABRICANTE
    ORDER BY 2;
    

/* 10.- Mostrar las oficinas en donde haya m�s de 1 tipo
diferente de puesto de trabajo.*/
SELECT idoficina, COUNT(DISTINCT puesto)
    FROM EMPLEADOS
    GROUP BY idoficina
    HAVING COUNT(DISTINCT puesto) > 1
    ORDER BY 1;

/* 11.- Mostrar el importe de cada pedido. Mostrar el c�digo de pedido y el importe.
El listado aparecer� ordenado por importe de mayor a menor.*/
SELECT codigo, SUM(PUNITARIO * CANTIDAD)
    FROM lineas_pedidos
    GROUP BY CODIGO
    ORDER BY 2 DESC;
/* 12.- Muestra solamente aquellos pedidos cuyo importe est� entre 10.000 y 30.000 euros.
Mostrar el c�digo de pedido y el importe. 
El listado aparecer� ordenado por c�digo de pedido de menor a mayor.*/
SELECT codigo, SUM(PUNITARIO * CANTIDAD) "IMPORTE"
    FROM lineas_pedidos
    GROUP BY CODIGO
    HAVING SUM(PUNITARIO * CANTIDAD) BETWEEN 10000 AND 30000
    ORDER BY 1 ;


/* 13.- Mostrar en cada a�o cuantos clientes se han dado de alta en nuestra empresa.
Ordenaremos el listado por a�o de menor a mayor. */
SELECT EXTRACT(YEAR FROM FALTA) "AÑO", COUNT(*)
    FROM CLIENTES
    GROUP BY  EXTRACT(YEAR FROM FALTA)
    ORDER BY 1;
/* 14.- �Y si queremos mostrar solamente el n�mero de clientes que han sido dados de alta en los a�os 2017, 2018 y 2020?*/
SELECT EXTRACT (YEAR FROM falta), COUNT (EXTRACT (YEAR FROM falta)) "AÑO"
    FROM CLIENTES
    WHERE EXTRACT (YEAR FROM falta) IN (2002, 2005, 2010)
    GROUP BY EXTRACT (YEAR FROM falta)
    ORDER BY 1 ;
/* 15.- Mostrar cuantos pedidos han sido enviados en el mismo a�o en el que han sido realizados, pero en diferente mes.*/
SELECT EXTRACT (YEAR FROM fpedido) "AÑO" , EXTRACT (MONTH FROM FENVIO) "MES",COUNT(fenvio)
    FROM PEDIDOS
    WHERE  EXTRACT (YEAR FROM fpedido) = EXTRACT (YEAR FROM fpedido) AND 
    EXTRACT (MOTH FROM fpedido) !=  EXTRACT (MONTH FROM fenvio)
    group by EXTRACT (YEAR FROM fpedido), EXTRACT (MONTH FROM FENVIO)
    order by 1;

/* 16.- Mostrar por cada director de oficina, cuantas oficinas dirige, 
qu� objetivo medio ten�a para sus oficinas y cuales han sido las ventas medias de sus oficinas.
El listado aparecer� ordenado por las ventas medias de las oficinas de mayor a menor.*/
SELECT DIRECTOR , COUNT(*) "OFICINAS", ROUND(AVG(OBJETIVO),2)"OBJETIVO", ROUND(AVG(VENTAS),2)"VENTAS"
    FROM OFICINAS
    group by director
    order by ventas DESC;

/* 17.- Mostrar de cada fabricante cu�l es el precio m�s caro y m�s barato de sus productos.
Mostrar el listado ordenado por fabricante.*/
SELECT idfabricante, MAX(PUNITARIO) "MAS CARO", MIN(PUNITARIO)"MAS BARATO"
    FROM PRODUCTOS
    GROUP BY IDFABRICANTE
    ORDER BY IDFABRICANTE ASC;

/* 18.- Mostrar de cada ciudad cu�l es el objetivo m�nimo de sus oficinas.*/
SELECT CIUDAD, COUNT (*)"OFICINAS",  MIN(OBJETIVO)"OBJETIVO MINIMO" 
    FROM OFICINAS
    GROUP BY CIUDAD
    ORDER BY CIUDAD;
