--EJERCICIOS DE FUNCIONES EN ORACLE
--ABS(146)= 146
    SELECT ABS(146) FROM DUAL;
--CEIL(2)= 2
    SELECT CEIL(2) FROM DUAL;
--CEIL(-2,3)= -2
    SELECT CEIL(-2.3) FROM DUAL;
--FLOOR(-2,3)= -3
    SELECT FLOOR(-2.3) FROM DUAL;
--FLOOR(2)= 2
    SELECT FLOOR(2) FROM DUAL;
--MOD(22,23)= 22 
    SELECT MOD(22,23) FROM DUAL;
--POWER(10,0)= 1	ABS(-30)= -30
    SELECT POWER(10,0),ABS(-30) FROM DUAL;
--CEIL(1,3)= 2
     SELECT CEIL(1.3) FROM DUAL;
--CEIL(-2)= -2
     SELECT CEIL(-2) FROM DUAL;
--FLOOR(-2.3)= -3
    SELECT FLOOR(-2.3) FROM DUAL;
--FLOOR(1.3)= 1
    SELECT FLOOR(1.3) FROM DUAL;
--MOD(10,3)= 1
    SELECT MOD(10,3) FROM DUAL;
--POWER(3,2)= 9
    SELECT POWER(3,2) FROM DUAL;
--POWER(3,-1)= 0,33333333
    SELECT POWER(3,-1) FROM DUAL;
--ROUND(33.67)= 34
    SELECT ROUND(33.67) FROM DUAL;
--ROUND(-33,67,-2)= 0
    SELECT ROUND(-33.67 ,-2) FROM DUAL;
--TRUNC(67,232)= 67
    SELECT TRUNC(67,232) FROM DUAL;
--TRUNC(67,232,2)=67,23
    SELECT TRUNC(67.232,2) FROM DUAL;
--TRUNC(67,58,1)=60	ROUND(33,67)=34
    SELECT TRUNC(67.58,-1), ROUND(33.67) FROM DUAL;
--ROUND(-33,67,-2)= 0
    SELECT ROUND(-33.67,-2) FROM DUAL;
--ROUND(67.232,-2)=
    SELECT ROUND(67.232,-2) FROM DUAL;
--TRUNC(67.232,-2)=
    SELECT TRUNC(67.232,-2) FROM DUAL; 
--TRUNC(67.58,-1)= 60
    SELECT TRUNC(67.58,-1) FROM DUAL;

--2.- Dada la tabla EMPLEADOS muestra el número medio de ventas, el máximo número de ventas
--y el mínimo número de ventas de los empleados de la oficina 12.  Los números deben aparecer redondeados a dos decimales.

SELECT ROUND(MIN(VENTAS)) "VENTAS MINIMAS", ROUND(MAX(VENTAS)) "VENTAS MAXIMAS", ROUND(AVG(VENTAS)) "MEDIA DE VENTAS"
    FROM EMPLEADOS;

--3.- Dada la tabla CLIENTES se debe mostrar en una columna los apellidos una coma 
--y el nombre del empleado en ese orden y en otra columna las iniciales.

SELECT NOMBRE 
    FROM CLIENTES;

SELECT NOMBRE, SUBSTR(NOMBRE,INSTR(nombre,' ')+1,INSTR(nombre,' ',1,2)-INSTR(nombre,' ')-1) || ' , '
    ||  SUBSTR(nombre,1,INSTR(nombre,' ')-1) "APELLIDO Y NOMBRE",
    SUBSTR(nombre,1,1) || SUBSTR(nombre, INSTR(NOMBRE,' ',1)+1,1) || SUBSTR(nombre, INSTR(NOMBRE,' ',1,2)+1,1)
        FROM CLIENTES;


4.- Dada la tabla EMPLEADOS se debe mostrar el nombre del empleado y en otra columna ,
la fecha de contrato, fecha de contrato formateada. Esta fecha seguirá el siguiente formato:
“Comenzó el 10 de octubre de 1980”

5.- Dada la tabla de empleados mostrar el nombre del empleado y el número de caracteres
que tiene su nombre completo, su nombre, el número de caracteres que ocupa el nombre y 
sus apellidos y el número de caracteres que ocupan sus apellidos.

6.- Convierte la cadena ‘010726’ a fecha y muestra el nombre del mes en letras mayúsculas. (Lanzar la orden contra DUAL)

7.- A partir de la tabla EMPLEADOS mostrar aquellos que llevan más de 25 años trabajando.

8.- Mostrar el apellido de aquellos empleados que llevan trabajando más de 25 años en las oficinas de Valencia.
 
9.- Dadas las oficinas mostrar si su objetivo es menor de 300.000 “BAJO”, si está entre 300.000 y 500.000 “MEDIO” y superior a 500.000 “ALTO” y mostrar sus ventas y si han sido BAJAS, MEDIAS o ALTAS (mismos valores que para el objetivo).

10.- Mostrar por cada cliente que ha hecho pedidos si es buen cliente, cliente básico 
si el valor total de los importes de sus pedidos es superior a 20.000 € (buen cliente),
menor que 5000 (cliente básico), o entre estas dos cifras (Cliente potencial).

11.- Mostrar la consulta anterior pero mostrando el nombre de cliente y si es buen cliente básico o potencial.

12.- Mostrar el precio medio de los productos de cada fabricante. 
(Utilizar formato de cantidades numéricas mostraremos las cantidades con dos decimales y la moneda por detrás de la cantidad).

13.- Mostrar la siguiente descripción de los manteles: 
            mantel color tamaño 99x99 del fabricante nombre cuesta 99 euros.
El texto en negrita se sustituirá por su valor en la Base de Datos.

14.- Mostrar la descripción de los productos y a continuación una columna en donde aparezca
el texto CUBERTERÍA si son copas y vasos o TEXTIL si son manteles.

15.- Mostrar las descripciones de los productos y una nueva columna en donde verifiquemos si 
tenemos que comprar urgentemente un producto verificando que el stock es menor que el nivel 
de nuevo pedido si la diferencia está entre 10 unidades y 30 unidades  tendremos que realizar
una compra a medio plazo y si es superior a 30 será una compra a largo plazo.*/
