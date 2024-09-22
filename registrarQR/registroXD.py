import cv2
from pyzbar.pyzbar import decode
import openpyxl
from datetime import datetime
import time
import os
import tkinter as tk
from tkinter import messagebox

# Define la fuente para los encabezados
font = cv2.FONT_HERSHEY_SIMPLEX

# Fecha de vencimiento del programa (cambiar según sea necesario)
fecha_vencimiento = datetime(2025, 12, 12) # YY/MM/DD

# Verifica si el programa ha caducado
if datetime.now() > fecha_vencimiento:
    # Crea una ventana emergente para informar al usuario que el programa ha caducado
    root = tk.Tk()
    root.withdraw()
    messagebox.showerror("Programa caducado", "Este programa ha caducado, contactece con el administrador, Gmail: fcastillosanabria@gmail.com.")
    exit()

# Inicializa la cámara
cap = cv2.VideoCapture(0)

# Define el nombre del archivo para guardar el conjunto de códigos QR registrados
qr_registrados_archivo = 'qr_registrados.txt'

# Verifica si el archivo de códigos registrados ya existe
if os.path.isfile(qr_registrados_archivo):
    # Si el archivo existe, carga el conjunto de códigos registrados
    with open(qr_registrados_archivo, 'r') as f:
        qr_registrados = set(f.read().splitlines())
else:
    # Si el archivo no existe, crea un conjunto vacío
    qr_registrados = set()
    
# Define el tamaño de la ventana de visualización
cv2.namedWindow('Registro QR SRC', cv2.WINDOW_NORMAL)
cv2.resizeWindow('Registro QR SRC', 900, 600)

while True:
    try:
        while True:
            # Lee el video de la cámara
            _, frame = cap.read()

            # Decodifica los códigos QR del video
            decoded_objects = decode(frame)

            # Itera sobre los códigos QR encontrados
            for obj in decoded_objects:
                # Obtiene los datos del código QR
                data = obj.data.decode('utf-8')

                # Separa los datos por comas y los convierte en una lista
                datos = data.split(',')

                # Verifica si el código QR ya ha sido registrado
                if data in qr_registrados:
                    cv2.putText(frame, "Este codigo ya ha sido registrado", (50, 50), font, 1, (0, 0, 255), 2, cv2.LINE_AA)
                else:
                    # Agrega la hora actual a los datos en formato 12 horas
                    datos.append(datetime.now().strftime('%I:%M:%S %p'))

                    # Obtiene el grado, sección y turno del estudiante
                    grado = datos[2]
                    seccion = datos[3]
                    turno = datos[4]

                    # Obtiene la fecha actual en formato DD-MM-YYYY
                    fecha_actual = datetime.now().strftime('%d-%m-%Y')

                    # Concatena la fecha con el nombre del archivo
                    nombre_archivo = f"{grado}_{seccion}_{turno}_Asistencia_{fecha_actual}.xlsx"

                    # Verifica si el archivo ya existe
                    if os.path.isfile(nombre_archivo):
                        # Si el archivo ya existe, carga la hoja de trabajo correspondiente
                        wb = openpyxl.load_workbook(nombre_archivo)
                        ws = wb.active
                    else:
                        # Si el archivo no existe, crea uno nuevo y agrega una hoja de trabajo
                        wb = openpyxl.Workbook()
                        ws = wb.active
                        # Agrega encabezados a la hoja de trabajo
                        ws.append(["Apellido", "Nombre", "Grado", "Seccion", "Turno", fecha_actual])

                    # Agrega los datos a la hoja de trabajo
                    ws.append(datos)

                    # Guarda los cambios en el archivo Excel
                    wb.save(nombre_archivo)

                    # Agrega el código QR al conjunto de códigos registrados
                    qr_registrados.add(data)

                    # Muestra un mensaje de éxito en la ventana
                    cv2.putText(frame, "Registro exitoso", (50, 50), font, 1, (0, 255, 0), 2, cv2.LINE_AA)

                    # Espera 1 segundos
                    time.sleep(1)

                    # Borra el mensaje de éxito de la ventana
                    cv2.putText(frame, "", (10, 50), font, 1, (0, 0, 0), 2, cv2.LINE_AA)

            # Muestra el video en una ventana
            cv2.imshow('Registro QR SRC', frame)

            # Espera a que se presione la tecla 'q' o que se cierre la ventana para salir
            key = cv2.waitKey(1)
            if key == ord('q') or key == ord('x'): #or cv2.getWindowProperty('frame', cv2.WND_PROP_VISIBLE) < 1: (este codigo es para poder cerra la ventana con el boton x)
                break
    
    # Este codigo maneja el error si el qr es invalido    
    except Exception:
        cv2.putText(frame, "Este codigo QR no es valido", (10, 50), font, 1, (0, 0, 255), 2, cv2.LINE_AA)
        print("QR invalido")
        continue
    
    # Libera la cámara y destruye la ventana de video
    cap.release()
    cv2.destroyAllWindows()
    break
