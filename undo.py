import pymongo
myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
mydb = myclient["biblioteca"]
mycol = mydb["libros"]

def historial():
    undo = ['a', 'b', 'c']
    redo = []
    
    x=undo.pop()
    y=redo.append(x)
    print(undo)
    print(redo)
    undo.append(y)


if __name__ == "__main__":
    historial()
