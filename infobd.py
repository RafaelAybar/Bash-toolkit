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
puerto = str(input())
#Forzamos que el número que llega es un entero https://stackoverflow.com/questions/5424716/how-to-check-if-string-input-is-a-number
print("Se va a realizar la conexión con el usuario "+ usuariobd + "@" + host+ " con el puerto "+puerto)

#comprobamos que no llegan valores vacíos
if len(usuariobd) == 0 or len(contra)==0 or len(host) == 0 or len(puerto) == 0:
    print("Debes introducir todos los datos")
    exit()
#Probamos la conexión
#https://stackoverflow.com/questions/22689895/list-of-databases-in-sqlalchemy
engine = create_engine('mysql://'+usuariobd+':'+contra+'@'+host+':'+puerto)
#Obtenemos info de las BDS disponibles
consulta = engine.execute('SHOW DATABASES')
listatablas = consulta.fetchall()
print(listatablas)