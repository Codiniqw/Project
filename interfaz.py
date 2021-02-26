from tkinter import *
import PySimpleGUI as sg 
from tkinter import messagebox as mb
from MongoConect import Conector
import pymongo


class Interfaz:

        
    def addLibro(ISBN, Titulo, Autor, Genero, Cantidad):
        libro = {
            'isbn': ISBN,
            'titulo': Titulo,
            'autor': Autor,
            'genero': Genero,
            'cantidad': Cantidad
        }
        conexion = Conector()
        connect = conexion.conector()
        resultado = connect.libros.insert_one(libro)
        print("Libro insertado: ", resultado)

    def interfaz():
        sg.theme('DarkBlue16')
        deshacer='iconos/deshacer.png'
        rehacer='iconos/rehacer.png'
        myclient = pymongo.MongoClient("mongodb://localhost:27017/")
        mydb = myclient["biblioteca"]
        mycol = mydb["libros"]

        with open("isbn.csv","w") as i:
            for documento in mycol.find():
                isbn = {
                    "isbn": str(documento["isbn"]),
                    }
                print(isbn.get('isbn'),file=i)
        i = open("isbn.csv",'r') 
        isbn = i.read()
        print(isbn)
        i.close()

        with open("titulo.csv", "w") as t:
            for documento in mycol.find():
                titulo = {
                    "titulo": documento["titulo"]
                }
                print(titulo.get('titulo'), file=t)
        t = open("titulo.csv", 'r')
        titulo = t.read()
        print(titulo)
        t.close()

        with open("autor.csv", "w") as a:
            for documento in mycol.find():
                autor = {
                    "autor": documento["autor"]
                }
                print(autor.get('autor'), file=a)
        a = open("autor.csv", 'r')
        autor = a.read()
        print(autor)
        a.close()

        with open("genero.csv", "w") as g:
            for documento in mycol.find():
                genero = {
                    "genero": documento["genero"]
                }
                print(genero.get('genero'), file=g)
        g = open("genero.csv", 'r')
        genero = g.read()
        print(genero)
        g.close()

        with open("cantidad.csv", "w") as c:
            for documento in mycol.find():
                cantidad = {
                    "cantidad": documento["cantidad"]
                }
                print(cantidad.get('cantidad'), file=c)
        c = open("cantidad.csv", 'r')
        cantidad = c.read()
        print(cantidad)
        c.close()

        layout= [
            [sg.RButton('',image_filename=deshacer, image_size=(32, 32),key="DESHACER"),
             sg.RButton('', image_filename=rehacer, image_size=(32, 32),key="HACER")],
            [sg.Text('_'*70)],
            [sg.Table(
                headings = ["ISBN","Titulo", "Autor","Genero","Cantidad"],
                key='table',  
                values=[
                    [isbn,titulo,autor,genero,cantidad]
                ],
                
                max_col_width=100,
                auto_size_columns=False,
                size=20,
                justification='left',
                background_color='#85C1E9', 
                num_rows=5,
                enable_events=True)],
            [sg.Text('_'*70)],
            [sg.Text("Edición de libros")],
            [sg.Text("ISBN"), sg.Input(size=(20,2))],
            [sg.Text("Titulo"), sg.Input(size=(20,2))],
            [sg.Text("Autor"), sg.Input(size=(20,2))],
            [sg.Text("Genero"), 
                sg.Combo(["Novela", "Cuento","Terror","ciencia ficcion"], size=(20, 2), change_submits=False),
                sg.Text("Cantidad"), 
                sg.Input(size=(10,2))],
            [sg.Text('_'*70)],
            [sg.Button('add New'), 
                sg.Button('Update'),
                sg.Button('Delete'), 
                sg.Button('Print All'),
                sg.Button('close')]]
        
        # Crear la ventana
        
        window = sg.Window('Biblioteca interactiva', layout)
        # Muestra la ventana
        while True:
            event, values = window.read()
            # Asigna el evento cerrar ventana
            if event == sg.WINDOW_CLOSED or event == 'close':
                break
            elif event=='add New':
                mb.showinfo("Información",
                            "Aquí se llamará el método agregarNuevo")
            elif event == 'Update':
                mb.showinfo("Información",
                            "Aquí se llamará el método actualizar")
            elif event == 'Delete':
                mb.showinfo("Información",
                            "Aquí se llamará el método eliminar")
            elif event == 'Print All':
                mb.showinfo("Información",
                            "Aquí se llamará el método ImprimirTodo")
            elif event == 'HACER':
                mb.showinfo("Información",
                            "Aquí se llamará el método hacer")
            elif event == 'DESHACER':
                mb.showinfo("Información",
                            "Aquí se llamará el método deshacer")
        # Cierra el programa al cerrar la ventana
        window.close()

    
