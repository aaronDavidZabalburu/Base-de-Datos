/* EJEMPLOS FUNCIONES*/

/****************1 FUNCIONES MATEM�TICAS**********************/

SELECT ROUND(100.34) FROM DUAL;
SELECT ROUND(100.84) FROM DUAL;

SELECT TRUNC(100.34) FROM DUAL;
SELECT TRUNC(100.84) FROM DUAL;

SELECT ROUND(100.34,2) FROM DUAL;
SELECT ROUND(100.85,1) FROM DUAL;

SELECT TRUNC(100.34,1) FROM DUAL;
SELECT TRUNC(100.85,1) FROM DUAL;

SELECT  ROUND (43.23, -2) FROM DUAL;
SELECT  ROUND (68.23, -2) FROM DUAL;

SELECT SQRT(25) FROM DUAL;

SELECT POWER(2,10) FROM DUAL;
SELECT MOD(10,3) FROM DUAL;

SELECT ABS(3.45) FROM DUAL;
SELECT ABS(-3.45) FROM DUAL;

SELECT SIGN(3.45) FROM DUAL;
SELECT SIGN(-3.45) FROM DUAL;
SELECT SIGN(0) FROM DUAL;

SELECT CEIL(3.45) FROM DUAL;
SELECT FLOOR(3.45) FROM DUAL;

SELECT CEIL(-3.45) FROM DUAL;
SELECT FLOOR(-3.45) FROM DUAL;

/**************************************************************************/

/**************************2 FUNCIONES DE CADENAS*******************************/

/***********************************LOWER*********************************
LOWER:PAsar a minusculas;
UPPER:PAsar a Mayusculas; 
INITCAP:ModoTitulo (Iniciales de las palabras en mayúscula)*/

SELECT LOWER(nombre),UPPER(nombre), INITCAP(nombre) FROM empleados;

/**********************************TRIM********************************************************************
TRIM: Eliminar Espacios por delante (RTRIM) o por detras (LTRIM). Por delante y por detras(TRIM)*/

SELECT LTRIM('                         Marta          Torre                         ') FROM DUAL;
SELECT RTRIM('                         Marta          Torre                         ') FROM DUAL;
SELECT TRIM('                         Marta          Torre                         ') FROM DUAL;
SELECT REPLACE('                         Marta          Torre                         ',' ','') FROM DUAL;

SELECT TRIM('$' FROM '$$$$$129$$$$$') FROM DUAL;
SELECT REPLACE('$$$$$129$$$$$','$','') FROM DUAL;

/*********************************INSTR************************************************************/
/*INSTR: Nos devuelve la posicion de un string dentro de otro.

INSTR(campo,'string a buscar')   o
INSTR(campo,'string a buscar', posicion iniciobusqueda)   o
INSTR(campo,'string a buscar', posicion iniciobusqueda, numero de repeticion)  */


SELECT nombre,INSTR(nombre,' ') "POSICION DEL ESPACIO" FROM empleados;

/****************SUBSTR*******************************************************************************************
SUBSTR: Nos devuelve un substring dentro de otro.
SUBSTR(campo,posición de inicio) : Devuelve el substring que va desde la posicion de inicio hasta el final.
SUBSTR(Campo, posición de inicio, cuantos caracteres coger) : Devuelve el substring que comienza en la posicion de inicio tomando el numero de caracteres que indica el tercer parametro)*/


SELECT nombre,SUBSTR(nombre,INSTR(nombre,' ')+1) "APELLIDOS" FROM empleados; 

SELECT nombre, INSTR(nombre,' ')  "PRIMER ESPACIO",INSTR(nombre,' ',1,2) "SEGUNDO ESPACIO",INSTR(nombre,' ',1,3) "TERCER ESPACIO" FROM empleados;

SELECT nombre, INSTR(nombre,' ')  "PRIMER ESPACIO",INSTR(nombre,' ', INSTR(nombre,' ') +1 ) "SEGUNDO ESPACIO" FROM empleados;

--1. Muestra solamente el NOMBRE del EMPLEADO

SELECT nombre, SUBSTR(nombre,1,INSTR(nombre,' ')-1) "NOMBRE" FROM empleados;

--2.  Mostrar el SEGUNDO APELLIDO

SELECT nombre,SUBSTR(nombre,INSTR(nombre,' ',1,2)+1) "SEGUNDO APELLIDO" FROM empleados;

--3. Mostrar el PRIMER APELLIDO*/

SELECT nombre,SUBSTR(nombre,INSTR(nombre,' ')+1,INSTR(nombre,' ',1,2)-INSTR(nombre,' ')-1) "PRIMER APELLIDO" FROM empleados;

--4.  Mostrar el primer apellido de los empleados que tienen nombre compuesto (Jose Luis, Ana Mar�a,...)

