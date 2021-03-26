import PySimpleGUI as sg
import time
from tkPDFViewer import tkPDFViewer as pdf
from tkinter import*
import sys

class Visor():
    def progres():
        layout = [[sg.Text('Imprimiendo')],
                  [sg.ProgressBar(1, orientation='h', size=(
                      40, 30), key='progress')],
                  ]
        window = sg.Window('Imprimir', layout).Finalize()
        progress_bar = window.FindElement('progress')
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
        window.Close()

class PDF():
    def pdf():
        root = Tk()
        root.geometry=("550x750")
        variable1 = pdf.ShowPdf()
        variable2 = variable1.pdf_view(
            root, pdf_location=r"reporte.pdf", width=80, height=100)
        variable2.pack()
        root.mainloop()

if __name__ == "__main__":
    Visor.progres()
    time.sleep(3)
    
    
    

    
