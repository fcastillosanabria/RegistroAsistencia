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
GO

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
GO


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
GO

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
GO

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
('DNI', '55569048', 'S', 'A', 'DIA', 'Luzia', 'Mendieta Cardena', '09/09/2009', 'A' , '1', 'luzia8794@gmail.com', '999640000', '010104'),
('DNI', '78901234', 'S', 'A', 'DIA', 'Isabel', 'Sanchez', '2009-01-14', 'A', '2', 'isabel@gmail.com', '789012345', '010101'),
('DNI', '89012345', 'S', 'A', 'DIA', 'Elena', 'Torres', '2008-12-30', 'A', '3', 'elena@gmail.com', '890123456', '010101'),
('DNI', '90123456', 'S', 'A', 'DIA', 'Fernanda', 'Mendez', '2009-11-03', 'A', '4', 'fernanda@gmail.com', '901234567', '010101'),
('DNI', '01234567', 'S', 'A', 'DIA', 'Victoria', 'Rojas', '2010-05-09', 'A', '5', 'victoria@gmail.com', '012345678', '010101'),
('DNI', '09876543', 'S', 'A', 'DIA', 'Gabriela', 'Cruz', '2009-07-22', 'A', '1', 'gabriela@gmail.com', '098765432', '010101'),
('DNI', '23456789', 'S', 'A', 'DIA', 'Valentina', 'Alvarez', '2010-06-10', 'A', '2', 'valentina88@gmail.com', '234567890', '010101'),
('DNI', '34567890', 'S', 'A', 'DIA', 'Camila', 'Mendoza', '2009-08-25', 'A', '3', 'cami@gmail.com', '345678901', '010101'),
('DNI', '45678901', 'S', 'A', 'DIA', 'Luciana', 'Lopez', '2010-04-05', 'A', '4', 'luciana@gmail.com', '456789012', '010101'),
('DNI', '56789012', 'S', 'A', 'DIA', 'Diana', 'Perez', '2009-10-15', 'A', '5', 'diANArar@gmail.com', '567890123', '010101'),
('DNI', '86123456', 'S', 'A', 'DIA', 'Daniela', 'Fuentes', '2010-09-20', 'A', 2, 'daniela@gmail.com', '861234567', '010101'),
('DNI', '77012345', 'S', 'A', 'DIA', 'Valeria', 'Ortega', '2009-06-11', 'A', 3, 'valeria@gmail.com', '770123456', '010101'),
('DNI', '68123456', 'S', 'A', 'DIA', 'Renata', 'Garcia', '2010-02-25', 'A', 4, 'renata@gmail.com', '681234567', '010101'),
('DNI', '59123456', 'S', 'A', 'DIA', 'Florencia', 'Paz', '2009-11-17', 'A', 5, 'florencia@gmail.com', '591234567', '010101'),
('DNI', '50123456', 'S', 'A', 'DIA', 'Mia', 'Jimenez', '2010-08-30', 'A', 1, 'miacastro@gmail.com', '501234567', '010101'),
('DNI', '41123456', 'S', 'A', 'DIA', 'Antonella', 'Silva', '2009-05-12', 'A', 2, 'antonella75257@gmail.com', '411234567', '010101'),
('DNI', '32123456', 'S', 'A', 'DIA', 'Bianca', 'Cruz', '2010-01-05', 'A', 3, 'bianca8282@gmail.com', '321234567', '010101'),
('DNI', '23123456', 'S', 'A', 'DIA', 'Lola', 'Marquez', '2009-10-27', 'A', 4, 'lolaXD@gmail.com', '231234567', '010101'),
('DNI', '14123456', 'S', 'A', 'DIA', 'Penelope', 'Valdez', '2010-07-09', 'A', 5, 'penelo@gmail.com', '141234567', '010101'),
('DNI', '95123645', 'S', 'A', 'TARDE', 'Isabella', 'Rojas', '2008-04-05', 'A', 3, 'isabella@hotmail.com', '951236459', '010104'),
('DNI', '86123454', 'S', 'A', 'TARDE', 'Valentina', 'Sanchez', '2009-09-15', 'A', 1, 'valentina87578@hotmail.com', '861234549', '010104'),
('DNI', '77012343', 'S', 'A', 'TARDE', 'Camila', 'Mendoza', '2008-12-20', 'A', 4, 'camilacabello@hotmail.com', '770123439', '010104'),
('DNI', '68123452', 'S', 'A', 'TARDE', 'Luciana', 'Perez', '2009-11-02', 'A', 2, 'lucianaxd@hotmail.com', '681234529', '010104'),
('DNI', '59123454', 'S', 'A', 'TARDE', 'Diana', 'Gutierrez', '2008-10-10', 'A', 5, 'dianaEXE@hotmail.com', '591234549', '010104'),
('DNI', '50123454', 'S', 'A', 'TARDE', 'Mia', 'Fuentes', '2009-07-25', 'A', 3, 'mia75@hotmail.com', '501234549', '010104'),
('DNI', '41123458', 'S', 'A', 'TARDE', 'Antonella', 'Ortega', '2010-05-19', 'A', 1, 'antonella58@hotmail.com', '411234589', '010104'),
('DNI', '56891234', 'S', 'A', 'TARDE', 'Luciana', 'Paz', '2009-11-26', 'A', 4, 'lucianaJAJ@gmail.com', '568912345', '010104'),
('DNI', '48796321', 'S', 'A', 'TARDE', 'Diana', 'Jimenez', '2009-10-18', 'A', 5, 'dianaHELLOWORLD@gmail.com', '487963215', '010104'),
('DNI', '39698547', 'S', 'A', 'TARDE', 'Mia', 'Silva', '2009-07-30', 'A', 1, 'mia785@gmail.com', '396985478', '010104'),
('DNI', '48796325', 'S', 'A', 'TARDE', 'Antonella', 'Cruz', '2010-05-05', 'A', 2, 'antonella785@gmail.com', '487963256', '010104'),
('DNI', '69854712', 'S', 'A', 'TARDE', 'Bianca', 'Marquez', '2009-09-27', 'A', 3, 'bianca496@gmail.com', '698547123', '010104'),
('DNI', '85963214', 'S', 'A', 'TARDE', 'Lola', 'Valdez', '2010-02-09', 'A', 4, 'lola8484@gmail.com', '859632145', '010104'),
('DNI', '89632147', 'S', 'A', 'TARDE', 'Penelope', 'Gutierrez', '2009-11-10', 'A', 5, 'lope@gmail.com', '896321478', '010104'),
('DNI', '74569321', 'S', 'A', 'TARDE', 'Olivia', 'Fuentes', '2010-08-25', 'A', 3, 'olivia8282@gmail.com', '745693215', '010104'),
('DNI', '98654713', 'S', 'A', 'TARDE', 'Sofia', 'Ortega', '2008-06-15', 'A', 1, 'sofiacaca@gmail.com', '986547139', '010104'),
('DNI', '25698741', 'S', 'A', 'TARDE', 'Valentina', 'Paz', '2009-04-20', 'A', 2, 'Vtina@gmail.com', '256987415', '010104'),
('DNI', '98741562', 'S', 'A', 'TARDE', 'Camila', 'Jimenez', '2010-01-03', 'A', 3, 'camila541@gmail.com', '987415628', '010104'),
('DNI', '74215896', 'S', 'A', 'TARDE', 'Luciana', 'Silva', '2009-10-22', 'A', 4, 'luciana516651159@gmail.com', '742158965', '010104'),
('DNI', '96587412', 'S', 'A', 'TARDE', 'Diana', 'Marquez', '2010-07-05', 'A', 5, 'diana@gmail.com', '965874129', '010104'),
('DNI', '75369841', 'S', 'A', 'TARDE', 'Mia', 'Valdez', '2009-03-10', 'A', 1, 'mia888@gmail.com', '753698415', '010104'),
('DNI', '87412365', 'S', 'A', 'TARDE', 'Antonella', 'Gutierrez', '2010-09-12', 'A', 2, 'anto@gmail.com', '874123658', '010104'),
('DNI', '36587412', 'S', 'A', 'TARDE', 'Bianca', 'Fuentes', '2009-06-25', 'A', 3, 'biancaholamunda@gmail.com', '365874129', '010104'),
('DNI', '58741236', 'S', 'A', 'TARDE', 'Lola', 'Ortega', '2010-02-09', 'A', 4, 'lolavaca@gmail.com', '587412369', '010104'),
('DNI', '96321475', 'S', 'A', 'TARDE', 'Penelope', 'Paz', '2009-11-10', 'A', 5, 'pen@gmail.com', '954213658', '010104'),
('DNI', '36547812', 'S', 'A', 'TARDE', 'Olivia', 'Gutierrez', '2009-07-25', 'A', 1, 'olivia2828@gmail.com', '365478125', '010104'),
('DNI', '58741239', 'S', 'A', 'TARDE', 'Sofia', 'Fuentes', '2010-05-05', 'A', 2, 'sofiaccccc@gmail.com', '587412395', '010104'),
('DNI', '21475369', 'S', 'A', 'TARDE', 'Valentina', 'Ortega', '2008-09-27', 'A', 3, 'val@gmail.com', '214753698', '010104'),
('DNI', '96321422', 'S', 'A', 'TARDE', 'Camila', 'Paz', '2010-02-09', 'A', 4, 'camila987777@gmail.com', '954000015', '010104'),
('CNE', '546897569522215', 'S', 'A', 'TARDE', 'Ana Luz', 'Castillo', '12/12/2008', 'A' , '3', 'anadelluz@gmail.com', '945612345', '010104');
GO


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
-- Insertar tres registros en un solo código
INSERT INTO registro_asistencia (id_estudent, attendance_status, attendance_ocurrencia)
VALUES
  (1, 'A', ''),
  (4, 'F', 'Falto porque comio tarde :V'),
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


