import qrcode  # importamos la libreria 
import tkinter as tk
from tkinter import filedialog, messagebox


def generate_qr():
    # Obtener los datos del estudiante ingresados en la interfaz
    nombre = nombre_entry.get().title()
    apellido = apellido_entry.get().upper()
    grado = grado_entry.get()
    seccion = seccion_entry.get().upper()
    turno = turno_var.get()
        
        # Verificar si hay campos vacíos
    if not nombre or not apellido or not grado or not seccion:
        messagebox.showwarning("Error", "El sistema no admite campos vacíos.")
        return

    # Crear el contenido del codigo QR
    qr_content = f"Nombre: {nombre}\nApellido: {apellido}\nGrado: {grado}\nSección: {seccion}\nTurno: {turno}"

    # Generar el codigo QR
    qr = qrcode.QRCode(version=1, box_size=10, border=5)
    qr.add_data(qr_content)
    qr.make(fit=True)
    qr_img = qr.make_image(fill="black", back_color="white")

    # Obtener la ruta de guardado del archivo
    filename = f"{grado}{seccion}_{turno}_{apellido}_{nombre}.png"
    file_path = filedialog.asksaveasfilename(initialfile=filename, defaultextension=".png")

    # Guardar la imagen generada
    qr_img.save(file_path)

# Crear la interfaz gráfica
root = tk.Tk()
root.title("Generador de código QR SRC")  # Nombre de la ventana
root.resizable(width=False, height=False)  # Desactivar la opción de maximizar
root.geometry("800x500")  # Establecer tamaño de la ventana
root.config(bg="#DEB887")  # Cambiar de  color el fondo de la ventana
root.iconbitmap("C:/Users/Francis/Desktop/generarQR/iconosrc.ico")

# Obtener el tamaño de la pantalla
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()

# Obtener el tamaño de la ventana
window_width = 900
window_height = 550

# Calcular la posición de la ventana para que se centre en la pantalla
x_position = int((screen_width / 2) - (window_width / 2))
y_position = int((screen_height / 2) - (window_height / 2))

# Establecer la posición de la ventana
root.geometry(f"{window_width}x{window_height}+{x_position}+{y_position}")

# Cargar el logo
logo = tk.PhotoImage(file="C:/Users/Francis/Desktop/generarQR/rita_cassia.png")
logo = logo.subsample(1)  # Controlar el tamaño de la imagen

# Insertar el logo en la interfaz
logo_label = tk.Label(root, image=logo)
logo_label.pack(side="left", padx=90, pady=10)

# Crear un contenedor para los campos de entrada de texto
input_container = tk.Frame(root, bg="#DEB887")  # Establecer color del contenedor
input_container.pack(padx=10, pady=12)

# Crear los campos de entrada de texto
apellido_label = tk.Label(input_container, text="Apellido:", bg="#DEB887", font=("Arial", 12, "bold"))
apellido_label.pack()
apellido_entry = tk.Entry(input_container, bg="#F0E68C", fg="black", font=("Arial", 20)) #cambiar de color de la entrada de texto
apellido_entry.pack(fill="both", padx=20, pady=10, ipady=4)

nombre_label = tk.Label(input_container, text="Nombre:", bg="#DEB887", font=("Arial", 12, "bold"))
nombre_label.pack()
nombre_entry = tk.Entry(input_container, bg="#F0E68C", fg="black", font=("Arial", 20)) #cambiar de color de la entrada de texto
nombre_entry.pack(fill="both", padx=20, pady=10, ipady=4)

grado_label = tk.Label(input_container, text="Grado:", bg="#DEB887", font=("Arial", 12, "bold"))
grado_label.pack()
grado_entry_validator = root.register(lambda value: value.isdigit() and len(value) == 1)  # Crear un validador que solo permita la entrada de números enteros
grado_entry = tk.Entry(input_container, bg="#F0E68C", fg="black", validate="key", validatecommand=(grado_entry_validator, '%S'), font=("Arial", 20)) #cambiar de color de la entrada de texto
grado_entry.pack(fill="both", padx=20, pady=10, ipady=4)
 
seccion_entry_validator = root.register(lambda value: all(c.isalpha() and (c.lower() in 'abcdefghijklmnñopqrstuvwxyz') for c in value))  # Crear un validador que solo permita la entrada de letras del alfabeto español latino
seccion_label = tk.Label(input_container, text="Sección:", bg="#DEB887", font=("Arial", 12, "bold"))
seccion_label.pack()
seccion_entry = tk.Entry(input_container, bg="#F0E68C", fg="black", validate="key", validatecommand=(seccion_entry_validator, '%S'), font=("Arial", 20)) # Campo de entrada de texto con el validador correspondiente
seccion_entry.pack(fill="both", padx=20, pady=10, ipady=4)

turno_label = tk.Label(input_container, text="Turno:", bg="#DEB887", font=("Arial", 12, "bold"))
turno_label.pack()
turno_var = tk.StringVar(value="Mañana")
turno_mañana_radiobutton = tk.Radiobutton(input_container, text="Mañana", variable=turno_var, value="Mañana", bg="#DEB887", font=("Arial", 12))
turno_tarde_radiobutton = tk.Radiobutton(input_container, text="Tarde", variable=turno_var, value="Tarde", bg="#DEB887", font=("Arial", 12))
turno_mañana_radiobutton.pack(pady=5)
turno_tarde_radiobutton.pack(pady=5)

# Crear el botón para generar el código QR
generate_button = tk.Button(root, text="Generar código QR", command=generate_qr, fg="white", bg="red", font=("Helvetica", 12, "bold"))
generate_button.pack(pady=10)

root.mainloop()
