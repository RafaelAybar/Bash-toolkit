#!/bin/bash
echo "Bienvenido al administrador de discos"
echo "ADVERTENCIA: UN USO INCORRECTO DE ESTE SCRIPT PUEDE PROVOCAR PÉRDIDAS DE DATOS IRREPARABLES. EL DESARROLLADOR NO SE HACE RESPONSABLE DE SU MAL USO"
echo "Si usted tiene un disco SSD, la sobreescritura de los datos lo degradará considerablente."
echo "Selecciona una opción"
sleep 2
while true
do
   cat <<- EOF
1   Obtención de información de los discos duros y las particiones del sistema.
2   Cifrar partición/disco
3   Hacer copia de las cabeceras LUKS
4   Borrar particion(es)
5   Salir
EOF
    read respuesta
    case $respuesta in
        1) echo "Listado de discos duros y particiones del sistema:"
            #Fuente: https://blog.desdelinux.net/4-comandos-para-conocer-datos-de-nuestros-hdd-o-particiones/
            
           ;;
        2) echo "Introduzca la partición o disco que cifrará";
            read candidato
            if [ -z "$candidato" ]
                then
                    echo "Introduce los datos correctamente"
            else
                echo "Elija el tamaño en bits del algoritmo"
                    read algoritmo
                echo "Se usarará luks"
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
                    cryptsetup -v -s $algoritmo -q -y luksFormat $candidato
                    #abrimos la partición y le asignamos un nombre a la partición cifrada
                    echo "Asigna un nombre a la partción cifrada"
                    read nomb
                    if [ -z "$nomb" ]
                        then
                            echo "Debes darle un nombre"
                            exit
                    fi
                    cryptsetup luksOpen $candidato $nomb
                    echo "Introduce el tipo de sistema de ficheros (ext4 por ejemplo)"
                    read sistfichr
                    if [ -z "$sistfichr" ]
                        then
                            echo "Debes introducir el sistema de ficheros"
                            exit
                    fi
                    mkfs.$sistfichr /dev/mapper/$nomb
                    #Añadimos la partición a crypttab, para ello debemos generar un UUID https://serverfault.com/questions/103359/how-to-create-a-uuid-in-bash
                    uuid=$(uuidgen)
                    echo "$nomb UUID=$uuid none lucks.timeout=180" >> /etc/crypttab
                    echo "Ya puede montar la partición cifrada como deseecomo desee"
                fi
            fi
        ;;
        3) echo "Introduce la partición que deseas formatear"
        read partaformat
        if [ -z "$partaformat" ]
            then
                echo "Debes introducir la partición"
        fi
        echo "Introduce el formato que quieres darle"
        read formatopart
        if [ -z "$formatopart" ]
            then
                echo "Debes introducir el formato"
                exit
        fi
        mkfs.$formatopart $partaformat
        ;;
        4)
        echo "Borrar una partición implica borrar todos los datos, desea continuar (pulsa s)"
        # https://serverfault.com/questions/250839/deleting-all-partitions-from-the-command-line?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
        read cnfrma
        if [ "$cnfrma" != "s" ]
            then
                echo "No has querido seguir con el programa"
            exit
        fi
        echo "Selecione qué partición desea borrar"
        read partbrrar
        if [ -z "$partbrrar" ]
            then
                echo "Debes introducir los datos"
                exit
        fi
         sudo  wipefs -a $partbrrar  ;;
        5) echo "Adiós"
        exit;;
        *) echo "Escoge un parámetro válido" ;;
    esac
    done
