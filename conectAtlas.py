
import pymongo
import dns

client = pymongo.MongoClient(
    "mongodb+srv://proyectoPOO:proyectoPOO2021@cluster0.xhagx.mongodb.net/libros?retryWrites=true&w=majority")
db = client.test
col = db["libros"]
print(client.list_database_names())


