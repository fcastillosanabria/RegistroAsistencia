-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-05-06 17:35:42.17
-- Adaptado para MySQL

-- Eliminar y crear la base de datos CASSIATEC
DROP DATABASE IF EXISTS CASSIATEC;
CREATE DATABASE CASSIATEC CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos CASSIATEC
USE CASSIATEC;

-- TABLES
-- Table: ubigeo
CREATE TABLE ubigeo (
    code CHAR(6) NOT NULL,
    region VARCHAR(70) NOT NULL,
    province VARCHAR(70) NOT NULL,
    district VARCHAR(70) NOT NULL,
    CONSTRAINT ubigeo_pk PRIMARY KEY (code)
) ENGINE=InnoDB;

-- Insertar ubigeo
INSERT INTO ubigeo VALUES 
('010101','AMAZONAS','CHACHAPOYAS','CHACHAPOYAS'),
('010102','AMAZONAS','CHACHAPOYAS','ASUNCION'),
('010103','AMAZONAS','CHACHAPOYAS','BALSAS'),
('010104','AMAZONAS','CHACHAPOYAS','CHETO'),
('010105','AMAZONAS','CHACHAPOYAS','CHILIQUIN'),
('010106','AMAZONAS','CHACHAPOYAS','CHUQUIBAMBA');

-- Table: person
-- Table: person
CREATE TABLE person (
    id INT NOT NULL AUTO_INCREMENT,
    document_type CHAR(3) NOT NULL CHECK (document_type IN ('DNI', 'CNE')),
    document_number VARCHAR(15) NOT NULL UNIQUE,
    role CHAR(1) NULL CHECK (role IN ('A', 'D')),
    status CHAR(1) NOT NULL DEFAULT 'A' CHECK (status IN ('A', 'I')),
    turn CHAR(1) NOT NULL CHECK (turn IN ('D', 'T')),
    gender CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')),
    names VARCHAR(50) NOT NULL,
    last_names VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    phone CHAR(9) NOT NULL UNIQUE,
    code_ubigeo CHAR(6) NOT NULL,
    CONSTRAINT person_pk PRIMARY KEY (id),
    CONSTRAINT chk_person_document_length CHECK (
        (LENGTH(document_number) = 8) OR (LENGTH(document_number) = 15)
    ),
    -- Removido el CHECK de birthdate - se validará con TRIGGER
    CONSTRAINT chk_person_email CHECK (
        email LIKE '%@gmail.com' OR 
        email LIKE '%@hotmail.com' OR 
        email LIKE '%@outlook.com' OR 
        email LIKE '%@yahoo.com'
    ),
    CONSTRAINT chk_person_phone CHECK (phone REGEXP '^[0-9]{9}$')
) ENGINE=InnoDB;

-- Crear TRIGGER para validar birthdate (debe ser mayor de 25 años)
DELIMITER //

CREATE TRIGGER trg_person_birthdate_insert
BEFORE INSERT ON person
FOR EACH ROW
BEGIN
    IF NEW.birthdate > DATE_SUB(CURDATE(), INTERVAL 25 YEAR) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La persona debe tener al menos 25 años de edad';
    END IF;
END//

CREATE TRIGGER trg_person_birthdate_update
BEFORE UPDATE ON person
FOR EACH ROW
BEGIN
    IF NEW.birthdate > DATE_SUB(CURDATE(), INTERVAL 25 YEAR) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La persona debe tener al menos 25 años de edad';
    END IF;
END//

DELIMITER ;

-- Insertar person
INSERT INTO person (document_type, document_number, role, status, turn, gender, names, last_names, birthdate, email, phone, code_ubigeo) VALUES
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

