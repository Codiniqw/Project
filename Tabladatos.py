import PySimpleGUI as sg
import random
import string
from MongoConect import Conector
import pymongo



# ------ Some functions to help generate data for the table ------ 
def make_table(num_rows):
    myclient = pymongo.MongoClient("mongodb://localhost:27017/")
    mydb = myclient["biblioteca"]
    mycol = mydb["libros"]
    data = [[j for j in range(5)] for i in range(num_rows+1)] #Define el tamaño de la tabla 5 columas, n filas +1 porque en el [se gurda el encabezado]
    data[0] = ["ISBN","Titulo", "Autor","Genero","Cantidad"] #Se Define el emcabezodo o titulos en el espacio[0]
    for i in range(1, num_rows+1):# ciclo que rellena las filas   
        myquery1 = { "col": i }
        for documento in mycol.find( myquery1 ):
            query = {
                    "isbn": str(documento["isbn"]),
                    "titulo": str(documento["titulo"]),
                    "autor": str(documento["autor"]),
                    "genero": str(documento["genero"]),
                    "cantidad": str(documento["cantidad"]),
            }
            data[i] = [query.get('isbn'),query.get('titulo'),query.get('autor'),query.get('genero'),query.get('cantidad')] #array que almacena rellena las columnas
    return data
myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["biblioteca"]
mycol = mydb["libros"]


def corregircol():
    myclient = pymongo.MongoClient("mongodb://localhost:27017/")
    mydb = myclient["biblioteca"]
    mycol = mydb["libros"]
    aux=mycol.count()
    myquery = { "col": { "$gte": 0 } }
    newvalues =  { "$set": {"col":2} }
    x = mycol.update_many(myquery, newvalues)
    myquery = { "col": { "$gte": 0 } }
    newvalues =  { "$inc": {"col":-1} }
    x = mycol.update_one(myquery, newvalues)
    for i  in range(2,aux):
        myquery = { "col": { "$gte": i } }
        newvalues =  { "$inc": {"col":1} }
        x = mycol.update_many(myquery, newvalues)
        myquery = { "col": { "$gt": i } }
        newvalues =  { "$inc": {"col":-1} }
        x = mycol.update_one(myquery, newvalues)

