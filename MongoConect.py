from pymongo import MongoClient
import sys


class Conector:
    def conector(self):
        host = "localhost"
        puerto = 27017
        db = "biblioteca"
        try:
            cliente = MongoClient("mongodb://{}:{}".format(host, puerto))
            print("conexion exitosa")
            return cliente[db]
            
        except:
            print(sys.exc_info())

if __name__ == "__main__":
    conexion = Conector()
    conexion.conector()
