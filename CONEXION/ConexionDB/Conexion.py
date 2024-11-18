import mysql.connector  

class Conexion:
    def __init__(self):
        self.conexion = None
        
    def conectar(self):
        try:
            self.conexion = mysql.connector.connect(
                user='root', 
                password='27186627', 
                host='localhost',
                database='BIBLIOTECA',  
                port=3306
            )
            if self.conexion.is_connected():
                print("¡Conexión exitosa a la base de datos 'biblioteca'!")
            return self.conexion
        except mysql.connector.Error as err:
            print(f"Error al conectar a la base de datos: {err}")
            return None

conexion_objeto = Conexion()

conexion = conexion_objeto.conectar()
