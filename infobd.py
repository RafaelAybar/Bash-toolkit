#!/bin/python3
from sqlalchemy import *
#Antes de abrir la conexión, se necesitarán los datos del usuario
#Borramos los espacios con la f(x) strip() https://stackoverflow.com/questions/761804/how-do-i-trim-whitespace-from-a-python-string
print("Introduzca el nombre del usuario")
usuariobd = input().strip()
print("Introduzca su contraseña")
contra = input()
print("Introduzca el host")
host = input().strip()
print("Introduzca el puerto a conectar (3306)")
#Forzamos que el número que llega es un entero https://stackoverflow.com/questions/5424716/how-to-check-if-string-input-is-a-number
puertocon = abs(int(input()))
print("Se va a realizar la conexión con el usuario {usuariobd}@{host}, al puerto {puertocon}")

#comprobamos que no llegan valores vacíos
if len(str(usuariobd)) == 0:
    print("Debes introducir todos los datos")
    exit()
#Probamos la conexión
#mysql+pymysql://<username>:<password>@<host>/<dbname>[?<options>]

engine = create_engine("mysql+pymysql://{usuariobd}:{contra}@{host}")