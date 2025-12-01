/*--Primer Ejemplo Tabla P_Empleados (Solo con Campos)
TIPOS DE RESTRICCIONES(PALABRAS RESERVADAS) : 
PRIMARY KEY:Clave Principal
UNIQUE: Crear Indices Unicos
CHECK : Condiciones a los campos
REFERENCES : Clave Extranjera

--RESTRICCIONES Tipo 1 
Las 5 restricciones se colocan justo detras del campo al que afectan.

--RESTRICCIONES Tipo 2
 Se colocan justo detras de todos los campos(Como si fuesen otro campo mas)
 y a parte de las palabras reservadas hay que colocar sobre que campo o campos
afecta esa restriccion

Generalmente es mejor poner nombres a las restricciones para modificarlas cuando
sea necesario. Eso se hace escribiendo CONSTRAINT + NOMBRE_RESTRICCION + palabra Reservada

IMPORTANTE : UN NOMBRE DE RESTRICCION NO SE PUEDE REPETIR EN TODO EL ESQUEMA
*/


CREATE TABLE P_Empleados(
    idEmpleado NUMBER(5),
    nombre VARCHAR2(25),
    direccion VARCHAR2(40),
    cPostal CHAR(5),
    poblacion VARCHAR2(15),
    provincia VARCHAR2(30),
    fNacimiento DATE,
    fContrato DATE,
    jefe NUMBER(5)
);

DESC P_Empleados;


CREATE TABLE P_Empleados_2(
    idEmpleado NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL UNIQUE,
    direccion VARCHAR2(40),
    cPostal CHAR(5) CHECK (cPostal LIKE '48%'),
    poblacion VARCHAR2(15),
    provincia VARCHAR2(30) CHECK (LOWER(provincia) IN ('bizkaia','gipuzkoa','araba')),
    fNacimiento DATE,
    fContrato DATE,
    jefe NUMBER(5) REFERENCES P_Empleados_2(idEmpleado)
);

DESC P_Empleados_2;

SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME)= 'p_empleados_2';

CREATE TABLE P_Empleados_3(
    idEmpleado NUMBER(5) CONSTRAINT PK_P_EMPLEADOS_3 PRIMARY KEY,
    nombre VARCHAR2(25) CONSTRAINT NN_NOMBRE NOT NULL CONSTRAINT U_NOMBRE UNIQUE,
    direccion VARCHAR2(40),
    cPostal CHAR(5) CONSTRAINT CK_CPOSTAL CHECK (cPostal LIKE '48%'),
    poblacion VARCHAR2(15),
    provincia VARCHAR2(30) CONSTRAINT CK_PROVINCIA CHECK (LOWER(provincia) IN ('bizkaia','gipuzkoa','araba')),
    fNacimiento DATE,
    fContrato DATE,
    jefe NUMBER(5) CONSTRAINT FK_EMPLEADOS_JEFE REFERENCES P_Empleados_2(idEmpleado)
);

DESC P_Empleados_3;

SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME)= 'p_empleados_3';
ALTER TABLE P_Empleados_3 DROP CONSTRAINT PK_P_EMPLEADOS_3;
ALTER TABLE P_Empleados_3 ADD CONSTRAINT PK_P_EMPLEADOS_3 PRIMARY KEY(idEmpleado);

SELECT * FROM USER_CONS_COLUMNS WHERE LOWER (TABLE_NAME)='p_empleados_3';

--CREACION DE LA TABLA DE OFICINAS EJERCICIO EN CLASE
CREATE TABLE P_OFICINAS(
    idOficna NUMBER(2) CONSTRAINT PK_P_OFICINAS PRIMARY KEY,
    Ciudad VARCHAR2(15),
    Region VARCHAR2(10) CONSTRAINT CK_REGION CHECK (UPPER(Region) IN ('NORTE','CENTRO','SUR','ESTE','OESTE')),
    Dir NUMBER(3),
    Objetivo NUMBER(10),
    VENTAS NUMBER(10)
);

SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME)= 'p_oficinas'; --Esto muestra el user dueño, la tabla y en que posicion
SELECT * FROM user_cons_columns WHERE LOWER(TABLE_NAME)= 'p_oficinas'; --Esto muestra sobre que campos estan aplicados los constraints

DESC P_OFICINAS;

INSERT INTO P_Oficinas VALUES (10, 'Basauri', 'NORTE', 101, 100000, 150000);
INSERT INTO P_Oficinas VALUES (11, 'Basauri', 'NORTE', null, null, 150000);
INSERT INTO P_Oficinas VALUES (12, 'Basauri', 'norte', null, null, 150000);

SELECT * FROM P_OFICINAS;

--RESTRICCION DE TIPO 2

CREATE TABLE P_PRODUCTOS(
    idFab CHAR (3) ,
    idProducto CHAR(5),
    descripcion VARCHAR2(20),
    precio NUMBER(6,2),
    existencias NUMBER(3),
    CONSTRAINT PK_P_PRODUCTOS PRIMARY KEY(idFab, idProducto),
    CONSTRAINT U_Descripcion UNIQUE (descripcion),
    CONSTRAINT CKPrecio CHECK (precio>0)
);
--Eliminar la tabla
DROP TABLE P_PRODUCTOS;

SELECT * FROM USER_CONSTRAINTS WHERE LOWER(table_name)='p_productos';
SELECT * FROM USER_CONS_COLUMNS WHERE LOWER(table_name)='p_productos';





