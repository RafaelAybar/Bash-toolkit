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
INFO_PEDIDA=''
pideInformacion() {
    dato='';
    while [ -z "$dato" ]; do
        read -p "Introduce $1: " dato
    done
    INFO_PEDIDA="$dato"
}


# Funcion que muestra datos en forma de menu
# Recibe la referencia de una lista con las opciones de la forma:
# mostrarComoMenu OPCIONES[@]
mostrarComoMenu() {
    declare -a OPS=("${!1}")
    for ((i = 0; i < ${#OPS[@]}; ++i)); do
        echo "$(($i + 1))) ${OPS[$i]}"
    done
}