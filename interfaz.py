import tkinter
import PySimpleGUI as sg 
import pandas as pd


class Interfaz:
    def interfaz(seft):
        # Define the window's contents
        sg.theme('DarkBlue16')
        
        layout = [
            [sg.Table(
                headings = None,
                key='table1',  
                values=[["1","2","4"],["1","2","4"]],
                
                max_col_width=25,
                auto_size_columns=False,
                justification='left',
                background_color='#85C1E9', 
                num_rows=5,
                enable_events=True)],
                #[pd.DataFrame({"Foo": (1, 2, 3, 4), "Bar": (7, 13, 17, 19)})],
                [sg.Text("Edicion de libros")],
                [sg.Text("ISBN"), sg.Input(size=(20,2))],
                [sg.Text("Titulo"), sg.Input(size=(20,2))],
                [sg.Text("Autor"), sg.Input(size=(20,2))],
                [sg.Text("Genero"), sg.Combo(["Novela", "Cuento"], size=(20, 2), change_submits=False),
                 sg.Text("Cantidad"), sg.Input(size=(10,2))],
                [sg.Button('add New'), sg.Button('Update'),
                sg.Button('Delete'), sg.Button('Print All'),
                sg.Button('close')]]  # Aqui van todos los botones
        
        # Create the window
        window = sg.Window('Biblioteca iteractiva', layout)

        # Display and interact with the Window using an Event Loop
        while True:
            event, values = window.read()
            # See if user wants to quit or window was closed
            if event == sg.WINDOW_CLOSED or event == 'close':
                break
            # Output a message to the window
            window['-OUTPUT-'].update('Hello ' + values['-INPUT-'] +
                                    "! Gracias por usar la bilblioteca")

        # Finish up by removing from the screen
        window.close()
