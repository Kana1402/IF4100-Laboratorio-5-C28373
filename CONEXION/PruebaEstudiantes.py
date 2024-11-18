from ConexionDB.Conexion import Conexion
from Procedimientos.EliminarEstudiante import EliminarEstudiante


conexion_instancia = Conexion()
conexion = conexion_instancia.conectar()

eliminar = EliminarEstudiante(conexion)

eliminar.eliminar_estudiante(10001)
