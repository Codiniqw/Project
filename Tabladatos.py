import PySimpleGUI as sg
import random
import string
from MongoConect import Conector
import pymongo

"""
    Basic use of the Table Element
"""

sg.theme('Dark Blue6')
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
# ------ Make the Table Data ------
'''data = make_table(num_rows=mycol.count())
headings = [str(data[0][x])+'     ..' for x in range(len(data[0]))]

# ------ Window Layout ------
layout = [[sg.Table(values=data[1:][:], headings=headings, max_col_width=25,
                    # background_color='light blue',
                    auto_size_columns=True,
                    display_row_numbers=False,
                         justification='right',
                    num_rows=10,
                    alternating_row_color='lightyellow',
                    key='-TABLE-',
                    row_height=35,
                    tooltip='This is a table')],
          [sg.Button('Read'), sg.Button('Double'), sg.Button('Change Colors')],
          [sg.Text('Read = read which rows are selected')],
          [sg.Text('Double = double the amount of data in the table')],
          [sg.Text('Change Colors = Changes the colors of rows 8 and 9')]]

# ------ Create Window ------
window = sg.Window('The Table Element', layout,
                   # font='Helvetica 25',
                   )

# ------ Event Loop ------
while True:
    event, values = window.read()
    print(event, values)
    if event == sg.WIN_CLOSED:
        break
    if event == 'Double':
        for i in range(len(data)):
            data.append(data[i])
        window['-TABLE-'].update(values=data)
    elif event == 'Change Colors':
        window['-TABLE-'].update(row_colors=((8, 'white', 'red'), (9, 'green')))

window.close()'''
