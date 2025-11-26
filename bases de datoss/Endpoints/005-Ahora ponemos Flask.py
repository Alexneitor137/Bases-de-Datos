import mysql.connector 
from flask import Flask
import json

conexion = mysql.connector.connect(
  host="localhost",
  user="tiendaclase",
  password="[TiendaClase123$]",
  database="tienda"
)                                      
app = Flask(__name__)

@app.route("/clientes")
def inicio():
    cursor = conexion.cursor() 
    cursor.execute("SELECT * FROM clientes;")  
    filas = cursor.fetchall()
    return json.dumps(filas)

if __name__ == "__main__":
  app.run(debug=True) 