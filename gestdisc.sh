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
                echo "Elija el tamaño en bits del algoritmo"
                    read algoritmo
                echo "Elija el algorimmo hash, como luksFormat"
                    read algohash
                if [ -z "$algoritmo" ]
                    then
                        echo "Introduce todos los datos"
                        exit
                else
                    echo "Es recomendable hacer una copia de seguridad de los datos previamente por que se va a realizar un borrado seguro de los datos"
                    echo "¿De acuerdo? pulsa s para aceptar"
                    read confirma
                    if [ "$confirma" != "s" ]
                        then
                            echo "No has querido continuar"
                            exit
                    fi
                    dd  if=/dev/urandom of=$candidato bs=4096

                    echo "Se va a cifrar $candidato con el tamaño del algoritmo $algoritmo y LUKS"
                    cryptsetup -v -s $algoritmo -y luksFormat $candidato
                    #abrimos la partición y le asignamos un nombre a la partición cifrada
                    echo "Asigna un nombre a la partción cifrada"
                    read nomb
                    if [ -z "$nomb" ]
                        then
                            echo "Debes darle un nombre"
                            exit
                    fi
                            cryptsetup luksOpen $candidato $nomb

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