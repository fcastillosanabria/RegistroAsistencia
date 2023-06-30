-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-05-06 17:35:42.17
	
-- Poner en uso la base de datos master.
	USE master;
	GO

-- Eliminar y crear la base de datos CASSIATEC
	DROP DATABASE IF EXISTS CASSIATEC;
	CREATE DATABASE CASSIATEC;
	GO

-- Poner en uso la base de datos CASSIATEC.
	USE CASSIATEC;
	GO

-- Configurar el idioma español el motor de base de datos.
	SET LANGUAGE Español
	GO
	SELECT @@language AS 'Idioma'
	GO

-- Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos.
	SET DATEFORMAT dmy
	GO


-- TABLES
-- Table: ubigeo
CREATE TABLE ubigeo (
    code char(6)  NOT NULL,
    region varchar(70)  NOT NULL,
    province varchar(70)  NOT NULL,
    district varchar(70)  NOT NULL,
    CONSTRAINT ubigeo_pk PRIMARY KEY  (code)
);

-- insertar ubigeo
insert into ubigeo 
values 
('010101','AMAZONAS','CHACHAPOYAS','CHACHAPOYAS'),
('010102','AMAZONAS','CHACHAPOYAS','ASUNCION'),
('010103','AMAZONAS','CHACHAPOYAS','BALSAS'),
('010104','AMAZONAS','CHACHAPOYAS','CHETO'),
('010105','AMAZONAS','CHACHAPOYAS','CHILIQUIN'),
('010106','AMAZONAS','CHACHAPOYAS','CHUQUIBAMBA');
GO

-- Table: login
CREATE TABLE login (
    id_login int  NOT NULL,
    usuario char(8)  NOT NULL,
    password varchar(15)  NOT NULL,
    id_student int  NOT NULL,
    id_auxiliary int  NOT NULL,
    CONSTRAINT login_pk PRIMARY KEY  (id_login)
);


