import tkinter
import PySimpleGUI as sg 
import PIL.ImageTk


class Interfaz:
    def interfaz(seft):
        # Define the window's contents
        sg.theme('DarkBlue16')
        deshacer='iconos/deshacer.png'
        rehacer='iconos/rehacer.png'
        layout = [
            [sg.RButton('',image_filename=deshacer, image_size=(32, 32)),
             sg.RButton('', image_filename=rehacer, image_size=(32, 32))],
            [sg.Table(
                headings = ["ISBN","Titulo", "Autor","Genero"],
                key='table1',  
                values=[["","",""],["","",""],["","",""],["","",""]],#
                max_col_width=50,
                auto_size_columns=False,
                justification='left',
                background_color='#85C1E9', 
                num_rows=5,
                enable_events=True)],
                [sg.Text("Edicion de libros")],
                [sg.Text("ISBN"), sg.Input(size=(20,2))],
                [sg.Text("Titulo"), sg.Input(size=(20,2))],
                [sg.Text("Autor"), sg.Input(size=(20,2))],
                [sg.Text("Genero"), sg.Combo(["Novela", "Cuento"], size=(20, 2), change_submits=False),
                 sg.Text("Cantidad"), sg.Input(size=(10,2))],
                [sg.Button('add New'), sg.Button('Update'),
                sg.Button('Delete'), sg.Button('Print All'),
                sg.Button('close')]]  # Aqui van todos los botones
        
        # Crear la ventana
        window = sg.Window('Biblioteca iteractiva', layout)

        # Musetra la ventana
        while True:
            event, values = window.read()
            # Asigna el evento cerrar ventana
            if event == sg.WINDOW_CLOSED or event == 'close':
                break
            # Salida de menssajes de la pantalla
            window['-OUTPUT-'].update('Hello ' + values['-INPUT-'] +
                                    "! Gracias por usar la bilblioteca")

        # Cierra el programa al cerrar la ventana
        window.close()
