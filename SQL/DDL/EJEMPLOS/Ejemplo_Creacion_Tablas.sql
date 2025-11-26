--Primer Ejemplo Tabla P_Empleados (Solo con Campos)

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
    fNacimiento DATE CHECK (fNacimiento),
    fContrato DATE,
    jefe NUMBER(5)
);