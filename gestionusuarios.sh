#!/bin/bash
while true
do
  cat <<-EOF
MENÚ DEL GESTIÓN de usuarios y grupos
1 Añadir/eliminar usuarios y gestión de contraseñas
2 Crear/eliminar grupos.
3 Modificar el grupo al que pertenece un usuario.
4 Cambiar el propietario de un archivo/directorio.
5 Comprobar qué usuarios existen y cuáles están conectados
6 Salir
EOF
  read respuesta

  case $respuesta in
    1) echo "Pulsa a para añadir un usuario, y d para borrarlo"
        read respu
            if [ $respu = "a" ] 
                then
                    echo "Introduce el nombre del usuaruio"
                    read nombre
                        if [ -n "$nombre" ]
                            then
                                adduser "$nombre"
                                echo "Introduce 1 para definir la caducidad en días de la contraseña"
                                        read r1
                                if [ -n "$r1" ]
                                    then
                                        echo "Introduce el número de días"
                                        read numdia
                                        if [[ $numdia =~ ^-?[0-9]+$ ]]
                                            then
                                            passwd -e -w $numdia "$nombre"
                                        elif [ -z $numdia ]
                                            then
                                            passwd $nombre                                       
                                        fi
                                fi
                            else
                                echo "Introduce un nombre válido"
                    
                            fi
            elif [ $respu = "d" ] 
                then
                    echo "Introduce el nombre"
                    read nomb
                        if [ -n "$nomb" ] 
                            then
                            userdel "$nomb"
                        else
                            echo "Introduce un valor válido"
                        fi
              fi;;
    2) echo "Pulsa 1 para crear un grupo, pulsa 2 para eliminarlo"
        read r1
        if [ $r1 = 1 ]
            then
                echo "Introduce el nombre del grupo"
                read nombre
                if [ -n "$nobre" ] 
                then
                    
                fi          
        fi;;
    3) echo "Una elección digna de un auténtico sibarita...";;
    4) echo "Introduce el nuevo propietario "
        read nuevoprop
        if [ -n "$nuevoprop" ]
        then
            echo "Ahora el directorio (recursivo)/fichero"
            read directorio
            if [  -d "$directorio" ] || [ -f "$directorio" ]
                then
                    chown -R "$nuevoprop" "$directorio"
            fi
        else
            echo "Introduce un valor válido"
        fi
        ;;
    5) echo "Comentario provisional";;
    6) echo "Hasta luego"
        exit;;
    *) echo "Debes escoger una opción válida.";;
esac
done