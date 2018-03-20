#!/bin/bash
echo "Bienvenido al administrador de discos"
echo "ADVERTENCIA: UN USO INCORRECTO DE ESTE SCRIPT PUEDE PROVOCAR PÉRDIDAS DE DATOS IRREPARABLES. EL DESARROLLADOR NO SE HACE RESPONSABLE DE SU MAL USO"
echo "Selecciona una opción"
while true
do
   cat <<- EOF
1   Obtención de información de los discos duros y las particiones del sistema.
2   Cifrar particiones
3   Formatear una partición
4   Borrar particion(es)
5   Montar particiones
6   Comprobar errores en los discos
7   Salir
EOF
    read respuesta
    case $respuesta in
        1) echo "Listado de discos duros y particiones del sistema:"
            #Fuente: https://blog.desdelinux.net/4-comandos-para-conocer-datos-de-nuestros-hdd-o-particiones/
            lsblk -fm
           ;;
        2) echo "Introduzca la partición o disco que cifrará";
            read candidato
            if [ -z "$candidato" ]
                then
                    echo "Introduce los datos correctamente"
            else
                echo "Elija el algoritmo"
                    read algoritmo
                echo "Elija el algorimmo hash"
                    read algohash
                if [ -z "$algoritmo" ] || [ -z "$algohash" ]
                    then
                        echo "Introduce todos los datos"
                else
                    echo "Se va a cifrar $candidato con algoritmo $algoritmo y algoritmo hash $algohash" 
                fi
            fi
        ;;
        3) echo "Seleccione qué formateará, y con qué formato" ;;
        4) echo "Selecione qué partición desea borrar" ;;
        5) echo "Seleccione la partición/disco a montar" ;;
        6) echo "Adiós" ;;
        7) ;;
        *) echo "Escoge un parámetro válido" ;;
    esac
    done
