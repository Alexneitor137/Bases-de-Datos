Comandos MySQL
sudo mysql -u root -p
--Ver Bases de datos disponibles
SHOW DATABASES;
--Crear base de datos
CREATE DATABASE empresadam;
Query OK, 1 row affected (0.02 sec)
USE empresadam;
Database changed
INT = Número entero
VARCHAR = Cadena de texto
TEXT = Texto largo
DATE = 	Fecha
-----------------------------------------------------
--Ver tablas
SHOW TABLES;
Empty set (0,00 sec)
CREATE TABLE clientes (
  dni VARCHAR(9),
  nombre VARCHAR(50),
  apellidos VARCHAR(255),
  email VARCHAR(100)
);
------------------------------------------------------
-- Meter daros a una tabla
INSERT INTO clientes VALUES(
  '12345678A',
  'Alejandro',
  'Calderón Sánchez',
  'Alejandro@gmail.com'
);
-----------------------------------------------------
-- Read

SELECT * FROM clientes;

+-----------+-----------+--------------------+---------------------+
| dni       | nombre    | apellidos          | email               |
+-----------+-----------+--------------------+---------------------+
| 12345678A | Alejandro | Calderón Sánchez   | Alejandro@gmail.com |
+-----------+-----------+--------------------+---------------------+
1 row in set (0.01 sec)
-----------------------------------------------------
-- Update

UPDATE clientes
SET dni = '11111111A'
WHERE nombre = 'Alejandro';
-----------------------------------------------------
-- Delete

DELETE FROM clientes
WHERE dni = '11111111A';
-------------------------------------------------------
mysql> DESCRIBE clientes;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| dni       | varchar(9)   | YES  |     | NULL    |       |
| nombre    | varchar(50)  | YES  |     | NULL    |       |
| apellidos | varchar(255) | YES  |     | NULL    |       |
| email     | varchar(100) | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+
Restriccion
mysql> ALTER TABLE clientes
    -> ADD CONSTRAINT comprobar_email
    -> Check (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-ZA-z]{2,}$'); 
----------------------------------------------------
Añadir identificador
ALTER TABLE clientes
ADD COLUMN identificador INT AUTO_INCREMENT PRIMARY KEY FIRST;
-------------------------------------------------------
Borrar la tabla
DELETE FROM clientes
----------------------------------------

ALTER TABLE clientes
  ADD CONSTRAINT comprobar_dni_nie_letra
  CHECK (
    (
      -- DNI: 8 dígitos + letra
      dni REGEXP '^[0-9]{8}[A-Za-z]$'
      AND
      UPPER(SUBSTRING(dni, 9, 1)) =
      SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE',
                (CAST(SUBSTRING(dni, 1, 8) AS UNSIGNED) MOD 23) + 1,
                1)
    )
    OR
    (
      -- NIE: X/Y/Z + 7 dígitos + letra
      dni REGEXP '^[XYZxyz][0-9]{7}[A-Za-z]$'
      AND
      UPPER(SUBSTRING(dni, 9, 1)) =
      SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE',
                (
                  CAST(CONCAT(
                        CASE UPPER(SUBSTRING(dni, 1, 1))
                          WHEN 'X' THEN '0'
                          WHEN 'Y' THEN '1'
                          WHEN 'Z' THEN '2'
                        END,
                        SUBSTRING(dni, 2, 7)
                  ) AS UNSIGNED) MOD 23
                ) + 1,
                1)
    )
  );
  --------------------------------
  Cargarte una caracteristica de una tabla o extra/regla
  ALTER TABLE clientes
  DROP COLUMN direccion;
  ALTER TABLE clientes
-> DROP CONSTRAINT comprobar_dni_nie_letra;

  ----------------------------------
  Cambiar de nombre a un valor de tabla
ALTER TABLE clientes
RENAME COLUMN dni TO dninie;
-------------------------------------
Vaciar y empezar de cero una tabla
TRUNCATE TABLE clientes;
-------------------------------------
