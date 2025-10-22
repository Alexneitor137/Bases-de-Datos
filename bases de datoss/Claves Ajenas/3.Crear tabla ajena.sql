Paso 1, cambio el tipo de columna
ALTER TABLE emails
MODIFY COLUMN persona INT;

Paso 2, crear la clave ajena
ALTER TABLE emails
ADD CONSTRAINT fk_emails_personas
FOREIGN KEY (persona) 
REFERENCES personas(identificador)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE emails --Altera la tabla de emails
ADD CONSTRAINT fk_emails_personas --Crea una restriccion con este nombre
FOREIGN KEY (persona) --Creamos una clave hacia persona
REFERENCES personas(identificador) --Que referencia al identificador
ON DELETE CASCADE --Cuando elimines, cascada
ON UPDATE CASCADE; -- Cuando actualices, cascada

SHOW TABLES;