SELECT nombre,SUBSTR(nombre,INSTR(nombre,' ',1,2)+1,INSTR(nombre,' ',1,3)-INSTR(nombre,' ',1,2)-1) FROM empleados;

--5. Crear un campo para la direccion de correo electronico, que se formara de la siguiente forma:

Inicial del nombre,un punto, primer apellido, un punto e inicial del segundo apellido, @zabalburu.org.*/

SELECT nombre, LOWER(SUBSTR(nombre,1,1) || '.' || REPLACE(SUBSTR(nombre,INSTR(nombre,' ')+1),' ','.')) || '@zabalburu.org'
FROM empleados;

SELECT LOWER(SUBSTR(nombre,1,1) || '.'||
SUBSTR(nombre,INSTR(nombre,' ')+1,INSTR(nombre,' ',1,2)-INSTR(nombre,' ')-1) || '.' ||
SUBSTR(nombre,INSTR(nombre,' ',1,2)+1))|| '@zabalburu.org' FROM empleados;


--6.  Mostrar un campo email con la siguiente sintaxis: 
-- l.alfonso.e@zabalburu.org
-- a.diaz.z@zabalburu.org*/   

SELECT nombre,LOWER(SUBSTR(nombre,1,1) || '.' 
|| SUBSTR(nombre,INSTR(nombre,' ')+1,INSTR(nombre,' ',1,2)-INSTR(nombre,' ')-1)||'.' 
|| SUBSTR(nombre,INSTR(nombre,' ',1,2)+1,1) || '@zabalburu.org') FROM empleados;

/***************************************************************************************************************************/ 
--7. MOSTRAR descripci�n + de +  fabricante, color, tamaño y 
fecha de compra de los manteles que ha comprado ESTEFANIA GARCIA ANTON */ 

/* PASO 1 */
SELECT descripcion,idfabricante,fpedido FROM pedidos p,productos pro,lineas_pedidos  lp,clientes c WHERE p.codigo=lp.codigo
AND lp.fabricante=pro.idfabricante AND lp.producto=pro.idproducto AND p.idcliente=c.idcliente 
AND lower(descripcion) like 'mantel%' 
AND lower(nombre)='estefania garcia anton';

/* PASO 2 : Con Multitabla */
SELECT SUBSTR(descripcion,1,INSTR(descripcion,' ',1,2)-1) || ' de ' ||    idfabricante "TIPO PRODUCTO",
SUBSTR(descripcion,INSTR(descripcion,' ',1,2)+1,INSTR(descripcion,' ',1,3)-INSTR(descripcion,' ',1,2)-1) "TAMAÑO MANTEL",
SUBSTR(descripcion,INSTR(descripcion,' ',1,3)+1) "COLOR MANTEL",
fpedido FROM pedidos p,productos pro,lineas_pedidos  lp,clientes c WHERE p.codigo=lp.codigo
AND lp.fabricante=pro.idfabricante AND lp.producto=pro.idproducto AND p.idcliente=c.idcliente 
AND lower(descripcion) like 'mantel%' 
AND lower(nombre)='estefania garcia anton';

/* PASO 2 : Con Multitabla y luego Subconsulta */
SELECT SUBSTR(descripcion,1,INSTR(descripcion,' ',1,2)-1) || ' de ' ||    idfabricante "TIPO PRODUCTO",
SUBSTR(descripcion,INSTR(descripcion,' ',1,2)+1,INSTR(descripcion,' ',1,3)-INSTR(descripcion,' ',1,2)-1) "TAMAÑO MANTEL",
SUBSTR(descripcion,INSTR(descripcion,' ',1,3)+1) "COLOR MANTEL",
fpedido FROM pedidos p,productos pro,lineas_pedidos  lp WHERE p.codigo=lp.codigo
AND lp.fabricante=pro.idfabricante AND lp.producto=pro.idproducto 
AND lower(descripcion) like 'mantel%'  AND idcliente=(SELECT idcliente FROM clientes WHERE
lower(nombre)='estefania garcia anton');
/***************************************************************************************************************************/


/**********************************************LENGTH***************************************************
LENGTH(campo):Muestra el numero total de caracteres que ocupa el valor de ese campo*/


SELECT nombre,LENGTH(nombre) FROM empleados;
SELECT nombre,LENGTH(SUBSTR(nombre,1,INSTR(nombre,' ')-1)) "Numero caracteres del nombre" FROM empleados;




/**********************REPLACE************************
REPLACE: Reemplaza un string por otro*/

SELECT REPLACE(nombre,' ', '') FROM empleados;
SELECT REPLACE(nombre,'A', '@') FROM empleados;
SELECT REPLACE(nombre,'UI', 'ui') FROM empleados;


