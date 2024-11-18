-- Crear la base de datos
CREATE DATABASE BIBLIOTECA;
USE BIBLIOTECA;

-- Crear las tablas
CREATE TABLE AUTOR
(
    CODIGO INT PRIMARY KEY NOT NULL,
    NOMBRE VARCHAR(30) NOT NULL
);

CREATE TABLE LIBRO
(
    CODIGO_LIBRO INT PRIMARY KEY NOT NULL,
    TITULO VARCHAR(50) NOT NULL,
    ISBN VARCHAR(15) NOT NULL,
    PAGINAS INT NOT NULL,
    EDITORIAL VARCHAR(25)
);

CREATE TABLE AUTOR_LIBRO
(
    CODIGO_AUTOR INT NOT NULL,
    CODIGO_LIBRO INT NOT NULL,
    PRIMARY KEY (CODIGO_AUTOR, CODIGO_LIBRO),
    FOREIGN KEY (CODIGO_AUTOR) REFERENCES AUTOR(CODIGO),
    FOREIGN KEY (CODIGO_LIBRO) REFERENCES LIBRO(CODIGO_LIBRO)
);

CREATE TABLE LOCALIZACION
(
    ID_LOCALIZACION INT PRIMARY KEY NOT NULL,
    RECINTO VARCHAR(25) NOT NULL
);

CREATE TABLE EJEMPLAR
(
    CODIGO_EJEMPLAR INT PRIMARY KEY NOT NULL,
    LOCALIZACION INT,
    FOREIGN KEY (LOCALIZACION) REFERENCES LOCALIZACION(ID_LOCALIZACION)
);

CREATE TABLE LIBRO_EJEMPLAR
(
    CODIGO_LIBRO INT NOT NULL,
    CODIGO_EJEMPLAR INT NOT NULL,
    PRIMARY KEY (CODIGO_LIBRO, CODIGO_EJEMPLAR),
    FOREIGN KEY (CODIGO_LIBRO) REFERENCES LIBRO(CODIGO_LIBRO),
    FOREIGN KEY (CODIGO_EJEMPLAR) REFERENCES EJEMPLAR(CODIGO_EJEMPLAR)
);

CREATE TABLE ESTUDIANTE
(
    CODIGO_USUARIO INT PRIMARY KEY NOT NULL,
    NOMBRE VARCHAR(20) NOT NULL,
    APELLIDOS VARCHAR(40) NOT NULL,
    TELEFONO VARCHAR(10) NULL,
    DIRECCION VARCHAR(100) NOT NULL,
    CARRERA VARCHAR(40) NOT NULL,
    LOCALIZACION INT NOT NULL,
    FOREIGN KEY (LOCALIZACION) REFERENCES LOCALIZACION(ID_LOCALIZACION)
);

CREATE TABLE PRESTAMO
(
    ID_PRESTAMO INT AUTO_INCREMENT PRIMARY KEY,
    CODIGO_USUARIO INT NOT NULL,
    CODIGO_EJEMPLAR INT NOT NULL,
    FECHA_PRESTAMO DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CODIGO_USUARIO) REFERENCES ESTUDIANTE(CODIGO_USUARIO) ON DELETE CASCADE,
    FOREIGN KEY (CODIGO_EJEMPLAR) REFERENCES EJEMPLAR(CODIGO_EJEMPLAR)
);

-- Insertar datos en LOCALIZACION
INSERT INTO LOCALIZACION (ID_LOCALIZACION, RECINTO)
VALUES
(1, 'Turrialba'),
(2, 'Paraiso'),
(3, 'Guapiles'),
(4, 'San Ramon'),
(5, 'San Pedro'),
(6, 'Grecia'),
(7, 'Liberia'),
(8, 'Limon');

-- Insertar datos en ESTUDIANTE
INSERT INTO ESTUDIANTE (CODIGO_USUARIO, NOMBRE, APELLIDOS, TELEFONO, DIRECCION, CARRERA, LOCALIZACION)
VALUES
(10000, 'Juan', 'Pérez', '88888888', 'San José, Zapote', 'Ingeniería Civil', 3),
(10001, 'Laura', 'González', '77777777', 'Alajuela, San Rafael', 'Arquitectura', 4),
(10002, 'Carlos', 'Rodríguez', '99999999', 'Heredia, Barva', 'Administración de Empresas', 6),
(10003, 'Paola', 'Ramírez', '66666666', 'Cartago, La Unión', 'Medicina', 7);

