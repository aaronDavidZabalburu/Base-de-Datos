CREATE TABLE Personas(
IDpersona NUMBER(4) PRIMARY KEY,
Nombre VARCHAR2(30),
Titulacion VARCHAR2(15),
FechaNacimineto DATE
);

CREATE TABLE Departamentos(
IDDepartamento NUMBER(2) PRIMARY KEY,
Nombre VARCHAR2(15),
Jefe NUMBER(4) REFERENCES Personas (IDPersona),
Planta NUMBER(2)
);

SELECT * FROM Personas;

SELECT * FROM Departamentos;

INSERT INTO Personas VALUES (1,'Iñigo Chueca','Informatica','10-10-1966');
INSERT INTO Personas VALUES (2,'Marta Torre','Informatica','10-12-1971');
INSERT INTO Personas VALUES (3,'Inez W.','Informatica','28-07-2006');
INSERT INTO Personas VALUES (4,'Iker Navarro','Informatica',null);
INSERT INTO Personas VALUES (null,'Maxwell Smart','Informatica','29-05-2007');

INSERT INTO Departamentos VALUES (1,'Sistemas',1,4);
INSERT INTO Departamentos VALUES (2,'Finanzas',3,3);
INSERT INTO Departamentos VALUES (3,'Desarrollo',1,4);
INSERT INTO Departamentos VALUES (4,'Laboratorios',null,4);

UPDATE Departamentos SET planta = 2 WHERE iddepartamento = 3;
UPDATE Departamentos SET nombre = 'Aplicaciones' WHERE LOWER(nombre) = 'desarrollo';
UPDATE Departamentos SET nombre = 'Aplicaciones' WHERE UPPER(nombre) = 'DESAROLLO';


DELETE FROM Departamentos WHERE LOWER(nombre) = 'sistemas';