/*********************TRANSLATE*********************** 
TRANSLATE: Reemplaza uno a uno todos los caracteres*/

SELECT TRANSLATE(nombre, 'UI','ui') FROM empleados; 
SELECT TRANSLATE(nombre, 'UI','u') FROM empleados;

/*************************RPAD - LPAD ******************************************************
RPAD y LPAD: Rellena con espacios u otro caracter por la derecha e izquierda respectivamente 
hasta el numero de caracteres especificado en la funcion*/

SELECT LPAD(nombre,70) FROM empleados;
SELECT RPAD(nombre,70),fcontrato FROM empleados;
SELECT LPAD(nombre,70,'#') FROM empleados;
SELECT RPAD(nombre,70,'#') FROM empleados;
SELECT LPAD(nombre,5) FROM empleados;

/*************REVERSE***************************************************
REVERSE: DA la vuelta a un string*/

SELECT REVERSE(nombre) FROM empleados;

/*********************ASCII*******************************************
ASCII: Muestra el numero que ocupa el caracter pasado en la tabla ASCII*/

SELECT ASCII('a') FROM DUAL;

/*******************CHR*********************************************
CHR: Mustra cual es el caracter en la tabla ASCII correspondiente al valor decimal pasado*/

SELECT CHR(126) FROM DUAL;


/*************************NVL  - NVL2 ***********************************************************************
NVL y NVL2: Condicion Nulos: 
--NVL: Muestran el valor indicado en el segundo par�metro si el campo pasado como primer parametro tiene valor nulo*/
--NVL2: Muestra un valor si el campo pasado a la funcion no es nulo y otro si el valor es nulo
*/

SELECT nombre,idoficina,NVL(idoficina,0) FROM empleados;
SELECT nombre,NVL2(idoficina,idoficina,-1)  FROM empleados;
SELECT nombre,idoficina,NVL2(idoficina,'OFICINA','TELETRABAJO') "LUGAR TRABAJO" FROM empleados;
SELECT nombre,NVL(idoficina,0),idoficina  FROM empleados;


/******************************3 FUNCIONES DE FECHAS ****************************************************/

/*****************************EXTRACT*******************************************
 EXTRACT: Extrae Anio,Mes,Dia de un a fecha o SEGUNDOS,MINUTOS y HORAS De una hora*/

SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;


/*************************SYSDATE******************************************
SYSDATE: Mustra la fecha actual*/

SELECT SYSDATE FROM DUAL; 

/*********************SYSTIMESTAMP***************************************
SYSTIMESTAMP: Mustra la fecha y hora actual*/

SELECT SYSTIMESTAMP FROM DUAL;


SELECT EXTRACT(YEAR FROM SYSTIMESTAMP) FROM DUAL;
SELECT EXTRACT(MONTH FROM SYSTIMESTAMP) FROM DUAL;
SELECT EXTRACT(DAY FROM SYSTIMESTAMP) FROM DUAL;

SELECT EXTRACT(HOUR FROM SYSTIMESTAMP) FROM DUAL;
SELECT EXTRACT(MINUTE FROM SYSTIMESTAMP) FROM DUAL;
SELECT EXTRACT(SECOND FROM SYSTIMESTAMP) FROM DUAL;


/* Sumar o restar números a una fecha suma o resta dias a esa fecha*/

SELECT codigo,fpedido,fpedido-3 "Fecha de envío estimada" FROM pedidos;
SELECT codigo,fpedido,ADD_MONTHS(fpedido,1) "F envio" FROM pedidos;

/* MONTHS_BETWEEN: Devuelve el numero de meses que han pasado entre dos fechas*/

SELECT nombre,TRUNC(MONTHS_BETWEEN(sysdate,fcontrato)/12) FROM empleados;

/***************************NEXT_DAY****************************************
NEXT_DAY:Muestra el siguiente dia de la semana a la fecha dada*/

SELECT NEXT_DAY(sysdate,'lunes') FROM dual;

/*************************LAST_DAY******************************************
LAST_DAY:Devuelve la fecha del último día del mes y año pasado en la fecha*/

SELECT codigo,fpedido,LAST_DAY(fpedido) FROM pedidos;

/*************************ROUND - TRUNC***************************************
ROUND y TRUNC: Redondea y trunca a DIA, MES y ANNIO una fecha*/

SELECT fpedido,ROUND(fpedido,'MONTH') FROM pedidos;
SELECT fpedido,TRUNC(fpedido,'MONTH') FROM pedidos;

/**********************************TO_CHAR********************************************
TO_CHAR: Pasa a texto una fecha*/

SELECT codigo,TO_CHAR(fpedido,'day, dd "de" m "de" YYYY'),idcliente FROm pedidos;
SELECT codigo,TO_CHAR(SUM(cantidad*punitario),'9G999G999D00L') FROM lineas_pedidos GROUP BY codigo;

