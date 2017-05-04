#!/bin/bash
echo "Bienvenido al configurador de red automático"
echo "Selecciona la red en el la que estás 10.0.0.0 por ejemplo"
read red
# El parámetro -z comprueba si la variable está vacía
if [ -z $red ]
    then
        echo "Debes introducir la dirección de red"
else
        echo "Ahora introduce la dirección ip de la máquina"
        read ip
        if [ -z $ip ]
            then
                echo "Debes introducir la máscara"
                exit
        else
            echo "Introduce la máscara de red"
            read netmask
            if [ -z $netmask ]
                then
                    echo "Debes introducir una mascara de red"
                    exit
            else
                echo "Introduce la dirección del servidor DNS por ejemplo 8.8.8.8"
                read dnsnameserver
                if [ -z $dnsnameserver ]
                    then
                        echo "Debes introducir la dirección del servidor dns"
                        exit
                else
                    echo "Introduce el dominio"
                    read search
                    if [ -z $search ]
                        then
                            echo "Debes introducir el dominio"
                            exit
                    else
                        echo "Introduce la puerta de enlace"
                        read puerta
                        if [ -z $puerta ]
                            then
                                echo "Debes introducir una puerta de enlace"
                         else
                            echo "auto enp0s3" >> /etc/network/interfaces
                            echo "iface enp0s3 inet static" >> /etc/network/interfaces
                            echo "address $ip" >> /etc/network/interfaces
                            echo "netmask $netmask" >> /etc/network/interfaces
                            echo "network $red" >> /etc/network/interfaces
                            echo "gateway $puerta" >> /etc/network/interfaces
                            echo "dns-nameservers $dnsnameserver" >> /etc/network/interfaces
                            echo "search $search" >> /etc/network/interfaces
                            echo "Configuración acabada"
                            exit
                         fi
                    fi
                fi
            fi
        fi
fi
