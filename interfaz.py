from tkinter import *
import PySimpleGUI as sg 
import pymongo
from Tabladatos import *
from datetime import datetime
from tkinter import messagebox as MessageBox
from getpass import getuser

class Interfaz:
    
    def addLibro(ISBN, Titulo, Autor, Genero, Cantidad):
        myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
        mydb = myclient["biblioteca"]
        mycol = mydb["libros"]
        libro = {
            'col': mycol.count()+1,
            'isbn': ISBN,
            'titulo': Titulo,
            'autor': Autor,
            'genero': Genero,
            'cantidad': Cantidad
        }
        resultado = mycol.insert_one(libro)
        print("Libro insertado: ", resultado)
        return libro

    def interfaz():
        undo=[]
        redo=[]
        sg.theme('DarkBlue6')
        deshacer='iconos/deshacer.png'
        rehacer='iconos/rehacer.png'
        myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
        mydb = myclient["biblioteca"]
        mycol = mydb["libros"]
        f = open("log.txt", "a")
        f.write("\n--> Log History info ("+str(datetime.now())+" Aplicacion iniciada) usaurio: "+getuser()+"\n")
        f.close()
        # ------ Make the Table Data ------
        data = make_table(num_rows=mycol.count())
        headi = [str(data[0][x])+'          ' for x in range(len(data[0]))]

        layout= [
            [sg.RButton('',image_filename=deshacer, image_size=(32, 32),key="DESHACER"),
             sg.RButton('', image_filename=rehacer, image_size=(32, 32),key="REHACER")],
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
                    myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
                    mydb = myclient["biblioteca"]
                    mycol = mydb["libros"]
                    resultado = mycol.insert_one(libro)
                    libro['key']='add'
                    undo.append(libro)
                    redo=[]
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
                    myclient = pymongo.MongoClient(
                        "mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
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
                    libro['key']='update'
                    undo.append(libro)
                    print(libro)
                    redo=[]

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
                    myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
                    mydb = myclient["biblioteca"]
                    mycol = mydb["libros"]

                    selected_row = window.Element('TABLE').SelectedRows[0]
                    for libro in mycol.find({'col': (selected_row+1)}):
                        print(libro)
                    mycol.delete_one(libro)
                    corregircol()
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
                    libro['key']='del'
                    undo.append(libro)
                    redo=[]             
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
                progres()
                pdf(data=data)
                MessageBox.showinfo("Información",
                            "Se ha creado el pdf")
                pdf1()


            elif event == 'REHACER':
                if redo.count!=0:
                    try:
                        myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
                        mydb = myclient["biblioteca"]
                        mycol = mydb["libros"]
                        aux2= redo.pop()
                        print(aux2);
                        if aux2['key']=='add': 
                            aux2.pop('key')
                            print(redo)
                            for libro in mycol.find({'isbn':aux2['isbn']}):
                                print(libro)
                            mycol.delete_one(libro);
                            aux2['key']='del'
                            undo.append(aux) 
                            data = make_table(num_rows=mycol.count())
                            window.FindElement('TABLE').update(values=data[1:][:])

                        elif aux2['key']=='del':
                            aux.pop('key')
                            print(redo)
                            mycol.insert_one(aux)
                            aux['key']='add'
                            undo.append(aux)
                            data = make_table(num_rows=mycol.count())
                            window.FindElement('TABLE').update(values=data[1:][:])

                        elif aux2['key']=='update1':
                            for libro1 in mycol.find({'col': aux2['col']}):
                                print()
                            libroUpdated2 = {"$set":
                                {
                                'col': aux2['col'],
                                'isbn': aux2['isbn'],
                                'titulo': aux2['titulo'],
                                'autor': aux2['autor'],
                                'genero': aux2['genero'],
                                'cantidad': aux2['cantidad']
                                }
                            }
                            mycol.update_one(libro1,libroUpdated2)
                            libroUpdated1 ={
                                'col': libro1['col'],
                                'isbn': libro1['isbn'],
                                'titulo': libro1['titulo'],
                                'autor': libro1['autor'],
                                'genero': libro1['genero'],
                                'cantidad': libro1['cantidad'],
                                'key':'update'
                            }
                            undo.append(libroUpdated1)
                            data = make_table(num_rows=mycol.count())
                            window.FindElement('TABLE').update(values=data[1:][:])

                    except:
                        print()

            elif event == 'DESHACER':
                try:
                    myclient = pymongo.MongoClient("mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
                    mydb = myclient["biblioteca"]
                    mycol = mydb["libros"]
                    aux=undo.pop()
                    if aux['key']=='add':
                        aux.pop('key')
                        print(aux)
                        print(redo)
                        for libro in mycol.find({'isbn':aux['isbn']}):
                            print(libro)
                        mycol.delete_one(libro);
                        aux['key']='del'
                        redo.append(aux)

                        data = make_table(num_rows=mycol.count())
                        window.FindElement('TABLE').update(values=data[1:][:])

                    elif aux['key']=='del':
                        aux.pop('key')
                        mycol.insert_one(aux)
                        aux['key']='add'
                        redo.append(aux)

                        data = make_table(num_rows=mycol.count())
                        window.FindElement('TABLE').update(values=data[1:][:])

                    elif aux['key']=='update':
                        for libro in mycol.find({'col': aux['col']}):
                            print()
                        libroUpdated = {"$set":
                            {
                            'col': aux['col'],
                            'isbn': aux['isbn'],
                            'titulo': aux['titulo'],
                            'autor': aux['autor'],
                            'genero': aux['genero'],
                            'cantidad': aux['cantidad']
                            }
                        }
                        libroUpdated1 ={
                                'col': libro['col'],
                                'isbn': libro['isbn'],
                                'titulo': libro['titulo'],
                                'autor': libro['autor'],
                                'genero': libro['genero'],
                                'cantidad': libro['cantidad'],
                                'key':'update1'
                        }
                        redo.append(libroUpdated1)
                        mycol.update_one(libro,libroUpdated)
                        data = make_table(num_rows=mycol.count())
                        window.FindElement('TABLE').update(values=data[1:][:])

                except:
                    print()

            elif event == 'TABLE':
                selected_row = window.Element('TABLE').SelectedRows[0]
                print(selected_row)
                myclient = pymongo.MongoClient(
                    "mongodb+srv://codiniqw:Codiniqw@codiniqw.3gcnu.mongodb.net/")
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

    
