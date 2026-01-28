// Actualizacion de un elemento
db.facturas.updateOne(
    {nombre:'Jose Vicente'},
    {
        $set:
        {email:"prueba@prueba.com"}
    }
)