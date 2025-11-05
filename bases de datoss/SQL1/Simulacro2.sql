-- Iniciamos sesion en SQL
sudo mysql -u root -p

-- Creamos la base de datos
CREATE DATABASE portafolio; 

-- Entramos a la base datos que acabamos de crear
USE portafolio;

-- Creamos la tabla pieza
CREATE TABLE Pieza(
    identificador INT(10) PRIMARY KEY,
    titulo1 VARCHAR(255),
    descripcion1 VARCHAR(255),
    imagen VARCHAR(100),
    url VARCHAR(255),
    id_categoria INT
);














-- a
ALTER TABLE Pieza
ADD CONSTRAINT Pieza_a_Autores
FOREIGN KEY (id_Categorias)
REFERENCES Categorias
