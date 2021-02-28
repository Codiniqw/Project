
import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["biblioteca"]
mycol = mydb["libros"]
aux=mycol.count()
myquery = { "col": { "$gte": 0 } }
newvalues =  { "$set": {"col":2} }
x = mycol.update_many(myquery, newvalues)
print(x.modified_count, "documents updated.")
myquery = { "col": { "$gte": 0 } }
newvalues =  { "$inc": {"col":-1} }
x = mycol.update_one(myquery, newvalues)
print(aux)
for i  in range(2,aux):
    myquery = { "col": { "$gte": i } }
    newvalues =  { "$inc": {"col":1} }
    x = mycol.update_many(myquery, newvalues)
    myquery = { "col": { "$gt": i } }
    newvalues =  { "$inc": {"col":-1} }
    x = mycol.update_one(myquery, newvalues)

    print(x.modified_count, "documents updated.")
