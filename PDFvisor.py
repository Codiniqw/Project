from tkinter import *
from tkdocviewer import *
import PySimpleGUI as sg
import time

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
        time.sleep(3)
        window.Close()

        root = Tk()
        v = DocViewer(root)
        v.pack(side="top", expand=1, fill="both")
        v.display_file("reporte.pdf")
        root.mainloop()


if __name__ == "__main__":
    Visor.progres()

    
