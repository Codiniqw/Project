import pymongo
from interfaz import Interfaz
myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
mydb = myclient["biblioteca"]
mycol = mydb["libros"]

undo = []
redo = []

undo.append(x)
print(undo)
