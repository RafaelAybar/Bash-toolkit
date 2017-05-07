#!/bin/bash
#La documentación está en https://femarper.wordpress.com/2016/11/20/a-vueltas-con-los-dominios-samba/
echo "Bienvenido a la instalación de Samba"
echo "Instalamos los paquetes necesarios"
    apt-get install attr build-essential libacl1-dev libattr1-dev libblkid-dev libgnutls-dev libreadline-dev python-dev libpam0g-dev python-dnspython gdb pkg-config libpopt-dev libldap2-dev dnsutils libbsd-dev attr krb5-user docbook-xsl libcups2-dev acl ntp ntpdate winbind
echo "Comprobamos los servicios de hora"
    sudo service ntp stop
    sudo ntpdate -B 0.ubuntu.pool.ntp.org
    sudo service ntp start
echo "Instalamos Samba"
    apt-get install samba smbclient
echo "Promocionamos a controlador de dominio"
    sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.orig
    sudo samba-tool domain provision --use-rfc2307 --interactive
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