-- Insertar datos en EJEMPLAR
INSERT INTO EJEMPLAR (CODIGO_EJEMPLAR, LOCALIZACION)
VALUES
(1001, 1),  -- Turrialba
(1002, 2),  -- Paraiso
(1003, 3),  -- Guapiles
(1004, 4),  -- San Ramon
(1005, 5),  -- San Pedro
(1006, 6),  -- Grecia
(1007, 7),  -- Liberia
(1008, 8);  -- Limon

-- Insertar libros
INSERT INTO LIBRO (CODIGO_LIBRO, TITULO, ISBN, PAGINAS, EDITORIAL)
VALUES
(1, 'Harry Potter y la piedra filosofal', '9780747532743', 223, 'Bloomsbury'),
(2, 'Cien años de soledad', '9780307474728', 417, 'Sudamericana'),
(3, 'Don Quijote de la Mancha', '9788491051953', 863, 'Alfaguara'),
(4, 'El principito', '9780156012195', 96, 'Reynal & Hitchcock'),
(5, '1984', '9780451524935', 328, 'Secker & Warburg'),
(6, 'Orgullo y prejuicio', '9780141040349', 279, 'T. Egerton'),
(7, 'Fahrenheit 451', '9781451673319', 158, 'Ballantine Books'),
(8, 'Matar a un ruiseñor', '9780061120084', 281, 'J.B. Lippincott & Co.');

-- Insertar autores
INSERT INTO AUTOR (CODIGO, NOMBRE)
VALUES
(1, 'Gabriel Garcia Marquez'),
(2, 'J.K. Rowling'),
(3, 'Miguel de Cervantes'),
(4, 'Antoine de Saint-Exupéry'),
(5, 'George Orwell'),
(6, 'Jane Austen'),
(7, 'Ray Bradbury'),
(8, 'Harper Lee');

-- Procedimiento para registrar un préstamo
DELIMITER //
CREATE PROCEDURE RegistrarPrestamo(IN id_estudiante INT, IN id_ejemplar INT)
BEGIN
    INSERT INTO PRESTAMO (CODIGO_USUARIO, CODIGO_EJEMPLAR, FECHA_PRESTAMO)
    VALUES (id_estudiante, id_ejemplar, NOW());
END;
//
DELIMITER ;

-- Procedimiento para consultar libros
DELIMITER //
CREATE PROCEDURE ConsultarLibros(
    IN p_id_libro INT, 
    IN p_nombre VARCHAR(50), 
    IN p_isbn VARCHAR(15), 
    IN p_paginas INT, 
    IN p_editorial VARCHAR(25)
)
BEGIN
    SELECT * 
    FROM LIBRO
    WHERE 
        (p_id_libro IS NULL OR CODIGO_LIBRO = p_id_libro) AND
        (p_nombre IS NULL OR TITULO LIKE CONCAT('%', p_nombre, '%')) AND
        (p_isbn IS NULL OR ISBN = p_isbn) AND
        (p_paginas IS NULL OR PAGINAS = p_paginas) AND
        (p_editorial IS NULL OR EDITORIAL LIKE CONCAT('%', p_editorial, '%'));
END;
//
DELIMITER ;

-- Procedimiento para Actualizar Autor
DELIMITER //
CREATE PROCEDURE ActualizarAutor(
    IN p_codigo INT,
    IN p_nombre VARCHAR(30)
)
BEGIN
    UPDATE AUTOR
    SET NOMBRE = IFNULL(p_nombre, NOMBRE)
    WHERE CODIGO = p_codigo;
END;
//
DELIMITER ;

-- Procedimiento para eliminar estudiante
DELIMITER //
CREATE PROCEDURE EliminarEstudiante(
    IN p_codigo_usuario INT
)
BEGIN
    DELETE FROM ESTUDIANTE
    WHERE CODIGO_USUARIO = p_codigo_usuario;
END;
//
DELIMITER ;

-- Consultas
-- DELETE FROM ESTUDIANTE WHERE CODIGO_USUARIO > 0;
-- DELETE FROM LIBRO WHERE CODIGO_LIBRO > 0;
-- DELETE FROM AUTOR WHERE CODIGO > 0;

SELECT * FROM AUTOR;
SELECT * FROM ESTUDIANTE;
SELECT * FROM LIBRO;
SELECT * FROM PRESTAMO;
