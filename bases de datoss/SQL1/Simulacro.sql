#Inicio sesion
sudo mysql -u root -p

#Creamos la base de datos
CREATE DATABASE blog2;

#Nos aseguramos de que se ha creado
SHOW DATABASES;

#Entramos a la base de datos
USE blog2;

#Creamos la tala autores
CREATE TABLE autores(
	identificador INT(10),
	nombre VARCHAR(255),
	apellidos VARCHAR(100),
	email VARCHAR(100)
);

#Miramos que se ha creado bien
SHOW TABLES;

#Quiero quitar la tabla identificador para ponerla bien
ALTER TABLE autores DROP identificador;

#Añado el identificaor arreglado de vuelta
ALTER TABLE autores
ADD COLUMN identificador INT AUTO_INCREMENT PRIMARY KEY FIRST;

#Miramos que se ha insertado bien
SHOW TABLES;

#Insertamos datos a la tabla
INSERT INTO autores VALUES(
	NULL,
	'Alejandro',
	'Calderón Sánchez',
	'Alex@gmail.com'
)

#Revisamos que los datos se hayan insertado apropiadamente
SELECT * FROM autores;

CREATE TABLE autores(
	identificador INT(10),
	titulo VARCHAR(100),
	fecha VARCHAR(100),
	imagen VARCHAR(100),
	id_autor VARCHAR(100),
	contenido TEXT,
	email VARCHAR(100)
);

#Miramos que se ha insertado bien
SHOW TABLES;

#Describimos
DESCRIBE entradas;

#Creamos una clave externa
ALTER TABLE entradas
ADD CONSTRAINT autores_a_entradas
FOREIGN KEY (id_autor)
REFERENCES autores(identificador)
ON DELETE CASCADE
ON UPDATE CASCADE;
#falla

ALTER TABLE entradas
MODIFY COLUMN id_autor INT;

#La volvemos a ejecutar
ALTER TABLE entradas
ADD CONSTRAINT autores_a_entradas
FOREIGN KEY (id_autor)
REFERENCES autores(identificador)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE entradas
  DROP COLUMN email;

INSERT INTO entradas VALUES (
	NULL,
	'Titulo de la entrada',
	'2025-11-03',
	'imagen.jpg',
	1,
	'Este es el contenido de la primera entrada'
);

#Peticion cruzada
SELECT 
entradas.titulo,entradas.fecha,entradas.imagen,entradas.contenido,
autores.nombre,autores.apellidos
FROM entradas
LEFT JOIN autores
ON entradas.id_autor = autores.identificador;

#Creamos una vista
CREATE VIEW vista_entradas AS
SELECT 
entradas.titulo,entradas.fecha,entradas.imagen,entradas.contenido,
autores.nombre,autores.apellidos
FROM entradas
LEFT JOIN autores
ON entradas.id_autor = autores.identificador;

#Vemos la Vista
SELECT * FROM vista_entradas;
