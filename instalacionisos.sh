#!/bin/bash
while true
do
        echo "Bienvenido al instalador de sistemas operativos en pendrive"
        echo "Indica dónde está la iso a intalar"
        echo "Si quires salir pulsa la tecla p "
        read ruta
        if [ $ruta = "p" ]
        then
                exit
        elif [ -z $ruta ]
        then
                echo "Oiga, introduzca la ruta"
        elif [ -f $ruta ]
        # Aquí comprobamos que la variable ruta no esté vacía y sea la
        # ruta exacta donde cargar la imagen del sistema operativo a instalar.
        then
                echo "Ahora introduce la ruta donde está el pendrive"
                read rutapen
                if [  -b "$rutapen" ]
                then
                        # Aquí ejecutamos la instrucción que permite grabar las isos booteables
                        sudo dd if=$ruta of=$rutapen bs=4094 status=progress && echo "Operación realizada con exito."
                else
                        echo "La ruta no es correcta"
                fi
        fi
done
