CREATE DATABASE Libreria;
USE Libreria;

CREATE TABLE Usuario(
	Id INT PRIMARY KEY NOT NULL,
	Nombre VARCHAR(20),
    Apellido VARCHAR(20),
    Email VARCHAR(20)
);

CREATE TABLE Libro (
    LibroId INT PRIMARY KEY NOT NULL,
    Titulo VARCHAR(100),
    ISBN VARCHAR(20),
    NumPaginas INT,
    EditorialId INT,
    FOREIGN KEY (EditorialId) REFERENCES Editorial(EditorialId)
);

CREATE TABLE Autor (
    AutorId INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(80)
);

CREATE TABLE  Editorial (
    EditorialId INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(100)
);

CREATE TABLE AutorLibro(
	AutorLibro INT PRIMARY KEY NOT NULL,
    LibroId INT  NOT NULL,
    AutorId INT NOT NULL,
    FOREIGN KEY(LibroId) REFERENCES Libro(LibroId),
    FOREIGN KEY(AutorId) REFERENCES Autor(AutorId)
);

CREATE TABLE Prestamo (
    PrestamoId INT PRIMARY KEY NOT NULL,
    UsuarioId INT NOT NULL,
    LibroId INT NOT NULL,
    FechaPrestamo DATE,
    FechaDevolucion DATE,
    FOREIGN KEY (UsuarioId) REFERENCES Usuario(Id),
    FOREIGN KEY (LibroId) REFERENCES Libro(LibroId)
);

CREATE TABLE Ejemplar(
	EjemplarId INT PRIMARY KEY NOT NULL ,
    EjemplarLoc VARCHAR(80),
    LibroId INT NOT NULL,
    FOREIGN KEY(LibroId) REFERENCES Libro(LibroId)
    
);

-- Inserción de datos en la tabla Autor
INSERT INTO Autor (AutorId, Nombre) VALUES
(1, 'Gabriel García Márquez'),
(2, 'J.K. Rowling'),
(3, 'Stephen King'),
(4, 'Haruki Murakami'),
(5, 'Agatha Christie');

-- Inserción de datos en la tabla Editorial
INSERT INTO Editorial (EditorialId, Nombre) VALUES
(1, 'Vintage Books'),
(2, 'Salamandra'),
(3, 'Viking Press'),
(4, 'Tusquets Editores'),
(5, 'William Collins Sons & Co.');

-- Inserción de datos en la tabla Libro
INSERT INTO Libro (LibroId, Titulo, ISBN, NumPaginas, EditorialId) VALUES
(1, 'Cien años de soledad', '9780307474728', 432, 1),
(2, 'Harry Potter y la piedra filosofal', '9788478884457', 352, 2),
(3, 'It', '9780340970986', 1138, 3),
(4, 'Tokio Blues', '9788483835036', 384, 4),
(5, 'Asesinato en el Orient Express', '9780062073495', 322, 5);

-- Inserción de datos en la tabla AutorLibro
INSERT INTO AutorLibro (AutorLibro, LibroId, AutorId) VALUES
(1, 1, 1), -- Gabriel García Márquez - Cien años de soledad
(2, 2, 2), -- J.K. Rowling - Harry Potter y la piedra filosofal
(3, 3, 3), -- Stephen King - It
(4, 4, 4), -- Haruki Murakami - Tokio Blues
(5, 5, 5); -- Agatha Christie - Asesinato en el Orient Express

ALTER TABLE Usuario
MODIFY COLUMN Email VARCHAR(100);

-- Inserción de datos en la tabla Usuario
INSERT INTO Usuario (Id, Nombre, Apellido, Email) VALUES
(1, 'Juan', 'García', 'juangarcia@example.com'),
(2, 'María', 'López', 'marialopez@example.com'),
(3, 'Carlos', 'Martínez', 'carlosmartinez@example.com'),
(4, 'Ana', 'Rodríguez', 'anarodriguez@example.com'),
(5, 'Luis', 'Fernández', 'luisfernandez@example.com');

