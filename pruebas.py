
import pymongo
'''
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
'''

from tabulate import tabulate
from Tabladatos import make_table
myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["biblioteca"]
mycol = mydb["libros"]
data = make_table(num_rows=mycol.count())
headi = [str(data[0][x])+'          ' for x in range(len(data[0]))]

# Imprime tabla a partir de los datos de 
# una lista de listas:
        
print(tabulate(data,headers='firstrow', showindex=True,tablefmt='fancy_grid'))

#-----------------------------------------------------------

def pdf():
    pdf=FPDF(format='letter', unit='in') 
    pdf.add_page()
    pdf.set_font('Arial','',10.0) 
    
    epw = pdf.w - 2*pdf.l_margin
    col_width = epw/5
    th = pdf.font_size
    
    pdf.set_font('Times','B',14.0) 
    pdf.cell(epw, 0.0, 'Informe de libros', align='C')
    pdf.set_font('Times','',10.0) 
    pdf.ln(0.5)
    
    for row in data:
        for datum in row:
            pdf.cell(col_width, 2*th, str(datum), border=1)
        pdf.ln(2*th)
    pdf.output('reporte.pdf','F')