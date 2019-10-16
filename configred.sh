#!/bin/bash

source funciones.sh

compruebaRoot

if [ $# -ne 6 ]; then
	echo-r "[AVISO] Este script espera 6 argumentos"
	echo "{ interfaz dirRed ip puerta netMask dns }"
	echo "Ejemplo de uso:"
	echo " $0 eth0 192.168.1.0 192.168.1.13 192.168.1.1 255.255.255.0 '9.9.9.9 8.8.8.8'"
	exit
fi

interfaz=$1
red=$2
ip=$3
puerta=$4
netmask=$5
dns=$6

echo "Bienvenido al configurador de red automático"
echo "Las interfaces detectadas son las siguientes"
ip a | grep "^[0-9]:" | awk -F: '{ print $2 }'

echo -e "\nLos datos introducidos son los siguientes:"
echo " - Interfaz: $interfaz"
echo " - Dirección de red: $red"
echo " - IP de la máquina: $ip"
echo " - Puerta de enlace: $puerta"
echo " - Máscara: $netmask"
echo " - Servdores DNS: $dns"
echo

read -p "La información es correcta?[S/n] " res
[[ "$res" =~ [Nn] ]] && exit

echo "Hacemos copia de seguirdad (el fichero será interfaces2)"
cp /etc/network/interfaces /etc/network/interfaces2

ficheroInterfaces="/etc/network/interfaces"
interfichero=$(ip a | grep $interfaz | awk -F: '{ print $2 }')
# Comprobamos si la interfaz introducida ya existe en el fichero, para no duplicarla
if ! [[ "$interfichero" =~ $interfaz ]]; then
    echo "auto $interfaz" >> $ficheroInterfaces
    echo "iface $interfaz inet static" >> $ficheroInterfaces
    echo "address $ip" >> $ficheroInterfaces
    echo "netmask $netmask" >> $ficheroInterfaces
    echo "network $red" >> $ficheroInterfaces
    echo "gateway $puerta" >> $ficheroInterfaces
    echo "dns-nameservers $dns" >> $ficheroInterfaces
else
    sed -i 's/dhcp/static/g' $ficheroInterfaces
    echo "address $ip" >> $ficheroInterfaces
    echo "netmask $netmask" >> $ficheroInterfaces
    echo "network $red" >> $ficheroInterfaces
    echo "gateway $puerta" >> $ficheroInterfaces
    echo "dns-nameservers $dns" >> $ficheroInterfaces
fi

echo "Configuración acabada"
echo "Recuerde modificar el los ficheros hosts y resolv.conf si fuera necesario"

if service networking restart; then
	echo "se ha reiniciado la tarjeta de red"
fi