-- Reference: REGISTRO_ASISTENCIA_DOCENTE (table: registro_asistencia)
/*ALTER TABLE registro_asistencia ADD CONSTRAINT REGISTRO_ASISTENCIA_DOCENTE
    FOREIGN KEY (id_person)
    REFERENCES person (id);*/

-- Reference: REGISTRO_ASISTENCIA_ESTUDIANTE (table: registro_asistencia)
ALTER TABLE registro_asistencia ADD CONSTRAINT REGISTRO_ASISTENCIA_ESTUDIANTE
    FOREIGN KEY (id_estudent)
    REFERENCES student (id);
GO

----------------------------------------------------
--Vista Person
----------------------------------------------------
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

----------------------------------------------------
--Vista Asistencia
----------------------------------------------------
CREATE VIEW listado_asistencia AS
SELECT 
	ra.id_attendance AS 'ID ASISTENCIA', 
	s.document_number AS 'NUMERO DE DOCUMENTO', 
	CONCAT(s.last_names, ', ', s.names) AS 'ESTUDIANTE', 
	s.grade AS 'GRADO', 
	s.section AS 'SECCION', 
	s.turn AS 'TURNO', 
	ra.attendance_datetime AS 'FECHA DE REGISTRO', 
	CASE 
		WHEN ra.attendance_status = 'A' THEN 'ASISTIO' 
		WHEN ra.attendance_status = 'F' THEN 'FALTO' 
		WHEN ra.attendance_status = 'J' THEN 'JUSTIFICO' 
	END AS 'ESTADO DE LA ASISTENCIA', 
	ra.attendance_ocurrencia AS 'OCURRENCIA'
	FROM registro_asistencia ra
JOIN student s ON ra.id_estudent = s.id;
GO

SELECT * FROM listado_asistencia;
GO


-- End of file.

-- mostrar las tablas con las insersiones
select * from person;
select * from student;
select * from registro_asistencia;
GO