import mysql.connector 
from flask import Flask

conexion = mysql.connector.connect(
  host="localhost",
  user="composiciones2",
  password="Composiciones123$",
  database="composiciones"
)                                      

app = Flask(__name__)
@app.route("/")
def inicio():
  cursor = conexion.cursor(dictionary=True) 
  cursor.execute("SELECT * FROM matriculas_join;")  
  filas = cursor.fetchall()
  return str(filas)

if __name__ == "__main__":
  # Pon en marcha la aplicación
  app.run(debug=True)