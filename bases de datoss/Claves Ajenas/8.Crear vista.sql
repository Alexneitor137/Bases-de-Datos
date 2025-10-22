CREATE VIEW personas_correos AS
SELECT
emails.direccion,
personas.nombre,
personas.apellidos
FROM emails
LEFT JOIN personas
ON emails.persona = personas.Identificador;

SELECT * FROM personas_correos; -- se comporta com una tabla de solo vista