-- Table: student
CREATE TABLE student (
    id INT NOT NULL AUTO_INCREMENT,
    document_type CHAR(3) CHECK (document_type IN ('DNI', 'CNE')),
    document_number VARCHAR(15) NOT NULL UNIQUE,
    role CHAR(1) NOT NULL DEFAULT 'S',
    status CHAR(1) NOT NULL DEFAULT 'A' CHECK (status IN ('A', 'I')),
    turn CHAR(5) NOT NULL CHECK (turn IN ('DIA', 'TARDE')),
    names VARCHAR(60) NOT NULL,
    last_names VARCHAR(60) NOT NULL,
    birthdate DATE NOT NULL,
    section CHAR(1) NOT NULL,
    grade TINYINT NOT NULL CHECK (grade BETWEEN 1 AND 5),
    email VARCHAR(60) NOT NULL UNIQUE,
    phone_proxy CHAR(9) NOT NULL UNIQUE,
    code_ubigeo CHAR(6) NOT NULL,
    CONSTRAINT student_pk PRIMARY KEY (id),
    CONSTRAINT chk_student_document_length CHECK (
        (LENGTH(document_number) = 8) OR (LENGTH(document_number) = 15)
    ),
    CONSTRAINT chk_student_email CHECK (
        email LIKE '%@gmail.com' OR 
        email LIKE '%@hotmail.com' OR 
        email LIKE '%@outlook.com' OR 
        email LIKE '%@yahoo.com'
    ),
    CONSTRAINT chk_student_phone CHECK (phone_proxy REGEXP '^[0-9]{9}$')
) ENGINE=InnoDB;

-- Insertar student
INSERT INTO student (document_type, document_number, role, status, turn, names, last_names, birthdate, section, grade, email, phone_proxy, code_ubigeo) VALUES
('DNI', '54896578', 'S', 'A', 'DIA', 'Mariana', 'De La Cruz', '2008-04-12', 'A', 5, 'maria@gmail.com', '956423569', '010102'),
('CNE', '512548956258454', 'S', 'A', 'DIA', 'Juana', 'Teresa', '2008-04-18', 'A', 5, 'juana@gmail.com', '951222584', '010103'),
('DNI', '15426589', 'S', 'A', 'DIA', 'Nayeli', 'Vicente', '2008-10-28', 'A', 5, 'nayeloFriki@hotmail.com', '954888578', '010101'),
('DNI', '52587486', 'S', 'A', 'DIA', 'Mayumi', 'Castro Herrera', '2008-11-01', 'A', 5, 'MayumiCV@hotmail.com', '995684582', '010101'),
('DNI', '15966235', 'S', 'A', 'DIA', 'Fatima', 'Guando Castro', '2008-11-26', 'A', 5, 'fatimaG@hotmail.com', '999562314', '010101'),
('DNI', '55569848', 'S', 'A', 'DIA', 'Maria', 'Del Rosario', '2009-09-09', 'A', 4, 'maria8794@gmail.com', '999645845', '010104'),
('DNI', '55569048', 'S', 'A', 'DIA', 'Luzia', 'Mendieta Cardena', '2009-09-09', 'A', 1, 'luzia8794@gmail.com', '999640000', '010104'),
('DNI', '78901234', 'S', 'A', 'DIA', 'Isabel', 'Sanchez', '2009-01-14', 'A', 2, 'isabel@gmail.com', '789012345', '010101'),
('DNI', '89012345', 'S', 'A', 'DIA', 'Elena', 'Torres', '2008-12-30', 'A', 3, 'elena@gmail.com', '890123456', '010101'),
('DNI', '90123456', 'S', 'A', 'DIA', 'Fernanda', 'Mendez', '2009-11-03', 'A', 4, 'fernanda@gmail.com', '901234567', '010101'),
('DNI', '01234567', 'S', 'A', 'DIA', 'Victoria', 'Rojas', '2010-05-09', 'A', 5, 'victoria@gmail.com', '012345678', '010101'),
('DNI', '09876543', 'S', 'A', 'DIA', 'Gabriela', 'Cruz', '2009-07-22', 'A', 1, 'gabriela@gmail.com', '098765432', '010101'),
('DNI', '23456789', 'S', 'A', 'DIA', 'Valentina', 'Alvarez', '2010-06-10', 'A', 2, 'valentina88@gmail.com', '234567890', '010101'),
('DNI', '34567890', 'S', 'A', 'DIA', 'Camila', 'Mendoza', '2009-08-25', 'A', 3, 'cami@gmail.com', '345678901', '010101'),
('DNI', '45678901', 'S', 'A', 'DIA', 'Luciana', 'Lopez', '2010-04-05', 'A', 4, 'luciana@gmail.com', '456789012', '010101'),
('DNI', '56789012', 'S', 'A', 'DIA', 'Diana', 'Perez', '2009-10-15', 'A', 5, 'diANArar@gmail.com', '567890123', '010101'),
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
('CNE', '546897569522215', 'S', 'A', 'TARDE', 'Ana Luz', 'Castillo', '2008-12-12', 'A', 3, 'anadelluz@gmail.com', '945612345', '010104');

