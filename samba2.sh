#!/bin/bash
echo "Comprobamos los servicios de hora"
    sudo service ntp stop
    sudo ntpdate -B 0.ubuntu.pool.ntp.org
    sudo service ntp start
echo "Instalamos Samba"
    apt-get install samba smbclient
echo "Promocionamos a controlador de dominio"
    sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.orig
    sudo samba-tool domain provision --use-rfc2307 --interactive
echo "Configuramos kerberos"
sudo mv /etc/krb5.conf /etc/krb5.conf.orig
sudo ln -sf /var/lib/samba/private/krb5.conf /etc/krb5.conf
echo "Iniciamos sesión en Kerberos para comprobar"
echo "Introduce tu dominio"
read dominio
if [ -n "$dominio" ]
    then
    kinit administrator@$dominio
    echo "Si da error modifica este fichero:"
    echo "/etc/nsswich"
else
    echo "Debes introducir otra cosa"
    exit
fi