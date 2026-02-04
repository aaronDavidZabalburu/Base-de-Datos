/* EXAMEN TIPO DDL */

/*1.- Crear las tablas: COCHES, MECANICOS, TRABAJOS */
CREATE TABLE COCHES(
matricula CHAR(9) CONSTRAINT PK_COCHES PRIMARY KEY ,
marca VARCHAR2(15) CONSTRAINT CK_MARCA CHECK 
            (LOWER(marca) IN ('ford', 'renault', 'seat', 'citroen', 'toyota')),
fabricacion NUMBER(2)
);

CREATE TABLE MECANICOS(
dni CHAR(9),
nombre VARCHAR2(15) CONSTRAINT NN_NOMBRE NOT NULL,
puesto VARCHAR2(15),
parcial CHAR(1) DEFAULT '0',
CONSTRAINT PK_MECANICOS PRIMARY KEY(dni),
CONSTRAINT U_NOMBRE UNIQUE(nombre),
CONSTRAINT CK_PUESTO CHECK(LOWER(puesto)IN ('motor','amortiguacion','chapa'))
);

CREATE TABLE TRABAJOS(
MATRICULA CHAR(9),
DNI CHAR(9),
HORAS NUMBER(3,1),
FECHA_REPARACION DATE,
CONSTRAINT FK_COCHES_TRABAJO FOREIGN KEY(matricula) REFERENCES COCHES(matricula),
CONSTRAINT CK_HORAS CHECK (horas>0)
);

/*2.- A�adir el atributo MODELO a la tabla COCHES. 
Este campo no puede contener valores nulos. (15 caracteres � texto variable)*/
ALTER TABLE COCHES ADD (modelo VARCHAR(15) CONSTRAINT NN_modelo NOT NULL,
                        color VARCHAR(15) CONSTRAINT CK_COLOR CHECK (LOWER(color) IN ('rojo','verde','azul')));


/*3.- Establecer los atributos MATRICULA y DNI como la clave principal de TRABAJOS.*/
ALTER TABLE TRABAJOS ADD CONSTRAINT PK_TRABAJOS PRIMARY KEY(matricula,dni);

/*4.- Establecer el atributo DNI de TRABAJOS como clave extranjera a la tabla de MECANICOS.*/
ALTER TABLE TRABAJOS ADD CONSTRAINT FK_MECANICOS_TRABAJOS FOREIGN KEY (dni) REFERENCES mecanicos;

/*5.- Ampliar la longitud a 4 del atributo Fabricaci�n de la tabla COCHES.*/
ALTER TABLE COCHES MODIFY fabricacion NUMBER(4);


/*6.- Cambiar el nombre del atributo HORAS de la tabla TRABAJOS por HORAS_EMPLEADAS.*/
/*7.- Insertar los siguientes registros:
Comprueba que hayan sido insertados y guarda los cambios en la BD para que sean permanentes.*/
/*8.- Inserta el siguiente registro en la tabla TRABAJOS:
�Qu� ha sucedido? �Por qu�?
�Qu� se te ocurre para poder insertarlo?
�Existe alguna otra posibilidad de insertarlo?
Si has hecho alg�n cambio, vuelve a dejar todo como estaba inicialmente.*/
/*9.- Modificar a CHAPA el puesto de ANTONIO.*/
/*10.- Borrar a LUIS de la tabla MECANICOS. �Qu� debemos hacer para conseguir borrar este empleado?
Deshaz los cambios.*/
/*11.- Borrar los trabajos realizados por Luis y despu�s eliminar a Luis
Deshaz los cambios.*/
/*12.- Aumentar las horas de los trabajos hechos el '23-FEB-96' en un 15%.*/
/*13.- Asignar los trabajos de LUIS a ANTONIO. (No vale usar los DNIs)*/
/*14.- Eliminar la clave principal de la tabla COCHES.*/
/*15.- Eliminar la tabla TRABAJOS.*/
/*16.- Insertar en la tabla TRABAJOS_ANTONIO un nuevo trabajo para el coche con matr�cula J1234Z hecho por el mec�nico llamado ANTONIO
(no sirve dni: 1111), asignarle 2,5 horas al trabajo y la fecha de reparaci�n ser� la del d�a de hoy*/