-- Table: login
CREATE TABLE login (
    id_login INT NOT NULL,
    usuario CHAR(8) NOT NULL,
    password VARCHAR(15) NOT NULL,
    id_student INT NOT NULL,
    id_auxiliary INT NOT NULL,
    CONSTRAINT login_pk PRIMARY KEY (id_login)
) ENGINE=InnoDB;

-- Table: registro_asistencia
CREATE TABLE registro_asistencia (
    id_attendance INT NOT NULL AUTO_INCREMENT,
    id_estudent INT NOT NULL,
    attendance_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    attendance_status CHAR(1) NOT NULL CHECK (attendance_status IN ('A', 'F', 'J')),
    attendance_ocurrencia VARCHAR(120),
    CONSTRAINT registro_asistencia_pk PRIMARY KEY (id_attendance)
) ENGINE=InnoDB;

-- Insertar registros de asistencia
INSERT INTO registro_asistencia (id_estudent, attendance_status, attendance_ocurrencia) VALUES
(1, 'A', ''),
(4, 'F', 'Falto porque comio tarde :V'),
(3, 'F', '');

-- FOREIGN KEYS
-- Reference: PERSON_UBIGEO
ALTER TABLE person 
    ADD CONSTRAINT PERSON_UBIGEO 
    FOREIGN KEY (code_ubigeo) 
    REFERENCES ubigeo (code);

-- Reference: STUDENT_UBIGEO
ALTER TABLE student 
    ADD CONSTRAINT STUDENT_UBIGEO 
    FOREIGN KEY (code_ubigeo) 
    REFERENCES ubigeo (code);

-- Reference: LOGIN_DOCENTE
ALTER TABLE login 
    ADD CONSTRAINT LOGIN_DOCENTE 
    FOREIGN KEY (id_auxiliary) 
    REFERENCES person (id);

-- Reference: LOGIN_ESTUDIANTE
ALTER TABLE login 
    ADD CONSTRAINT LOGIN_ESTUDIANTE 
    FOREIGN KEY (id_student) 
    REFERENCES student (id);

-- Reference: REGISTRO_ASISTENCIA_ESTUDIANTE
ALTER TABLE registro_asistencia 
    ADD CONSTRAINT REGISTRO_ASISTENCIA_ESTUDIANTE 
    FOREIGN KEY (id_estudent) 
    REFERENCES student (id);

-- ----------------------------------------------------
-- Vista Person
-- ----------------------------------------------------
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
    DATE_FORMAT(birthdate, '%d - %b - %Y') AS 'FEC. NACIMIENTO',
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

-- ----------------------------------------------------
-- Vista Asistencia
-- ----------------------------------------------------
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

-- Mostrar las tablas con las inserciones
SELECT * FROM person;
SELECT * FROM student;
SELECT * FROM registro_asistencia;

-- Mostrar las vistas
SELECT * FROM listado_person;
SELECT * FROM listado_asistencia;

-- End of file.