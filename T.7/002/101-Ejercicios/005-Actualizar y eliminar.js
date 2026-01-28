// Actualizacion de un elemento
db.facturas.updateOne(
    {nombre:'Alejandro'},
    {
        $set:
        {email:"prueba@prueba.com"}
    }
)

// Actualizar muchos
db.facturas.updateMany(
    {email:'info@juan.com'},
    {
        $set:
        {telefono:"11111111"}
    }
)

// Eliminar uno
db.facturas.deleteOne(
    {nombre:'Alejandro'}
)

// Eliminar muchos
db.facturas.deleteMany(
    {email:'info@juan.com'}
)