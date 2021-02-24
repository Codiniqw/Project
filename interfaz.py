from tkinter import *
import PySimpleGUI as sg 
from tkinter import messagebox as mb
from MongoConect import Conector

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

        layout = [
            [sg.RButton('',image_filename=deshacer, image_size=(32, 32),key="DESHACER"),
             sg.RButton('', image_filename=rehacer, image_size=(32, 32),key="HACER")],
            [sg.Text('_'*70)],
            [sg.Table(
                headings = ["ISBN","Titulo", "Autor","Genero","Cantidad"],
                key='table1',  
                values=[["","","","",""],["","","","",""],["","","","",""],["","","","",""]],
                max_col_width=50,
                auto_size_columns=False,
                justification='center',
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

    
