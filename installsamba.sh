#!/bin/bash
#La documentación está en https://femarper.wordpress.com/2016/11/20/a-vueltas-con-los-dominios-samba/
echo "Bienvenido a la instalación de Samba"
echo "Al reiniciar el PC ejecute samba2.sh para terminar de configurar los pasos restantes"
echo "Instalamos los paquetes necesarios"
    apt-get install attr build-essential libacl1-dev libattr1-dev libblkid-dev libgnutls-dev libreadline-dev python-dev libpam0g-dev python-dnspython gdb pkg-config libpopt-dev libldap2-dev dnsutils libbsd-dev attr krb5-user docbook-xsl libcups2-dev acl ntp ntpdate winbind
echo "¿Quieres reiniciar el servidor para aplicar los cambios? pulsa una tecla para reiniciar"
read respuesta
if [ -n "$respuesta"  ] 
    then
        reboot
        exit
else
    echo "Hasta luego"
    exit
fi
