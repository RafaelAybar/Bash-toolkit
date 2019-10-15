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
    until [ -n "$dato" ]; do
        read -p "Introduce $1: " dato
    done
    INFO_PEDIDA="$dato"
}


# Funcion que colorea los datos delimitados por algun caracter de una
# fichero
imprimeColoreado() {
    espacio="SpAcE"
    coloreado=""
    delimitador="$3"

    for linea in `cat "$1" | sed s/' '/"$espacio"/g`; do
        codigoDeColor=30
        for i in `echo "$linea" | sed s/"$2"/' '/g`; do
            codigoDeColor=$(($codigoDeColor+1))
            coloreado="$coloreado\e[${codigoDeColor}m$i\e[m "
        done
        coloreado="${coloreado::-1}\n"
    done

    echo -e "$coloreado" | sed s/' '/':'/g | sed s/"$espacio"/' '/g
}


# Funcion que muestra datos en forma de menu
# Recibe la referencia de una lista con las opciones de la forma:
# mostrarComoMenu OPCIONES[@]
mostrarComoMenu() {
    OPS=("${!1}")
    for ((i = 0; i < ${#OPS[@]}; ++i)); do
        echo "$(($i + 1))) ${OPS[$i]}"
    done
}