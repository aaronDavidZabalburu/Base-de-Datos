/*Ejercicios Consultas JOIN*/
/*1.- Listar las oficinas del este indicando para cada una de ellas su n�mero, 
ciudad, n�meros y nombres de sus empleados.Mostrar todas las oficinas aunque no tengan 
empleados asignados*/

SELECT  o.idoficina, o.region, o.ciudad, e.idempleado, e.nombre 
FROM oficinas o JOIN empleados e ON  e.idoficina = o.idoficina 
WHERE LOWER(o.region)= 'este'


/*2.- Listar los pedidos mostrando su n�mero, 
importe, c�digo y nombre del cliente,
su fecha de alta.*/

/*3.- Listar los datos de cada uno de los empleados, 
la ciudad y regi�n en donde trabaja.
Mostrar todos los empleados aunque no tengan oficina asignada.*/

/*4.- Listar las oficinas con objetivo superior a 590.000 �
indicando para cada una de ellas el nombre de su director. Mostrar todas las oficinas
aunque no tengan director asignado.*/

/*5.- Listar los pedidos con importe superior a 10000�. 
Se mostrar�n los c�digos y n�meros de pedidos, junto con su importe.*/

/*Posteriormente se incluir� el nombre del empleado que tom� el pedido 
y el nombre del cliente que lo solicit�.*/

/*6.- Listar los empleados que realizaron sus primeros pedidos el d�a que fueron contratados. Mostrar el nombre del empleado,
fecha de contrato, c�digo e importe de esos pedidos.*/

/*7.- Listar los empleados con una cuota superior a la de su jefe;
para cada empleado mostrar todos sus datos
y el n�mero, nombre y cuota de su jefe. Mostrar todos los empleados independientemente de si
tienen jefe o no.*/

/*8.- Listar todos los pedidos en los que se hayan comprado cucharas o cuchillos. 
Debemos mostrar el n�mero de pedido, la cantidad e importe de las l�neas de pedido que las contengan 
el fabricante y la descripci�n del producto.*/

/*9.- Listar el n�mero de pedidos e importe de los mismos que cada empleado ha realizado a cada cliente.
Se mostrar� el n�mero y nombre del cliente, el n�mero y nombre del empleado, la cantidad de pedidos y el importe del pedido.*/

/*10.- Listar el n�mero de oficinas con su ciudad y region
que dirige cada uno de los empleados mostrando su n�mero,nombre y fecha de contrato.
Mostrar los datos de los empleados aunque no dirijan oficinas */

/*Listar el n�mero de oficinas que tengan ventas que dirige cada uno de los empleados.*/ 
