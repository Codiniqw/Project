from tkinter import *
import PySimpleGUI as sg 
from tkinter import messagebox as mb
from MongoConect import Conector
import pymongo
from Tabladatos import make_table
from Tabladatos import corregircol
from datetime import datetime
from tkinter import messagebox as MessageBox



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

        
        f = open("log.txt", "a")
        f.write("\n--> Log History info ("+str(datetime.now())+" Aplicacion iniciada)\n")
        f.close()

        # ------ Make the Table Data ------
        data = make_table(num_rows=mycol.count())
        headi = [str(data[0][x])+'          ' for x in range(len(data[0]))]

        layout= [
            [sg.RButton('',image_filename=deshacer, image_size=(32, 32),key="DESHACER"),
             sg.RButton('', image_filename=rehacer, image_size=(32, 32),key="HACER")],
            [sg.Text('_'*70)],
            [sg.Table(
                headings = headi,
                display_row_numbers=True,
                key='TABLE',  
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
                sg.Combo(["Novela", "Cuento","Terror","ciencia ficcion"], size=(20, 5), change_submits=False,key='-GENERO-'),
                sg.Text("Cantidad"),sg.Input(size=(10,2),key='-CANTIDAD-')],
            [sg.Text('_'*70)],
            [sg.Button('add New'), 
                sg.Button('Update'),
                sg.Button('Delete'), 
                sg.Button('Print All'),
                sg.Button('limpiar'),
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

                if window.FindElement('-ISBN-').Get() and window.FindElement('-TITULO-').Get() and window.FindElement('-AUTOR-').Get() and window.FindElement('-GENERO-').Get() and window.FindElement('-CANTIDAD-').Get() != '':
                    #OBTENEMOS LOS VALORES INGRESADOS POR EL USUARIO
                    ISBN=window['-ISBN-'].Get()
                    Titulo = window['-TITULO-'].Get()
                    Autor = window['-AUTOR-'].Get()
                    Genero = window['-GENERO-'].Get()
                    Cantidad=window['-CANTIDAD-'].Get()
                    Col= mycol.count()+1
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
                    # IMPRIMIMOS EL JSON EN CONSOLA
                    print(libro)
                    #LIMPIAMOS LOS CAMPOS
                    window.FindElement('-ISBN-').update('')
                    window.FindElement('-TITULO-').update('')
                    window.FindElement('-AUTOR-').update('')
                    window.FindElement('-GENERO-').update('')
                    window.FindElement('-CANTIDAD-').update('')
                    #ACTUALIZAMOS LA TABLA
                    data = make_table(num_rows=mycol.count())
                    headi = [str(data[0][x])+'     ..' for x in range(len(data[0]))]
                    window.FindElement('TABLE').update(values=data[1:][:])

                    f = open("log.txt", "a")
                    f.write("\n--> Nuevo libro agregado ("+str(datetime.now())+")\n")
                    f.write("LIBRO: "+str(libro)+"\n\n")
                    f.close()
                else:
                    MessageBox.showwarning("Alerta", "Todos los datos son requeridos")

            elif event == 'Update':
                try:
                    myclient = pymongo.MongoClient("mongodb://localhost:27017/")
                    mydb = myclient["biblioteca"]
                    mycol = mydb["libros"]

                    selected_row = window.Element('TABLE').SelectedRows[0]
                    for libro in mycol.find({'col': (selected_row+1)}):
                        print(libro)

                    ISBN = window['-ISBN-'].Get()
                    Titulo = window['-TITULO-'].Get()
                    Autor = window['-AUTOR-'].Get()
                    Genero = window['-GENERO-'].Get()
                    Cantidad = window['-CANTIDAD-'].Get()

                    libroUpdated = {"$set":
                    {
                        'col': (selected_row+1),
                        'isbn': ISBN,
                        'titulo': Titulo,
                        'autor': Autor,
                        'genero': Genero,
                        'cantidad': Cantidad
                        }
                    }
                    x = mycol.update_one(libro, libroUpdated)

                    #LIMPIAMOS LOS CAMPOS
                    window.FindElement('-ISBN-').update('')
                    window.FindElement('-TITULO-').update('')
                    window.FindElement('-AUTOR-').update('')
                    window.FindElement('-GENERO-').update('')
                    window.FindElement('-CANTIDAD-').update('')

                    #ACTUALIZAMOS LA TABLA
                    data = make_table(num_rows=mycol.count())
                    headi = [str(data[0][x]) +
                            '     ..' for x in range(len(data[0]))]
                    window.FindElement('TABLE').update(values=data[1:][:])

                    f = open("log.txt", "a")
                    f.write("\n--> Libro actualizado ("+str(datetime.now())+")\n")
                    f.write("LIBRO ORIGINAL: "+str(libro)+"\n")
                    f.write("LIBRO ACTUALIZADO: "+str(libroUpdated)+"\n\n")
                    f.close()
                except:
                    MessageBox.showwarning("Alerta", "Seleccione el libro a actualizar")

            elif event == 'Delete':
                try:
                    myclient = pymongo.MongoClient("mongodb://localhost:27017/")
                    mydb = myclient["biblioteca"]
                    mycol = mydb["libros"]

                    selected_row = window.Element('TABLE').SelectedRows[0]
                    for libro in mycol.find({'col': (selected_row+1)}):
                        print(libro)
                    mycol.delete_one(libro)
                    corregircol()
                                        

                    #LIMPIAMOS LOS CAMPOS
                    window.FindElement('-ISBN-').update('')
                    window.FindElement('-TITULO-').update('')
                    window.FindElement('-AUTOR-').update('')
                    window.FindElement('-GENERO-').update('')
                    window.FindElement('-CANTIDAD-').update('')

                    #ACTUALIZAMOS LA TABLA
                    data = make_table(num_rows=mycol.count())
                    headi = [str(data[0][x]) +
                            '     ..' for x in range(len(data[0]))]
                    window.FindElement('TABLE').update(values=data[1:][:])
                    f = open("log.txt", "a")
                    f.write("\n--> Libro Eliminado ("+str(datetime.now())+")\n")
                    f.write("LIBRO: "+str(libro)+"\n\n")
                    f.close()
                except:
                    MessageBox.showwarning("Alerta", "Seleccione el libro a eliminar")

            elif event == 'Print All':
                mb.showinfo("Información",
                            "Aquí se llamará el método ImprimirTodo")
            elif event == 'HACER':
                mb.showinfo("Información",
                            "Aquí se llamará el método hacer")
            elif event == 'DESHACER':
                mb.showinfo("Información",
                            "Aquí se llamará el método deshacer")
            elif event == 'TABLE':
                selected_row = window.Element('TABLE').SelectedRows[0]
                print(selected_row)
                myclient = pymongo.MongoClient("mongodb://localhost:27017/")
                mydb = myclient["biblioteca"]
                mycol = mydb["libros"]
                for resultado in mycol.find({'col': (selected_row+1)}):
                    print(resultado)
                window.FindElement('-ISBN-').update(resultado.get('isbn'))
                window.FindElement('-TITULO-').update(resultado.get('titulo'))
                window.FindElement('-AUTOR-').update(resultado.get('autor'))
                window.FindElement('-GENERO-').update(resultado.get('genero'))
                window.FindElement('-CANTIDAD-').update(resultado.get('cantidad'))
            elif event == 'limpiar':
                #LIMPIAMOS LOS CAMPOS
                window.FindElement('-ISBN-').update('')
                window.FindElement('-TITULO-').update('')
                window.FindElement('-AUTOR-').update('')
                window.FindElement('-GENERO-').update('')
                window.FindElement('-CANTIDAD-').update('')

        # Cierra el programa al cerrar la ventana
        window.close()

    
