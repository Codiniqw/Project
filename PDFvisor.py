import PySimpleGUI as sg
import time
from tkPDFViewer import tkPDFViewer as pdf2
from tkinter import *
import os

def progres():
     layout = [[sg.Text('Imprimiendo')],
               [sg.ProgressBar(1, orientation='h', size=(
                   40, 30), key='progress')],
               ]
     window1 = sg.Window('Imprimir', layout).Finalize()
     progress_bar = window1.FindElement('progress')
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
     window1.Close()
def pdf1():
    time.sleep(10)
    path = 'reporte.pdf'
    os.system(path)
    
  
    
    

    
