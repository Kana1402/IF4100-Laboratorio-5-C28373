from ConexionDB.Conexion import Conexion
from Procedimientos.ConsultaLibro import ConsultaLibro


conexion_instancia = Conexion()
conexion = conexion_instancia.conectar()

consulta = ConsultaLibro(conexion)

consulta.consultar_libro(editorial='alfaguara')