-- Inserción de datos en la tabla Prestamo
INSERT INTO Prestamo (PrestamoId, UsuarioId, LibroId, FechaPrestamo, FechaDevolucion) VALUES
(1, 1, 1, '2024-04-01', '2024-04-15'), -- Juan García presta "Cien años de soledad"
(2, 2, 2, '2024-03-20', '2024-04-10'), -- María López presta "Harry Potter y la piedra filosofal"
(3, 3, 3, '2024-04-05', '2024-04-20'), -- Carlos Martínez presta "It"
(4, 4, 4, '2024-03-25', '2024-04-15'), -- Ana Rodríguez presta "Tokio Blues"
(5, 5, 5, '2024-04-10', '2024-04-25'); -- Luis Fernández presta "Asesinato en el Orient Express"


-- Inserción de datos en la tabla Ejemplar
INSERT INTO Ejemplar (EjemplarId, EjemplarLoc, LibroId) VALUES
(1, 'Estantería 1 - A1', 1), -- Ejemplar de "Cien años de soledad"
(2, 'Estantería 2 - B3', 1), -- Segundo ejemplar de "Cien años de soledad"
(3, 'Estantería 3 - C2', 2), -- Ejemplar de "Harry Potter y la piedra filosofal"
(4, 'Estantería 4 - D5', 3), -- Ejemplar de "It"
(5, 'Estantería 5 - E1', 3), -- Segundo ejemplar de "It"
(6, 'Estantería 6 - F3', 4), -- Ejemplar de "Tokio Blues"
(7, 'Estantería 7 - G2', 4), -- Segundo ejemplar de "Tokio Blues"
(8, 'Estantería 8 - H4', 5), -- Ejemplar de "Asesinato en el Orient Express"
(9, 'Estantería 9 - I1', 5); -- Segundo ejemplar de "Asesinato en el Orient Express"


SELECT * FROM Libro;


-- ¿Cuántos autores distintos han escrito libros en la biblioteca?
SELECT COUNT(AutorId) FROM AutorLibro;

-- ¿Cuál es el autor que ha escrito más libros?

SELECT Autor.Nombre AS NombreAutor, COUNT(AutorLibro.LibroId) AS TotalLibrosEscritos
FROM Autor
JOIN AutorLibro ON Autor.AutorId = AutorLibro.AutorId
GROUP BY Autor.AutorId
ORDER BY TotalLibrosEscritos DESC
LIMIT 1;

-- ¿Cuál es el libro más prestado (en términos de cantidad de préstamos) en la biblioteca?

SELECT Libro.Titulo AS TituloLibro, COUNT(Prestamo.LibroId) AS TotalPrestamos
FROM Libro
JOIN Prestamo ON Libro.LibroId = Prestamo.LibroId
GROUP BY Libro.LibroId
ORDER BY TotalPrestamos DESC
LIMIT 1;

SELECT * FROM Usuario;

-- ¿Cuál es el nombre del cliente que ha tomado prestado un ejemplar más recientemente?

SELECT Usuario.Nombre AS NombreCliente, Usuario.apellido
FROM Usuario
JOIN Prestamo ON Usuario.Id = Prestamo.UsuarioId
ORDER BY Prestamo.FechaPrestamo DESC
LIMIT 1;

-- ¿Cuántos préstamos se han realizado en total en la biblioteca?

SELECT COUNT(*) AS TotalPrestamos
FROM Prestamo;

-- ¿Cuántas editoriales distintas hay en la biblioteca?
SELECT COUNT(DISTINCT EditorialId) AS TotalEditoriales
FROM Editorial;

-- ¿Cuál es la editorial que ha publicado más libros?

INSERT INTO Libro (LibroId, Titulo, ISBN, NumPaginas, EditorialId) VALUES
(6, 'Test', '9787474728', 432, 1);

SELECT Editorial.Nombre AS NombreEditorial, COUNT(Libro.LibroId) AS TotalLibrosPublicados
FROM Editorial
JOIN Libro ON Editorial.EditorialId = Libro.EditorialId
GROUP BY Editorial.EditorialId
ORDER BY TotalLibrosPublicados DESC
LIMIT 1;

