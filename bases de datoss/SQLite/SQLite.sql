CREATE TABLE "clientes" (
	"identificador"	INTEGER,
	"nombre"	TEXT,
	"apellidos"	TEXT,
	"email"	TEXT,
	PRIMARY KEY("identificador" AUTOINCREMENT)
);

CREATE TABLE "productos" (
	"identificador"	INTEGER,
	"nombre"	TEXT,
	"descripcion"	TEXT,
	"precio"	TEXT,
	PRIMARY KEY("identificador" AUTOINCREMENT)
);
