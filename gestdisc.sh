#!/bin/bash
echo "Bienvenido al administrador de discos"
echo "ADVERTENCIA: UN USO INCORRECTO DE ESTE SCRIPT PUEDE PROVOCAR PÉRDIDAS DE DATOS IRREPARABLES. EL DESARROLLADOR NO SE HACE RESPONSABLE DE SU MAL USO"
echo "Si usted tiene un disco SSD, la sobreescritura de los datos lo degradará considerablente."
echo "Selecciona una opción"
while true
do
   cat <<- EOF
1   Obtención de información de los discos duros y las particiones del sistema.
2   Cifrar partición/disco
3   Hacer copia de las cabeceras LUKS
4   Formatear una partición
5   Borrar particion(es)
6   Montar particiones
7   Comprobar errores en los discos
8   Salir
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
                    echo "¿Desea hacer copia de seguridad de los datos? s/n"
                    read confirmarcopiaseg
                        if [ "$confirmarcopiaseg" != "s" ] || [ "$confirmarcopiaseg" != "n" ]
                            then
                                echo "Debes seleccionar una opción válida."
                                exit
                        elif [ "$confirmarcopiaseg" == "s" ]
                            then
                                echo "Selecciona la ruta del directorio/partición del que se quiere respaldar"
                                read rutaorigbak
                                if [ -d "$rutaorigbak" ]
                                    then
                                    echo "Selecciona la ruta de destino"

                                fi
                        fi
                    echo "Se va a cifrar $candidato con algoritmo $algoritmo y algoritmo hash $algohash"
                    

                fi
            fi
        ;;
        3) echo "Seleccione qué formateará" ;;
        4) echo "Selecione qué partición desea borrar" ;;
        5) echo "Seleccione la partición/disco a montar" ;;
        6) echo "Adiós" ;;
        7) ;;
        *) echo "Escoge un parámetro válido" ;;
    esac
    done
