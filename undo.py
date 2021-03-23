import pymongo
from interfaz import Interfaz
myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
mydb = myclient["biblioteca"]
mycol = mydb["libros"]

undo = []
redo = []
x=Interfaz.addLibro('1234','Hola mundo','joyanes','terror','10')
undo.append(x);
x=Interfaz.addLibro('12345','Hola mundo','joyanes','terror','10')
undo.append(x);
x=Interfaz.addLibro('123456','Hola mundo','joyanes','terror','10')
undo.append(x);
print(undo)
x=undo.pop();
redo.append(x);
for libro in mycol.find({'col':x['col']}):
    print(libro)
mycol.delete_one(libro);
print(undo)
x=undo.pop();
redo.append(x);
for libro in mycol.find({'col':x['col']}):
    print(libro)
mycol.delete_one(libro);
print(undo)
x=undo.pop();
redo.append(x);
for libro in mycol.find({'col':x['col']}):
    print(libro)
mycol.delete_one(libro);
print(undo);
y=redo.pop();
mycol.insert_one(y);
undo.append(y);
print(undo);
print(redo);
print (redo.clear())



