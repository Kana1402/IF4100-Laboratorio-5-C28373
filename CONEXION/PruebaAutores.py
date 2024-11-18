from ConexionDB.Conexion import Conexion
from Procedimientos.ActualizarAutor import ActualizarAutor

conexion_instancia = Conexion()
conexion = conexion_instancia.conectar()

actualizar = ActualizarAutor(conexion)

actualizar.actualizar_autor(1, 'Keinth Viales Reyes')
