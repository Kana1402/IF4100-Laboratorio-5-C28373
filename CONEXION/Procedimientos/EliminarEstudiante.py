import mysql.connector

class EliminarEstudiante:
    def __init__(self, conexion):
        self.conexion = conexion

    def eliminar_estudiante(self, codigo_usuario):
        try:
            cursor = self.conexion.cursor()
            
            cursor.callproc('EliminarEstudiante', (codigo_usuario,))
            
            self.conexion.commit()
            print("Estudiante eliminado con éxito.")
            
        except mysql.connector.Error as e:
            print("Error al eliminar el estudiante:", e)
        finally:
            cursor.close()
