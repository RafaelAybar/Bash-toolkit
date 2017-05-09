#!/bin/bash
#La documentación usada se encuentra disponible en https://femarper.wordpress.com/2017/05/02/a-vueltas-con-los-dominios-samba-clientes-linux/
#Importante leer también https://blogdeanillas.wordpress.com/2011/10/24/montar-unidades-con-fstab-en-un-active-directory/

echo "Procedemos a cambiar la configuración de red"
echo "Introduce la red en la que estás"
    read network
echo "Introduce la dirección IP de tu servidor"
    read gateway
echo "Introduce tu dirección IP"
    read address
echo "Introduce tu máscara de red"
    read netmask
echo "Introduce tu servidor dns"
    read dnsnameserver
echo "Introduce el dominio"
    read dnssearch
if [ -z "$gateway" ] || [ -z "$address" ] || [ -z "$netmask" ] || [ -z "$dnsnameserver" ] || [ -z "$dnssearch" ] || [ -z "$network" ]
    then
        echo "Debes introducir todos los parámetros"
        exit
else
    echo "auto enp0s3" >> /etc/network/interfaces
    echo "iface enp0s3 inet static" >> /etc/network/interfaces
    echo "address $address" >> /etc/network/interfaces
    echo "netmask $netmask" >> /etc/network/interfaces
    echo "network $network" >> /etc/network/interfaces
    echo "gateway $gateway" >> /etc/network/interfaces
    echo "dns-nameservers $dnsnameserver" >> /etc/network/interfaces
    echo "dns-search $dnssearch" >> /etc/network/interfaces
    echo "Configuración acabada"
    echo "¿Quieres reiniciar los servicios de Red?"
        read reiniciars
        if [ -z "$reiniciars" ] 
            then
            echo "Hasta luego"
            exit
        else
            service networking reload
            service networking restart
            ifdown enp0s3
            ifup enp0s3
            echo "Modificamos /etc/pam.d/common-session"
            sed -i.back "30s/^/session [success=ok default=ignore] pam_lsass.so \n/" /etc/pam.d/common-session
            echo "Se ha generado un fichero commonsession.conf.bak de copia de seguridad"
            sudo /opt/pbis/bin/config UserDomainPrefix $dnssearch
            sudo /opt/pbis/bin/config AssumeDefaultDomain true
            sudo /opt/pbis/bin/config LoginShellTemplate /bin/bash
            sudo /opt/pbis/bin/config HomeDirTemplate %H/%U
            echo "Añada %domain^admins ALL=(ALL:ALL) ALL a /etc/sudoeaers"
        fi
fi