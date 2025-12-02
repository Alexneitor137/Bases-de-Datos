En este examen voy a hacer una base de datos llamada portafolio examen con el objetivo de mostrar todo lo aprendido este trimestre
```
--Abrimos mysql
sudo mysql -u root -p

--Creamos la base de datos
CREATE DATABASE portafolioexamen;
Query OK, 1 row affected (0.01 sec)

--Abrimos la base de datos
USE portafolioexamen
Database changed

--Creamos la tabla categorias
CREATE TABLE categoriasportafolio (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);
Query OK, 0 rows affected, 1 warning (0.13 sec)

--Mostramos que la tabla se ha creado apropiadamente
DESCRIBE categoriasportafolio;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| nombre | varchar(100) | NO   |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

--Creamos la tabla piezas
CREATE TABLE piezasportafolio(
    id INT(10) PRIMARY KEY AUTO_INCREMENT, --identificador, con clave primaria para que salga lo primero y Auto increment para que se actualiza solo el id automaticamente.
    titulo VARCHAR(255) NOT NULL, --NOT NULL significa que no se puede dejar en blanco
    descripcion VARCHAR(255) NOT NULL,
    fecha VARCHAR(255) NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categoriasportafolio(id)-- clave externa para poder conectcar con la tabla de categorias mas adelante
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
Query OK, 0 rows affected, 1 warning (0.17 sec)

--Mostramos que la tabla se ha creado apropiadamente
DESCRIBE piezasportafolio;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int          | NO   | PRI | NULL    | auto_increment |
| titulo       | varchar(255) | NO   |     | NULL    |                |
| descripcion  | varchar(255) | NO   |     | NULL    |                |
| fecha        | varchar(255) | NO   |     | NULL    |                |
| id_categoria | int          | YES  | MUL | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

--Muestro las tablas que he creado
SHOW TABLES;
+----------------------------+
| Tables_in_portafolioexamen |
+----------------------------+
| categoriasportafolio       |
| piezasportafolio           |
+----------------------------+
2 rows in set (0.00 sec)

--Inserto una serie de valores en categorias
INSERT INTO categoriasportafolio VALUES( 
    NULL, 
    'France' 
);
Query OK, 1 row affected (0.03 sec)

--Inserto una serie de valores en piezas
INSERT INTO piezasportafolio (titulo, descripcion, fecha, id_categoria)
    -> VALUES ('Le France', 'Una obra literaria de kiwis', '2025-11-10', 1);
Query OK, 1 row affected (0.02 sec)

--Le cambio el nombre a la columna titulo dentro de la tabla de piezas por titulitis
ALTER TABLE piezasportafolio
    RENAME COLUMN titulo TO titulitis;
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

--Mustro la tabla para confirmar el cambio
SELECT * FROM piezasportafolio;
+----+-----------+-----------------------------+------------+--------------+
| id | titulitis | descripcion                 | fecha      | id_categoria |
+----+-----------+-----------------------------+------------+--------------+
|  1 | Le France | Una obra literaria de kiwis | 2025-11-10 |            1 |
+----+-----------+-----------------------------+------------+--------------+
1 row in set (0.00 sec)

--Inserto otra serie de valores en piezas
INSERT INTO piezasportafolio (titulitis, descripcion, fecha, id_categoria) VALUES (
    'Le Normandy', 
    'Una obra de comedia Francesa', 
    '2024-11-10', 
    1
    );
Query OK, 1 row affected (0.03 sec)

--Lo muestro
SELECT * FROM piezasportafolio;
+----+-------------+------------------------------+------------+--------------+
| id | titulitis   | descripcion                  | fecha      | id_categoria |
+----+-------------+------------------------------+------------+--------------+
|  1 | Le France   | Una obra literaria de kiwis  | 2025-11-10 |            1 |
|  2 | Le Normandy | Una obra de comedia Francesa | 2024-11-10 |            1 |
+----+-------------+------------------------------+------------+--------------+

--La borro
DELETE FROM piezasportafolio 
    WHERE ID = 2;
Query OK, 1 row affected (0.03 sec)

--Muestro que la he borrado
SELECT * FROM piezasportafolio;
+----+-----------+-----------------------------+------------+--------------+
| id | titulitis | descripcion                 | fecha      | id_categoria |
+----+-----------+-----------------------------+------------+--------------+
|  1 | Le France | Una obra literaria de kiwis | 2025-11-10 |            1 |
+----+-----------+-----------------------------+------------+--------------+
1 row in set (0.01 sec)

--Hago el join
SELECT
piezasportafolio.titulitis,piezasportafolio.descripcion,piezasportafolio.fecha,
categoriasportafolio.nombre
FROM piezasportafolio
LEFT JOIN categoriasportafolio
ON piezasportafolio.id_categoria = categoriasportafolio.id;
+-----------+-----------------------------+------------+--------+
| titulitis | descripcion                 | fecha      | nombre |
+-----------+-----------------------------+------------+--------+
| Le France | Una obra literaria de kiwis | 2025-11-10 | France |
+-----------+-----------------------------+------------+--------+
1 row in set (0.00 sec)

--Hago una vista del join
CREATE VIEW vista_piezas AS
SELECT
piezasportafolio.titulitis,piezasportafolio.descripcion,piezasportafolio.fecha,
categoriasportafolio.nombre
FROM piezasportafolio
LEFT JOIN categoriasportafolio
ON piezasportafolio.id_categoria = categoriasportafolio.id;
Query OK, 0 rows affected (0.04 sec)

--Mustro la vista
SELECT * FROM vista_piezas;
+-----------+-----------------------------+------------+--------+
| titulitis | descripcion                 | fecha      | nombre |
+-----------+-----------------------------+------------+--------+
| Le France | Una obra literaria de kiwis | 2025-11-10 | France |
+-----------+-----------------------------+------------+--------+
1 row in set (0.00 sec)

--Creo un usuario
CREATE USER 'Manolo'@'localhost' IDENTIFIED BY 'Portafolio123$';

--Le doy acceso
GRANT USAGE ON *.* TO 'Manolo'@'localhost';
Query OK, 0 rows affected (0.01 sec)

--Le quito sus limites
ALTER USER 'Manolo'@'localhost'
    REQUIRE NONE 
    WITH MAX_QUERIES_PER_HOUR 0 
    MAX_CONNECTIONS_PER_HOUR 0 
    MAX_UPDATES_PER_HOUR 0 
    MAX_USER_CONNECTIONS 0;
Query OK, 0 rows affected (0.01 sec)

--Le doy acceso y privilegios a la base de datos
GRANT ALL PRIVILEGES ON `portafolioexamen`.*
    TO 'Manolo'@'localhost';
Query OK, 0 rows affected (0.03 sec)

--Recargo la tabla de privilegios
FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)
```
En este examen he mostrado y explicado todo lo que he dado a lo largo del curso desde usuarios hasta join y hasta creacion y alteracion de datos en una tabla, todo esto me servira a futuro en caso de tener que crearle una base de datos en una empresa
