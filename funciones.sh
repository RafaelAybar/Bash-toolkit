#!/bin/bash

# Funciones para pintar cadenas
echo-r() {
    echo -e "\e[31m$1\e[m"
}

echo-v() {
    echo -e "\e[32m$1\e[m"
}


# Funcion que comprueba la ejecucion con permisos
compruebaRoot() {
    if [ $UID -ne 0 ]; then
        echo-r "[ERROR de permisos] Necesitas ejecutar este script con sudo."
        exit
    fi
}


# Funcion que pide informacion relativa a lo que reciba como parametro
# La informacion recogida se almacena en $INFO
INFO=''
pideInformacion() {
    dato='';
    while [ -z "$dato" ]; do
        read -p "Introduce $1: " dato
    done
    INFO="$dato"
}