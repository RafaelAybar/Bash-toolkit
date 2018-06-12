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
            if [ "$respu" = "a" ] 
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
                                        if [ -z "$numdia" ]
                                            then
                                            sudo passwd $nombre
                                            sudo chage -M $numdia $nombre
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
                            sudo userdel "$nomb"
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
                if [ -n "$nombre" ] 
                then
                    groupadd $nombre
                 elif [ $r1 = 2 ] 
                    then
                        echo "Introduce el nombre del grupo"
                                read nombreg
                                if [ -n "$nombreg" ] 
                                then
                                    sudo groupdel $nombreg
                                else
                                    echo "Debes introducir algo"
                                fi
                            else
                                echo "Debes introducir algo"
                fi
        fi;;
    3) echo "Introduce el  nombre del usuario"
        read usu
        if [ -n "$usu" ] 
        then
            echo "Ahora el nombre del grupo"
            read ngrup
            if [ -z "$ngrup" ] 
            then
                sudo usermod -a -G $ngrup $usu
            fi
        fi;;
    4) echo "Introduce el nuevo propietario "
        read nuevoprop
        if [ -n "$nuevoprop" ]
        then
            echo "Ahora el directorio (recursivo)/fichero"
            read directorio
            if [  -d "$directorio" ] || [ -f "$directorio" ]
                then
                   sudo chown -R "$nuevoprop" "$directorio"
            fi
        else
            echo "Introduce un valor válido"
        fi
        ;;

    5) echo "Pulsa 1 para ver quin está conectado, 2 para ver la lista de usuarios"
        read rnum
            if [ $rnum = 1 ] 
                then
                    who
            elif [ $rnum = 2 ] 
                then
                    echo "¿Quieres un usuario concreto s/n"
                    read usuc
                    if [ "$usuc" = "s" ]
                        then
                            echo "Introduce el nombre"
                            read nombreus
                            sudo cat /etc/passwd | grep $nombreus
                    elif [ "$usuc" = "n" ] 
                        then
                            sudo cat /etc/passwd
                    fi
            fi
    ;;
    6) echo "Hasta luego"
        exit;;
    *) echo "Debes escoger una opción válida";;
esac
done
