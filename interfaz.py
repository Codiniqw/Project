import tkinter
import PySimpleGUI as sg  

class Interfaz:
    def interfaz(seft):
        # Define the window's contents
        sg.theme('DarkBlue16')
        layout = [[sg.Text()],
                #visualizacion de los elementos
                #elementos a agregar o consultar
                [sg.Button('add New'), sg.Button('Update'), sg.Button('Delete'), sg.Button('Print All'), sg.Button('close')]]  # Aqui van todos los botones

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
