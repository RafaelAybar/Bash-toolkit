#!/bin/bash
echo "Bienvenido al configurador de red automático"
echo "Selecciona la red en el la que estás 10.0.0.0 por ejemplo"
    read red
echo "Ahora introduce la dirección ip de la máquina"
    read ip
echo "Introduce la puerta de enlace"
    read puerta
echo "Introduce la máscara de red"
    read netmask
echo "Introduce la dirección del servidor DNS por ejemplo 8.8.8.8"
    read dnsnameserver
echo "Introduce el dominio"
    read search
# El parámetro -z comprueba si la variable está vacía y -n si está completa
if [ -z $red ] || [ -z $ip ] || [ -z $netmask ] || [ -z $dnsnameserver ] || [ -z "$search" ] || [ -z $puerta ]
    then
        echo "Debes introducir todos los parámetros"
        exit
else
    echo "Hacemos copia de seguirdad (el fichero será interfaces2)"
            cp /etc/network/interfaces /etc/network/interfaces2
    echo "auto enp0s3" >> /etc/network/interfaces
    echo "iface enp0s3 inet static" >> /etc/network/interfaces
    echo "address $ip" >> /etc/network/interfaces
    echo "netmask $netmask" >> /etc/network/interfaces
    echo "network $red" >> /etc/network/interfaces
    echo "gateway $puerta" >> /etc/network/interfaces
    echo "dns-nameservers $dnsnameserver" >> /etc/network/interfaces
    echo "dns-search $search" >> /etc/network/interfaces
    echo "Configuración acabada"

    echo "¿Quieres modificar ahora el fichero resolv.conf? Pulsa una tecla"
        read respuestaa
            if [ -n "$respuestaa" ]
                then
                    echo "Procedemos a modificar el fichero /etc/resolv.conf"
                    sed -i.back "1s/^/ $ip   $HOSTNAME.$search  $HOSTNAME\n/" /etc/resolv.conf
                    echo "Se ha generado un fichero resolv.conf.bak de copia de seguridad"
                    echo "¿Quieres reiniciar la tajeta de red para aplicar los cambios? pulsa una tecla para confirmar"
                    read respuesta
                    if [ -n "$respuesta" ] 
                        then
                            ifdown enp0s3
                            ifup enp0s3
                            echo "se ha reiniciado la tarjeta de red"
                    elif [ -z "$respuesta" ]
                        then
                            echo "Hasta luego"
                                exit
                    fi
                else
                    echo "Introduce una respuesta válida"
                    exit
            fi
fi
