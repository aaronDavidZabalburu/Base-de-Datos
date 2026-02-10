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
ALTER TABLE TRABAJOS RENAME COLUMN HORAS TO HORAS_EMPLEADAS;
/*7.- Insertar los siguientes registros:
Comprueba que hayan sido insertados y guarda los cambios en la BD para que sean permanentes.*/
INSERT INTO COCHES (matricula, marca, modelo, fabricacion)
values ('M320KY', 'Toyota', 'Carina Megane', 1996);
select * from coches;
commit;
/*8.- Inserta el siguiente registro en la tabla TRABAJOS:
�Qu� ha sucedido? �Por qu�?
�Qu� se te ocurre para poder insertarlo?
�Existe alguna otra posibilidad de insertarlo?
Si has hecho alg�n cambio, vuelve a dejar todo como estaba inicialmente.*/

INSERT INTO MECANICOS (dni, nombre, puesto, parcial)
values (111111111, 'ANTONIO', 'MOTOR', 1);

INSERT INTO MECANICOS (dni, nombre, puesto, parcial)
values (222222222, 'LUIS', 'MOTOR', 0);

DELETE FROM MECANICOS;

INSERT INTO TRABAJOS (matricula, dni, horas_empleadas, fecha_reparacion)
VALUES ('M320KY',111111111, 1, '23/02/96');

INSERT INTO TRABAJOS (matricula, dni, horas_empleadas, fecha_reparacion)
VALUES ('M320KY',222222222, 2.5, '23/02/96');

INSERT INTO TRABAJOS (matricula, dni, horas_empleadas, fecha_reparacion)
VALUES ('J1234Z', NULL, 7, '19/03/97');
/*NO SE HAN ISERTADO LOS DATOS EN LA TABLA TRABAJOS PORQUE NO EXISTE EL MECANICO CON DNI 4444444 Y AL SER PRIMARY KEY El SISTEMA NO LO DEJA*/
/*PARA PODER INSERTAR EL TRABAJO HABRIA QUE CREAR PRIMERO EL MECANICO CON DNI 44444444*/
/*PARA PODERLO AGREGARLO LA TABLA DE MECANICOS EN EL ATRIBUTO DNI ADMITE VALORES NULL AL SER ASI SE PODRIA AGREGAR CON EL CAMPO DNI NULL*/
/*Una manera de agregarlo seria desactivando la constraint en trabajos y luego activandola.*/

/*9.- Modificar a CHAPA el puesto de ANTONIO.*/
UPDATE MECANICOS set puesto = 'CHAPA'
    WHERE dni = 111111111; 
/*10.- Borrar a LUIS de la tabla MECANICOS. �Qu� debemos hacer para conseguir borrar este empleado?
Deshaz los cambios.*/
ALTER TABLE TRABAJOS DROP CONSTRAINT FK_MECANICOS_TRABAJOS;
ALTER TABLE TRABAJOS ADD CONSTRAINT FK_MECANICOS_TRABAJOS 
    FOREIGN KEY (dni) REFERENCES MECANICOS(dni) ON DELETE CASCADE;

DELETE FROM MECANICOS 
    WHERE dni = '222222222';
ROLLBACK; --> DESHACE LOS CAMBIOS
SELECT * FROM MECANICOS;
/*Como creamos la foreign key y no le dejamos on delete cascade, primero eliminamos la constraint
y luego la volvemos a crear con on delete cascade evitando asi que oracle proteja los datos evitando que se eliminen los mecanicos y dejando trabajos huerfanos*/

/*11.- Borrar los trabajos realizados por Luis y despu�s eliminar a Luis
Deshaz los cambios.*/
DELETE FROM TRABAJOS 
    WHERE dni = '222222222';

DELETE FROM MECANICOS
    WHERE dni = '222222222';
    
    ROLLBACK;

/*12.- Aumentar las horas de los trabajos hechos el '23-FEB-96' en un 15%.*/
/*13.- Asignar los trabajos de LUIS a ANTONIO. (No vale usar los DNIs)*/

/*14.- Eliminar la clave principal de la tabla COCHES.*/
ALTER TABLE COCHES DROP CONSTRAINT PK_COCHES CASCADE; --> COMO HACE REFERENCIA A OTRAS TABLAS HAY QUE USAR EL CASCADE

/*15.- Eliminar la tabla TRABAJOS.*/
DROP TABLE TRABAJOS;

/*16.- Insertar en la tabla TRABAJOS_ANTONIO un nuevo trabajo para el coche con matr�cula J1234Z hecho por el mec�nico llamado ANTONIO
(no sirve dni: 1111), asignarle 2,5 horas al trabajo y la fecha de reparaci�n ser� la del d�a de hoy*/

-- Confirmar la inserción
COMMIT;