/*********************************TO_DATE*********************************************
 TO_DATE: convierte un texto en una fecha*/

SELECT TRUNC(MONTHS_BETWEEN(sysdate,(TO_DATE('viernes 10/12/1971','day dd/MM/YYYY')))/12) FROM DUAL;

/********************************FUNCIONES CONDICIONALES ************************************************/

/*******************************DECODE****************************************************
 DECODE: ASigna diferentes valores a un campo dependiendo del valor que toma otro campo 
(comparacion con operador de igualdad)*/

SELECT nombre,puesto,ventas,
ventas*1.10 "OBJETIVO 2021" FROM empleados;

/* Mostrar un campo con la cuota incrementada dependiendo del puesto que ocupan nuestros empleados:

Comerciales:5%
Directores de �rea:2%
Directrores de Ventas:2,5%
Resto de empleados: 3%
*/

--HECHO CON DECODE
SELECT nombre, cuota,
puesto,
                DECODE(lower(puesto),'comercial','Incremento 5%', 'director ventas', 'Incremento 2,5%','director area', 'Incremento 2%', 'Incremento 3%') "TIPO DE INCREMENTO",
                DECODE(lower(puesto) ,'comercial',cuota*1.05, 'director ventas', cuota*1.025,'director area', cuota*1.02, cuota*1.03) "INCREMENTO DE CUOTA"
                
FROM empleados;

/*************************CASE WHEN *********************************************************
 CASE.... WHEN....END: ASigna diferentes valores a un campo dependiendo del valor que toma otro campo 
(operador =,<,<=,>,>=, BETWEEN...)*/

SELECT nombre,puesto,ventas,
CASE lower(puesto)
WHEN 'comercial' THEN ventas*1.01
WHEN 'director general' THEN ventas*1.15
WHEN 'director area' THEN ventas*1.05
ELSE
ventas
END "Objetivo 2021"
FROM empleados;

/* Mostrar un campo con la cuota incrementada dependiendo del puesto que ocupan nuestros empleados:

Comerciales:5%
Directores de �rea:2%
Directrores de Ventas:2,5%
Resto de empleados: 3%
*/
--HECHO CON CASE WHEN

SELECT nombre, cuota,
puesto,CASE lower(puesto)
  WHEN   'comercial' THEN 'Incremento del 5%'
  WHEN  'director area' THEN 'Incremento del 2%'
  WHEN  'director ventas' THEN 'Incremento del 2,5%'
ELSE 'Incremento del 2,5%'
END "TIPO DE INCREMENTO",

CASE
WHEN lower(puesto)='comercial' THEN cuota*1.05
WHEN lower(puesto)='director area' THEN cuota*1.02
WHEN lower(puesto)='director ventas' THEN cuota*1.025
ELSE cuota*1.03
END "INCREMENTO DE LA CUOTA"

FROM empleados;

/*Mostrar un nuevo campo denominado Objetivo2026 que ser�n las ventas incrementadas en un porcentaje seg�n el 
puesto de trabajo que ocupe en la empresa:
comerciales incrementaremos en un 1%, director general en un 15%, director area en un 5% */

-- Hecho con DECODE
SELECT nombre,puesto,ventas,
DECODE(lower(puesto),'comercial',ventas*1.01,'director general',ventas*1.15,'director area',
ventas*1.05,ventas) "OBJETIVO 2026" FROM empleados;


--Hecho con CASE WHEN
SELECT nombre,puesto,ventas,
CASE 
WHEN lower(puesto)='comercial' THEN ventas*1.01
WHEN lower(puesto)='director general' THEN ventas*1.15
WHEN lower(puesto)='director area' THEN ventas*1.05
ELSE
ventas
END "Objetivo 2026"
FROM empleados;

/* Poner una calificaci�n a los empleados en un nuevo campo que ser� en funci�n de las ventas
 que haya hecho cada empleado:
Si las ventas son nulas aparecer� el mensaje NO REALZIA VENTAS,
Si las ventas son menores a 250000 aparecer� el mensaje VENDEDOR REGULAR
Si las ventas est�n entre 250000 y 500000 aparecer� el mensaje BUEN VENDEDOR 
Si las ventas son superiores a 500000 aparecer� el mensaje VENDEDOR EXCEPCIONAL*/

SELECT nombre,ventas,
CASE 
WHEN ventas>500000 THEN 'VENDEDOR EXCEPCIONAL'
WHEN ventas BETWEEN 250000 AND 500000 THEN 'BUEN VENDEDOR'
WHEN ventas<250000 THEN ' VENDEDOR REGULAR'
WHEN ventas is null THEN 'NO REALIZA VENTAS'
END "TIPO VENDEDOR"
FROM empleados;
















