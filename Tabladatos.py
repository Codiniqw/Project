import PySimpleGUI as sg
import random
import string
import pymongo
from fpdf import FPDF
import time
from tkPDFViewer import tkPDFViewer as pdf2
from tkinter import *
import os



# ------ Some functions to help generate data for the table ------ 
def make_table(num_rows):
    myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
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


def corregircol():
    myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
    mydb = myclient["biblioteca"]
    mycol = mydb["libros"]
    aux= mycol.count()
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

def pdf(data):
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

def progres():
     layout = [[sg.Text('Imprimiendo')],
               [sg.ProgressBar(1, orientation='h', size=(
                   40, 30), key='progress')],
               ]
     window1 = sg.Window('Imprimir', layout).Finalize()
     progress_bar = window1.FindElement('progress')
     progress_bar.UpdateBar(0, 5)
     time.sleep(.5)
     progress_bar.UpdateBar(1, 6)
     time.sleep(.5)
     progress_bar.UpdateBar(2, 6)
     time.sleep(.5)
     progress_bar.UpdateBar(3, 6)
     time.sleep(.5)
     progress_bar.UpdateBar(4, 6)
     time.sleep(.5)
     progress_bar.UpdateBar(5, 6)
     time.sleep(.5)
     progress_bar.UpdateBar(6, 6)
     time.sleep(.5)
     window1.Close()
def pdf1():
    time.sleep(10)
    path = 'reporte.pdf'
    os.system(path)
    
  
    
    