-- MAESTRO1 person
-- Table: person
CREATE TABLE person (
    id int IDENTITY(1,1) NOT NULL,
    document_type char(3) NOT NULL CHECK (document_type IN ('DNI', 'CNE')),
    document_number varchar(15) NOT NULL UNIQUE CHECK ((LEN(document_number) = 8) OR (LEN(document_number) = 15)),
    role char(1) NULL CHECK (role in ('A', 'D')),
    status char(1) NOT NULL DEFAULT 'A' CHECK (status in ('A', 'I')),
    turn char(1) NOT NULL CHECK (turn in ('D', 'T')),
	gender char(1) NOT NULL CHECK (gender in ('M', 'F')),
    names varchar(50)  NOT NULL,
    last_names varchar(50)  NOT NULL,
    birthdate date NOT NULL CHECK (birthdate <= DATEADD(year, -25, GETDATE())),
    email varchar(60)  NOT NULL UNIQUE CHECK (email LIKE '%@gmail.com' OR email LIKE '%@hotmail.com' OR email LIKE '%@outlook.com' OR email LIKE '%@yahoo.com'),
    phone char(9) NOT NULL UNIQUE CHECK (phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	code_ubigeo char(6)  NOT NULL,
	CONSTRAINT person_pk PRIMARY KEY  (id)
);

-- insertar person
INSERT INTO person
(document_type, document_number, role, status, turn, gender, names, last_names, birthdate, email, phone, code_ubigeo)
VALUES
('DNI', '16789456', 'A', 'A', 'D', 'M', 'Jesus', 'Guando Matos', '1972-04-12', 'jcanales@gmail.com', '976754981', '010102'),
('DNI', '71997493', 'D', 'A', 'D', 'M', 'Francis', 'Castillo Sanabria', '1972-03-17', 'fcastillosanabria@gmail.com', '154265554', '010102'),
('DNI', '15359394', 'A', 'A', 'D', 'F', 'Aide Shumay', 'Sanabria Cuevas', '1972-12-12', 'shumysanabria@gmail.com', '979767669', '010102'),
('DNI', '12555869', 'A', 'A', 'D', 'F', 'Guillermo Alejandro', 'Aranda Taco', '1972-12-12', 'alejandroTACO@gmail.com', '154442254', '010106'),
('CNE', '975642318794561', 'A', 'I', 'T', 'F', 'Gabriel', 'Sanchez Cjanche', '1988-04-12', 'gabrielsanches@hotmail.com', '976754895', '010104'),
('DNI', '95461238', 'D', 'A', 'D', 'M', 'Boris', 'Guando Guando', '1992-04-12', 'borisAngel@outlook.com', '988854981', '010106'),
('CNE', '874512367894561', 'A', 'I', 'D', 'F', 'Sofia', 'Gutierrez', '1987-08-22', 'sofiagutierrez@yahoo.com', '966547812', '010102'),
('CNE', '951236458794564', 'A', 'A', 'D', 'F', 'Maria', 'Gonzales Huayta', '1987-08-22', 'mariaGONZA@yahoo.com', '966547628', '010105'),
('DNI', '15489632', 'D', 'A', 'T', 'M', 'Luis', 'Morales', '1996-03-07', 'luismorales@gmail.com', '977432189', '010104'),
('DNI', '15236587', 'A', 'A', 'D', 'M', 'Peter', 'Parker', '1996-03-07', 'hombrearaña@gmail.com', '962225487', '010104');
GO


-- MAESTRO2 student
-- Table: student
CREATE TABLE student (
    id int IDENTITY(1,1) NOT NULL,
    document_type char(3) CHECK (document_type IN ('DNI', 'CNE')),
    document_number varchar(15) NOT NULL UNIQUE CHECK ((LEN(document_number) = 8) OR (LEN(document_number) = 15)),
    role char(1) NOT NULL DEFAULT 'S',
    status char(1) NOT NULL DEFAULT 'A' CHECK (status IN ('A', 'I')),
    turn char(5) NOT NULL CHECK (turn IN ('DIA', 'TARDE')),
    names varchar(60) NOT NULL,
    last_names varchar(60) NOT NULL,
    birthdate date NOT NULL,
    section char(1) NOT NULL,
    grade tinyint NOT NULL CHECK (grade BETWEEN 1 AND 5),
    email varchar(60) NOT NULL UNIQUE CHECK (email LIKE '%@gmail.com' OR email LIKE '%@hotmail.com' OR email LIKE '%@outlook.com' OR email LIKE '%@yahoo.com'),
    phone_proxy char(9) NOT NULL UNIQUE CHECK (phone_proxy LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	code_ubigeo char(6)  NOT NULL,
    CONSTRAINT student_pk PRIMARY KEY (id)
);

-- insertar student
INSERT INTO student
(document_type, document_number, role, status, turn, names, last_names, birthdate, section , grade, email, phone_proxy, code_ubigeo)
VALUES
('DNI', '54896578', 'S', 'A', 'DIA', 'Mariana', 'De La Cruz', '12/04/2008', 'A' , '5', 'maria@gmail.com', '956423569', '010102'),
('CNE', '512548956258454', 'S', 'A', 'DIA', 'Juana', 'Teresa', '18/04/2008', 'A' , '5', 'juana@gmail.com', '951222584', '010103'),
('DNI', '15426589', 'S', 'A', 'DIA', 'Nayeli', 'Vicente', '28/10/2008', 'A' , '5', 'nayeloFriki@hotmail.com', '954888578', '010101'),
('DNI', '52587486', 'S', 'A', 'DIA', 'Mayumi', 'Castro Herrera', '01/11/2008', 'A' , '5', 'MayumiCV@hotmail.com', '995684582', '010101'),
('DNI', '15966235', 'S', 'A', 'DIA', 'Fatima', 'Guando Castro', '26/11/2008', 'A' , '5', 'fatimaG@hotmail.com', '999562314', '010101'),
('DNI', '55569848', 'S', 'A', 'DIA', 'Maria', 'Del Rosario', '09/09/2009', 'A' , '4', 'maria8794@gmail.com', '999645845', '010104'),
('CNE', '546897569522215', 'S', 'A', 'TARDE', 'Ana Luz', 'Castillo', '12/12/2008', 'A' , '3', 'anadelluz@gmail.com', '945612345', '010104');
GO


-- Crear tabla aula
/*CREATE TABLE aula (
  idaula int PRIMARY KEY,
  descripcion varchar(50)
);
go

-- Crear tabla ocurrencia
CREATE TABLE ocurrencia (
  idocurrencia int PRIMARY KEY,
  descripcion varchar(50)
);
go

-- Crear tabla asistencia
CREATE TABLE asistencia (
  id int,
  fecha DATE,
  idocurrencia int,
  detalle varchar(50),
  PRIMARY KEY (fecha, id),
  FOREIGN KEY (id) REFERENCES student(id),
  FOREIGN KEY (idocurrencia) REFERENCES ocurrencia(idocurrencia)
);
go

-- Insertar datos en la tabla ocurrencia
INSERT INTO ocurrencia VALUES
  (1, 'PRESENTE'),
  (2, 'TARDE'),
  (3, 'JUSTIFICADO');
  go*/

-- Table: registro_asistencia
CREATE TABLE registro_asistencia (
    id_attendance int IDENTITY(1,1)  NOT NULL,
	id_estudent int  NOT NULL,
    attendance_datetime datetime NOT NULL DEFAULT GETDATE(),
    attendance_status char(1) NOT NULL CHECK (attendance_status IN ('A', 'F', 'J')),
	attendance_ocurrencia varchar(120),
    CONSTRAINT registro_asistencia_pk PRIMARY KEY  (id_attendance)
);
GO
-- Insertar dos registros en un solo código
INSERT INTO registro_asistencia (id_estudent, attendance_status, attendance_ocurrencia)
VALUES
  (1, 'A', ''),
  (2, 'F', 'Falto porque comio tarde :V'),
  (3, 'F', '');
GO


-- foreign keys
-- Reference: DOCENTE_UBIGEO (table: person)
ALTER TABLE person ADD CONSTRAINT PERSON_UBIGEO
    FOREIGN KEY (code_ubigeo)
    REFERENCES ubigeo (code);

-- Reference: ESTUDIANTE_UBIGEO (table: student)
ALTER TABLE student ADD CONSTRAINT STUDENT_UBIGEO
    FOREIGN KEY (code_ubigeo)
    REFERENCES ubigeo (code);

-- Reference: LOGIN_DOCENTE (table: login)
ALTER TABLE login ADD CONSTRAINT LOGIN_DOCENTE
    FOREIGN KEY (id_auxiliary)
    REFERENCES person (id);

-- Reference: LOGIN_ESTUDIANTE (table: login)
ALTER TABLE login ADD CONSTRAINT LOGIN_ESTUDIANTE
    FOREIGN KEY (id_student)
    REFERENCES student (id);
go

-- Reference: REGISTRO_ASISTENCIA_DOCENTE (table: registro_asistencia)
/*ALTER TABLE registro_asistencia ADD CONSTRAINT REGISTRO_ASISTENCIA_DOCENTE
    FOREIGN KEY (id_person)
    REFERENCES person (id);*/

-- Reference: REGISTRO_ASISTENCIA_ESTUDIANTE (table: registro_asistencia)
ALTER TABLE registro_asistencia ADD CONSTRAINT REGISTRO_ASISTENCIA_ESTUDIANTE
    FOREIGN KEY (id_estudent)
    REFERENCES student (id);
GO

--Vista Person
CREATE VIEW listado_person AS 
SELECT 
	id AS 'ID',
	document_type AS 'TIPO DE DOC',
	document_number AS 'NUMERO DE DOC',
	CASE 
    	WHEN role = 'A' THEN 'Auxiliar' 
    	WHEN role = 'D' THEN 'Director'
    END AS 'ROL',
	CASE 
    	WHEN status = 'A' THEN 'Activo' 
    	WHEN status = 'I' THEN 'Inactivo'
    END AS 'ESTADO',
	CASE 
    	WHEN turn = 'D' THEN 'Dia' 
    	WHEN turn = 'T' THEN 'Tarde'
    END AS 'TURNO',
	CASE 
    	WHEN gender = 'M' THEN 'Masculino' 
    	WHEN gender = 'F' THEN 'Femenino'
    END AS 'SEXO',
	CONCAT(UPPER(last_names), ', ', names) AS 'PERSONA',
	FORMAT(birthdate, 'dd - MMM - yyyy') AS 'FEC. NACIMIENTO',
	email AS 'EMAIL',
	phone AS 'CELULAR',
	CASE 
    	WHEN code_ubigeo = '010101' THEN 'AMAZONAS, CHACHAPOYAS, CHACHAPOYAS'
    	WHEN code_ubigeo = '010102' THEN 'AMAZONAS, CHACHAPOYAS, ASUNCION'
    	WHEN code_ubigeo = '010103' THEN 'AMAZONAS, CHACHAPOYAS, BALSAS'
    	WHEN code_ubigeo = '010104' THEN 'AMAZONAS, CHACHAPOYAS, CHETO'
    	WHEN code_ubigeo = '010105' THEN 'AMAZONAS, CHACHAPOYAS, CHILIQUIN'
    	WHEN code_ubigeo = '010106' THEN 'AMAZONAS, CHACHAPOYAS, CHUQUIBAMBA'
    END AS 'UBIGEO'
FROM person;
GO

SELECT * FROM listado_person;
GO

-- End of file.


--Ejemplo para ver mejor las tablas
/*
CREATE VIEW listado_personas AS 
select 
	id as 'ID',
	number_dni as 'DNI',
	CONCAT(UPPER(last_name), ', ', names) AS 'PERSONA',
	cell_phone as 'CELULAR',
	email as 'EMAIL',
	FORMAT(birthday, 'dd - MMM - yyyy') AS 'FEC. NACIMIENTO',
    CASE 
    WHEN type_person = 'V' THEN 'Vendedor' 
    WHEN type_person = 'C' THEN 'Cliente'
	WHEN type_person = 'J' THEN 'Jefe'
    END AS 'Tipo'
from persons;
GO

select * from listado_personas;
GO
*/

-- mostrar las tablas con las insersiones
select * from person;
select * from student;
select * from registro_asistencia;
GO

/*SELECT ra.id_attendance, s.document_number, s.last_names, s.names, s.grade, s.section, s.turn, ra.attendance_datetime, ra.attendance_status
FROM registro_asistencia ra
JOIN student s ON ra.id_estudent = s.id;
GO*/