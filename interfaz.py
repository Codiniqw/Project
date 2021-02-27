from tkinter import *
import PySimpleGUI as sg 
from tkinter import messagebox as mb
from MongoConect import Conector
import pymongo
from Tabladatos import make_table


class Interfaz:
    
    def addLibro(Col,ISBN, Titulo, Autor, Genero, Cantidad):
        libro = {
            'col': Col,
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
        sg.theme('DarkBlue6')
        deshacer='iconos/deshacer.png'
        rehacer='iconos/rehacer.png'
        myclient = pymongo.MongoClient("mongodb://localhost:27017/")
        mydb = myclient["biblioteca"]
        mycol = mydb["libros"]

        # ------ Make the Table Data ------
        data = make_table(num_rows=mycol.count())
        headi = [str(data[0][x])+'     ..' for x in range(len(data[0]))]

        layout= [
            [sg.RButton('',image_filename=deshacer, image_size=(32, 32),key="DESHACER"),
             sg.RButton('', image_filename=rehacer, image_size=(32, 32),key="HACER")],
            [sg.Text('_'*70)],
            [sg.Table(
                headings = headi,
                key='-TABLE-',  
                values=data[1:][:],
                max_col_width=100,
                auto_size_columns=False,
                size=50,
                justification='left',
                background_color='#85C1E9', 
                num_rows=10,
                alternating_row_color='lightyellow',
                enable_events=True)],
            [sg.Text('_'*70)],
            [sg.Text("Edición de libros")],
            [sg.Text("ISBN"), sg.Input(size=(20,2),key='-ISBN-')],
            [sg.Text("Titulo"), sg.Input(size=(20,2),key='-TITULO-')],
            [sg.Text("Autor"), sg.Input(size=(20,2),key='-AUTOR-')],
            [sg.Text("Genero"), 
                sg.Combo(["Novela", "Cuento","Terror","ciencia ficcion"], size=(20, 2), change_submits=False,key='-GENERO-'),
                sg.Text("Cantidad"),sg.Input(size=(10,2),key='-CANTIDAD-')],
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
                #OBTENEMOS LOS VALORES INGRESADOS POR EL USUARIO
                ISBN=window['-ISBN-'].Get()
                Titulo = window['-TITULO-'].Get()
                Autor = window['-AUTOR-'].Get()
                Genero = window['-GENERO-'].Get()
                Cantidad=window['-CANTIDAD-'].Get()
                Col= mycol.count()+1;
                #GUARDAMOS LA INFORMACION EN UN JSON
                libro = {
                    'col': Col,
                    'isbn': ISBN,
                    'titulo': Titulo,
                    'autor': Autor,
                    'genero': Genero,
                    'cantidad': Cantidad
                }
                #NOS CONECTAMOS A LA BASE DE DATOS Y AGREGAMOS EL JSON SI NO TIENE VALORES NULOS
                conexion = Conector()
                connect = conexion.conector()
                resultado = connect.libros.insert_one(libro)

                #MOSTRAMOS LA ADVERTENCIA DE EXITO E IMPRIMIMOS EL JSON EN CONSOLA
                print(libro)
                mb.showinfo("Información",
                            "El libro se ha agregado con exito")
                #LIMPIAMOS LOS CAMPOS
                window.FindElement('-ISBN-').update('')
                window.FindElement('-TITULO-').update('')
                window.FindElement('-AUTOR-').update('')
                window.FindElement('-GENERO-').update('')
                window.FindElement('-CANTIDAD-').update('')
                data = make_table(num_rows=mycol.count())
                headi = [str(data[0][x])+'     ..' for x in range(len(data[0]))]
                window.FindElement('-TABLE-').update(values=data[1:][:])
                #RECARGAMOS LA VENTANA
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

    
