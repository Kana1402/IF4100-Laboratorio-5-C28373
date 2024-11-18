from ConexionDB.Conexion import Conexion
from Procedimientos.InsertarPrestamo import InsertarPrestamo

conexion_instancia = Conexion()
conexion = conexion_instancia.conectar()

prestamo = InsertarPrestamo(conexion)

id_estudiante = 10000 
id_ejemplar = 1008
prestamo.registrar_prestamo(id_estudiante, id_ejemplar)
